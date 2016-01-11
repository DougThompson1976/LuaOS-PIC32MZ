/*
 * Whitecat, ethernet driver
 *
 * Copyright (C) 2015
 * IBEROXARXA SERVICIOS INTEGRALES, S.L. & CSS IBÉRICA, S.L.
 * 
 * Author: Jaume Olivé (jolive@iberoxarxa.com / jolive@whitecatboard.com)
 * 
 * All rights reserved.  
 *
 * Based on sources of Serge Vakulenko - LiteBSD project
 *
 * ----------------------------------------------------------------------
 *
 * Copyright (c) 2015, Serge Vakulenko
 *
 * Loosely based on sources of Digilent deIPcK library by Keith Vogel.
 *
 * ----------------------------------------------------------------------
 *
 * Copyright (c) 2013-2014, Digilent <www.digilentinc.com>
 * Permission to use, copy, modify, and distribute this software
 * and its documentation for any purpose and without fee is hereby
 * granted, provided that the above copyright notice appear in all
 * copies and that both that the copyright notice and this
 * permission notice and warranty disclaimer appear in supporting
 * documentation, and that the name of the author not be used in
 * advertising or publicity pertaining to distribution of the
 * software without specific, written prior permission.
 *
 * The author disclaim all warranties with regard to this
 * software, including all implied warranties of merchantability
 * and fitness.  In no event shall the author be liable for any
 * special, indirect or consequential damages or any damages
 * whatsoever resulting from loss of use, data or profits, whether
 * in an action of contract, negligence or other tortious action,
 * arising out of or in connection with the use or performance of
 * this software.
 */

#include "whitecat.h"

#if USE_PIC_PHY

#include "arch/cc.h"
#include "utils/delay.h"
#include "utils/bman.h"
#include "utils/kmem.h"
#include "drivers/phy.h"
#include "drivers/gpio/gpio.h"

#include "netif/ethernetif.h"
#include "netif/etharp.h"
#include "lwip/mem.h"
#include "lwip/stats.h"

#include <sydlog.h>

extern void ethernetInput( void * pvParameter1, uint32_t ulParameter2 );
extern struct netif eth_netif;

volatile int receive_index = 0;

volatile char        rx_buf[RX_DESCRIPTORS][RX_BYTES_PER_DESC];     /* receive buffers */
volatile eth_desc_t  rx_desc[RX_DESCRIPTORS+1];  /* an additional terminating descriptor */
volatile eth_desc_t  tx_desc[TX_DESCRIPTORS+1];  /* an additional terminating descriptor */

/* Start of packet */
#define DESC_SOP(d)             ((d)->hdr & 0x80000000)
#define DESC_SET_SOP(d)         ((d)->hdr |= 0x80000000)

/* End of packet */
#define DESC_EOP(d)             ((d)->hdr & 0x40000000)
#define DESC_SET_EOP(d)         ((d)->hdr |= 0x40000000)

/* Number of data bytes */
#define DESC_BYTECNT(d)         ((d)->hdr >> 16 & 0x7ff)
#define DESC_SET_BYTECNT(d,n)   ((d)->hdr = ((d)->hdr & ~0x7ff0000) | (n) << 16)

/* Next descriptor pointer valid */
#define DESC_SET_NPV(d)         ((d)->hdr |= 0x00000100)
#define DESC_CLEAR_NPV(d)       ((d)->hdr &= ~0x00000100)

/* Eth controller owns this desc */
#define DESC_EOWN(d)            ((d)->hdr & 0x00000080)
#define DESC_SET_EOWN(d)        ((d)->hdr |= 0x00000080)
#define DESC_CLEAR_EOWN(d)      ((d)->hdr &= ~0x00000080)

/* Size of received packet */
#define DESC_FRAMESZ(d)         ((d)->status & 0xffff)

/* Receive filter status */
#define DESC_RXF(d)             ((d)->ctl >> 24)
#define DESC_SET_RXF(d,n)       ((d)->ctl = ((d)->ctl & 0xffffff) | (n) << 24)

/*-------------------------------------------------------------
 * PHY registers.
 */
#define PHY_CONTROL_DPLX            0x0100  /* Full duplex */
#define PHY_CONTROL_ANEG_RESTART    0x0200  /* Write 1 to restart autoneg */
#define PHY_CONTROL_ISOLATE         0x0400  /* MII interface disable */
#define PHY_CONTROL_PDN             0x0800  /* Powerdown enable */
#define PHY_CONTROL_ANEG_EN         0x1000  /* Auto-negotiation enable */
#define PHY_CONTROL_SPEED_100       0x2000  /* Select 100 Mbps speed */
#define PHY_CONTROL_LPBK            0x4000  /* Loopback enable */
#define PHY_CONTROL_RESET           0x8000  /* Reset, bit self cleared */
#define PHY_CONTROL_BITS "\20"\
"\11dplx\12aneg-rst\13isolate\14pdn\15aneg-en\16speed100\17lpbk\20rst"

#define PHY_STATUS_EXCAP            0x0001  /* Extended capabilities regs present */
#define PHY_STATUS_JAB              0x0002  /* Jabber detected */
#define PHY_STATUS_LINK             0x0004  /* Link valid */
#define PHY_STATUS_CAP_ANEG         0x0008  /* Auto-negotiation available */
#define PHY_STATUS_REM_FLT          0x0010  /* Remote fault detected */
#define PHY_STATUS_ANEG_ACK         0x0020  /* Auto-negotiation acknowledge */
#define PHY_STATUS_EXSTATUS         0x0100  /* Extended status reg present */
#define PHY_STATUS_CAP_100T2_HDX    0x0200  /* Can do 100Base-T2 half duplex */
#define PHY_STATUS_CAP_100T2_FDX    0x0400  /* Can do 100Base-T2 full duplex */
#define PHY_STATUS_CAP_10_HDX       0x0800  /* Can do 10Base-TX half duplex */
#define PHY_STATUS_CAP_10_FDX       0x1000  /* Can do 10Base-TX full duplex */
#define PHY_STATUS_CAP_100_HDX      0x2000  /* Can do 100Base-TX half duplex */
#define PHY_STATUS_CAP_100_FDX      0x4000  /* Can do 100Base-TX full duplex */
#define PHY_STATUS_CAP_100_T4       0x8000  /* Can do 100Base-T4 */
#define PHY_STATUS_BITS "\20"\
"\1exreg\2jab\3link\4cap-aneg\5rem-flt\6aneg-ack"\
"\14hdx10\15fdx10\16hdx100\17fdx100\20t4-100"

#define PHY_ADVRT_CSMA              0x0001  /* Capable of 802.3 CSMA operation */
#define PHY_ADVRT_10_HDX            0x0020  /* Can do 10Base-TX half duplex */
#define PHY_ADVRT_10_FDX            0x0040  /* Can do 10Base-TX full duplex */
#define PHY_ADVRT_100_HDX           0x0080  /* Can do 100Base-TX half duplex */
#define PHY_ADVRT_100_FDX           0x0100  /* Can do 100Base-TX full duplex */
#define PHY_ADVRT_RF                0x2000  /* Remote fault */
#define PHY_ADVRT_BITS "\20"\
"\1csma\6hdx10\7fdx10\10hdx100\11fdx100\16rf"

/*
 * Register #31 for SMSC LAN8720A, LAN8740A.
 */
#define PHY_LAN87x0A_AUTODONE       0x1000  /* Auto-negotiation is done */
#define PHY_LAN87x0A_4B5B           0x0040  /* Enable 4B5B encoding */
#define PHY_LAN87x0A_FDX            0x0010  /* Full duplex */
#define PHY_LAN87x0A_100            0x0008  /* Speed 100 Mbps */
#define PHY_LAN87x0A_10             0x0004  /* Speed 10 Mbps */
#define PHY_LAN87x0A_BITS "\20"\
"\3speed10\4speed100\5fdx\15autodone"

/*
 * Read PHY register.
 * Return -1 when failed.
 */
int phy_read(int phy_addr, int reg_num, unsigned msec)
{
    unsigned time_start = ReadCoreTimer();
    unsigned timeout = (CPU_HZ / 2000) * msec;

    /* Clear any commands. */
    EMAC1MCMD = 0;
    while (EMAC1MIND & _EMAC1MIND_MIIMBUSY_MASK) {
        if (ReadCoreTimer() - time_start > timeout) {
            return -1;
        }
    }

    EMAC1MADR = ((reg_num)<<_EMAC1MADR_REGADDR_POSITION)|((phy_addr)<<_EMACxMADR_PHYADDR_POSITION);
    EMAC1MCMDSET = _EMAC1MCMD_READ_MASK;
    delay(1);

    /* Wait to finish. */
    time_start = ReadCoreTimer();
    while (EMAC1MIND & _EMAC1MIND_MIIMBUSY_MASK) {
        if (ReadCoreTimer() - time_start > timeout) {
            EMAC1MCMD = 0;
            return -1;
        }
    }

    EMAC1MCMD = 0;
    return EMAC1MRDD & 0xffff;
}

/*
 * Scan PHY register for expected value.
 * Return -1 when failed.
 */
static int phy_scan(int phy_addr, int reg_num,
    unsigned scan_mask, unsigned expected_value, unsigned msec)
{
    unsigned time_start = ReadCoreTimer();
    unsigned timeout = (CPU_HZ / 2000) * msec;

    /* Clear any commands. */
    EMAC1MCMD = 0;
    while (EMAC1MIND & _EMAC1MIND_MIIMBUSY_MASK) {
        if (ReadCoreTimer() - time_start > timeout) {
            return -1;
        }
    }

    /* Scan the PHY until it is ready. */
    EMAC1MADR = ((reg_num)<<_EMAC1MADR_REGADDR_POSITION)|((phy_addr)<<_EMACxMADR_PHYADDR_POSITION);
    EMAC1MCMDSET = _EMAC1MCMD_SCAN_MASK;
    delay(1);

    /* Wait for it to become valid. */
    time_start = ReadCoreTimer();
    while (EMAC1MIND & _EMAC1MIND_NOTVALID_MASK) {
        if (ReadCoreTimer() - time_start > timeout) {
            return -1;
        }
    }

    /* Wait until we hit our mask. */
    time_start = ReadCoreTimer();
    while (((EMAC1MRDD & scan_mask) == scan_mask) != expected_value) {
        if (ReadCoreTimer() - time_start > timeout) {
            return -1;
        }
    }

    /* Kill the scan. */
    EMAC1MCMD = 0;
    delay(1);
    time_start = ReadCoreTimer();
    while (EMAC1MIND & _EMAC1MIND_MIIMBUSY_MASK) {
        if (ReadCoreTimer() - time_start > timeout) {
            return -1;
        }
    }
    return 0;
}

/*
 * Write PHY register.
 * Return -1 when failed.
 */
static int phy_write(int phy_addr, int reg_num, int value, unsigned msec)
{
    unsigned time_start = ReadCoreTimer();
    unsigned timeout = (CPU_HZ / 2000) * msec;

    /* Clear any commands. */
    EMAC1MCMD = 0;
    while (EMAC1MIND & _EMAC1MIND_MIIMBUSY_MASK) {
        if (ReadCoreTimer() - time_start > timeout) {
            return -1;
        }
    }

    EMAC1MADR = ((reg_num)<<_EMAC1MADR_REGADDR_POSITION)|((phy_addr)<<_EMACxMADR_PHYADDR_POSITION);
    EMAC1MWTD = value;
    delay(1);

    /* Wait to finish. */
    time_start = ReadCoreTimer();
    while (EMAC1MIND & _EMAC1MIND_MIIMBUSY_MASK) {
        if (ReadCoreTimer() - time_start > timeout) {
            return -1;
        }
    }
    return 0;
}

/*
 * Reset the PHY via MIIM interface.
 * Return -1 on failure.
 */
int phy_reset(int phy_addr)
{
    int advrt;
    int advertise_all = PHY_ADVRT_10_HDX | PHY_ADVRT_10_FDX |
        PHY_ADVRT_100_HDX | PHY_ADVRT_100_FDX;

    /* Check ADVRT register is writable. */
    phy_write(phy_addr, PHY_ADVRT, 0, 100);
    advrt = phy_read(phy_addr, PHY_ADVRT, 1);
    if (advrt & advertise_all)
        return -1;
    phy_write(phy_addr, PHY_ADVRT, PHY_ADVRT_CSMA | advertise_all, 100);
    advrt = phy_read(phy_addr, PHY_ADVRT, 1);
    if ((advrt & advertise_all) != advertise_all)
        return -1;

    /* Send a reset to the PHY. */
    if (phy_write(phy_addr, PHY_CONTROL, PHY_CONTROL_RESET, 100) < 0)
        return -1;

    /* Wait for the reset pin to autoclear. */
    if (phy_scan(phy_addr, PHY_CONTROL, PHY_CONTROL_RESET, 0, 500) < 0)
        return -1;

    /* Advertise both 100Mbps and 10Mbps modes, full or half duplex. */
    phy_write(phy_addr, PHY_ADVRT, PHY_ADVRT_CSMA | advertise_all, 100);

    /* Restart autonegotiation. */
    phy_write(phy_addr, PHY_CONTROL, PHY_CONTROL_ANEG_EN | PHY_CONTROL_ANEG_RESTART, 100);

    return 0;
}

/*
 * Get the speed and duplex mode of LAN87x0A chip.
 */
static void phy_lan87x0a_poll(int phy_addr, int *speed_100, int *full_duplex)
{
    /* Read 87x0A-specific register #31. */
    int special = phy_read(phy_addr, 31, 1);

    if (special & PHY_LAN87x0A_AUTODONE) {
        /* Auto-negotiation is done - get the speed. */
        *speed_100 = (special & PHY_LAN87x0A_100) != 0;
        *full_duplex = (special & PHY_LAN87x0A_FDX) != 0;
    }
#if 0
    int special_modes = phy_read(phy_addr, 18, 1);
    int error_counter = phy_read(phy_addr, 26, 1);
    int cable_length  = phy_read(phy_addr, 28, 1);
    printf("     SPECIAL=%b\n", special, PHY_LAN87x0A_BITS);
    printf("     Special_Modes=%04x, Error_Counter=%04x, Cable_Length=%04x\n",
        special_modes, error_counter, cable_length);
#endif
}

/*
 * Determine whether the link is up.
 * When up, get the speed and duplex mode.
 */
int is_phy_linked(int *speed_100, int *full_duplex) {

    int status = phy_read(PHY_ADDRESS, PHY_STATUS, 1);
    if (status < 0)
        return 0;

    if (! (status & PHY_STATUS_LINK))           /* Is link up? */
        return 0;
    if (! (status & PHY_STATUS_ANEG_ACK))       /* Is auto-negotiation done? */
        return 0;

    phy_lan87x0a_poll(PHY_ADDRESS, speed_100, full_duplex);

    return 1;
}

/*
 * Different devices can have different pin assignments,
 * denending on pin count and DEVCFG.FETHIO configuration setting.
 */
void setup_signals() {
    gpio_disable_analog(RXERR_PIN);
    gpio_disable_analog(ERXD0_PIN);
    gpio_disable_analog(ERXD1_PIN);
    gpio_disable_analog(ETXEN_PIN);
    gpio_disable_analog(MDC_PIN);
    
    PINOUTPUT(PORB(ETXD0_PIN),PINB(ETXD0_PIN));
    PINOUTPUT(PORB(ETXD1_PIN),PINB(ETXD1_PIN));
    PINOUTPUT(PORB(ETXEN_PIN),PINB(ETXEN_PIN));
}

/*
 * Initialize the Ethernet Controller.
 */
void en_setup() {
    setup_signals();
    
    /* Disable the ethernet interrupt. */
    IECCLR(PIC32_IRQ_ETH >> 5) = 1 << (PIC32_IRQ_ETH & 31);

    /* Turn the Ethernet cotroller off. */
    ETHCON1CLR = PIC32_ETHCON1_ON | PIC32_ETHCON1_RXEN | PIC32_ETHCON1_TXRTS;

    /* Wait for abort to finish. */
    while (ETHSTAT & PIC32_ETHSTAT_ETHBUSY)
        continue;

    /* Turn on the ethernet controller. */
    ETHCON1 = PIC32_ETHCON1_ON;

    /* Clear the interrupt flag bit. */
    IFSCLR(PIC32_IRQ_ETH >> 5) = 1 << (PIC32_IRQ_ETH & 31);

    /* Clear interrupts. */
    ETHIEN = 0;
    ETHIRQ = 0;

    /* Clear discriptor pointers; for now. */
    ETHTXST = 0;
    ETHRXST = 0;

    /* High and low watermarks. */
    int empty_watermark = ETHER_MAX_LEN / RX_BYTES_PER_DESC;
    int full_watermark  = RX_DESCRIPTORS - (ETHER_MAX_LEN * 2) / RX_BYTES_PER_DESC;

    ETHRXWM = PIC32_ETHRXWM_FWM(full_watermark) |
              PIC32_ETHRXWM_EWM(empty_watermark);

    /* Set RX descriptor buffer size in bytes (aligned to 16 bytes). */
    ETHCON2 = RX_BYTES_PER_DESC;

    /* Set our Rx filters. */
    ETHRXFC = PIC32_ETHRXFC_CRCOKEN |   /* enable checksum filter */
              PIC32_ETHRXFC_RUNTEN |    /* enable short packets */
              PIC32_ETHRXFC_UCEN |      /* enable unicast filter */
              PIC32_ETHRXFC_BCEN;       /* enable broadcast filter */

    /* Hash table, not used. */
    ETHHT0 = 0;
    ETHHT1 = 0;

    /* Pattern match, not used. */
    ETHPMM1 = 0;
    ETHPMM1 = 0;

    /* Byte in TCP like checksum pattern calculation. */
    ETHPMCS = 0;
}

/*
 * Initialize the MAC.
 */
void en_setup_mac()
{
    /* Reset the MAC. */
    EMAC1CFG1 = PIC32_EMAC1CFG1_SOFTRESET;
    delay(1);

    /* Pull it out of reset. */
    EMAC1CFG1 = 0;
    delay(1);

    EMAC1CFG1 = PIC32_EMAC1CFG1_RXENABLE |  /* Receive enable */
                PIC32_EMAC1CFG1_TXPAUSE |   /* MAC TX flow control */
                PIC32_EMAC1CFG1_RXPAUSE;    /* MAC RX flow control */

    EMAC1CFG2 = PIC32_EMAC1CFG2_PADENABLE | /* Pad/CRC enable */
                PIC32_EMAC1CFG2_CRCENABLE | /* CRC enable */
                PIC32_EMAC1CFG2_EXCESSDFR |
                PIC32_EMAC1CFG2_AUTOPAD |
                PIC32_EMAC1CFG2_LENGTHCK;

    EMAC1MAXF = 6*256;                      /* max frame size in bytes */
    EMAC1IPGR = PIC32_EMAC1IPGR(12, 18);    /* non-back-to-back interpacket gap */
    EMAC1CLRT = PIC32_EMAC1CLRT(55, 15);    /* collision window/retry limit */
}

/*
 * Initialize RMII and MIIM.
 */
void en_setup_mii()
{
    EMAC1SUPP = PIC32_EMAC1SUPP_RESETRMII;  /* reset RMII */
    delay(1);
    EMAC1SUPP = 0;

    EMAC1MCFG = PIC32_EMAC1MCFG_RESETMGMT;  /* reset the management fuctions */
    delay(1);
    EMAC1MCFG = 0;

    /* The IEEE 802.3 spec says no faster than 2.5MHz.
     * 80 / 40 = 2MHz
     */
    EMAC1MCFG = PIC32_EMAC1MCFG_CLKSEL_40;
}

void en_set_hwaddr(struct netif *netif) {
    /* set MAC hardware address length */
    netif->hwaddr_len = ETHARP_HWADDR_LEN;

    /* Extract ans set our MAC address */
    netif->hwaddr[0] = EMAC1SA2;
    netif->hwaddr[1] = EMAC1SA2 >> 8;
    netif->hwaddr[2] = EMAC1SA1;
    netif->hwaddr[3] = EMAC1SA1 >> 8;
    netif->hwaddr[4] = EMAC1SA0;
    netif->hwaddr[5] = EMAC1SA0 >> 8;
}

void en_enable_interrupts() {
    /* Enable interrupts. */
    ETHIENSET = PIC32_ETHIRQ_TXBUSE |       /* Transmit Bus Error */
                PIC32_ETHIRQ_TXDONE |       /* Transmit Done */
                PIC32_ETHIRQ_TXABORT |      /* Transmit Abort */
                PIC32_ETHIRQ_RXBUSE |       /* Receive Bus Error */
                PIC32_ETHIRQ_RXDONE |       /* Receive Done */
                PIC32_ETHIRQ_RXBUFNA |      /* Receive Buffer Not Available */
                PIC32_ETHIRQ_RXOVFLW;       /* Receive FIFO Overflow */

    // Clear the Ethernet Controller priority and sub-priority
    IPCCLR(PIC32_IRQ_ETH >> 2) = 0x1f << (5 * (PIC32_IRQ_ETH & 0x03));

    // Set IPL 2, sub-priority 0
    IPCSET(PIC32_IRQ_ETH >> 2) = 0x0800;

    IECSET(PIC32_IRQ_ETH >> 5) = 1 << (PIC32_IRQ_ETH & 31);    
    ETHCON1SET = PIC32_ETHCON1_RXEN;    
}

/*
 * Set DMA descriptors.
 */
void en_setup_dma() {
    int i;

    /* Set Rx discriptor list.
     * All owned by the ethernet controller. */
    bzero((void *)rx_desc, sizeof(rx_desc));
    for (i=0; i<RX_DESCRIPTORS; i++) {
        DESC_SET_EOWN(&rx_desc[i]);
        DESC_CLEAR_NPV(&rx_desc[i]);
        rx_desc[i].paddr = KVA_TO_PA(&rx_buf[i]);
    }

    /* Loop the list back to the begining.
     * This is a circular array descriptor list. */
    rx_desc[RX_DESCRIPTORS].hdr = KVA_TO_PA(rx_desc);
    DESC_SET_NPV(&rx_desc[RX_DESCRIPTORS-1]);

    /* Set RX at the start of the list. */
    receive_index = 0;
    ETHRXST = KVA_TO_PA(&rx_desc[0]);

    /* Set up the transmitt descriptors all owned by
     * the software; clear it completely out. */
    bzero((void *)tx_desc, sizeof(tx_desc));
    ETHTXST = KVA_TO_PA(tx_desc);
}

struct pbuf *low_level_input(struct netif *netif) {
  UNUSED_ARG(netif);
  
  struct pbuf *p, *q;
  u16_t len = 0;
  u16_t frame_size = 0;

  // Get the size of the received ethernet packet
  volatile eth_desc_t *desc = &rx_desc[receive_index];

  if (!DESC_EOWN(desc)) {
    len = DESC_FRAMESZ(desc);
  }

  // If we don't receive nothing, exit
  if (len == 0) return NULL;

  frame_size = len;

#if ETH_PAD_SIZE
  len += ETH_PAD_SIZE; /* allow room for Ethernet padding */
#endif

  /* We allocate a pbuf chain of pbufs from the pool. */
  p = pbuf_alloc(PBUF_RAW, len, PBUF_POOL);
  if (p != NULL) {
    gpio_pin_set(LED_NET);

#if ETH_PAD_SIZE
    pbuf_header(p, -ETH_PAD_SIZE); /* drop the padding word */
#endif

    q = p;

    u16_t qi = 0;
    u16_t qlen = q->len;

    while (qlen > 0) {
        bcopy(&rx_buf[receive_index], q->payload + qi, frame_size);
        qlen = qlen - frame_size;
        qi = qi + frame_size;

        // Reinitialize RX descriptor
        bzero((void *)desc, sizeof(eth_desc_t));
        DESC_SET_EOWN(desc);
        DESC_CLEAR_NPV(desc);
        desc->paddr = KVA_TO_PA(&rx_buf[receive_index]);

        ETHCON1SET = _ETHCON1_BUFCDEC_MASK;      /* decrement the BUFCNT */
        receive_index++;                         /* next descriptor */

        if (receive_index >= RX_DESCRIPTORS) {
            receive_index = 0;

            rx_desc[RX_DESCRIPTORS].hdr = KVA_TO_PA(rx_desc);
            DESC_SET_NPV(&rx_desc[RX_DESCRIPTORS-1]);
        }

        desc = &rx_desc[receive_index];
        frame_size = DESC_FRAMESZ(desc);
    }

#if ETH_PAD_SIZE
    pbuf_header(p, ETH_PAD_SIZE); /* reclaim the padding word */
#endif

    LINK_STATS_INC(link.recv);
  } else {
    LINK_STATS_INC(link.memerr);
    LINK_STATS_INC(link.drop);
  }

  return p;
}

err_t low_level_output(struct netif *netif, struct pbuf *p) {
  UNUSED_ARG(netif);

  struct pbuf *q;

#if ETH_PAD_SIZE
  pbuf_header(p, -ETH_PAD_SIZE); /* drop the padding word */
#endif
  
    q = p;
    
    if (q->len > 0) {
        gpio_pin_set(LED_NET);

        while(ETHCON1 & PIC32_ETHCON1_TXRTS);

        volatile eth_desc_t *desc = &tx_desc[0];

        while (q != NULL) {
            if (q->len == 0) continue;

            desc->hdr = 0;
            desc->paddr = KVA_TO_PA(q->payload);
            DESC_SET_BYTECNT(desc, q->len);

            if (desc == tx_desc)
                DESC_SET_SOP(desc); // Start of packet

            DESC_SET_EOWN(desc); // Set owner

            desc++;
            q = q->next;
        }

        DESC_SET_EOP(desc - 1); // End of packet

        /* Set the descriptor table to be transmitted. */
        ETHTXST = KVA_TO_PA(tx_desc);

        /* Start transmitter. */
        ETHCON1SET = PIC32_ETHCON1_TXRTS;
    }

#if ETH_PAD_SIZE
  pbuf_header(p, ETH_PAD_SIZE); /* reclaim the padding word */
#endif

  LINK_STATS_INC(link.xmit);

  return ERR_OK;
}

void __attribute__( (interrupt(IPL2AUTO), vector(PIC32_IRQ_ETH))) vEthernetInterruptWrapper( void );

// Ethernet interrupt handler
void  vEthernetInterruptHandler(void) {
    BaseType_t xHigherPriorityTaskWoken = pdFALSE;

    int irqn;

    /* Read the interrupt requests and acknowledge the interrupt. */
    irqn = ETHIRQ;
    ETHIRQCLR = irqn;

    /* Receiver error. */
    if (irqn & (_ETHIRQ_RXBUSE_MASK |
                _ETHIRQ_RXBUFNA_MASK |
                _ETHIRQ_RXOVFLW_MASK)) {
        //e->netif.if_ierrors++;
        //log(LOG_ERR, "en%d: receive error: irq %x\n", unit, irq);
    }

    if (ETHCON1 & _ETHCON1_RXEN_MASK) {
        /* Receiver enabled. */
        if (!DESC_EOWN(&rx_desc[receive_index])) {
            xTimerPendFunctionCallFromISR(ethernetInput,NULL,0,&xHigherPriorityTaskWoken);
        }
    }

    /* Transmit error. */
    if (irqn & (_ETHIRQ_TXBUSE_MASK | _ETHIRQ_TXABORT_MASK)) {
        //log(LOG_ERR, "en%d: transmit error: irq %x\n", unit, irq);
        //e->netif.if_oerrors++;
    }

    /* Packet Transmitted */
    if (irqn & _ETHIRQ_TXDONE_MASK) {
        gpio_pin_clr(LED_NET);

        //++e->netif.if_opackets;
        //e->netif.if_collisions += ETHSCOLFRM + ETHMCOLFRM;
    }

    /* Transmitter is idle. */
//    if (! (ETHCON1 & _ETHCON1_TXRTS_MASK)) {
//        if (e->tx_packet) {
//            m_freem(e->tx_packet);
//            e->tx_packet = 0;
//        }
//        if (e->is_up) {
//            /* Any more to send? */
//            en_start(&e->netif);
//        }
//    }

    /* Clear the interrupt flag on exit from the service routine. */
    IFSCLR(PIC32_IRQ_ETH >> 5) = 1 << (PIC32_IRQ_ETH & 31);

    portEND_SWITCHING_ISR(xHigherPriorityTaskWoken);
}

void en_watchdog(void *arg) {
  UNUSED_ARG(arg);

  int speed_100;
  int full_duplex;

  if (eth_netif.flags & NETIF_FLAG_LINK_UP) {
      // Previous link is up
      if (!is_phy_linked(&speed_100,&full_duplex)) {
          // Now link is down
          LWIP_DEBUGF(NETIF_DEBUG, ("netif: link down\n"));

          netif_set_link_down(&eth_netif);
      }
  } else {
      // Previous link is down
      if (is_phy_linked(&speed_100,&full_duplex)) {
          // Now link is up
          u8_t speed;
          const char *duplex;

          // Set speed
          if (speed_100) {
            speed = 100;
            EMAC1SUPPSET = _EMAC1SUPP_SPEEDRMII_MASK;
          } else {
            speed = 10;
            EMAC1SUPPCLR = _EMAC1SUPP_SPEEDRMII_MASK;
          }

          // Set duplex
          if (full_duplex) {
            duplex = "full";
            EMAC1CFG2SET = _EMAC1CFG2_FULLDPLX_MASK;
          } else {
            duplex = "half";
            EMAC1CFG2CLR = _EMAC1CFG2_FULLDPLX_MASK;
          }

          // Set gap size
          EMAC1IPGT = full_duplex ? 21 : 18;

          syslog(LOG_ERR, ("netif: link up, speed %d Mbps / %s duplex", speed, duplex);

          // Link now is up
          netif_set_link_up(&eth_netif);
       }
  }
};

int en_init(struct netif *netif) {
    en_setup();
    en_setup_mac();
    en_setup_mii();

    if (phy_reset(PHY_ADDRESS) < 0) {
      ETHCON1 = 0;
      LWIP_DEBUGF(NETIF_DEBUG, ("netif: PHY not detected at address=%u\n",PHY_ADDRESS));
      return ERR_IF;
    }

    en_set_hwaddr(netif);
    
    LWIP_DEBUGF(NETIF_DEBUG, (
            "netif: mac address is %02x:%02x:%02x:%02x:%02x:%02x\n",
            netif->hwaddr[0],netif->hwaddr[1],
            netif->hwaddr[2],netif->hwaddr[3],
            netif->hwaddr[4],netif->hwaddr[5]
    ));
    
    en_setup_dma();
    en_enable_interrupts();

    LWIP_DEBUGF(NETIF_DEBUG, ("netif: PHY detected at address=%u\n",PHY_ADDRESS));

    int phy_id = (phy_read(PHY_ADDRESS, PHY_ID1, 1) << 16 |
            phy_read(PHY_ADDRESS, PHY_ID2, 1)) & 0xfffffff0;

    switch (phy_id) {
        case PHY_ID_LAN8720A:
            LWIP_DEBUGF(NETIF_DEBUG, ("netif: PHY is LAN8720A\n"));
            break;
        default:
            LWIP_DEBUGF(NETIF_DEBUG, ("netif: unknow PHY id %d\n", phy_id));
            
            return ERR_IF;
    }
    
    return ERR_OK;
}
#endif
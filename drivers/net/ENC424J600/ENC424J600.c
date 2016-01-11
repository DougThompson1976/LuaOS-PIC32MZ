/*
 * Whitecat, ENC424J600 ethernet driver
 *
 * Copyright (C) 2015
 * IBEROXARXA SERVICIOS INTEGRALES, S.L. & CSS IBÉRICA, S.L.
 * 
 * Author: Jaume Olivé (jolive@iberoxarxa.com / jolive@whitecatboard.com)
 * 
 * All rights reserved.  
 *
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

#if USE_SPI_PHY

#include "FreeRTOS.h"
#include "task.h"
#include "timers.h"

#include "drivers/gpio/gpio.h"
#include "drivers/spi/spi.h"
#include "drivers/net/en.h"
#include "drivers/net/ENC424J600/ENC424J600.h"
#include <machine/machConst.h>
#include "utils/delay.h"

#include "netif/etharp.h"
#include "netif/ethernetif.h"
#include "lwip/stats.h"

#include <syslog.h>
#include <time.h>

#define SPI_PHY_SPI_KHZ 14000 // 14MHz

#define UDA_WINDOW		(0x1)
#define GP_WINDOW		(0x2)
#define RX_WINDOW		(0x4)

extern unsigned int activity;
extern struct netif eth_netif;
extern volatile UBaseType_t uxInterruptNesting;
extern void ethernetInput( void * pvParameter1, uint32_t ulParameter2 );
extern void link_status_change( void * pvParameter1, uint32_t ulParameter2 );

static volatile int currentBank;
static uint16_t nextPacketPointer;

static uint16_t exec_8_op(uint8_t op) {
	uint16_t readed = 0;
    int x;

    int rup = mips_di();
        
    spi_select(SPI_PHY_SPI);

	// Issue command
	readed = spi_transfer(SPI_PHY_SPI, op);

	// Read/write data
    spi_deselect(SPI_PHY_SPI);
   
    mtc0_Status(rup);

	return readed;
}
 
static uint16_t exec_16_op(uint8_t op, uint16_t data) {
	uint16_t readed = 0;
    int x;

    int rup = mips_di();
        
    spi_select(SPI_PHY_SPI);
    
	// Issue command
	spi_transfer(SPI_PHY_SPI, op);
            
	 //Read/write data
	for (x = 0; x < 2; x++) {
		((uint8_t*) & readed)[x] = spi_transfer(SPI_PHY_SPI, ((uint8_t*) & data)[x]);
	}

    spi_deselect(SPI_PHY_SPI);

    mtc0_Status(rup);

	return readed;
}

static uint32_t exec_32_op(uint8_t op, uint32_t data) {
	uint16_t readed = 0;
    int x;

    int rup = mips_di();
        
    spi_select(SPI_PHY_SPI);

	// Issue command
	spi_transfer(SPI_PHY_SPI, op);

	// Read/write data
	for (x = 0; x < 3; x++) {
		((uint8_t*) & readed)[x] = spi_transfer(SPI_PHY_SPI, ((uint8_t*) & data)[x]);
	}

    spi_deselect(SPI_PHY_SPI);
    
    mtc0_Status(rup);

	return readed;
}

static void change_bank_if_needed(uint8_t bank) {
    if (bank != currentBank) {
        if (bank == (0x0u << 5))
            exec_8_op(B0SEL);
        else if (bank == (0x1u << 5))
            exec_8_op(B1SEL);
        else if (bank == (0x2u << 5))
            exec_8_op(B2SEL);
        else if (bank == (0x3u << 5))
            exec_8_op(B3SEL);

        currentBank = bank;
    }    
}

static void write_reg(uint16_t address, uint16_t data) {
	uint8_t bank;

	bank = ((uint8_t) address) & 0xE0;
	if (bank <= (0x3u << 5)) {
        change_bank_if_needed(bank);
		exec_16_op(WCR | (address & 0x1F), data);
	} else {
		uint32_t data32;
		((uint8_t*) & data32)[0] = (uint8_t) address;
		((uint8_t*) & data32)[1] = ((uint8_t*) & data)[0];
		((uint8_t*) & data32)[2] = ((uint8_t*) & data)[1];
		exec_32_op(WCRU, data32);
	}
}

static uint16_t read_reg(uint16_t address) {
	uint16_t returnValue;
	uint8_t bank;

	bank = ((uint8_t) address) & 0xE0;
	if (bank <= (0x3u << 5)) {
        change_bank_if_needed(bank);
        returnValue = exec_16_op(RCR | (address & 0x1F), 0x0000);
	} else {
		uint32_t returnValue32 = exec_32_op(RCRU, (uint32_t) address);
		((uint8_t*) & returnValue)[0] = ((uint8_t*) & returnValue32)[1];
		((uint8_t*) & returnValue)[1] = ((uint8_t*) & returnValue32)[2];
	}

	return returnValue;
}

static uint16_t read_phy_reg(uint8_t address) {
	uint16_t readed;

	// Set the right address and start the register read operation
	write_reg(MIREGADR, 0x0100 | address);
	write_reg(MICMD, MICMD_MIIRD);

	// Loop to wait until the PHY register has been read through the MII
	// This requires 25.6us
	while (read_reg(MISTAT) & MISTAT_BUSY);

	// Stop reading
	write_reg(MICMD, 0x0000);

	// Obtain results and return
	readed = read_reg(MIRD);

	return readed;
}

static void write_phy_reg(uint8_t address, uint16_t Data) {
	// Write the register address
	write_reg(MIREGADR, 0x0100 | address);

	// Write the data
	write_reg(MIWR, Data);

	// Wait until the PHY register has been written
	while (read_reg(MISTAT) & MISTAT_BUSY);
}

static void bfs_reg(uint16_t address, uint16_t bitMask) {
    uint8_t bank;

    bank = ((uint8_t) address) & 0xE0;
    change_bank_if_needed(bank);
    exec_16_op(BFS | (address & 0x1F), bitMask);
}

static void bfc_reg(uint16_t address, uint16_t bitMask) {
    uint8_t bank;

    bank = ((uint8_t) address) & 0xE0;
    change_bank_if_needed(bank);
    exec_16_op(BFC | (address & 0x1F), bitMask);
}

static void suspend_interrupts() {
    // Disable global interrupts while processing this interrupt
    // to avoid loose events
    bfc_reg(EIE, EIE_INTIE);
}

static void reenable_interrupts() {
    // Clear all interrupt flags
    bfc_reg(EIR, 0xffff);
    
    // Reenable ENC global interrupts
    bfs_reg(EIE, EIE_INTIE);
}

static int phy_reset() {    
    uint16_t ret = 0;
    time_t start, now;
    
    do {
        // Set and clear a few bits that clears themselves upon reset.
        // If EUDAST cannot be written to and your code gets stuck in this
        // loop, you have a hardware problem of some sort (SPI or PMP not
        // initialized correctly, I/O pins aren't connected or are
        // shorted to something, power isn't available, etc.)
        
        time(&start);
        do {
            time(&now);
            if (now - start > 2) {
                return -1;
            }
            write_reg(EUDAST, 0x1234);
        } while ((ret = read_reg(EUDAST)) != 0x1234);
        

        // Issue a reset and wait for it to complete
        bfs_reg(ECON2, ECON2_ETHRST);
	currentBank = 0;

        #define RST_MASK (ESTAT_CLKRDY | ESTAT_RSTDONE | ESTAT_PHYRDY)
        time(&start);
        while (((ret = read_reg(ESTAT)) & RST_MASK) != RST_MASK) {
            time(&now);
            if (now - start > 2) {
                return -1;
            }            
        }

        // Check to see if the reset operation was successful by
        // checking if EUDAST went back to its reset default.  This test
        // should always pass, but certain special conditions might make
        // this test fail, such as a PSP pin shorted to logic high.
    } while (((ret = read_reg(EUDAST)) != 0x0000u) && (ret != 0xffff));

    if (ret == 0xffff) {
        return -1;
    }
    
    // Really ensure reset is done and give some time for power to be stable
    delay(100);
    
    return 0;
}

int en_init(struct netif *netif) {
    currentBank = 0;
    
    // Configure external interrupt line
    IECCLR(PIC32_IRQ_INT2 >> 5) = 1 << (PIC32_IRQ_INT2 & 31); // Disable INT2

    gpio_pin_input(INT2_PIN);           // Configure pin as INPUT
    gpio_disable_analog(INT2_PIN);
    
    INT2R = gpio_input_map3(INT2_PIN);  // Pin map
    
    INTCONSET = (1 << PIC32_INTCON_INT2EP); // Configure as  high-to-low 

    IFSCLR(PIC32_IRQ_INT2 >> 5) = 1 << (PIC32_IRQ_INT2 & 31); // Clear INT2 flag

    // Clear the Ethernet Controller priority and sub-priority
    IPCCLR(PIC32_IRQ_INT2 >> 2) = 0x1f << (5 * (PIC32_IRQ_INT2 & 0x03));

    // Set IPL 2, sub-priority 0
    IPCSET(PIC32_IRQ_INT2 >> 2) = 0x0800;

    // Configure SPI
    if (spi_init(SPI_PHY_SPI) != 0) {
        syslog(LOG_ERR, "netif: cannot open spi%u port", SPI_PHY_SPI);
        return 0;
    }

    spi_set_cspin(SPI_PHY_SPI, SPI_PHY_CS);
    spi_set_speed(SPI_PHY_SPI, SPI_PHY_SPI_KHZ);
    spi_set(SPI_PHY_SPI, PIC32_SPICON_CKE | PIC32_SPICON_SMP);
    
    syslog(LOG_INFO, "netif: phy is at spi%u, pin cs=%c%d, speed %d Mhz", 
            SPI_PHY_SPI, 
            gpio_portname(SPI_PHY_CS), gpio_pinno(SPI_PHY_CS),
            spi_get_speed(SPI_PHY_SPI) / 1000        
    );

    if (phy_reset() < 0) {
        syslog(LOG_ERR, "netif: can't reset phy"); 
        
        return ERR_IF;
    }

    // Initialize RX tracking variables and other control state flags
	nextPacketPointer = ENC424J600_RXSTART;

	// Set up TX/RX/UDA buffer addresses
	write_reg(ETXST,   ENC424J600_TXSTART);
	write_reg(ERXST,   ENC424J600_RXSTART);
	write_reg(ERXTAIL, ENC424J600_RAMSIZE - 2);
	write_reg(EUDAST,  ENC424J600_RAMSIZE);
	write_reg(EUDAND,  ENC424J600_RAMSIZE + 1);

    // Get MAC adress
	uint16_t regValue;
	regValue = read_reg(MAADR1);
    
        netif->hwaddr_len = ETHARP_HWADDR_LEN;
        
	netif->hwaddr[0] = ((uint8_t*) & regValue)[0];
	netif->hwaddr[1] = ((uint8_t*) & regValue)[1];
    
	regValue = read_reg(MAADR2);
	netif->hwaddr[2] = ((uint8_t*) & regValue)[0];
	netif->hwaddr[3] = ((uint8_t*) & regValue)[1];
    
	regValue = read_reg(MAADR3);
	netif->hwaddr[4] = ((uint8_t*) & regValue)[0];
	netif->hwaddr[5] = ((uint8_t*) & regValue)[1];

    LWIP_DEBUGF(NETIF_DEBUG, (
            "netif: mac address is %02x:%02x:%02x:%02x:%02x:%02x",
            netif->hwaddr[0],netif->hwaddr[1],
            netif->hwaddr[2],netif->hwaddr[3],
            netif->hwaddr[4],netif->hwaddr[5]
    ));
   
    // Set PHY Auto-negotiation to support 10BaseT Half duplex,
    // 10BaseT Full duplex, 100BaseTX Half Duplex, 100BaseTX Full Duplex,
    // and symmetric PAUSE capability
    write_phy_reg(PHANA, PHANA_ADPAUS0 | PHANA_AD10FD | PHANA_AD10 | PHANA_AD100FD | PHANA_AD100 | PHANA_ADIEEE0);

    // Enable RX packet reception
    bfs_reg(ECON1, ECON1_RXEN);

    // Enable interrupts
    IECSET(PIC32_IRQ_INT2 >> 5) = 1 << (PIC32_IRQ_INT2 & 31);    
    
    // Clear ENC interrupt flags
    bfc_reg(EIR,  EIR_LINKIF  |  // INT Global Interrupt Enable
                  EIR_LINKIF  |  // PHY Link Status Change Interrupt Enable
                  EIR_PKTIF   |  // RX Packet Pending Interrupt Enable
                  EIR_TXIF    |  // Transmit Done Interrupt Enable
                  EIR_TXABTIF |  // Transmit Abort Interrupt Enable
                  EIR_RXABTIF |  // Receive Abort Interrupt Enable
                  EIR_PCFULIF);  // Packet Counter Full Interrupt Enable     
    
    // Enable ENC interrupts
	bfs_reg( EIE, EIE_INTIE   |  // INT Global Interrupt Enable
                  EIE_LINKIE  |  // PHY Link Status Change Interrupt Enable
                  EIE_PKTIE   |  // RX Packet Pending Interrupt Enable
                  EIE_TXIE    |  // Transmit Done Interrupt Enable
                  EIE_TXABTIE |  // Transmit Abort Interrupt Enable
                  EIE_RXABTIE |  // Receive Abort Interrupt Enable
                  EIE_PCFULIE);  // Packet Counter Full Interrupt Enable        
    
    return ERR_OK;
}

static void mac_flush(void) {
	uint16_t w;

	// Check to see if the duplex status has changed.  This can
	// change if the user unplugs the cable and plugs it into a
	// different node.  Auto-negotiation will automatically set
	// the duplex in the PHY, but we must also update the MAC
	// inter-packet gap timing and duplex state to match.
	if (read_reg(EIR) & EIR_LINKIF) {
		bfc_reg(EIR, EIR_LINKIF);

		// Update MAC duplex settings to match PHY duplex setting
		w = read_reg(MACON2);
		if (read_reg(ESTAT) & ESTAT_PHYDPX) {
			// Switching to full duplex
			write_reg(MABBIPG, 0x15);
			w |= MACON2_FULDPX;
		} else {
			// Switching to half duplex
			write_reg(MABBIPG, 0x12);
			w &= ~MACON2_FULDPX;
		}
		write_reg(MACON2, w);
	}
    
	// Start the transmission, but only if we are linked.  Supressing
	// transmissing when unlinked is necessary to avoid stalling the TX engine
	// if we are in PHY energy detect power down mode and no link is present.
	// A stalled TX engine won't do any harm in itself, but will cause the
	// MACIsTXReady() function to continuously return FALSE, which will
	// ultimately stall the Microchip TCP/IP stack since there is blocking code
	// elsewhere in other files that expect the TX engine to always self-free
	// itself very quickly.
	if (read_reg(ESTAT) & ESTAT_PHYLNK)
            bfs_reg(ECON1, ECON1_TXRTS);
}

static void write_n(uint8_t op, uint8_t* data, uint16_t len) {
    int rup = mips_di();

    spi_select(SPI_PHY_SPI);
    spi_transfer(SPI_PHY_SPI, op);

	while (len--) {
        spi_transfer(SPI_PHY_SPI, *data++);
	}

    spi_deselect(SPI_PHY_SPI);

    mtc0_Status(rup);
}

static void read_n(uint8_t op, uint8_t* data, uint16_t dataLen) {
    int rup = mips_di();

    spi_select(SPI_PHY_SPI);
    spi_transfer(SPI_PHY_SPI, op);
    
	while (dataLen--) {
		*data++ = spi_transfer(SPI_PHY_SPI, 0x00);
	}

    spi_deselect(SPI_PHY_SPI);

    mtc0_Status(rup);
}

static void write_memory_window(uint8_t window, uint8_t *data, uint16_t len) {
	uint8_t op = RBMUDA;

    int rup = mips_di();
    
	if (window & GP_WINDOW)
		op = WBMGP;
	if (window & RX_WINDOW)
		op = WBMRX;

	write_n(op, data, len);
    
    mtc0_Status(rup);
}

static void read_memory_window(uint8_t window, uint8_t *data, uint16_t len) {
    if (len == 0u)
        return;

    int rup = mips_di();
    
    uint8_t op = RBMUDA;

    if (window & GP_WINDOW)
        op = RBMGP;
    if (window & RX_WINDOW)
        op = RBMRX;

    read_n(op, data, len);
    
    mtc0_Status(rup);
}

static int is_phy_linked(void) {
	return (read_reg(ESTAT) & ESTAT_PHYLNK) != 0u;
}

void en_output(struct pbuf *q) {
	write_memory_window(GP_WINDOW, q->payload, q->len);

	write_reg(EGPWRPT, ENC424J600_TXSTART);
	write_reg(ETXLEN, q->len);

	mac_flush();
}

unsigned int en_packet_size() {
	RXSTATUS statusVector;
    unsigned int len;
    
	// Set the RX Read Pointer to the beginning of the next unprocessed packet
	write_reg(ERXRDPT, nextPacketPointer);

	read_memory_window(RX_WINDOW, (uint8_t*) & nextPacketPointer, sizeof (nextPacketPointer));
	read_memory_window(RX_WINDOW, (uint8_t*) & statusVector, sizeof (statusVector));

	len = statusVector.bits.ByteCount - 4;

    return len;
}    
   
 void link_status_change( void * pvParameter1, uint32_t ulParameter2 ) {
  UNUSED_ARG(pvParameter1);
  UNUSED_ARG(ulParameter2);

  uint16_t w;
  
  if (eth_netif.flags & NETIF_FLAG_LINK_UP) {
      // Previous link is up
      if (!is_phy_linked()) {
          // Now link is down
          syslog(LOG_INFO, "netif: link down");

          netif_set_link_down(&eth_netif);
      }
  } else {
    // Previous link is down
    if (is_phy_linked()) {  
        const char *speed;
        const char *duplex;

        // Now link is up

        // Update MAC duplex settings to match PHY duplex setting
        w = read_reg(MACON2);
        if (read_reg(ESTAT) & ESTAT_PHYDPX) {
            duplex = "full";

            // Switching to full duplex
            write_reg(MABBIPG, 0x15);
            w |= MACON2_FULDPX;
        } else {
            duplex = "half";

            // Switching to half duplex
            write_reg(MABBIPG, 0x12);
            w  &= ~MACON2_FULDPX;
        }

        write_reg(MACON2, w);
        
        w = (read_phy_reg(PHSTAT3) & 0b11100) >> 2;
        if ((w == 0b110) || (w == 0b010)) {
            speed = "100";
        } else {
            if ((w == 0b101) || (w == 0b001)) {
                speed = "10";
            } else {
                speed = "?";
            }
        }

        syslog(LOG_INFO, "netif: link up, speed %s Mbps / %s duplex", speed, duplex);

        // Link now is up
        netif_set_link_up(&eth_netif);
    }
  }      
}

void  ether_intr(void) {
    BaseType_t xHigherPriorityTaskWoken = pdFALSE;
    unsigned int flag;
    int reenable = 1;
   
    suspend_interrupts();
    
    // Get cause of this interrupt
    flag = read_reg(EIR);
    if (flag & EIR_LINKIF) {
        // PHY Link Status Change
        xTimerPendFunctionCallFromISR(link_status_change,NULL,0,
                                      &xHigherPriorityTaskWoken);
    } 

    if (flag & EIR_PKTIF) {        
        // One or more RX packets have been saved and are ready for software 
        // processing      
        xTimerPendFunctionCallFromISR(ethernetInput,NULL,0,
                                      &xHigherPriorityTaskWoken);
    
        reenable = 0;
    }
    
    if (flag & EIR_TXIF) {
        // Packet transmission has completed
    }

    if (flag & EIR_TXABTIF) {
        // Packet transmission has been aborted due to an error
    }

    if (flag & EIR_RXABTIF) {
        // An RX packet was dropped because there is insufficient space in the
        // RX buffer to store the complete packet
    }

    if (flag & EIR_PCFULIF) {
        // PKTCNT field has reached FFh. Software must decrement the packet
        // counter to prevent the next RX packet from being dropped
    }

    if (reenable) {
        reenable_interrupts();
    }
    
    // Clear the interrupt flag
    IFSCLR(PIC32_IRQ_INT2 >> 5) = 1 << (PIC32_IRQ_INT2 & 31);

    portEND_SWITCHING_ISR(xHigherPriorityTaskWoken);
}

struct pbuf *low_level_input(struct netif *netif) {
    UNUSED_ARG(netif);
  
    RXSTATUS statusVector;
    uint16_t newRXTail;
    struct pbuf *p, *q;
    u16_t len = 0;
    u16_t frame_size = 0;

    // Set the RX Read Pointer to the beginning of the next unprocessed packet
    write_reg(ERXRDPT, nextPacketPointer);

    read_memory_window(RX_WINDOW, (uint8_t*) & nextPacketPointer, sizeof (nextPacketPointer));
    read_memory_window(RX_WINDOW, (uint8_t*) & statusVector, sizeof (statusVector));

    len = statusVector.bits.ByteCount - 4;
    
    if (statusVector.bits.Zero || statusVector.bits.ZeroH || 
	   statusVector.bits.CRCError ||
	   statusVector.bits.ByteCount > 1522u ||
	   !statusVector.bits.ReceiveOk) {

        reenable_interrupts();
        
        return NULL;
    }
                   
    // If we don't receive nothing, exit
    if (len <= 0) {
        reenable_interrupts();
        
        return NULL;
    }
  
    frame_size = len;

    #if ETH_PAD_SIZE
    len += ETH_PAD_SIZE; /* allow room for Ethernet padding */
    #endif

    /* We allocate a pbuf chain of pbufs from the pool. */
    p = pbuf_alloc(PBUF_RAW, len, PBUF_POOL);
    if (p != NULL) {
        #if LED_NET > 0
        activity = 1;
        gpio_pin_set(LED_NET);
        #endif
        
        #if ETH_PAD_SIZE
        pbuf_header(p, -ETH_PAD_SIZE); /* drop the padding word */
        #endif

        q = p;

        read_memory_window(RX_WINDOW, q->payload, frame_size);

        newRXTail = nextPacketPointer - 2;

        //Special situation if nextPacketPointer is exactly RXSTART
        if (nextPacketPointer == ENC424J600_RXSTART)
            newRXTail = ENC424J600_RAMSIZE - 2;

        //Packet decrement
        bfs_reg(ECON1, ECON1_PKTDEC);

        //Write new RX tail
        write_reg(ERXTAIL, newRXTail);

        #if LED_NET > 0
        gpio_pin_clr(LED_NET);
        activity = 0;
        #endif

        #if ETH_PAD_SIZE
        pbuf_header(p, ETH_PAD_SIZE); /* reclaim the padding word */
        #endif

        LINK_STATS_INC(link.recv);
    } else {
        LINK_STATS_INC(link.memerr);
        LINK_STATS_INC(link.drop);
    }

    reenable_interrupts();

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
        #if LED_NET > 0
        activity = 1;
        gpio_pin_set(LED_NET);
        #endif

        write_memory_window(GP_WINDOW, q->payload, q->len);

        write_reg(EGPWRPT, ENC424J600_TXSTART);
        write_reg(ETXLEN, q->len);

        mac_flush();
        
        #if LED_NET > 0
        gpio_pin_clr(LED_NET);
        activity = 0;
        #endif
    }

    #if ETH_PAD_SIZE
    pbuf_header(p, ETH_PAD_SIZE); /* reclaim the padding word */    
    #endif

    LINK_STATS_INC(link.xmit);

    return ERR_OK;
}

#endif
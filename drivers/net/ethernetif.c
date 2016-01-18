/*
 * Copyright (c) 2001-2004 Swedish Institute of Computer Science.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification,
 * are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice,
 *    this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 * 3. The name of the author may not be used to endorse or promote products
 *    derived from this software without specific prior written permisxsion.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR IMPLIED
 * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT
 * SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT
 * OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
 * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY
 * OF SUCH DAMAGE.
 *
 * This file is part of the lwIP TCP/IP stack.
 *
 * Author: Adam Dunkels <adam@sics.se>
 *
 */

/*
 * This file is a skeleton for developing Ethernet network interface
 * drivers for lwIP. Add code to the low_level functions and do a
 * search-and-replace for the word "ethernetif" to replace it with
 * something that better describes your network interface.
 */

#include "whitecat.h"

#include "FreeRTOS.h"
#include "event_groups.h"
#include "timers.h"

#include "utils/delay.h"

#include "lwip/opt.h"
#include "drivers/net/en.h"
#include "netif/ethernetif.h"

#include "lwip/dhcp.h"
#include "lwip/timers.h"
#include "lwip/def.h"
#include "lwip/mem.h"
#include "lwip/pbuf.h"
#include "lwip/stats.h"
#include "lwip/snmp.h"
#include "lwip/ethip6.h"
#include "netif/etharp.h"
#include "netif/ppp/pppoe.h"

#include "drivers/network/network.h"
#include "drivers/gpio/gpio.h"
#include "drivers/net/en.h"

#include <syslog.h>

#if USE_ETHERNET

/* Define those to better describe your network interface. */
#define IFNAME0 'e'
#define IFNAME1 'n'

extern struct netif eth_netif;
extern struct pbuf *low_level_input(struct netif *netif);
extern err_t low_level_output(struct netif *netif, struct pbuf *p);

// Previous network status
static ip4_addr_t prev_ip_addr;
static u8_t       prev_link;

// This function notifies to the applications status changes on the network
// link, and ip address.
//
// Also starts the dhcp client if necessary at the right time.
static void statusCallback(struct netif *netif) {
    u8_t ip_changed = 0;
    u8_t lk_changed = 0;

    // Check for changes
    ip_changed = (netif->ip_addr.addr != prev_ip_addr.addr);
    lk_changed = (prev_link != ((netif->flags & NETIF_FLAG_LINK_UP) != 0));

    // Store current values
    prev_ip_addr.addr = netif->ip_addr.addr;
    prev_link = ((netif->flags & NETIF_FLAG_LINK_UP) != 0);

    // Notify changes
    if (ip_changed || lk_changed) {
        if (netif->flags & NETIF_FLAG_LINK_UP) {
            if (netif->ip_addr.addr != 0) {
                xEventGroupSetBits(networkEvent, evEthernet_link_up | evEthernet_started);
            } else {
                #if !ETH_USE_FIXED_IP
                    syslog(LOG_INFO, "netif: starting dhcp client");
                    if (!eth_netif.dhcp) {
                        dhcp_start(&eth_netif);
                    }
                #endif
            }
        } else {
            if (netif->ip_addr.addr != 0) {
                xEventGroupSetBits(networkEvent, evEthernet_link_down);
            }
        }
    }
}

static void linkCallback(struct netif *netif) {
    statusCallback(netif);
}

/**
 * Helper struct to hold private data used to operate your ethernet interface.
 * Keeping the ethernet address of the MAC in this struct is not necessary
 * as it is already kept in the struct netif.
 * But this is only an example, anyway...
 */
struct ethernetif {
  struct eth_addr *ethaddr;
  /* Add whatever per-interface state that is needed here. */
};

void ethernetif_watchdog(void *arg);

/**
 * In this function, the hardware should be initialized.
 * Called from ethernetif_init().
 *
 * @param netif the already initialized lwip network interface structure
 *        for this ethernetif
 */
static err_t
low_level_init(struct netif *netif) {
    err_t err;
    
    netif->flags = 0;

#if LED_NET > 0
    gpio_pin_output(LED_NET);
#endif
    
    prev_link = 0;
    bzero(&prev_ip_addr,sizeof(prev_ip_addr));

    netif_set_status_callback(netif, statusCallback);
    netif_set_link_callback(netif, linkCallback);

    err = en_init(netif);
    if (err != ERR_OK) {
        return err;
    }
    
    /* maximum transfer unit */
    netif->mtu = 1500;

    /* device capabilities */
    netif->flags = NETIF_FLAG_BROADCAST | NETIF_FLAG_ETHARP;

#if LWIP_IPV6 && LWIP_IPV6_MLD
  /*
   * For hardware/netifs that implement MAC filtering.
   * All-nodes link-local is handled by default, so we must let the hardware know
   * to allow multicast packets in.
   * Should set mld_mac_filter previously. */
  if (netif->mld_mac_filter != NULL) {
    ip6_addr_t ip6_allnodes_ll;
    ip6_addr_set_allnodes_linklocal(&ip6_allnodes_ll);
    netif->mld_mac_filter(netif, &ip6_allnodes_ll, MLD6_ADD_MAC_FILTER);
  }
#endif /* LWIP_IPV6 && LWIP_IPV6_MLD */

  return ERR_OK;
}

/**
 * This function should do the actual transmission of the packet. The packet is
 * contained in the pbuf that is passed to the function. This pbuf
 * might be chained.
 *
 * @param netif the lwip network interface structure for this ethernetif
 * @param p the MAC packet to send (e.g. IP packet including MAC addresses and type)
 * @return ERR_OK if the packet could be sent
 *         an err_t value if the packet couldn't be sent
 *
 * @note Returning ERR_MEM here if a DMA queue of your MAC is full can lead to
 *       strange results. You might consider waiting for space in the DMA queue
 *       to become available since the stack doesn't retry to send a packet
 *       dropped because of memory failure (except for the TCP timers).
 */




/**
 * This function should be called when a packet is ready to be read
 * from the interface. It uses the function low_level_input() that
 * should handle the actual reception of bytes from the network
 * interface. Then the type of the received packet is determined and
 * the appropriate input function is called.
 *
 * @param netif the lwip network interface structure for this ethernetif
 */
err_t ethernetif_input(struct netif *netif) {
  struct ethernetif *ethernetif;
  struct eth_hdr *ethhdr;
  struct pbuf *p;
  err_t ok = ERR_OK;

  ethernetif = netif->state;
  
  /* move received packet into a new pbuf */
  p = low_level_input(netif);
  /* no packet could be read, silently ignore this */
  if (p == NULL) return ok;
  /* points to packet payload, which starts with an Ethernet header */
  ethhdr = p->payload;

  switch (htons(ethhdr->type)) {
  /* IP or ARP packet? */
  case ETHTYPE_IP:
  case ETHTYPE_IPV6:
  case ETHTYPE_ARP:
#if PPPOE_SUPPORT
  /* PPPoE packet? */
  case ETHTYPE_PPPOEDISC:
  case ETHTYPE_PPPOE:
#endif /* PPPOE_SUPPORT */
    /* full packet send to tcpip_thread to process */
    ok = netif->input(p, netif);
    if (ok!=ERR_OK) { 
       LWIP_DEBUGF(NETIF_DEBUG, ("ethernetif_input: IP input error\n"));
       pbuf_free(p);
       p = NULL;
     }
    break;

  default:
    pbuf_free(p);
    p = NULL;
    break;
  }
  
  return ok;
}

/**
 * Should be called at the beginning of the program to set up the
 * network interface. It calls the function low_level_init() to do the
 * actual setup of the hardware.
 *
 * This function should be passed as a parameter to netif_add().
 *
 * @param netif the lwip network interface structure for this ethernetif
 * @return ERR_OK if the loopif is initialized
 *         ERR_MEM if private data couldn't be allocated
 *         any other err_t on error
 */
err_t ethernetif_init(struct netif *netif) {
  struct ethernetif *ethernetif;

  LWIP_ASSERT("netif != NULL", (netif != NULL));

  ethernetif = mem_malloc(sizeof(struct ethernetif));
  if (ethernetif == NULL) {
    LWIP_DEBUGF(NETIF_DEBUG, ("ethernetif_init: out of memory\n"));
    return ERR_MEM;
  }

#if LWIP_NETIF_HOSTNAME
  /* Initialize interface hostname */
  netif->hostname = "lwip";
#endif /* LWIP_NETIF_HOSTNAME */

  /*
   * Initialize the snmp variables and counters inside the struct netif.
   * The last argument should be replaced with your link speed, in units
   * of bits per second.
   */
  NETIF_INIT_SNMP(netif, snmp_ifType_ethernet_csmacd, LINK_SPEED_OF_YOUR_NETIF_IN_BPS);

  netif->state = ethernetif;
  netif->name[0] = IFNAME0;
  netif->name[1] = IFNAME1;
  /* We directly use etharp_output() here to save a function call.
   * You can instead declare your own function an call etharp_output()
   * from it if you have to do some checks before sending (e.g. if link
   * is available...) */
  netif->output = etharp_output;
#if LWIP_IPV6
  netif->output_ip6 = ethip6_output;
#endif /* LWIP_IPV6 */
  netif->linkoutput = low_level_output;

  /* initialize the hardware */
  err_t ok = low_level_init(netif);

  ethernetif->ethaddr = (struct eth_addr *)&(netif->hwaddr[0]);

  return ok;
}

void ethernetInput( void * pvParameter1, uint32_t ulParameter2 ) {
    UNUSED_ARG(pvParameter1);
    UNUSED_ARG(ulParameter2);
    
    ethernetif_input(&eth_netif);
}

int ethernet_init() {
    ip_addr_t  ip_addr;             // Local ip address
    ip_addr_t  gateway;             // Gateway ip address
    ip_addr_t  netmask;             // Netmask
    void      *state = NULL;

    // Add ethernet interface
    ip_addr.addr = eth_ip;
    netmask.addr = eth_netmask;
    gateway.addr = eth_gateway;

    if (netif_add(&eth_netif, &ip_addr, &netmask, &gateway, state, ethernetif_init, ethernet_input) == NULL) {
        return -1;
    } else {
        netif_set_default(&eth_netif);
        netif_set_up(&eth_netif);

        return 0;
        
        #if USE_PIC_PHY
        // Create a timer for monitor ethernet link every 500 ms
        TimerHandle_t xTimer = NULL;
        xTimer = xTimerCreate("ethwd", 500, pdTRUE, (void *) 0, en_watchdog);

        if(xTimer != NULL ){
            xTimerStart( xTimer, 0 );
        }
        #endif
    }
}

void ethernet_stop() {
    #if !ETH_USE_FIXED_IP
        dhcp_stop(&eth_netif);
    #endif
        
    netif_remove(&eth_netif);
    
    eth_netif.ip_addr.addr = IP4_GET_ADDR(0,0,0,0);
    eth_netif.gw.addr = IP4_GET_ADDR(0,0,0,0);
    eth_netif.netmask.addr = IP4_GET_ADDR(0,0,0,0);

    eth_netif.hwaddr[0] = 0;
    eth_netif.hwaddr[1] = 0;
    eth_netif.hwaddr[2] = 0;
    eth_netif.hwaddr[3] = 0;
    eth_netif.hwaddr[4] = 0;
    eth_netif.hwaddr[5] = 0;
}

#endif
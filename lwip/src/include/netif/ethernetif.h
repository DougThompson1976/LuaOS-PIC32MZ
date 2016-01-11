/* 
 * File:   ethernetif.h
 * Author: jolive
 *
 * Created on 23 / abril / 2015, 16:53
 */

#ifndef ETHERNETIF_H
#define	ETHERNETIF_H

#include "lwip/netif.h"

err_t ethernetif_init(struct netif *netif);
err_t ethernetif_input(struct netif *netif);

#endif	/* ETHERNETIF_H */
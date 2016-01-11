/* 
 * File:   netif.h
 * Author: jolive
 *
 * Created on 22 / abril / 2015, 19:48
 */

#ifndef NETIF_H
#define	NETIF_H

void ethernetif_init(struct netif *netif);
void ethernetif_input(struct netif *netif);

#endif	/* NETIF_H */


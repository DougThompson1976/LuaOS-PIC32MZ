#ifndef EN_H
#define	EN_H

#include "lwip/netif.h"

void en_output(struct pbuf *q);
unsigned int en_packet_size();
void en_input(struct pbuf *q, unsigned int len,  unsigned int frame_size);
void en_watchdog(void *arg);
int en_init(struct netif *netif);

#endif	/* EN_H */
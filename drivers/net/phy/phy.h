#ifndef _ETH_PHY_H_
#define _ETH_PHY_H_

#include "whitecat.h"

#if USE_PIC_PHY

/*
 * DMA buffer descriptor.
 */
typedef struct {
    u32_t hdr;              /* Flags */
    u32_t paddr;            /* Phys address of data buffer */
    u32_t ctl;              /* TX options / RX filter status */
    u32_t status;           /* Status */
} eth_desc_t;


#define MCLBYTES            512
#define ETHER_MAX_LEN       1536
#define RX_PACKETS          4
#define RX_BYTES_PER_DESC   MCLBYTES
#define RX_BYTES            (RX_PACKETS * ETHER_MAX_LEN)
#define RX_DESCRIPTORS      (RX_BYTES / RX_BYTES_PER_DESC)
#define TX_DESCRIPTORS      6

#define PHY_CONTROL                 0       /* Basic Control Register */
#define PHY_STATUS                  1       /* Basic Status Register */
#define PHY_ID1                     2       /* PHY identifier 1 */
#define PHY_ID2                     3       /* PHY identifier 2 */
#define PHY_ADVRT                   4       /* Auto-negotiation advertisement */

#define PHY_MOD_CONTROL             17      /* Mode Control / Status  */


#define PHY_ID_LAN8720A         0x0007c0f0  /* SMSC LAN8720A */
#define PHY_ID_LAN8740A         0x0007c110  /* SMSC LAN8740A */
#define PHY_ID_LAN9303          0x0007c0d0  /* SMSC LAN9303 */
#define PHY_ID_IP101G           0x02430c50  /* IC+ IP101G */

#endif

#endif	// _ETH_PHY_H_

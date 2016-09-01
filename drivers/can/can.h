/*
 * Whitecat, CAN driver
 *
 * Copyright (C) 2015 - 2016
 * IBEROXARXA SERVICIOS INTEGRALES, S.L. & CSS IBÉRICA, S.L.
 * 
 * Author: Jaume Olivé (jolive@iberoxarxa.com / jolive@whitecatboard.org)
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
#include "FreeRTOS.h"
#include "queue.h"

#ifndef CAN_H
#define	CAN_H

#define CAN_MAX_LEN 8

#define CAN_1TQ 0
#define CAN_2TQ 1
#define CAN_3TQ 2
#define CAN_4TQ 3
#define CAN_5TQ 4
#define CAN_6TQ 5
#define CAN_7TQ 6
#define CAN_8TQ 7
        
#define CAN_LOWEST_PRIO   0
#define CAN_LOW_MED_PRIO  1
#define CAN_HIGH_MED_PRIO 2
#define CAN_HIGHEST_PRIO  3
                
#define CAN_BUFF_SIZE (2 * 20 * 16)

/* Create a CMSGSID data type. */
typedef struct {
    unsigned SID:11;
    unsigned :21;
} txcmsgsid;

/* Create a CMSGEID data type. */
typedef struct {
    unsigned DLC:4;
    unsigned RB0:1;
    unsigned :3;
    unsigned RB1:1;
    unsigned RTR:1;
    unsigned EID:18;
    unsigned IDE:1;
    unsigned SRR:1;
    unsigned :2;
} txcmsgeid;

/* Create a CMSGDATA0 data type. */
typedef struct {
    unsigned Byte0:8;
    unsigned Byte1:8;
    unsigned Byte2:8;
    unsigned Byte3:8;
} txcmsgdata0;

/* Create a CMSGDATA1 data type. */
typedef struct {
    unsigned Byte4:8;
    unsigned Byte5:8;
    unsigned Byte6:8;
    unsigned Byte7:8;
} txcmsgdata1;

/* This is the main data structure. */
typedef union uCANTxMessageBuffer {
    struct {
        txcmsgsid CMSGSID;
        txcmsgeid CMSGEID;
        unsigned char data[8];
    };
    int messageWord[4];
} canMessage;

#if USE_CAN
#define NCAN    1
#else
#define NCAN    0
#endif

#define CAN_CON_REQOP_CONF_MASK 0xFCFFFFFF
#define CAN_CON_REQOP_NORM_MASK 0xF8FFFFFF
#define CAN_CON_OPMOD_CONF_VAL  0x00800000
#define CAN_CON_OPMOD_NORM_VAL  0x00000000

#define CAN_CON_OPMOD_MASK 0x00E00000

#define CAN_DEF_TIMEOUT               100
#define PIC32_CxCON_ABAT_MASK         (1 << 27)
#define PIC32_CxCON_ABAT_ON           (1 << 27)
#define PIC32_CxCON_ABAT_OFF          (0 << 27)
#define PIC32_CxCON_REQOP_MASK        (0b111 << 24)
#define PIC32_CxCON_REQOP_LISTEN_ALL  (0b111 << 24)
#define PIC32_CxCON_REQOP_CONFIG      (0b100 << 24)
#define PIC32_CxCON_REQOP_LISTEN_ONLY (0b011 << 24)
#define PIC32_CxCON_REQOP_LOOPBACK    (0b010 << 24)
#define PIC32_CxCON_REQOP_DISABLE     (0b001 << 24)
#define PIC32_CxCON_REQOP_NORMAL      (0b000 << 24)
#define PIC32_CxCON_OPMOD_MASK        (0b111 << 21)
#define PIC32_CxCON_OPMOD_LISTEN_ALL  (0b111 << 21)
#define PIC32_CxCON_OPMOD_CONFIG      (0b100 << 21)
#define PIC32_CxCON_OPMOD_LISTEN_ONLY (0b011 << 21)
#define PIC32_CxCON_OPMOD_LOOPBACK    (0b010 << 21)
#define PIC32_CxCON_OPMOD_DISABLE     (0b001 << 21)
#define PIC32_CxCON_OPMOD_NORMAL      (0b000 << 21)
#define PIC32_CxCON_CAP_MASK          (1 << 20)
#define PIC32_CxCON_CAP_ON            (1 << 20)
#define PIC32_CxCON_CAP_OFF           (0 << 20)
#define PIC32_CxCON_ON_MASK           (1 << 15)
#define PIC32_CxCON_ON                (1 << 15)
#define PIC32_CxCON_OFF               (0 << 15)
#define PIC32_CxCON_SIDLE_MASK        (1 << 13)
#define PIC32_CxCON_SIDLE_ON          (1 << 13)
#define PIC32_CxCON_SIDLE_OFF         (0 << 13)
#define PIC32_CxCON_CANBUSY_MASK      (1 << 11)
#define PIC32_CxCON_CANBUSY_ON        (1 << 11)
#define PIC32_CxCON_CANBUSY_OFF       (0 << 11)
#define PIC32_CxCON_DNCNT_MASK        (0b11111)
#define PIC32_CxFIFOCON_UNIC_MASK     (1 << 13)
#define PIC32_CxFIFOCON_TXREQ_MASK    (1 << 3)
#define PIC32_CxINT_RBIE              (1 << 17)

#define PIC32_CAN_FIFO_INT_TXNFULLIE  (1 << 26)
#define PIC32_CAN_FIFO_INT_TXHALFIE   (1 << 25)
#define PIC32_CAN_FIFO_INT_TXEMPTYIE  (1 << 24)
#define PIC32_CAN_FIFO_INT_RXOVFLIE   (1 << 19)
#define PIC32_CAN_FIFO_INT_RXFULLIE   (1 << 18)
#define PIC32_CAN_FIFO_INT_RXHALFIE   (1 << 17)
#define PIC32_CAN_FIFO_INT_RXNEMPTYIE (1 << 16)
#define PIC32_CAN_FIFO_INT_TXNFULLIF  (1 << 10)
#define PIC32_CAN_FIFO_INT_TXHALFIF   (1 << 9)
#define PIC32_CAN_FIFO_INT_TXEMPTYIF  (1 << 8)
#define PIC32_CAN_FIFO_INT_RXOVFLIF   (3 << 9)
#define PIC32_CAN_FIFO_INT_RXFULLIF   (2 << 9)
#define PIC32_CAN_FIFO_INT_RXHALFIF   (1 << 9)
#define PIC32_CAN_FIFO_INT_RXNEMPTYIF (1 << 0)

#define PIC32_CxINT_IVRIE             (1 << 31)
#define PIC32_CxINT_WAKIE             (1 << 30)
#define PIC32_CxINT_CERRIE            (1 << 29)
#define PIC32_CxINT_SERRIE            (1 << 28)
#define PIC32_CxINT_RBOVIE            (1 << 27)
#define PIC32_CxINT_MODIE             (1 << 19)
#define PIC32_CxINT_CTMRIE            (1 << 18)
#define PIC32_CxINT_RBIE              (1 << 17)
#define PIC32_CxINT_TBIE              (1 << 16)
#define PIC32_CxINT_IVRIF             (1 << 15)
#define PIC32_CxINT_WAKIF             (1 << 14)
#define PIC32_CxINT_CERRIF            (1 << 13)
#define PIC32_CxINT_SERRIF            (1 << 12)
#define PIC32_CxINT_RBOVIF            (1 << 11)
#define PIC32_CxINT_MODIF             (1 << 3)
#define PIC32_CxINT_CTMRIF            (1 << 2)
#define PIC32_CxINT_RBIF              (1 << 1)
#define PIC32_CxINT_TBIF              (1 << 0)

#define PIC32_CxVEC_ICODE_MASK        (0b1111111)


struct can_irq {
    int num;                            /* Receive error interrupt number */
    unsigned irq_mask;                  /* Receive error irq bitmask */
    unsigned ipc_mask; 
    volatile unsigned *iecset;          
    volatile unsigned *iecclr;         
    volatile unsigned *ipcset;          
    volatile unsigned *ipcclr;         
    volatile unsigned *ifsclr;         
};

struct can_fifo_reg {
    volatile unsigned fifoba;
    volatile unsigned fifobaclr;
    volatile unsigned fifobaset;
    volatile unsigned fifobainv;
    volatile unsigned fifocon;
    volatile unsigned fifoconclr;
    volatile unsigned fifoconset;
    volatile unsigned fifoconinv;
    volatile unsigned fifoint;
    volatile unsigned fifointclr;
    volatile unsigned fifointset;
    volatile unsigned fifointinv;
    volatile unsigned fifoua;
    volatile unsigned fifouaclr;
    volatile unsigned fifouaset;
    volatile unsigned fifouainv;
};

struct can_accf_reg {
    volatile unsigned rxf;
    volatile unsigned rxfclr;
    volatile unsigned rxfset;
    volatile unsigned rxfinv;
};

struct can_conf_reg {
    volatile unsigned con;
    volatile unsigned conclr;
    volatile unsigned conset;
    volatile unsigned coninv;
    volatile unsigned cfg;
    volatile unsigned cfgclr;
    volatile unsigned cfgset;
    volatile unsigned cfginv;
    volatile unsigned intr;
    volatile unsigned intrclr;
    volatile unsigned intrset;
    volatile unsigned intrinv;
    volatile unsigned vec;
    volatile unsigned vecclr;
    volatile unsigned vecset;
    volatile unsigned vecinv;
    volatile unsigned trec;
    volatile unsigned trecclr;
    volatile unsigned trecset;
    volatile unsigned trecinv;
    volatile unsigned fstat;
    volatile unsigned fstatclr;
    volatile unsigned fstatset;
    volatile unsigned fstatinv;
    volatile unsigned rxovf;
    volatile unsigned rxovfclr;
    volatile unsigned rxovfset;
    volatile unsigned rxovfinv;
    volatile unsigned tmr;
    volatile unsigned tmrclr;
    volatile unsigned tmrset;
    volatile unsigned tmrinv;
    volatile unsigned rxm0;
    volatile unsigned rxm0clr;
    volatile unsigned rxm0set;
    volatile unsigned rxm0inv;
    volatile unsigned rxm1;
    volatile unsigned rxm1clr;
    volatile unsigned rxm1set;
    volatile unsigned rxm1inv;
    volatile unsigned rxm2;
    volatile unsigned rxm2clr;
    volatile unsigned rxm2set;
    volatile unsigned rxm2inv;
    volatile unsigned rxm3;
    volatile unsigned rxm3clr;
    volatile unsigned rxm3set;
    volatile unsigned rxm3inv;
    volatile unsigned fltcon0;
    volatile unsigned fltcon0clr;
    volatile unsigned fltcon0set;
    volatile unsigned fltcon0inv;
    volatile unsigned fltcon1;
    volatile unsigned fltcon1clr;
    volatile unsigned fltcon1set;
    volatile unsigned fltcon1inv;
    volatile unsigned fltcon2;
    volatile unsigned fltcon2clr;
    volatile unsigned fltcon2set;
    volatile unsigned fltcon2inv;
    volatile unsigned fltcon3;
    volatile unsigned fltcon3clr;
    volatile unsigned fltcon3set;
    volatile unsigned fltcon3inv;
    volatile unsigned fltcon4;
    volatile unsigned fltcon4clr;
    volatile unsigned fltcon4set;
    volatile unsigned fltcon4inv;
    volatile unsigned fltcon5;
    volatile unsigned fltcon5clr;
    volatile unsigned fltcon5set;
    volatile unsigned fltcon5inv;
    volatile unsigned fltcon6;
    volatile unsigned fltcon6clr;
    volatile unsigned fltcon6set;
    volatile unsigned fltcon6inv;
    volatile unsigned fltcon7;
    volatile unsigned fltcon7clr;
    volatile unsigned fltcon7set;
    volatile unsigned fltcon7inv;
};

struct can_stats {
    unsigned long long rx;
    unsigned long long tx;
    unsigned long long rxerr;
    unsigned long long txerr;
    unsigned int       rxqueued;
    unsigned int       rxunqueued;
};

struct can {
    struct can_conf_reg *conf;
    struct can_fifo_reg *fifo;
    struct can_accf_reg *accf;
    struct can_irq       irqs;    
    unsigned char        buff[CAN_BUFF_SIZE];
    char name[5];
    QueueHandle_t        q;
    struct can_stats     stats;
};

void can_pins(int unit, unsigned char *rx, unsigned char *tx);

#endif	/* CAN_H */


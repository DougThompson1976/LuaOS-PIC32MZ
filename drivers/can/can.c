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
 * whatsoever resulting from loss of use, ƒintedata or profits, whether
 * in an action of contract, negligence or other tortious action,
 * arising out of or in connection with the use or performance of
 * this software.
 */

#include "whitecat.h"

#ifdef USE_CAN

#define CAN_BUS_SPEED   250000

#include "FreeRTOS.h"
#include "queue.h"
#include "task.h"
#include "semphr.h"

#include "can.h"
#include <machine/pic32mz.h>
#include <sys/kmem.h>
#include <strings.h>
#include <syslog.h>

#include "drivers/gpio/gpio.h"
#include "drivers/can/can.h"

#define CAN_IRQ_INIT(name) { \
        name,  \
        1 << (name & 31), \
        0x1f << (8 * (name & 0x03)), \
        &IECSET(name >> 5), \
        &IECCLR(name >> 5), \
        &IPCSET(name >> 2), \
        &IPCCLR(name  >> 2), \
        &IFSCLR(name  >> 5), \
    }

struct can can[NCAN] = {
    {
        (struct can_conf_reg*) &C1CON, (struct can_fifo_reg*) &C1FIFOBA,
        (struct can_accf_reg*) &C1RXF0, CAN_IRQ_INIT(PIC32_IRQ_CAN1), {}, 
        "can1", 0
    },
#if NCAN > 1     
    {
        (struct can_conf_reg*) &C2CON, (struct can_fifo_reg*) &C2FIFOBA,
        (struct can_accf_reg*) &C2RXF0, CAN_IRQ_INIT(PIC32_IRQ_CAN2), {}, 
        "can2", 0
    }
#endif
};

void can_pins(int unit, unsigned char *rx, unsigned char *tx) {
    int channel = unit - 1;

    switch (channel) {
        case 0:
            *rx = CAN1_PINS >> 8 & 0xFF;
            *tx = CAN1_PINS & 0xFF;
            break;
        case 1:
            *rx = CAN2_PINS >> 8 & 0xFF;
            *tx = CAN2_PINS & 0xFF;
            break;
    }
}

// Set CAN module into config mode
int can_config_mode(unsigned int unit) {
    register struct can_conf_reg *conf;
    unsigned time_start;
    unsigned timeout;
    unsigned int abat;
    unsigned int sidle;
    unsigned int dncnt;
    
    conf = can[unit - 1].conf;    

    abat = conf->con & PIC32_CxCON_ABAT_MASK;
    sidle = conf->con & PIC32_CxCON_SIDLE_MASK;
    dncnt = conf->con & PIC32_CxCON_DNCNT_MASK;

    conf->con = abat                     |
                PIC32_CxCON_REQOP_CONFIG |
                PIC32_CxCON_CAP_OFF      |
                PIC32_CxCON_ON           |
                sidle                    |
                dncnt;

    time_start = ReadCoreTimer();
    timeout = (CPU_HZ / 2000) * CAN_DEF_TIMEOUT;

    while ((conf->con & PIC32_CxCON_OPMOD_MASK) != PIC32_CxCON_OPMOD_CONFIG) {
        if (ReadCoreTimer() - time_start > timeout) {
            return -1;
        }
    }
    
    return 0;
}

// Set CAN module into normal mode
int can_normal_mode(unsigned int unit) {
    register struct can_conf_reg *conf;
    unsigned time_start;
    unsigned timeout;
    unsigned int abat;
    unsigned int sidle;
    unsigned int dncnt;
    
    conf = can[unit - 1].conf;    

    abat = conf->con & PIC32_CxCON_ABAT_MASK;
    sidle = conf->con & PIC32_CxCON_SIDLE_MASK;
    dncnt = conf->con & PIC32_CxCON_DNCNT_MASK;

    conf->con = abat                     |
                PIC32_CxCON_REQOP_NORMAL |
                PIC32_CxCON_CAP_OFF      |
                PIC32_CxCON_ON           |
                sidle                    |
                dncnt;

    time_start = ReadCoreTimer();
    timeout = (CPU_HZ / 2000) * CAN_DEF_TIMEOUT;

    while ((conf->con & PIC32_CxCON_OPMOD_MASK) != PIC32_CxCON_OPMOD_NORMAL) {
        if (ReadCoreTimer() - time_start > timeout) {
            return -1;
        }
    }
    
    return 0;
}

// Enable CAN module
int can_enable(unsigned int unit) {
    register struct can_conf_reg *conf;
    
    conf = can[unit - 1].conf;    
    conf->conset = PIC32_CxCON_ON_MASK;
    
    return 0;
}

// Test for CAN module enabled
int can_enabled(unsigned int unit) {
    register struct can_conf_reg *conf;
    
    conf = can[unit - 1].conf;   

    return (conf->con & PIC32_CxCON_ON_MASK);
}

// Disable CAN module
int can_disable(unsigned int unit) {
    register struct can_conf_reg *conf;
    unsigned time_start;
    unsigned timeout;
    
    conf = can[unit - 1].conf;    
    
    // According to the datasheet CAN module must be in configuration
    // mode before disable it
    if (can_config_mode(unit) < 0) {
        return -1;
    }
    
    // Disable the module
    conf->conclr = PIC32_CxCON_ON_MASK;
    
    // Wait for disabled
    time_start = ReadCoreTimer();
    timeout = (CPU_HZ / 2000) * CAN_DEF_TIMEOUT;

    while (conf->con & PIC32_CxCON_CANBUSY_MASK) {
        if (ReadCoreTimer() - time_start > timeout) {
            return -1;
        }
    }
    
    return 0;
}

void can_set_speed(unsigned int unit, unsigned int speed,
                   unsigned int phase_seg1,
                   unsigned int phase_seg2, unsigned int propagation_seg,
                   unsigned int phase_seg2_ts, unsigned int sample3_time,
                   unsigned int sync_jump_width
) {
    register struct can_conf_reg *conf;    
    unsigned int total_tq;
    unsigned int prescalar;
    
    conf = can[unit - 1].conf;    
    
    total_tq = (phase_seg1 + 1) + (phase_seg2 + 1) + (propagation_seg + 1) + 1;
    prescalar = (PBCLK5_HZ / (speed * total_tq * 2)) - 1;
    
    conf->cfg = (phase_seg2 << 16)     | // SEG2PH
                (phase_seg2_ts << 15)  | // SEG2PHTS
                (sample3_time << 14)   | // SAM
                (phase_seg1 << 11)     | // SEG1PH
                (propagation_seg << 8) | // PRSEG
                (sync_jump_width << 6) | // SJW
                prescalar;               // BRP
}

void can_set_buffer(unsigned int unit, unsigned char *buff) {
    register struct can_fifo_reg *fifo;
    
    fifo = can[unit - 1].fifo;
    fifo->fifoba = KVA_TO_PA(buff);
}

void can_filter(unsigned int unit, unsigned int chan, unsigned int sid,
                unsigned int eid, unsigned int sid_mask, unsigned int eid_mask) {
    register struct can_conf_reg *conf;   
    register struct can_accf_reg *accf;   

    conf = can[unit - 1].conf; 
    accf = can[unit - 1].accf; 

    conf->fltcon0 = (0 << 4); // FSEL0: use fifo 0
    
    *(&accf->rxf + (0x10 * chan)) = (sid << 21) | // SID
                                     eid;         // EXID
    

    conf->rxm0 = (sid_mask << 21) | // SID
                 (eid_mask << 17) | // EID
                 (1 << 19);         // MIDE: Match only message types
    
    conf->fltcon0set = (1 << 7); // FLTEN0
}

// Configure CAN channel for tx
int can_configure_tx_channel(unsigned int unit, unsigned int chan,
                             unsigned int prio, unsigned int rtr) 
{
    register struct can_fifo_reg *fifo;
    
    fifo = can[unit - 1].fifo;

    if (can_config_mode(unit) < 0) {
        return -1;
    }

    *(&fifo->fifocon + (0x40 * chan)) = ((CAN_BUFF_SIZE / 2) << 16) | // FSIZE
                                        (1 << 7)                    | // TXEN
                                        (1 << 2)                    | // RTR
                                        prio;                         // TXPR    

    if (can_normal_mode(unit) < 0) {
        return -1;
    }
    
    return 0;
}

// Configure CAN channel for rx
int can_configure_rx_channel(unsigned int unit, unsigned int chan,
                             unsigned int data_only)
{
    register struct can_conf_reg *conf;
    register struct can_fifo_reg *fifo;
    register struct can_irq      *irqs;
    
    conf = can[unit - 1].conf;
    fifo = can[unit - 1].fifo;
    irqs = &can[unit - 1].irqs;

    if (can_config_mode(unit) < 0) {
        return -1;
    }
    
    *(&fifo->fifocon + (0x40 * chan)) = ((CAN_BUFF_SIZE / 2) << 16) | // FSIZE
                                        (data_only << 12);            // DONLY
    
    // Default filter, accept all sid, all eid
    can_filter(unit, chan, 0, 0, 0, 0);
     
    // Enable interrupts
    *(&fifo->fifointset + (0x40 * chan)) = PIC32_CAN_FIFO_INT_RXNEMPTYIE;

    *irqs->ipcset = irqs->ipc_mask & 0x08080808;
    *irqs->iecset = irqs->irq_mask;

    conf->intrset = PIC32_CxINT_RBIE;
    
    if (can_normal_mode(unit) < 0) {
        return -1;
    }
    
    return 0;
}

// Increment head / tail buffer
void can_update(unsigned int unit, unsigned int chan) {
    unit--;
    *(&can[unit].fifo->fifoconset + (0x40 * chan)) = PIC32_CxFIFOCON_UNIC_MASK;
}

// Start transmission
void can_flush_tx(unsigned int unit, unsigned int chan) {
    unit--;
    *(&can[unit].fifo->fifoconset + (0x40 * chan)) = PIC32_CxFIFOCON_TXREQ_MASK;
}

// Transmit standard data frame
void can_tx(unsigned int unit, unsigned int chan, canMessage *frame) 
{
    canMessage *buff;
    register struct can_fifo_reg *fifo;
    register int i;
    
    fifo = can[unit - 1].fifo;
        
    // Wait for tx
    while (!(*(&fifo->fifoint + (0x40 * chan)) & (1 << 10))) {
        can_flush_tx(unit, chan);    
    }
    
    // Get buffer and clear
    buff = (canMessage *)(PA_TO_KVA1(*(&fifo->fifoua + (0x40 * chan))));
    memcpy(buff, frame, sizeof(canMessage));
    
    can_update(unit, chan);
    can_flush_tx(unit, chan);
    
    can[unit - 1].stats.tx++;
}

// Receive standard data frame
void can_rx(unsigned int unit, unsigned int chan, canMessage *frame) {
    if (xQueueReceive(can[unit - 1].q, frame, (TickType_t)(portMAX_DELAY)) == pdTRUE) {        
        if (can[unit - 1].stats.rxqueued > 0) {
            can[unit - 1].stats.rxqueued--;
        }
    }
}

static int assign_rx(int unit, int pin) {
    unit--;
    switch (unit) {
        case 0: C1RXR = gpio_input_map2(pin); break;
        case 1: C2RXR = gpio_input_map3(pin); break;
    }
    
    return 0;
}

static int assign_tx(int unit, int pin) {
    volatile unsigned *rpreg = NULL;
    
    unit--;
    if (unit == 0) {
        switch (pin) {
            case RP('D',2):  rpreg = &RPD2R; break;
            case RP('G',8):  rpreg = &RPG8R; break;
            case RP('F',4):  rpreg = &RPF4R; break;
            case RP('D',10): rpreg = &RPD10R; break;
            case RP('F',1):  rpreg = &RPF1R; break;
            case RP('B',9):  rpreg = &RPB9R; break;
            case RP('B',10): rpreg = &RPB10R; break;
            case RP('C',14): rpreg = &RPC14R; break;
            case RP('B',5):  rpreg = &RPB5R; break;
            case RP('C',1):  rpreg = &RPC1R; break;
            case RP('D',14): rpreg = &RPD14R; break;
            case RP('G',1):  rpreg = &RPG1R; break;
            case RP('A',14): rpreg = &RPA14R; break;
            case RP('D',6):  rpreg = &RPD6R; break;
        }        
    }
    
    if (unit == 1) {
        switch (pin) {
            case RP('D',1):  rpreg = &RPD1R; break;
            case RP('G',9):  rpreg = &RPG9R; break;
            case RP('B',14): rpreg = &RPB14R; break;
            case RP('D',0):  rpreg = &RPD0R; break;
            case RP('B',6):  rpreg = &RPB6R; break;
            case RP('D',5):  rpreg = &RPD5R; break;
            case RP('B',2):  rpreg = &RPB2R; break;
            case RP('F',3):  rpreg = &RPF3R; break;
            case RP('F',13): rpreg = &RPF13R; break;
            case RP('C',2):  rpreg = &RPC2R; break;
            case RP('E',8):  rpreg = &RPE8R; break;
            case RP('F',2):  rpreg = &RPF2R; break;
        }        
    }
    
    if (rpreg) {
        *rpreg = 0b1111;
    } else {
        syslog(LOG_ERR, "%s: cannot map tx pin %c%d", can[unit+1].name,
              gpio_portname(pin), gpio_pinno(pin) 
        );       
        
        return -1;
    }
    
    return 0;
}

int can_init(unsigned int unit, unsigned int speed) {
    register struct can_conf_reg *conf;
    register struct can_fifo_reg *fifo;
    register struct can_irq      *irqs;
    
    unsigned char *buff;
    unsigned char rx, tx;
    
    speed = speed * 1000;
    
    // Enable module
    switch (unit) {
        case 1: PMD5CLR = CAN1MD; break;
        case 2: PMD5CLR = CAN2MD; break;
    }

    if (speed == 0) {
        speed = CAN_BUS_SPEED;
    }

    conf = can[unit - 1].conf;
    fifo = can[unit - 1].fifo;
    irqs = &can[unit - 1].irqs;
    
    conf->intr = 0;
        
    // If CAN module is enabled, disable first for reset
    if (can_enabled(unit)) {
        can_disable(unit);
    }
    
    // Enable CAN module
    if (can_enable(unit) < 0) {
        return -1;
    }
    
    // Assign rx / tx pins
    can_pins(unit, &rx, &tx);
            
    if (assign_rx(unit, rx) < 0) {
        return -1;
    }
    
    if (assign_tx(unit, tx) < 0) {
        return -1;
    }
    
    gpio_pin_input(rx);
    gpio_pin_output(tx);
    gpio_disable_analog(rx);

    syslog(LOG_INFO, "%s: at pins rx=%c%d/tx=%c%d, speed %d Khz, interrupt %d",can[unit - 1].name,
        gpio_portname(rx), gpio_pinno(rx),
        gpio_portname(tx), gpio_pinno(tx),
        speed / 1000, irqs->num);
    
    if (can_config_mode(unit) < 0) {
        return -1;
    }
    
    can_set_speed(unit, speed, CAN_3TQ, CAN_3TQ, CAN_3TQ, 1, 1, CAN_2TQ);    
    can_set_buffer(unit, can[unit - 1].buff);

    if (can_normal_mode(unit) < 0) {
        return -1;
    }

    if (can[unit - 1].q != 0) {
        vQueueDelete(can[unit - 1].q);
    }
    
    can[unit - 1].q = xQueueCreate(CAN_RX_QUEUE, sizeof(canMessage));
    if (can[unit - 1].q == 0) {
        return -1;
    }
    
    can[unit - 1].stats.rx = 0;
    can[unit - 1].stats.tx = 0;
    can[unit - 1].stats.rxerr = 0;
    can[unit - 1].stats.txerr = 0;
    can[unit - 1].stats.rxqueued = 0;
    can[unit - 1].stats.rxunqueued = 0;
    
    return 0;
}

// Interrupt handler
void can_intr(unsigned int unit) {
    register struct can_conf_reg *conf;
    register struct can_fifo_reg *fifo;
    register struct can_irq      *irqs;
    register unsigned int i;
    canMessage *buff;
    unsigned int src;
    BaseType_t xHigherPriorityTaskWoken;
    
    xHigherPriorityTaskWoken = pdFALSE;
    
    conf = can[unit].conf;  
    fifo = can[unit].fifo;  
    irqs = &can[unit].irqs;  
    
    // Get FIFO source
    src = (conf->vec & PIC32_CxVEC_ICODE_MASK);
    if (src <= 31) {
        // Has something to read?
        while ((*(&fifo->fifoint + (0x40 * src)) & 0x01)) {
            // Get buffer frame
            buff = (canMessage *)(PA_TO_KVA1(*(&fifo->fifoua + (0x40 * src))));

            if (can[unit].q != 0) {
                can[unit].stats.rx++;

                // Queue the frame
                if (xQueueSendFromISR(can[unit].q, buff, &xHigherPriorityTaskWoken) == pdTRUE) {
                    can[unit].stats.rxqueued++;
                } else {
                    can[unit].stats.rxunqueued++;
                }        
            }
            
            can_update(unit + 1, src);
            can_flush_tx(unit + 1, src);
        }
    }
    
    *irqs->ifsclr = irqs->irq_mask;
    
    portEND_SWITCHING_ISR(xHigherPriorityTaskWoken);    
}

#endif
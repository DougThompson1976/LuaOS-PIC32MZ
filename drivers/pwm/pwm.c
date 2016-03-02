/*
 * Whitecat, pwm driver
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

#include <syslog.h>
#include <drivers/pwm/pwm.h>
#include <drivers/gpio/gpio.h>
#include <math.h>

/*
 * PBCLK      = peripheripal clock (MHZ)
 * pwm_freq   = pwm frequency hz
 * preescaler = timer preescaler
 * 
 *      PBCLK - pwm_freq * preescaler
 * pr = -----------------------------
 *                pwm_freq
 * 
 * 
 * 
 * 
 *                   /                               \
 *                  |           PBCLK                 |
 *            log10 |  ----------------------------   | 
 *                  |  pwm_freq * 1000 * preescaler   |
 *                   \                               /
 * pwm_res = ------------------------------------------------
 *                         log10(2) 
 */

static int output_map1 (unsigned channel) {
    switch (channel) {
        case 2: return 0b1011;   // OC3
        case 5: return 0b1100;   // OC6
    }

    syslog(LOG_ERR, "oc%u: cannot map OC pin, group 1", channel + 1);
    return 0;
}

static int output_map2 (unsigned channel) {
    switch (channel) {
        case 3: return 0b1011;   // OC4
        case 6: return 0b1100;   // OC7
    }

    syslog(LOG_ERR, "oc%u: cannot map OC pin, group 2", channel + 1);
    return 0;
}

static int output_map3 (unsigned channel) {
    switch (channel) {
        case 4: return 0b1011;   // OC5
        case 7: return 0b1100;   // OC8
    }

    syslog(LOG_ERR, "oc%u: cannot map OC pin, group 3", channel + 1);
    return 0;
}

static int output_map4 (unsigned channel) {
    switch (channel) {
        case 1: return 0b1011;   // OC2
        case 0: return 0b1100;   // OC1
        case 8: return 0b1101;   // OC9
    }

    syslog(LOG_ERR, "oc%u: cannot map OC pin, group 4", channel + 1);
    return 0;
}

static void assign_oc_pin(int channel, int pin) {
    switch (pin) {
        case RP('A',14): RPA14R = output_map1(channel); return;
        case RP('A',15): RPA15R = output_map2(channel); return;
        case RP('B',0):  RPB0R  = output_map3(channel); return;
        case RP('B',10): RPB10R = output_map1(channel); return;
        case RP('B',14): RPB14R = output_map4(channel); return;
        case RP('B',15): RPB15R = output_map3(channel); return;
        case RP('B',1):  RPB1R  = output_map2(channel); return;
        case RP('B',2):  RPB2R  = output_map4(channel); return;
        case RP('B',3):  RPB3R  = output_map2(channel); return;
        case RP('B',5):  RPB5R  = output_map1(channel); return;
        case RP('B',6):  RPB6R  = output_map4(channel); return;
        case RP('B',7):  RPB7R  = output_map3(channel); return;
        case RP('B',8):  RPB8R  = output_map3(channel); return;
        case RP('B',9):  RPB9R  = output_map1(channel); return;
        case RP('C',13): RPC13R = output_map2(channel); return;
        case RP('C',14): RPC14R = output_map1(channel); return;
        case RP('C',1):  RPC1R  = output_map1(channel); return;
        case RP('C',2):  RPC2R  = output_map4(channel); return;
        case RP('C',3):  RPC3R  = output_map3(channel); return;
        case RP('C',4):  RPC4R  = output_map2(channel); return;
        case RP('D',0):  RPD0R  = output_map4(channel); return;
        case RP('D',10): RPD10R = output_map1(channel); return;
        case RP('D',11): RPD11R = output_map2(channel); return;
        case RP('D',12): RPD12R = output_map3(channel); return;
        case RP('D',14): RPD14R = output_map1(channel); return;
        case RP('D',15): RPD15R = output_map2(channel); return;
        case RP('D',1):  RPD1R  = output_map4(channel); return;
        case RP('D',2):  RPD2R  = output_map1(channel); return;
        case RP('D',3):  RPD3R  = output_map2(channel); return;
        case RP('D',4):  RPD4R  = output_map3(channel); return;
        case RP('D',5):  RPD5R  = output_map4(channel); return;
        case RP('D',6):  RPD6R  = output_map1(channel); return;
        case RP('D',7):  RPD7R  = output_map2(channel); return;
        case RP('D',9):  RPD9R  = output_map3(channel); return;
        case RP('E',3):  RPE3R  = output_map3(channel); return;
        case RP('E',5):  RPE5R  = output_map2(channel); return;
        case RP('E',8):  RPE8R  = output_map4(channel); return;
        case RP('E',9):  RPE9R  = output_map3(channel); return;
        case RP('F',0):  RPF0R  = output_map2(channel); return;
        case RP('F',12): RPF12R = output_map3(channel); return;
        case RP('F',13): RPF13R = output_map4(channel); return;
        case RP('F',1):  RPF1R  = output_map1(channel); return;
        case RP('F',2):  RPF2R  = output_map4(channel); return;
        case RP('F',3):  RPF3R  = output_map4(channel); return;
        case RP('F',4):  RPF4R  = output_map1(channel); return;
        case RP('F',5):  RPF5R  = output_map2(channel); return;
        case RP('F',8):  RPF8R  = output_map3(channel); return;
        case RP('G',0):  RPG0R  = output_map2(channel); return;
        case RP('G',1):  RPG1R  = output_map1(channel); return;
        case RP('G',6):  RPG6R  = output_map3(channel); return;
        case RP('G',7):  RPG7R  = output_map2(channel); return;
        case RP('G',8):  RPG8R  = output_map1(channel); return;
        case RP('G',9):  RPG9R  = output_map4(channel); return;
    }
}

// Calculate PR value for timer for desired pwm frequency
unsigned int pwm_pr_freq(int pwmhz, int preescaler) {
    return (unsigned int)((((double)1.0 / (double)pwmhz) / (((double)1.0 / (double)PBCLK3_HZ) * (double)preescaler)) - (double)1.0);
}

// Calculate PR value for timer for desired pwm resolution
unsigned int pwm_pr_res(int res, int preescaler) {
    return pwm_pr_freq(PBCLK3_HZ / ((2 << (res - 1)) * preescaler), preescaler);    
}

void pwm_start(int unit) {
    unit--;
    
    *(&OC1CONSET + unit * 0x80) = (1 << 15);
}

void pwm_stop(int unit) {
    unit--;
    
    *(&OC1CONCLR + unit * 0x80) = (1 << 15);    
}

static void pwm_enable_timer_module(int unit) {    
    switch (unit) {
        case 0: PMD4CLR = T4MD; break;
        case 1: PMD4CLR = T5MD; break;
        case 2: PMD4CLR = T4MD; break;
        case 3: PMD4CLR = T2MD; break;
        case 4: PMD4CLR = T3MD; break;
        case 5: PMD4CLR = T2MD; break;
        case 6: PMD4CLR = T6MD; break;
        case 7: PMD4CLR = T7MD; break;
        case 8: PMD4CLR = T6MD; break;
    }
}

static void pwm_disable_timer_module(int unit) {    
    switch (unit) {
        case 0: PMD4SET = T4MD; break;
        case 1: PMD4SET = T5MD; break;
        case 2: PMD4SET = T4MD; break;
        case 3: PMD4SET = T2MD; break;
        case 4: PMD4SET = T3MD; break;
        case 5: PMD4SET = T2MD; break;
        case 6: PMD4SET = T6MD; break;
        case 7: PMD4SET = T7MD; break;
        case 8: PMD4SET = T6MD; break;
    }
}

static void pwm_enable_timer(int unit) {    
    switch (unit) {
        case 0: T4CONSET = (1 << 15); break;
        case 1: T5CONSET = (1 << 15); break;
        case 2: T4CONSET = (1 << 15); break;
        case 3: T2CONSET = (1 << 15); break;
        case 4: T3CONSET = (1 << 15); break;
        case 5: T2CONSET = (1 << 15); break;
        case 6: T6CONSET = (1 << 15); break;
        case 7: T7CONSET = (1 << 15); break;
        case 8: T6CONSET = (1 << 15); break;
    }
}

static void pwm_disable_timer(int unit) {
    switch (unit) {
        case 0: T4CON = 0; break;
        case 1: T5CON = 0; break;
        case 2: T4CON = 0; break;
        case 3: T2CON = 0; break;
        case 4: T3CON = 0; break;
        case 5: T2CON = 0; break;
        case 6: T6CON = 0; break;
        case 7: T7CON = 0; break;
        case 8: T6CON = 0; break;
    }
}

static void pwm_configure_timer_freq(int unit, int pwmhz) {
    unsigned int pr;
    unsigned int preescaler;
    unsigned int preescaler_bits;
    char timery = 0;
        
    preescaler_bits = 0;
    for(preescaler=1;preescaler <= 256;preescaler = preescaler * 2) {
        if (preescaler != 128) {
            pr = pwm_pr_freq(pwmhz, preescaler);
        
            if (pr <= 0xffff) {
                break;
            }
            
            preescaler_bits++;
        }
    }
    
    switch (unit) {
        case 0: T4CON = (preescaler_bits << 4);TMR4 = 0;PR4 = pr;timery=0; break;
        case 1: T5CON = (preescaler_bits << 4);TMR5 = 0;PR5 = pr;timery=1; break;
        case 2: T4CON = (preescaler_bits << 4);TMR4 = 0;PR4 = pr;timery=0; break;
        case 3: T2CON = (preescaler_bits << 4);TMR2 = 0;PR2 = pr;timery=0; break;
        case 4: T3CON = (preescaler_bits << 4);TMR3 = 0;PR3 = pr;timery=1; break;
        case 5: T2CON = (preescaler_bits << 4);TMR2 = 0;PR2 = pr;timery=0; break;
        case 6: T6CON = (preescaler_bits << 4);TMR6 = 0;PR6 = pr;timery=0; break;
        case 7: T7CON = (preescaler_bits << 4);TMR7 = 0;PR7 = pr;timery=1; break;
        case 8: T6CON = (preescaler_bits << 4);TMR6 = 0;PR6 = pr;timery=0; break;
    }
    
    if (timery) {
        *(&OC1CONSET + unit * 0x80) = (1 << 3);
    } else {
        *(&OC1CONCLR + unit * 0x80) = (1 << 3);
    }
}

static void pwm_configure_timer_res(int unit, int res) {
    unsigned int pr;
    unsigned int preescaler;
    unsigned int preescaler_bits;
    char timery = 0;
        
    preescaler_bits = 0;
    for(preescaler=1;preescaler <= 256;preescaler = preescaler * 2) {
        if (preescaler != 128) {
            pr = pwm_pr_res(res, preescaler);
        
            if (pr <= 0xffff) {
                break;
            }
            
            preescaler_bits++;
        }
    }
    
    switch (unit) {
        case 0: T4CON = (preescaler_bits << 4);TMR4 = 0;PR4 = pr;timery=0; break;
        case 1: T5CON = (preescaler_bits << 4);TMR5 = 0;PR5 = pr;timery=1; break;
        case 2: T4CON = (preescaler_bits << 4);TMR4 = 0;PR4 = pr;timery=0; break;
        case 3: T2CON = (preescaler_bits << 4);TMR2 = 0;PR2 = pr;timery=0; break;
        case 4: T3CON = (preescaler_bits << 4);TMR3 = 0;PR3 = pr;timery=1; break;
        case 5: T2CON = (preescaler_bits << 4);TMR2 = 0;PR2 = pr;timery=0; break;
        case 6: T6CON = (preescaler_bits << 4);TMR6 = 0;PR6 = pr;timery=0; break;
        case 7: T7CON = (preescaler_bits << 4);TMR7 = 0;PR7 = pr;timery=1; break;
        case 8: T6CON = (preescaler_bits << 4);TMR6 = 0;PR6 = pr;timery=0; break;
    }
    
    if (timery) {
        *(&OC1CONSET + unit * 0x80) = (1 << 3);
    } else {
        *(&OC1CONCLR + unit * 0x80) = (1 << 3);
    }
}

static int pwm_timer_pr(int unit) {
    switch (unit) {
        case 0: return PR4;
        case 1: return PR5;
        case 2: return PR4;
        case 3: return PR2;
        case 4: return PR3;
        case 5: return PR2;
        case 6: return PR6;
        case 7: return PR7;
        case 8: return PR6;
    }
}

static int pwm_timer_preescaler(int unit) {
    unsigned int preescaler_bits;
    
    switch (unit) {
        case 0: preescaler_bits = ((T4CON >> 4) & 0b111);break;
        case 1: preescaler_bits = ((T5CON >> 4) & 0b111);break; 
        case 2: preescaler_bits = ((T4CON >> 4) & 0b111);break; 
        case 3: preescaler_bits = ((T2CON >> 4) & 0b111);break; 
        case 4: preescaler_bits = ((T3CON >> 4) & 0b111);break; 
        case 5: preescaler_bits = ((T2CON >> 4) & 0b111);break; 
        case 6: preescaler_bits = ((T6CON >> 4) & 0b111);break; 
        case 7: preescaler_bits = ((T7CON >> 4) & 0b111);break; 
        case 8: preescaler_bits = ((T6CON >> 4) & 0b111);break; 
    }
    
    switch (preescaler_bits) {
        case 0: return 1;
        case 1: return 2;
        case 2: return 4;
        case 3: return 8;
        case 4: return 16;
        case 5: return 32;
        case 6: return 64;
        case 7: return 256;
    }
}

void pwm_set_duty(int unit, double duty) {
    unit--;
    
    *(&OC1R  + unit * 0x80) = pwm_timer_pr(unit) * duty;
    *(&OC1RS + unit * 0x80) = pwm_timer_pr(unit) * duty;    
}

void pwm_write(int unit, int res, int value) {
    double duty = (double)value / (double)(2 << (res - 1));

    unit--;
        
    *(&OC1R  + unit * 0x80) = pwm_timer_pr(unit) * duty;
    *(&OC1RS + unit * 0x80) = pwm_timer_pr(unit) * duty;
}

// Calculate real pwm frequency
unsigned int pwm_freq(int unit) {
    unit--;
    
    return (PBCLK3_HZ / ((pwm_timer_pr(unit) + 1) *  pwm_timer_preescaler(unit)));
}

void pwm_setup_freq(int unit, int pwmhz, double duty) {
    pwm_enable_timer_module(unit);

    pwm_disable_timer(unit);
    pwm_configure_timer_freq(unit, pwmhz);
    
    *(&OC1CON + unit * 0x80) = 0; // Disable OC module
    *(&OC1R  + unit * 0x80)  = pwm_timer_pr(unit) * duty;
    *(&OC1RS + unit * 0x80)  = pwm_timer_pr(unit) * duty;
    *(&OC1CON + unit * 0x80) = 0x0006;
    
    pwm_enable_timer(unit);
}

void pwm_setup_res(int unit, int res, int value) {
    double duty = (double)value / (double)(2 << (res - 1));
    
    pwm_enable_timer_module(unit);

    pwm_disable_timer(unit);
    pwm_configure_timer_res(unit, res);
    
    *(&OC1CON + unit * 0x80) = 0; // Disable OC module
    *(&OC1R  + unit * 0x80)  = pwm_timer_pr(unit) * duty;
    *(&OC1RS + unit * 0x80)  = pwm_timer_pr(unit) * duty;
    *(&OC1CON + unit * 0x80) = 0x0006;
    
    pwm_enable_timer(unit);
}

void pwm_init_freq(int unit, int pwmhz, double duty) {
    int pin;
    unit--;

    switch (unit) {
        case 0: pin = OC1_PINS; PMD3CLR = OC1MD;break;
        case 1: pin = OC2_PINS; PMD3CLR = OC2MD;break;
        case 2: pin = OC3_PINS; PMD3CLR = OC3MD;break;
        case 3: pin = OC4_PINS; PMD3CLR = OC4MD;break;
        case 4: pin = OC5_PINS; PMD3CLR = OC5MD;break;
        case 5: pin = OC6_PINS; PMD3CLR = OC6MD;break;
        case 6: pin = OC7_PINS; PMD3CLR = OC7MD;break;
        case 7: pin = OC8_PINS; PMD3CLR = OC8MD;break;
        case 8: pin = OC9_PINS; PMD3CLR = OC9MD;break;
    }

    assign_oc_pin(unit, pin);
    
    pwm_setup_freq(unit, pwmhz, duty);
    
    syslog(LOG_INFO,"pwm%d, at pin %c%d, %d hz", unit + 1, 
           gpio_portname(pin), gpio_pinno(pin), pwm_freq(unit + 1));
}

void pwm_init_res(int unit, int res, int val) {
    int pin;
    unit--;
    
    switch (unit) {
        case 0: pin = OC1_PINS; PMD3CLR = OC1MD;break;
        case 1: pin = OC2_PINS; PMD3CLR = OC2MD;break;
        case 2: pin = OC3_PINS; PMD3CLR = OC3MD;break;
        case 3: pin = OC4_PINS; PMD3CLR = OC4MD;break;
        case 4: pin = OC5_PINS; PMD3CLR = OC5MD;break;
        case 5: pin = OC6_PINS; PMD3CLR = OC6MD;break;
        case 6: pin = OC7_PINS; PMD3CLR = OC7MD;break;
        case 7: pin = OC8_PINS; PMD3CLR = OC8MD;break;
        case 8: pin = OC9_PINS; PMD3CLR = OC9MD;break;
    }

    assign_oc_pin(unit, pin);
    
    pwm_setup_res(unit, res, val);

    syslog(LOG_INFO,"pwm%d, at pin %c%d, %d hz", unit + 1, 
           gpio_portname(pin), gpio_pinno(pin), pwm_freq(unit + 1));

    pwm_start(unit + 1);    
}

void pwm_pins(int unit, unsigned char *pin) {
    int channel = unit - 1;

    switch (channel) {
        case 0:
            *pin = OC1_PINS & 0xFF;
            break;
        case 1:
            *pin = OC2_PINS & 0xFF;
            break;
        case 2:
            *pin = OC3_PINS & 0xFF;
            break;
        case 3:
            *pin = OC4_PINS & 0xFF;
            break;
        case 4:
            *pin = OC5_PINS & 0xFF;
            break;
        case 5:
            *pin = OC6_PINS & 0xFF;
            break;
        case 6:
            *pin = OC7_PINS & 0xFF;
            break;
        case 7:
            *pin = OC8_PINS & 0xFF;
            break;
        case 8:
            *pin = OC9_PINS & 0xFF;
            break;
    }
}
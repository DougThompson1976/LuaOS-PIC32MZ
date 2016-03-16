/*
 * Whitecat, stepper driver
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
#include <drivers/error.h>
#include <drivers/stepper/stepper.h>
#include <drivers/gpio/gpio.h>
#include <drivers/cpu/resource.h>
#include <math.h>

#include "FreeRTOS.h"
#include "task.h"

// Stepper base timer frequency
#define STEPPER_HZ 300000

static char clock_pulse = 10;  // Width of clock pulse in usecs
char stepper_timer = 0;        // Timer used by steppers
static char setup;             // Set up stepper mask (1 = setup, 2 = not setup)
static char clock_port;        // Port used for clock signal
static char dir_port;          // Port used for dir signal

static stepper_end *end_callback = NULL;

struct stepper stepper[NSTEP] = {
    {0,0},
    {0,0},
    {0,0},
    {0,0},
    {0,0},
    {0,0},
    {0,0},
    {0,0},
};

void stepper_setup_timer() {
    unsigned int pr;
    unsigned int preescaler;
    unsigned int preescaler_bits;

    // Enable timer module
    PMD4CLR = (1 << (stepper_timer - 1));
        
    // Disable timer
    TCON(stepper_timer) = 0;
    
    // Computes most lower preescaler for current frequency and period value
    preescaler_bits = 0;
    for(preescaler=1;preescaler <= 256;preescaler = preescaler * 2) {
        if (preescaler != 128) {
            pr = (unsigned int)floor(((((double)1.0 / (double)STEPPER_HZ) / (((double)1.0 / (double)PBCLK3_HZ) * (double)preescaler)) - (double)1.0));
            if (pr <= 0xffff) {
                break;
            }
            
            preescaler_bits++;
        }
    }
            
    printf("pr = %d\n", pr);
    printf("preescaler_bits = %d\n", preescaler_bits);
    
    // Configure timer
    TCON(stepper_timer) = (preescaler_bits << 4);
    TMR(stepper_timer) = 0;
    PR(stepper_timer) = pr;   
    
    // Configure timer interrupts
    int irq = PIC32_IRQ_T1 + (stepper_timer - 1) * 5;

    IPCCLR(irq >> 2) = 0x1f << (5 * (irq & 0x03));
    IPCSET(irq >> 2) = (0x1f << (8 * (irq & 0x03))) & 0x0d0d0d0d;
    IFSCLR(irq >> 5) = 1 << (irq & 31); 
    IECSET(irq >> 5) = 1 << (irq & 31); 

    // Start timer
    TCONSET(stepper_timer) = (1 << 15);
    
    syslog(LOG_ERR,"steppers, using timer%d, irq %d", stepper_timer, irq);        
}

void stepper_update_frequency(int unit, double freq) {  
    stepper[unit].ticks = (int)floor((((double)1 / freq) / ((double)1 / (double)STEPPER_HZ)));
    stepper[unit].cticks = 0;
}

tdriver_error *steppers_setup(int pulse_width, stepper_end *callback) {
    clock_pulse = pulse_width;
    end_callback = callback;
    
    return NULL;
}

tdriver_error *stepper_setup(int unit, int step_pin, int dir_pin) {
    tresource_lock *lock;
    
    unit--;

    // Lock needed resources: timer
    if (!stepper_timer) {
        lock = resource_lock(TIMER, -1, STEPPER, unit);
        if (!lock) {
            tdriver_error *error;

            error = (tdriver_error *)malloc(sizeof(tdriver_error));
            if (error) {
                error->type = LOCK;
                error->resource = TIMER;
                error->resource_unit = -1;            
                error->owner = -1;
                error->owner_unit = -1;
            }

            syslog(LOG_ERR,"steppers, no available timer");        
            free(lock);

            return error;
        } else {
            stepper_timer = lock->unit + 1;
            stepper_setup_timer();
        }        
        free(lock);
    }

    // TO DO: lock needed resources, step and dir pins

    mips_di();
    
    // Store stepper pins and ports
    clock_port = PORB(step_pin);
    dir_port = PORB(dir_pin);
    
    stepper[unit].clock_pin = PINB(step_pin);
    stepper[unit].dir_pin = PINB(dir_pin);
            
    // Configure stepper pins, as output, initial low
    gpio_pin_output(step_pin);
    gpio_pin_clr(step_pin);
    gpio_disable_analog(step_pin);
                
    gpio_pin_output(dir_pin);
    gpio_pin_clr(dir_pin);
    gpio_disable_analog(dir_pin);

    stepper[unit].move = 0;
    stepper[unit].start = 0;
    
    // Update setup mask
    setup |= (1 << unit);

    mips_ei();

    syslog(LOG_INFO,"stepper%d, at pins step=%c%d, dir=%c%d", unit + 1, 
           gpio_portname(step_pin),
           gpio_pinno(step_pin), 
           gpio_portname(dir_pin),
           gpio_pinno(dir_pin));
    
    return NULL;
}

void stepper_move(int unit, int dir, int steps, int ramp, double ifreq, double efreq) {
    unit--;
    
    stepper[unit].steps = steps;

    stepper[unit].steps_up = steps - ramp + 1;
    stepper[unit].steps_down = ramp;

    stepper[unit].target_freq  = efreq;   
    stepper[unit].current_freq = (ramp > 0?ifreq:efreq);
    
    if (ramp > 0) {
        stepper[unit].freq_inc = (stepper[unit].target_freq - ifreq) / ramp;
    } else {
        stepper[unit].freq_inc = 0;
    } 
    
    printf("\n\nmove unit %d\n", unit);
    printf("steps %d\n",stepper[unit].steps);
    printf("steps up %d\n",stepper[unit].steps_up);
    printf("steps down %d\n",stepper[unit].steps_down);
    printf("target freq %f\n",stepper[unit].target_freq);
    printf("current freq %f\n",stepper[unit].current_freq);
    printf("freq inc %f\n",stepper[unit].freq_inc);
    printf("ticks %d\n", (int)floor((((double)1 / stepper[unit].current_freq) / ((double)1 / (double)STEPPER_HZ))));
    
    stepper[unit].move = 1;
    stepper[unit].dir = dir;
    
    stepper_update_frequency(unit, stepper[unit].current_freq);
}

void stepper_start(int mask) {
    int unit = 0;

    mips_di();
    for (unit = 0; unit < NSTEP; unit++, mask = (mask >> 1)) {
        if (mask & 0b1) {
            stepper[unit].start = 1;
        }
    }
    mips_ei();
}

void stepper_intr(u8_t irq) {  
    BaseType_t xHigherPriorityTaskWoken = pdFALSE;
    
    int clock_mask = 0; // Clock mask to generate
    int dirs_mask = 0;  // Direction set mask
    int dirc_mask = 0;  // Direction clear mask
    int stop_mask = 0;  // Stopped steppers in this cycle
    
    int unit;
    struct stepper *pstepper;
    
    for(unit=0;unit < NSTEP;unit++) {        
        // Unit is setup?
        if ((setup >> unit) & (0b1)) {
            pstepper = &stepper[unit];
            if (!pstepper->move) {
                continue;
            }

            if (!pstepper->start) {
                continue;
            }
            
            // Is this timer tick for the stepper?
            pstepper->cticks++;
            if (pstepper->cticks == pstepper->ticks) {
                // Init ticks
                pstepper->cticks = 0;
                                
                // Update clock mask
                clock_mask |= (1 << pstepper->clock_pin);
                
                // Dir must be generated
                if (pstepper->dir) {
                    dirs_mask |= (1 << pstepper->dir_pin);
                } else {
                    dirc_mask |= (1 << pstepper->dir_pin);
                }
                
                // Stop condition
                if (pstepper->steps == 1) {
                    pstepper->move = 0;
                    pstepper->start = 0;

                    stop_mask |= (1 << unit);                        
                    
                    continue;
                }

                // Ramp UP
                if (pstepper->steps >= pstepper->steps_up) {
                    pstepper->current_freq += pstepper->freq_inc;
                    stepper_update_frequency(unit, pstepper->current_freq);
                } else {
                    // Ramp DOWN
                    if (pstepper->steps <= pstepper->steps_down) {
                        pstepper->current_freq -= pstepper->freq_inc;
                        stepper_update_frequency(unit, pstepper->current_freq);
                    }
                }  
                
                pstepper->steps--;
            }
        }
    }
    
    if (clock_mask) {
        // Update direction
        LATSET(dir_port) = dirs_mask;
        LATCLR(dir_port) = dirc_mask;

        // Generate clock pulse
        LATINV(clock_port) = clock_mask;
        udelay(clock_pulse);
        LATINV(clock_port) = clock_mask;
    }
    
    if (stop_mask) {
        xTimerPendFunctionCallFromISR(end_callback,stepper,stop_mask,
                              &xHigherPriorityTaskWoken);        
    }

    IFSCLR(irq >> 5) = 1 << (irq & 31); 

    if (stop_mask) {
       portEND_SWITCHING_ISR(xHigherPriorityTaskWoken);
    }
}
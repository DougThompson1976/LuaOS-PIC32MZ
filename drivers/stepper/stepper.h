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

#ifndef STEPPER_H
#define STEPPER_H

#define NSTEP 8

#include <unistd.h>

#include <drivers/error.h>

typedef void (stepper_end)(void *, uint32_t);

void stepper_update_frequency(int unit, double freq);
tdriver_error *stepper_setup(int unit, int step_pin, int dir_pin);
void stepper_move(int unit, int dir, int steps, int ramp, double ifreq, double efreq, stepper_end *callback);
void stepper_start(int mask);
tdriver_error *steppers_setup(int pulse_width);

#endif

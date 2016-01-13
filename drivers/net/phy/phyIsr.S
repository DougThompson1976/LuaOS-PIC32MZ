/*
 * isAtPoint.com Ethernet Interrupt vector
 *
 * Copyright (C) 2015 - 2016
 * IBEROXARXA SERVICIOS INTEGRALES, S.L., <contactar@iberoxarxa.com>
 * CSS IBERICA, S.L., <info@cssiberica.com>
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

#include <xc.h>
#include <sys/asm.h>
#include "ISR_Support.h"
    
#if USE_PIC_PHY

    .set	nomips16
    .set 	noreorder

    .extern vEthernetInterruptHandler
    .extern xISRStackTop
    .global	vEthernetInterruptWrapper

    .set	noreorder
    .set 	noat
    .ent	vEthernetInterruptWrapper

vEthernetInterruptWrapper:

	portSAVE_CONTEXT
	jal vEthernetInterruptHandler
	nop
	portRESTORE_CONTEXT

	.end	vEthernetInterruptWrapper

#endif
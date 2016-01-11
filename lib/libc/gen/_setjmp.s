/*-
 * Copyright (c) 1991, 1993
 *	The Regents of the University of California.  All rights reserved.
 *
 * This code is derived from software contributed to Berkeley by
 * Ralph Campbell.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 3. All advertising materials mentioning features or use of this software
 *    must display the following acknowledgement:
 *	This product includes software developed by the University of
 *	California, Berkeley and its contributors.
 * 4. Neither the name of the University nor the names of its contributors
 *    may be used to endorse or promote products derived from this software
 *    without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
 * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
 * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
 * SUCH DAMAGE.
 */

#include <machine/reg.h>
#include <machine/machAsmDefs.h>

#if defined(LIBC_SCCS) && !defined(lint)
	ASMSTR("@(#)_setjmp.s	8.1 (Berkeley) 6/4/93")
#endif /* LIBC_SCCS and not lint */

/*
 * C library -- _setjmp, _longjmp
 *
 *	_longjmp(a,v)
 * will generate a "return(v)" from
 * the last call to
 *	_setjmp(a)
 * by restoring registers from the stack,
 * The previous signal state is NOT restored.
 */

	.set	noreorder

LEAF(_setjmp)
#if ( __mips_hard_float == 1 )
        # Test a0 for 8-byte aligned, needed for save FPU registers
        sw      t0, 0(a0)       # Store t0
        andi    t0, a0, 7       # Test for last 3 bits of s0
        beqz    t0, 1f          # If t0 = 0 we have 8 byte aligned
        
        # s0 is not 8-byte aligned, make 8-bit aligned
        lw      t0, 0(a0)       # Restore t0
        srl     a0, a0, 3
        sll     a0, a0, 3
        addiu   a0, a0, 8
        b       2f

1:
        lw      t0, 0(a0)       # Restore t0

2:
#endif

        sw      s0, 0(a0)
        sw      s1, 4(a0)
        sw      s2, 8(a0)
        sw      s3, 12(a0)
        sw      s4, 16(a0)
        sw      s5, 20(a0)
        sw      s6, 24(a0)
        sw      s7, 28(a0)
        sw      gp, 32(a0)
        sw      sp, 36(a0)
        sw      s8, 40(a0)
        sw      ra, 44(a0)

#if ( __mips_hard_float == 1 )
        cfc1    v0, $31
        sdc1    $f24, 48(a0)
        sdc1    $f25, 56(a0)
        sdc1    $f26, 64(a0)
        sdc1    $f27, 72(a0)
        sdc1    $f28, 80(a0)
        sdc1    $f29, 88(a0)
        sdc1    $f30, 96(a0)
        sdc1    $f31, 104(a0)
        sw      v0, 112(a0)
#endif

        j       ra
        move	v0, zero
END(_setjmp)

LEAF(_longjmp)
#if ( __mips_hard_float == 1 )
        # Test a0 for 8-byte aligned, needed for save FPU registers
        sw      t0, 0(a0)       # Store t0
        andi    t0, a0, 7       # Test for last 3 bits of s0
        beqz    t0, 1f          # If t0 = 0 we have 8 byte aligned
        
        # s0 is not 8-byte aligned, make 8-bit aligned
        lw      t0, 0(a0)       # Restore t0
        srl     a0, a0, 3
        sll     a0, a0, 3
        addiu   a0, a0, 8
        b       2f

1:
        lw      t0, 0(a0)       # Restore t0

2:
#endif
        lw      s0, 0(a0)
        lw      s1, 4(a0)
        lw      s2, 8(a0)
        lw      s3, 12(a0)
        lw      s4, 16(a0)
        lw      s5, 20(a0)
        lw      s6, 24(a0)
        lw      s7, 28(a0)
        lw      gp, 32(a0)
        lw      sp, 36(a0)
        lw      s8, 40(a0)
        lw      ra, 44(a0)

#if ( __mips_hard_float == 1 )
        lw      v0, 112(a0)
        ctc1    v0, $31
        sdc1    $f24, 48(a0)
        sdc1    $f25, 56(a0)
        sdc1    $f26, 64(a0)
        sdc1    $f27, 72(a0)
        sdc1    $f28, 80(a0)
        sdc1    $f29, 88(a0)
        sdc1    $f30, 96(a0)
        sdc1    $f31, 104(a0)
#endif

1:
        j       ra
        move    v0, a1
END(_longjmp)
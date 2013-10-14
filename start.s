/*
 * Copyright (c) 1999-2008 Apple Inc. All rights reserved.
 *
 * @APPLE_LICENSE_HEADER_START@
 * 
 * Portions Copyright (c) 1999 Apple Computer, Inc.  All Rights
 * Reserved.  This file contains Original Code and/or Modifications of
 * Original Code as defined in and that are subject to the Apple Public
 * Source License Version 1.1 (the "License").  You may not use this file
 * except in compliance with the License.  Please obtain a copy of the
 * License at http://www.apple.com/publicsource and read it before using
 * this file.
 * 
 * The Original Code and all software distributed under the License are
 * distributed on an "AS IS" basis, WITHOUT WARRANTY OF ANY KIND, EITHER
 * EXPRESS OR IMPLIED, AND APPLE HEREBY DISCLAIMS ALL SUCH WARRANTIES,
 * INCLUDING WITHOUT LIMITATION, ANY WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE OR NON- INFRINGEMENT.  Please see the
 * License for the specific language governing rights and limitations
 * under the License.
 * 
 * @APPLE_LICENSE_HEADER_END@
 */

/*
 * C runtime startup for ppc, ppc64, i386, x86_64
 *
 * Kernel sets up stack frame to look like:
 *
 *	       :
 *	| STRING AREA |
 *	+-------------+
 *	|      0      |	
 *	+-------------+	
 *	|  exec_path  | extra "apple" parameters start after NULL terminating env array
 *	+-------------+
 *	|      0      |
 *	+-------------+
 *	|    env[n]   |
 *	+-------------+
 *	       :
 *	       :
 *	+-------------+
 *	|    env[0]   |
 *	+-------------+
 *	|      0      |
 *	+-------------+
 *	| arg[argc-1] |
 *	+-------------+
 *	       :
 *	       :
 *	+-------------+
 *	|    arg[0]   |
 *	+-------------+
 *	|     argc    | argc is always 4 bytes long, even in 64-bit architectures
 *	+-------------+ <- sp
 *
 *	Where arg[i] and env[i] point into the STRING AREA
 */

	.text
	.globl crt0_start
	.align 2

crt0_start:
	popq	%rax
	pushq	$0		    # push a zero for debugger end of frames marker
	movq	%rsp,%rbp	    # pointer to base of kernel frame
	andq    $-16,%rsp	    # force SSE alignment
	movq	8(%rbp),%rdi	    # put argc in %rdi
	leaq	16(%rbp),%rsi	    # addr of arg[0], argv, into %rsi
	movl	%edi,%edx	    # copy argc into %rdx
	addl	$1,%edx		    # argc + 1 for zero word
	sall	$3,%edx		    # * sizeof(char *)
	addq	%rsi,%rdx	    # addr of env[0], envp, into %rdx
	movq	%rdx,%rcx
	jmp	.Lapple2
.Lapple:	add	$8,%rcx
.Lapple2:cmpq	$0,(%rcx)	    # look for NULL ending env[] array
	jne	.Lapple		    
	add	$8,%rcx		    # once found, next pointer is "apple" parameter now in %rcx
	call	*%r15
	movl	%eax,%edi	    # pass result from main() to exit() 
	call	_exit		    # need to use call to keep stack aligned
	hlt


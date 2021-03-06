/*
 * Copyright 1991-1998 by Open Software Foundation, Inc.
 *              All Rights Reserved
 *
 * Permission to use, copy, modify, and distribute this software and
 * its documentation for any purpose and without fee is hereby granted,
 * provided that the above copyright notice appears in all copies and
 * that both the copyright notice and this permission notice appear in
 * supporting documentation.
 *
 * OSF DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE
 * INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE.
 *
 * IN NO EVENT SHALL OSF BE LIABLE FOR ANY SPECIAL, INDIRECT, OR
 * CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
 * LOSS OF USE, DATA OR PROFITS, WHETHER IN ACTION OF CONTRACT,
 * NEGLIGENCE, OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION
 * WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 */
/*
 * MkLinux
 */

#ifndef	_KERN_KERN_TYPES_H_
#define	_KERN_KERN_TYPES_H_
#ifdef _KERNEL
#include <mach/port.h>

typedef	mach_port_t			*thread_array_t;
typedef	mach_port_t			*thread_port_array_t;
typedef mach_port_t			thread_act_port_t;
typedef	thread_act_port_t		*thread_act_port_array_t;
typedef struct mach_task			*task_t;
typedef struct clock *mach_clock_t;
typedef struct processor		*processor_t;
typedef struct subsystem		*subsystem_t;
#endif
#endif	/* _KERN_KERN_TYPES_H_ */

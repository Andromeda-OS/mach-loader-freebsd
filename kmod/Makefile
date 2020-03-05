KMOD=imgact_mach
SRCS=imgact_mach.c kern/task.c kern/ipc_tt.c kern/ipc_host.c \
	defs_gen/clock_server.c defs_gen/host_priv_server.c mach/mach_clock.c \
	mach/mach_convert.c defs_gen/mach_host.c defs_gen/mach_host_priv.c \
	defs_gen/mach_host_server.c mach/mach_misc.c mach/mach_module.c \
	defs_gen/mach_port_server.c mach/mach_processor.c mach/mach_semaphore.c \
	mach/mach_task.c mach/mach_thread.c mach/mach_traps.c \
	mach/mach_vm.c defs_gen/mach_vm_server.c mach/proc_info.c \
	defs_gen/task_server.c defs_gen/vm_map_server.c \
	ipc/ipc_entry.c ipc/ipc_hash.c ipc/ipc_init.c ipc/ipc_kmsg.c \
	ipc/ipc_kobject.c ipc/ipc_mqueue.c ipc/ipc_notify.c ipc/ipc_object.c \
	ipc/ipc_port.c ipc/ipc_pset.c ipc/ipc_right.c ipc/ipc_space.c \
	ipc/ipc_table.c ipc/ipc_thread.c ipc/mach_debug.c ipc/mach_msg.c \
	ipc/mach_port.c kern/ipc_host.c kern/ipc_tt.c kern/task.c \
	kern/thread_pool.c vnode_if.h

.if !defined(DYLD_PATH) && !make(clean)
.error DYLD_PATH must be defined
.endif

.if defined(DEBUG) || make(debug)
CFLAGS += -O0 -DDEBUG
.else
CFLAGS += -O3
.endif

CFLAGS += -DDYLD=\"$(DYLD_PATH)\" -D__DARWIN_UNIX03=1
CFLAGS += -I${.CURDIR}/../include -I${.CURDIR}/defs

.include <bsd.kmod.mk>

.ORDER : run_mig beforebuild
run_mig : .PHONY
	${MAKE} -C defs

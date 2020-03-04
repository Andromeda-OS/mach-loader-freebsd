PROG = loader
SRCS = boot.s dyld_stub_binder.s set_proc_comm.s
CFLAGS += -I../include

.if defined(DEBUG) || make(debug)
CFLAGS += -O0 -g
.else
CFLAGS += -O3 -DNDEBUG
.endif

.include <bsd.prog.mk>

afterbuild:
	cp loader ../loader

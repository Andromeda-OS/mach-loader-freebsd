PROG = loader
SRCS = loader.c boot.s dyld_stub_binder.S set_proc_comm.s
CFLAGS += -I../include
MK_MAN = no

.if defined(DEBUG) || make(debug)
CFLAGS += -O0 -g
.else
CFLAGS += -O3 -DNDEBUG
.endif

.include <bsd.prog.mk>

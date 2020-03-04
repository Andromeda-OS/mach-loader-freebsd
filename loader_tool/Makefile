PROG = loader
SRCS = loader.c fatal.c boot.s dyld_stub_binder.S set_proc_comm.s
MK_MAN = no

CFLAGS  = -I../include -DUSE_BSD_LIBS -std=c99
LDFLAGS = -lm -lpthread -rpath '$$ORIGIN'

.if defined(DEBUG) || make(debug)
CFLAGS += -O0 -g
.else
CFLAGS += -O3 -DNDEBUG
.endif

.include <bsd.prog.mk>

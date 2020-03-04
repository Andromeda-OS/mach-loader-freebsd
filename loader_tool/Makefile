PROG = loader
SRCS = loader.c boot.s dyld_stub_binder.S set_proc_comm.s
MK_MAN = no

CPPFLAGS = -I../include
CPPFLAGS += -DUSE_BSD_LIBS
CFLAGS = -std=c99
LDFLAGS = -lm -lpthread

.if defined(DEBUG) || make(debug)
CFLAGS += -O0 -g
.else
CFLAGS += -O3 -DNDEBUG
.endif

.include <bsd.prog.mk>

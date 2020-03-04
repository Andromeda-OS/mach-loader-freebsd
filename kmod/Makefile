SRCS=imgact_mach.c vnode_if.h
KMOD=imgact_mach

.if !defined(DYLD_PATH) && !make(clean)
.error DYLD_PATH must be defined
.endif

.if defined(DEBUG) || make(debug)
CFLAGS += -O0 -DDEBUG
.else
CFLAGS += -O3
.endif

CFLAGS += -DDYLD=\"$(DYLD_PATH)\"

.include <bsd.kmod.mk>

SRCS=imgact_mach.c vnode_if.h
KMOD=imgact_mach

PWD != pwd
.if !defined(DYLD_PATH)
.error DYLD_PATH must be defined
.endif

CFLAGS += -DDYLD=\"$(DYLD_PATH)\"

.include <bsd.kmod.mk>

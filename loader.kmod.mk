SRCS=imgact_mach.c vnode_if.h
KMOD=imgact_mach

PWD != pwd
.if defined(DYLD_PATH)
CFLAGS += -DDYLD=\"$(DYLD_PATH)\"
.else
CFLAGS += -DDYLD=\"$(PWD)/loader\"

.include <bsd.kmod.mk>

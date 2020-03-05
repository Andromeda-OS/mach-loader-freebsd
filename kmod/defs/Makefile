MIG = ${.CURDIR}/../../migcom/mig.sh -migcom ${.CURDIR}/../../migcom/migcom
MIGFLAGS += -DKERNEL_SERVER -I${.CURDIR}/../../include

ALL_SOURCES = \
	clock.c host_priv.c mach_host.c mach_port.c \
	mach_vm.c task.c vm_map.c

ALL_HEADERS = \
	clock.h host_priv.h mach_host.h mach_port.h mach_vm.h task.h vm_map.h

all : headers sources
sources : ${ALL_SOURCES}
headers : ${ALL_HEADERS}
	mkdir -p mach
	cp *.h mach

.SUFFIXES : .defs
.defs.c:
	${MIG} ${MIGFLAGS} -header /dev/null -user /dev/null \
		-server $@ -sheader /dev/null $<

.defs.h:
	${MIG} ${MIGFLAGS} -header /dev/null -user /dev/null \
		-server /dev/null -sheader $@ $<

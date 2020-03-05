MIG = ${.CURDIR}/../../migcom/mig.sh -migcom ${.CURDIR}/../../migcom/migcom
MIGFLAGS += -DKERNEL_SERVER -I${.CURDIR}/../../include

ALL_SOURCES = \
	clock_server.c host_priv_server.c mach_host_server.c mach_port_server.c \
	mach_vm_server.c task_server.c vm_map_server.c

ALL_HEADERS = \
	clock.h host_priv.h mach_host.h mach_port.h mach_vm.h task.h vm_map.h

all : headers sources
sources : ${ALL_SOURCES}
headers : ${ALL_HEADERS}
	mkdir -p mach
	cp *.h mach

.SUFFIXES : .defs
.defs_server.c:
	@mkdir -p mach
	${MIG} ${MIGFLAGS} -header /dev/null -user /dev/null \
		-server $@ -sheader /dev/null $<

.defs.h:
	@mkdir -p mach
	${MIG} ${MIGFLAGS} -header /dev/null -user /dev/null \
		-server /dev/null -sheader $@ $<

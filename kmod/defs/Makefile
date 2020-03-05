MIG = ${.CURDIR}/../../migcom/mig.sh -migcom ${.CURDIR}/../../migcom/migcom
MIGFLAGS += -DKERNEL_SERVER -I${.CURDIR}/../../include

ALL_SOURCES = \
	clock_server.c host_priv_server.c mach_host_server.c mach_port_server.c \
	mach_vm_server.c task_server.c vm_map_server.c

ALL_HEADERS = \
	mach/clock.h mach/host_priv.h mach/mach_host.h mach/mach_port.h \
	mach/mach_vm.c mach/task.h mach/vm_map.h

all : headers sources
headers : ${ALL_HEADERS}
sources : ${ALL_SOURCES}

.for file in ${ALL_SOURCES}
def_file=${file:S/_server.c/.defs/}
header=${file:S/_server.c/.h/}
mach/${header}: ${def_file} _mach_dir
	${MIG} ${MIGFLAGS} -header /dev/null -user /dev/null \
		-server /dev/null -sheader mach/${header} ${def_file}

${file}: ${def_file}
	${MIG} ${MIGFLAGS} -header /dev/null -user /dev/null \
		-server ${file} -sheader /dev/null ${def_file}
.endfor

_mach_dir : .PHONY
	mkdir -p ${.CURDIR}/mach

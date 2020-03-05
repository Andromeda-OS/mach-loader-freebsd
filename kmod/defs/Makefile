MIG = ${.CURDIR}/../../migcom/mig.sh -migcom ${.CURDIR}/../../migcom/migcom
MIGFLAGS += -DKERNEL_SERVER -I${.CURDIR}/../../include

ALL_SOURCES = \
	clock_server.c host_priv_server.c mach_host_server.c mach_port_server.c \
	mach_vm_server.c task_server.c vm_map_server.c

all : ${ALL_SOURCES}

.for file in ${ALL_SOURCES}
def_file=${file:S/_server.c/.defs/}
header=${file:S/_server.c/_server.h/}
${file} ${header}: ${def_file}
	${MIG} ${MIGFLAGS} -header /dev/null -user /dev/null \
		-server ${file} -sheader ${header} ${def_file}
.endfor

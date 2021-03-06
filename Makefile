.if make(debug)
DEBUG=1
.endif

.if defined(DEBUG)
DYLD_PATH = $(PWD)/loader
.else
DYLD_PATH = /System/Library/ELFLoader/loader
.endif

default: loader
all: default kmod
debug: all

loader: .PHONY
	${MAKE} -C loader_tool DYLD_PATH=$(DYLD_PATH) DEBUG=$(DEBUG)
	cp loader_tool/loader loader

run: loader
	./loader test/hello_asm

run_c: loader
	./loader test/hello

run_all: loader
	-@for BIN in test/*; do\
		if [ -x $$BIN ]; then\
			echo "Testing $$BIN...";\
			./loader $$BIN;\
			echo "";\
		fi\
	done

kmod: .PHONY migcom
	${MAKE} -C kmod DYLD_PATH=$(DYLD_PATH) DEBUG=$(DEBUG)
	cp kmod/imgact_mach.ko imgact_mach.ko

migcom: .PHONY
	${MAKE} -C migcom

run_kmod: loader
	-kldunload ./imgact_mach.ko
	-kldload ./imgact_mach.ko
	-test/hello_asm
	-kldunload ./imgact_mach.ko

clean:
	${MAKE} -C loader_tool clean
	${MAKE} -C kmod clean

archive:
	rm -f mach-loader-freebsd-*.tar.gz
	git archive --prefix=mach-loader-freebsd/ --format tar HEAD | gzip -9 > mach-loader-freebsd-`git log -1 --format='%h'`.tar.gz

archive-tests:
	tar czf test.tar.gz test/

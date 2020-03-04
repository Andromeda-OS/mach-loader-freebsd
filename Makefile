CC = clang
AS = as
CPPFLAGS = -I./include
CPPFLAGS += -DUSE_BSD_LIBS
CFLAGS = -std=c99
LDFLAGS = -lm -lpthread

.if defined(DEBUG) || make(debug)
DYLD_PATH = $(PWD)/loader
.else
DYLD_PATH = /System/Library/ELFLoader/loader
.endif

default: loader
all: default kmod

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

kmod: .PHONY
	make -C kmod DYLD_PATH=$(DYLD_PATH) DEBUG=$(DEBUG)
	cp kmod/imgact_mach.ko imgact_mach.ko

run_kmod: loader
	-kldunload ./imgact_mach.ko
	-kldload ./imgact_mach.ko
	-test/hello_asm
	-kldunload ./imgact_mach.ko

clean:
	make -C loader_tool clean
	make -C kmod clean DYLD_PATH=$(DYLD_PATH)

ARCHIVE_NAME != echo mach-loader-freebsd-`git log -1 --format='%h'`.tar
archive:
	git archive --prefix=mach-loader-freebsd/ --format tar HEAD > $(ARCHIVE_NAME)
	gzip -f -9 $(ARCHIVE_NAME)

archive-tests:
	tar czf test.tar.gz test/

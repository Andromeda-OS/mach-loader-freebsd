CC = clang
AS = as
CPPFLAGS = -I./include
CPPFLAGS += -DUSE_BSD_LIBS
CFLAGS = -std=c99
LDFLAGS = -lm -lpthread

.if defined(DEBUG) || make(debug)
CFLAGS += -O0 -g
DYLD_PATH = $(PWD)/loader
.else
CFLAGS += -O3 -DNDEBUG
DYLD_PATH = /System/Library/ELFLoader/loader
.endif

default: loader
all: default kmod

loader: loader.c osx_compat.h boot.o dyld_stub_binder.o set_proc_comm.o
	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -o $@ $< boot.o dyld_stub_binder.o set_proc_comm.o \
		-Xlinker -R -Xlinker $$$$ORIGIN

set_proc_comm.o: set_proc_comm.s
boot.o: boot.s
	$(AS) -o $@ $<

dyld_stub_binder.o: dyld_stub_binder.S
	$(CC) -c -o $@ $<

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
	make -C kmod DYLD_PATH=$(DYLD_PATH)
	cp kmod/imgact_mach.ko imgact_mach.ko

run_kmod: kmod
	-kldunload ./imgact_mach.ko
	-kldload ./imgact_mach.ko
	-test/hello_asm
	-kldunload ./imgact_mach.ko

clean:
	rm -f loader
	rm -f *.o
	rm -f *.core
	rm -f *.tar.gz
	make -C kmod clean DYLD_PATH=$(DYLD_PATH)

ARCHIVE_NAME != echo mach-loader-freebsd-`git log -1 --format='%h'`.tar
archive:
	git archive --prefix=mach-loader-freebsd/ --format tar HEAD > $(ARCHIVE_NAME)
	gzip -f -9 $(ARCHIVE_NAME)

archive-tests:
	tar czf test.tar.gz test/

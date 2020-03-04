#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>

void loader_fatal(const char *msg, ...) __attribute__((noreturn)) {
	char *message = NULL;

	va_list ap;
	va_start(ap, msg);
	vasprintf(&message, msg, ap);
	va_end(ap);

	fprintf(stderr, "fatal loader error: %s\n", message);
	abort();
}

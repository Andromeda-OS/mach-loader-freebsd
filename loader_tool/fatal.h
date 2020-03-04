#ifndef _LOADER_FATAL_H_
#define _LOADER_FATAL_H_ 1

extern void loader_fatal(const char *msg, ...) __attribute__((noreturn));

#define loader_assert(condition, msg, ...) \
    do { if (!(condition)) { loader_fatal(msg, ##__VA_ARGS__); } } while (0)
#ifndef assert
#define assert(condition) loader_assert(condition, #condition)
#endif

#endif

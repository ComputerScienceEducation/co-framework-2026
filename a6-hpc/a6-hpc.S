#ifdef MACOS
    .global _main
    printf: jmp _printf
    malloc: jmp _malloc
    calloc: jmp _calloc
    realloc: jmp _realloc
    free: jmp _free
    clock_gettime: jmp _clock_gettime
#else
    .global main
    _printf: jmp printf
    _malloc: jmp malloc
    _calloc: jmp calloc
    _realloc: jmp realloc
    _free: jmp free
    _clock_gettime: jmp clock_gettime
#endif

# Do not hard-code the array size and number of times to run the kernel.
# Use $STREAM_ARRAY_SIZE and $NTIMES instead. These values will be set by the
# testing framework. When debugging, you may change the #defines below to the
# values you want to use.

#ifndef STREAM_ARRAY_SIZE
    #define STREAM_ARRAY_SIZE 75000000
#endif

#ifndef NTIMES
    #define NTIMES 20
#endif

.bss
# [unitialized static variables]

.data
# [initialized static variables]

.text
# Strings for formatted output:
fmt_info:
    .asciz "Array size = %lu (elements).\nEach kernel will be executed %u times.\n"
    # printf(fmt_info, STREAM_ARRAY_SIZE, NTIMES)
fmt_div:
    .asciz "-------------------------------------------------------------\n"
fmt_title:
    .asciz "%-10s  %14s  %8s  %11s  %11s\n"
    # printf(fmt_title, col_title_function, ...)
fmt_row:
    .asciz "%-9s  %12.1f  %11.6f  %11.6f  %11.6f\n"
    # printf(fmt_row, row_title_copy, 13029.0, ...)
col_title_function: .asciz "Function"
col_title_rate: .asciz "Best Rate MB/s"
col_title_avg: .asciz "Avg time"
col_title_min: .asciz "Min time"
col_title_max: .asciz "Max time"
row_title_copy: .asciz "Copy:"
row_title_scale: .asciz "Scale:"
row_title_add: .asciz "Add:"
row_title_triad: .asciz "Triad:"

_main:
main:
    # Implement me!
    ret
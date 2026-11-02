# Side-by-side comparison of the student's a6-hpc.S against the reference stream.c.
# Run with: cmake --build .build -t a6-compare

set(A6_SIZES 7500000 10000 CACHE STRING "STREAM_ARRAY_SIZE values to compare")
set(A6_NTIMES 20 CACHE STRING "NTIMES for the comparison")

if (CMAKE_HOST_SYSTEM_PROCESSOR MATCHES "^(arm|aarch)")
    message(STATUS "a6-compare: ARM host runs x86-64 emulated, MB/s numbers are not meaningful")
endif ()

set(A6_DIR ${CMAKE_BINARY_DIR}/a6-compare)
set(A6_RUN)

foreach (N ${A6_SIZES})
    set(DEFS STREAM_ARRAY_SIZE=${N} NTIMES=${A6_NTIMES})

    add_executable(a6-cmp-student-${N} EXCLUDE_FROM_ALL a6-hpc/a6-hpc.S)
    target_compile_definitions(a6-cmp-student-${N} PRIVATE ${DEFS})

    add_executable(a6-cmp-ref-${N} EXCLUDE_FROM_ALL a6-hpc/stream.c)
    target_compile_definitions(a6-cmp-ref-${N} PRIVATE ${DEFS})
    target_compile_options(a6-cmp-ref-${N} PRIVATE -O -fno-sanitize=address)
    target_link_options(a6-cmp-ref-${N} PRIVATE -fno-sanitize=address)
    target_link_libraries(a6-cmp-ref-${N} PRIVATE m)

    set_target_properties(a6-cmp-student-${N} a6-cmp-ref-${N}
            PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${A6_DIR})

    list(APPEND A6_DEPS a6-cmp-student-${N} a6-cmp-ref-${N})
    if (A6_RUN)
        list(APPEND A6_RUN COMMAND ${CMAKE_COMMAND} -E echo "")
    endif ()
    list(APPEND A6_RUN
            COMMAND ${CMAKE_COMMAND} -E echo "=== STREAM_ARRAY_SIZE=${N} NTIMES=${A6_NTIMES} ==="
            COMMAND ${CMAKE_COMMAND} -E echo "--- student (a6-hpc.S) ---"
            COMMAND ${A6_DIR}/a6-cmp-student-${N}
            COMMAND ${CMAKE_COMMAND} -E echo "--- reference (stream.c, -O) ---"
            COMMAND sh -c "${A6_DIR}/a6-cmp-ref-${N} | grep -A4 '^Function'"
    )
endforeach ()

add_custom_target(a6-compare ${A6_RUN} DEPENDS ${A6_DEPS} VERBATIM)

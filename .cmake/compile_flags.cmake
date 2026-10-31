# Do not modify the compile options
# We will test solely with these flags
set(CMAKE_C_STANDARD 11)
set(CMAKE_ASM_STANDARD 11)

if (CMAKE_HOST_SYSTEM_NAME STREQUAL "Darwin" AND CMAKE_HOST_SYSTEM_PROCESSOR STREQUAL "arm64")
    set(CO_ASAN_DEFAULT OFF)
else ()
    set(CO_ASAN_DEFAULT ON)
endif ()
option(CO_ASAN "Build with AddressSanitizer" ${CO_ASAN_DEFAULT})

if (CO_ASAN)
    set(CO_SAN_FLAG "-fsanitize=address")
else ()
    set(CO_SAN_FLAG "")
    message(STATUS "AddressSanitizer is OFF (use ./co-docker for ASan, or -DCO_ASAN=ON)")
endif ()

set(CMAKE_C_FLAGS "-g -gdwarf-4 -fPIE -Wall -O0 ${CO_SAN_FLAG} -fno-omit-frame-pointer")
set(CMAKE_ASM_FLAGS ${CMAKE_C_FLAGS})
set(CMAKE_EXE_LINKER_FLAGS "-g ${CO_SAN_FLAG} -fno-omit-frame-pointer")
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR})

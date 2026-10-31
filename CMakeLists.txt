cmake_minimum_required(VERSION 3.13)

set(CMAKE_C_COMPILER clang)
set(CMAKE_ASM_COMPILER clang)
if (CMAKE_HOST_SYSTEM_NAME STREQUAL "Darwin")
    set(CMAKE_OSX_ARCHITECTURES "x86_64" CACHE INTERNAL "" FORCE)
endif ()

project(CO-Lab-Framework C ASM)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

include(.cmake/compile_flags.cmake)
include(.cmake/compatibility.cmake)
include(.cmake/executables.cmake)
include(.cmake/a6-compare.cmake)

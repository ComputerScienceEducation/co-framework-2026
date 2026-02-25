# Your programs will run as standalone executables
add_compile_definitions(STANDALONE)

# maxOS (Apple Silicon) Support
if (APPLE)
    message(STATUS "Detected macOS, adding -DMACOS flag")
    add_compile_definitions(MACOS)
    set(CMAKE_OSX_ARCHITECTURES "x86_64" CACHE INTERNAL "" FORCE)
endif ()

# ARM WSL/LINUX Support
if(NOT APPLE AND UNIX AND (CMAKE_SYSTEM_PROCESSOR MATCHES "aarch64|arm64"))
    message(STATUS "Detected ARM64 Linux, Cross-compiling to x86_64")

    set(X86_TARGET "--target=x86_64-unknown-linux-gnu")
    add_compile_options(${X86_TARGET})
    add_link_options(${X86_TARGET})
    set(CMAKE_ASM_FLAGS "${CMAKE_ASM_FLAGS} ${X86_TARGET}")
endif ()

# Please use WSL :(
if (WIN32)
    message(FATAL_ERROR "Windows is not supported")
endif ()

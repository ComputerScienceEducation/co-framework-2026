# Your programs will run as standalone executables
add_compile_definitions(STANDALONE)

# Check if on macOS and add -DMACOS flag
# (-arch x86_64 comes from CMAKE_OSX_ARCHITECTURES, set in CMakeLists.txt)
if (APPLE)
    message(STATUS "Detected macOS, adding -DMACOS flag")
    add_compile_definitions(MACOS)
endif ()

# The assignments are x86-64 assembly, which cannot run natively on ARM Linux
# (including WSL on ARM). Run inside the x86-64 Docker container instead.
if (CMAKE_HOST_SYSTEM_NAME STREQUAL "Linux" AND CMAKE_HOST_SYSTEM_PROCESSOR MATCHES "^(aarch64|arm)")
    message(FATAL_ERROR "ARM Linux detected: the assignments are x86-64 assembly.\n"
            "Use ./co-docker <target> instead.")
endif ()

# Please use WSL :(
if (WIN32)
    message(FATAL_ERROR "Windows is not supported")
endif ()

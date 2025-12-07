## Windows variant configuration
# Use the GCC/MinGW toolchain by default when building the Windows variant.
# You can override this by passing -DCMAKE_TOOLCHAIN_FILE=... on the cmake command line.
set(CMAKE_TOOLCHAIN_FILE ${CMAKE_SOURCE_DIR}/tools/gcc/toolchain.cmake CACHE PATH "Toolchain file for Windows builds")

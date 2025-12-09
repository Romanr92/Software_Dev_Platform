## Linux variant toolchain selection
# By default keep existing toolchain file setting (clang toolchain)
set(CMAKE_TOOLCHAIN_FILE tools/toolchains/clang/toolchain.cmake CACHE PATH "toolchain file")

# If `zig` is available on PATH (for example installed via scoop), prefer
# using it as the cross-compiler to produce Linux binaries from Windows.
find_program(ZIG_EXECUTABLE NAMES zig)
set(ZIG_TARGET "x86_64-linux-gnu" CACHE STRING "Zig target triple (e.g. x86_64-linux-gnu, x86_64-linux-musl)")
if(ZIG_EXECUTABLE)
	message(STATUS "Zig found: ${ZIG_EXECUTABLE} - configuring compilers to use Zig (target=${ZIG_TARGET})")

	# When cross-compiling with Zig, tell CMake we're targeting Linux.
	# This helps CMake set correct system language/headers behavior.
	set(CMAKE_SYSTEM_NAME Linux CACHE STRING "Target system name" FORCE)
	set(CMAKE_SYSTEM_PROCESSOR x86_64 CACHE STRING "Target processor" FORCE)

	# Avoid using an external toolchain file when using Zig as driver
	set(CMAKE_TOOLCHAIN_FILE "" CACHE PATH "" FORCE)

	# Use small wrapper scripts that forward to `zig cc` / `zig c++` so we
	# can provide CMake a full-path executable (required on Windows).
	set(_zig_cc_wrapper "${CMAKE_SOURCE_DIR}/cmake/wrappers/zig-cc.cmd")
	set(_zig_cxx_wrapper "${CMAKE_SOURCE_DIR}/cmake/wrappers/zig-c++.cmd")
	set(CMAKE_C_COMPILER "${_zig_cc_wrapper}" CACHE FILEPATH "C compiler wrapper" FORCE)
	set(CMAKE_CXX_COMPILER "${_zig_cxx_wrapper}" CACHE FILEPATH "C++ compiler wrapper" FORCE)

	# Add Zig target flags to C/C++ flags so Zig emits Linux-targeted binaries
	# These flags are prepended so user flags can override when needed.
	set(CMAKE_C_FLAGS "--target=${ZIG_TARGET} ${CMAKE_C_FLAGS}")
	set(CMAKE_CXX_FLAGS "--target=${ZIG_TARGET} ${CMAKE_CXX_FLAGS}")
else()
	message(STATUS "Zig not found on PATH; using configured toolchain: ${CMAKE_TOOLCHAIN_FILE}")
endif()
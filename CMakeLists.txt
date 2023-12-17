cmake_minimum_required(VERSION 3.23)

project(
  MyFibonacci
  VERSION 0.0.0
  DESCRIPTION "A starter C++ project for generating a Fibonacci sequence."
  HOMEPAGE_URL https://github.com/threeal/cpp-starter
)

# Disable testing build if built as a subproject.
if(NOT CMAKE_CURRENT_SOURCE_DIR STREQUAL CMAKE_SOURCE_DIR)
  set(BUILD_TESTING OFF)
endif()

file(
  DOWNLOAD
  https://github.com/cpm-cmake/CPM.cmake/releases/download/v0.38.7/CPM.cmake
  ${CMAKE_BINARY_DIR}/_deps/CPM.cmake
  EXPECTED_MD5 14ea07dfb484cad5db4ee1c75fd6a911
)
include(${CMAKE_BINARY_DIR}/_deps/CPM.cmake)
cpmusepackagelock(package-lock)

cpmgetpackage(argparse)
cpmgetpackage(CheckWarning.cmake)

add_library(sequence src/sequence.cpp)

target_sources(
  sequence PUBLIC FILE_SET HEADERS
  BASE_DIRS include
  FILES include/my_fibonacci/sequence.hpp
)

set_property(TARGET sequence PROPERTY CXX_STANDARD 11)
if(BUILD_TESTING)
  target_check_warning(sequence)
endif()

add_executable(generate_sequence src/main.cpp)
target_link_libraries(generate_sequence PUBLIC argparse sequence)
set_property(TARGET generate_sequence PROPERTY CXX_STANDARD 11)
if(BUILD_TESTING)
  target_check_warning(generate_sequence)
endif()

if(BUILD_TESTING)
  enable_testing()

  cpmgetpackage(Format.cmake)

  cpmgetpackage(Catch2)
  include("${Catch2_SOURCE_DIR}/extras/Catch.cmake")

  get_target_property(sequence_SOURCES sequence SOURCES)
  add_executable(sequence_test test/sequence_test.cpp ${sequence_SOURCES})

  get_target_property(sequence_HEADER_DIRS sequence HEADER_DIRS)
  get_target_property(sequence_HEADER_SET sequence HEADER_SET)
  target_sources(
    sequence_test PRIVATE FILE_SET HEADERS
    BASE_DIRS ${sequence_HEADER_DIRS}
    FILES ${sequence_HEADER_SET}
  )

  target_link_libraries(sequence_test PRIVATE Catch2::Catch2WithMain)

  target_check_warning(sequence_test)
  target_compile_options(sequence_test PRIVATE --coverage -O0)
  target_link_options(sequence_test PRIVATE --coverage)

  catch_discover_tests(sequence_test)
endif()

install(
  TARGETS generate_sequence sequence
  EXPORT my_fibonacci_targets
  LIBRARY DESTINATION lib
  RUNTIME DESTINATION bin
  FILE_SET HEADERS
)

install(
  EXPORT my_fibonacci_targets
  FILE MyFibonacciTargets.cmake
  NAMESPACE my_fibonacci::
  DESTINATION lib/cmake/MyFibonacci
)

include(CMakePackageConfigHelpers)

write_basic_package_version_file(
  MyFibonacciConfigVersion.cmake
  COMPATIBILITY SameMajorVersion
)

install(
  FILES
    cmake/MyFibonacciConfig.cmake
    ${CMAKE_CURRENT_BINARY_DIR}/MyFibonacciConfigVersion.cmake
  DESTINATION lib/cmake/MyFibonacci
)

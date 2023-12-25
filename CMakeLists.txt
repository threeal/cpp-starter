cmake_minimum_required(VERSION 3.23)

project(
  MyFibonacci
  VERSION 0.0.0
  DESCRIPTION "A starter C++ project for generating a Fibonacci sequence."
  HOMEPAGE_URL https://github.com/threeal/cpp-starter
)

file(
  DOWNLOAD
  https://github.com/cpm-cmake/CPM.cmake/releases/download/v0.38.7/CPM.cmake
  ${CMAKE_BINARY_DIR}/_deps/CPM.cmake
  EXPECTED_MD5 14ea07dfb484cad5db4ee1c75fd6a911
)
include(${CMAKE_BINARY_DIR}/_deps/CPM.cmake)
cpmusepackagelock(package-lock)

cpmgetpackage(argparse)

add_library(sequence src/sequence.cpp)
target_sources(
  sequence PUBLIC FILE_SET HEADERS
  BASE_DIRS include
  FILES include/my_fibonacci/sequence.hpp
)
target_compile_features(sequence PRIVATE cxx_std_11)

add_executable(generate_sequence src/main.cpp)
target_link_libraries(generate_sequence PUBLIC argparse sequence)

if(CMAKE_CURRENT_SOURCE_DIR STREQUAL CMAKE_SOURCE_DIR AND BUILD_TESTING)
  enable_testing()

  cpmgetpackage(CheckWarning.cmake)
  add_check_warning()

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

  if(NOT MSVC)
    target_compile_options(sequence_test PRIVATE --coverage -O0 -fno-exceptions)
    target_link_options(sequence_test PRIVATE --coverage)

    get_target_property(sequence_test_SOURCES sequence_test SOURCES)
    foreach(SOURCE ${sequence_test_SOURCES})
      set(GCDA ${CMAKE_CURRENT_BINARY_DIR}/CMakeFiles/sequence_test.dir/${SOURCE}.gcda)
      add_custom_command(
        TARGET sequence_test PRE_LINK
        COMMAND ${CMAKE_COMMAND} -E rm -f ${GCDA}
      )
    endforeach()
  endif()

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

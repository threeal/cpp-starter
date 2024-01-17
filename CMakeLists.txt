cmake_minimum_required(VERSION 3.23)

project(
  MyFibonacci
  VERSION 0.0.0
  DESCRIPTION "A starter C++ project for generating a Fibonacci sequence."
  HOMEPAGE_URL https://github.com/threeal/cpp-starter
  LANGUAGES CXX
)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)

find_package(argparse REQUIRED)

add_library(sequence src/sequence.cpp)
target_sources(
  sequence PUBLIC
  FILE_SET HEADERS
  BASE_DIRS include
  FILES include/my_fibonacci/sequence.hpp
)
target_compile_features(sequence PRIVATE cxx_std_11)

add_executable(generate_sequence src/main.cpp)
target_link_libraries(generate_sequence PUBLIC argparse::argparse sequence)

if(CMAKE_CURRENT_SOURCE_DIR STREQUAL CMAKE_SOURCE_DIR)
  if(BUILD_TESTING)
    enable_testing()

    find_package(CheckWarning REQUIRED)
    include(CheckWarning)
    add_check_warning()

    find_package(FixFormat REQUIRED)
    include(FixFormat)
    target_fix_format(sequence)
    target_fix_format(generate_sequence)

    find_package(Catch2 REQUIRED)

    get_target_property(sequence_SOURCES sequence SOURCES)
    get_target_property(sequence_HEADER_DIRS sequence HEADER_DIRS)

    add_executable(sequence_test test/sequence_test.cpp ${sequence_SOURCES})
    target_include_directories(sequence_test PRIVATE ${sequence_HEADER_DIRS})
    target_link_libraries(sequence_test PRIVATE Catch2::Catch2WithMain)

    include(CheckCoverage)
    target_check_coverage(sequence_test)
    target_fix_format(sequence_test)

    include(Catch)
    catch_discover_tests(sequence_test)

    add_custom_target(format)
    add_dependencies(format sequence_format generate_sequence_format sequence_test_format)
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
endif()

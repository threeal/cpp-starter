cmake_minimum_required(VERSION 3.23)

project(
  MyFibonacci
  VERSION 0.0.0
  DESCRIPTION "A starter C++ project for generating a Fibonacci sequence."
  HOMEPAGE_URL https://github.com/threeal/cpp-starter
  LANGUAGES CXX
)

# Check if this project is a subproject of another project.
if(NOT CMAKE_CURRENT_SOURCE_DIR STREQUAL CMAKE_SOURCE_DIR)
  set(SUBPROJECT TRUE)
endif()

# Append the module path and export to the parent scope if is a subproject.
list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)
if(SUBPROJECT)
  set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} PARENT_SCOPE)
endif()

function(cpmaddpackage)
  file(
    DOWNLOAD
    https://github.com/cpm-cmake/CPM.cmake/releases/download/v0.39.0/CPM.cmake
    ${CMAKE_BINARY_DIR}/_deps/CPM.cmake
    EXPECTED_MD5 04eefa38baf672f7e8fcd09075122517
  )
  include(${CMAKE_BINARY_DIR}/_deps/CPM.cmake)
  cpmaddpackage(${ARGN})
endfunction()

# Enable warning checks if it is not a subproject and testing is enabled.
if(NOT SUBPROJECT AND BUILD_TESTING)
  find_package(CheckWarning QUIET)
  if(NOT CheckWarning_FOUND)
    cpmaddpackage(gh:threeal/CheckWarning.cmake@2.1.1)
    list(APPEND CMAKE_MODULE_PATH ${CheckWarning_SOURCE_DIR}/cmake)
  endif()
  include(CheckWarning)
  add_check_warning()
endif()

find_package(argparse QUIET)
if(NOT argparse_FOUND)
  cpmaddpackage(gh:p-ranav/argparse@3.0)
endif()

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

# Declare test targets if it is not a subproject and testing is enabled.
if(NOT SUBPROJECT AND BUILD_TESTING)
  enable_testing()

  find_package(ut QUIET)
  if(NOT ut_FOUND)
    cpmaddpackage(
      NAME ut
      GITHUB_REPOSITORY boost-ext/ut
      VERSION 2.0.1
      OPTIONS "BOOST_UT_DISABLE_MODULE ON"
    )
  endif()

  get_target_property(sequence_SOURCES sequence SOURCES)
  get_target_property(sequence_HEADER_DIRS sequence HEADER_DIRS)

  add_executable(sequence_test test/sequence_test.cpp ${sequence_SOURCES})
  target_include_directories(sequence_test PRIVATE ${sequence_HEADER_DIRS})
  target_link_libraries(sequence_test PRIVATE Boost::ut)

  include(CheckCoverage)
  target_check_coverage(sequence_test)

  add_test(NAME "Sequence Test" COMMAND sequence_test)
endif()

# Enable automatic formatting if it is not a subproject and testing is enabled.
if(NOT SUBPROJECT AND BUILD_TESTING)
  find_package(FixFormat QUIET)
  if(NOT FixFormat_FOUND)
    cpmaddpackage(gh:threeal/FixFormat.cmake@1.1.1)
    list(APPEND CMAKE_MODULE_PATH ${FixFormat_SOURCE_DIR}/cmake)
  endif()
  include(FixFormat)
  add_fix_format()
endif()

# Declare export and install targets if it is not a subproject.
if(NOT SUBPROJECT)
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

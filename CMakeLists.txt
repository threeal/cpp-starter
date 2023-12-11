cmake_minimum_required(VERSION 3.0)

project(example)

file(DOWNLOAD https://github.com/cpm-cmake/CPM.cmake/releases/download/v0.38.7/CPM.cmake
     ${CMAKE_BINARY_DIR}/_deps/CPM.cmake
     EXPECTED_HASH SHA256=83e5eb71b2bbb8b1f2ad38f1950287a057624e385c238f6087f94cdfc44af9c5)
include(${CMAKE_BINARY_DIR}/_deps/CPM.cmake)
cpmusepackagelock(package-lock)

cpmgetpackage(CheckWarning.cmake)

add_library(example src/example.cpp)
target_include_directories(example PUBLIC include)
target_check_warning(example)

if(CMAKE_CURRENT_SOURCE_DIR STREQUAL CMAKE_SOURCE_DIR)
  cpmgetpackage(Format.cmake)

  if(BUILD_TESTING)
    enable_testing()

    cpmgetpackage(Catch2)
    include("${Catch2_SOURCE_DIR}/extras/Catch.cmake")

    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fprofile-arcs -ftest-coverage -fPIC -O0")

    add_executable(example_test test/example_test.cpp)
    target_link_libraries(example_test PRIVATE example Catch2::Catch2WithMain)
    target_check_warning(example_test)
    catch_discover_tests(example_test)
  endif()
endif()

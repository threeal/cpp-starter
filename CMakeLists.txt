cmake_minimum_required(VERSION 3.5)

project(MyFibonacci)

file(DOWNLOAD https://github.com/cpm-cmake/CPM.cmake/releases/download/v0.38.7/CPM.cmake
     ${CMAKE_BINARY_DIR}/_deps/CPM.cmake EXPECTED_MD5 14ea07dfb484cad5db4ee1c75fd6a911)
include(${CMAKE_BINARY_DIR}/_deps/CPM.cmake)
cpmusepackagelock(package-lock)

cpmgetpackage(CheckWarning.cmake)

add_library(my_fibonacci src/sequence.cpp)
target_include_directories(my_fibonacci PUBLIC include)
set_property(TARGET my_fibonacci PROPERTY CXX_STANDARD 11)
target_check_warning(my_fibonacci)

add_executable(my_fibonacci_main src/main.cpp)
target_link_libraries(my_fibonacci_main PUBLIC my_fibonacci)
set_property(TARGET my_fibonacci_main PROPERTY CXX_STANDARD 11)
target_check_warning(my_fibonacci_main)

if(CMAKE_CURRENT_SOURCE_DIR STREQUAL CMAKE_SOURCE_DIR)
  cpmgetpackage(Format.cmake)

  if(BUILD_TESTING)
    enable_testing()

    cpmgetpackage(Catch2)
    include("${Catch2_SOURCE_DIR}/extras/Catch.cmake")

    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fprofile-arcs -ftest-coverage -fPIC -O0")

    add_executable(my_fibonacci_test test/sequence_test.cpp)
    target_link_libraries(my_fibonacci_test PRIVATE my_fibonacci Catch2::Catch2WithMain)
    target_check_warning(my_fibonacci_test)
    catch_discover_tests(my_fibonacci_test)
  endif()
endif()

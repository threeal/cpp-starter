cmake_minimum_required(VERSION 3.0)

project(example)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Wextra -Wshadow -Wnon-virtual-dtor -Wpedantic")

add_library(example src/example.cpp)
target_include_directories(example PUBLIC include)

if(CMAKE_CURRENT_SOURCE_DIR STREQUAL CMAKE_SOURCE_DIR)
  include(cmake/CPM.cmake)
  cpmaddpackage("gh:TheLartians/Format.cmake@1.7.3")

  if(BUILD_TESTING)
    enable_testing()

    cpmaddpackage("gh:catchorg/Catch2@3.3.2")
    include("${Catch2_SOURCE_DIR}/extras/Catch.cmake")

    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fprofile-arcs -ftest-coverage -fPIC -O0")

    add_executable(example_test test/example_test.cpp)
    target_link_libraries(example_test PRIVATE example Catch2::Catch2WithMain)
    catch_discover_tests(example_test)
  endif()
endif()

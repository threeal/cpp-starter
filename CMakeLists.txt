cmake_minimum_required(VERSION 3.0)

project(example)

add_library(example src/example.cpp)
target_include_directories(example PUBLIC include)
target_compile_options(example PRIVATE -Werror -Wall -Wextra -Wshadow -Wnon-virtual-dtor -Wpedantic)

if(CMAKE_CURRENT_SOURCE_DIR STREQUAL CMAKE_SOURCE_DIR)
  include(cmake/CPM.cmake)
  cpmusepackagelock(package-lock)
  cpmgetpackage(Format.cmake)

  if(BUILD_TESTING)
    enable_testing()

    cpmgetpackage(Catch2)
    include("${Catch2_SOURCE_DIR}/extras/Catch.cmake")

    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fprofile-arcs -ftest-coverage -fPIC -O0")

    add_executable(example_test test/example_test.cpp)
    target_link_libraries(example_test PRIVATE example Catch2::Catch2WithMain)
    target_compile_options(example_test PRIVATE -Werror -Wall -Wextra -Wshadow -Wnon-virtual-dtor -Wpedantic)
    catch_discover_tests(example_test)
  endif()
endif()

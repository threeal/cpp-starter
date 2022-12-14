cmake_minimum_required(VERSION 3.0)

project(example)

add_library(example src/example.cpp)
target_include_directories(example PUBLIC include)

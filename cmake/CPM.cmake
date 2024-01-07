file(
  DOWNLOAD
  https://github.com/cpm-cmake/CPM.cmake/releases/download/v0.38.7/CPM.cmake
  ${CMAKE_BINARY_DIR}/_deps/CPM.cmake
  EXPECTED_MD5 14ea07dfb484cad5db4ee1c75fd6a911
)

include(${CMAKE_BINARY_DIR}/_deps/CPM.cmake)

cpmdeclarepackage(
  argparse
  VERSION 3.0
  GITHUB_REPOSITORY p-ranav/argparse
  SYSTEM YES
  EXCLUDE_FROM_ALL YES
)

cpmdeclarepackage(
  CheckWarning.cmake
  VERSION 2.0.1
  GITHUB_REPOSITORY threeal/CheckWarning.cmake
  SYSTEM YES
  EXCLUDE_FROM_ALL YES
)

cpmdeclarepackage(
  Format.cmake
  VERSION 1.7.3
  GITHUB_REPOSITORY TheLartians/Format.cmake
  SYSTEM YES
  EXCLUDE_FROM_ALL YES
  OPTIONS "FORMAT_SKIP_CMAKE ON"
)

cpmdeclarepackage(
  Catch2
  VERSION 3.5.1
  GITHUB_REPOSITORY catchorg/Catch2
  SYSTEM YES
  EXCLUDE_FROM_ALL YES
)

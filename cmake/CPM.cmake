file(
  DOWNLOAD
  https://github.com/cpm-cmake/CPM.cmake/releases/download/v0.38.7/CPM.cmake
  ${CMAKE_BINARY_DIR}/_deps/CPM.cmake
  EXPECTED_MD5 14ea07dfb484cad5db4ee1c75fd6a911
)

include(${CMAKE_BINARY_DIR}/_deps/CPM.cmake)

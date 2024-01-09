if(Catch2_FOUND)
  return()
endif()

find_package(Catch2 QUIET CONFIG)
if(Catch2_FOUND)
  return()
endif()

include(CPM)
cpm_add_catch2()

list(APPEND CMAKE_MODULE_PATH ${Catch2_SOURCE_DIR}/extras)

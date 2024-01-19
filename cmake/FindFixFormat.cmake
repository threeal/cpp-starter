if(FixFormat_FOUND)
  return()
endif()

find_package(FixFormat QUIET CONFIG)
if(FixFormat_FOUND)
  return()
endif()

include(CPM)
cpmaddpackage(gh:threeal/FixFormat.cmake@1.1.0)

list(APPEND CMAKE_MODULE_PATH ${FixFormat_SOURCE_DIR}/cmake)

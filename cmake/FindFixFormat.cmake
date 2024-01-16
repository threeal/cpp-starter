if(FixFormat_FOUND)
  return()
endif()

find_package(FixFormat QUIET CONFIG)
if(FixFormat_FOUND)
  return()
endif()

include(CPM)
cpm_add_fix_format()

list(APPEND CMAKE_MODULE_PATH ${FixFormat_SOURCE_DIR}/cmake)

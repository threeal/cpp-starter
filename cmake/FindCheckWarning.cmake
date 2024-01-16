if(CheckWarning_FOUND)
  return()
endif()

find_package(CheckWarning QUIET CONFIG)
if(CheckWarning_FOUND)
  return()
endif()

include(CPM)
cpmaddpackage(gh:threeal/CheckWarning.cmake@2.1.0)

list(APPEND CMAKE_MODULE_PATH ${CheckWarning_SOURCE_DIR}/cmake)

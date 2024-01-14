if(CheckWarning_FOUND)
  return()
endif()

find_package(CheckWarning QUIET CONFIG)
if(CheckWarning_FOUND)
  return()
endif()

include(CPM)
cpm_add_check_warning()

list(APPEND CMAKE_MODULE_PATH ${CheckWarning_SOURCE_DIR}/cmake)

if(argparse_FOUND)
  return()
endif()

find_package(argparse QUIET CONFIG)
if(argparse_FOUND)
  return()
endif()

include(CPM)
cpmaddpackage(gh:p-ranav/argparse@3.0)

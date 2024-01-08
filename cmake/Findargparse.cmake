if(argparse_FOUND)
  return()
endif()

find_package(argparse QUIET CONFIG)
if(argparse_FOUND)
  return()
endif()

include(CPM)
cpm_add_argparse()

file(
  DOWNLOAD
  https://github.com/cpm-cmake/CPM.cmake/releases/download/v0.38.7/CPM.cmake
  ${CMAKE_BINARY_DIR}/_deps/CPM.cmake
  EXPECTED_MD5 14ea07dfb484cad5db4ee1c75fd6a911
)

include(${CMAKE_BINARY_DIR}/_deps/CPM.cmake)

function(cpm_add_argparse)
  cpmaddpackage(gh:p-ranav/argparse@3.0)
endfunction()

function(cpm_add_check_warning)
  cpmaddpackage(gh:threeal/CheckWarning.cmake@2.1.0)
endfunction()

function(cpm_add_fix_format)
  cpmaddpackage(gh:threeal/FixFormat.cmake@1.0.0)
endfunction()

function(cpm_add_catch2)
  cpmaddpackage(gh:catchorg/Catch2@3.5.2)
endfunction()

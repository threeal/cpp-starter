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
  cpmaddpackage(gh:threeal/CheckWarning.cmake@2.0.1)
endfunction()

function(cpm_add_format)
  cpmaddpackage(
    Format.cmake
    VERSION 1.7.3
    GITHUB_REPOSITORY TheLartians/Format.cmake
    OPTIONS "FORMAT_SKIP_CMAKE ON"
  )
endfunction()

function(cpm_add_catch2)
  cpmaddpackage(gh:catchorg/Catch2@3.5.1)
endfunction()

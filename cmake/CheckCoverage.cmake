include_guard(GLOBAL)

function(target_check_coverage TARGET)
  if(MSVC)
    message(WARNING "Test coverage check is not available on MSVC")
    return()
  endif()

  target_compile_options(${TARGET} PRIVATE --coverage -O0 -fno-exceptions)
  target_link_options(${TARGET} PRIVATE --coverage)

  get_target_property(TARGET_BINARY_DIR ${TARGET} BINARY_DIR)
  get_target_property(TARGET_SOURCES ${TARGET} SOURCES)

  foreach(SOURCE ${TARGET_SOURCES})
    set(GCDA ${TARGET_BINARY_DIR}/CMakeFiles/${TARGET}.dir/${SOURCE}.gcda)
    add_custom_command(
      TARGET ${TARGET} PRE_LINK
      COMMAND ${CMAKE_COMMAND} -E rm -f ${GCDA}
    )
  endforeach()
endfunction()

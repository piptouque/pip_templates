# required variable :
#     PROJECT_NAME : name of the current project.

set(IS_GNU OFF)
set(IS_MSVC OFF)
set(IS_CLANG OFF)

if (CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
    set(IS_GNU ON)
elseif (CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
    set(IS_MSVC ON)
elseif (CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
    set(IS_CLANG ON)
endif ()

if (${IS_GNU} OR ${IS_CLANG})
    ## -Warray-bounds is clang-only I think?
    set(${PROJECT_NAME}_CXX_FLAGS
            "-fPIC"
            "-Werror"
            "-Wall"
            # "-pedantic"
            "-Wextra"
            "-Wshadow"
            "-Wnon-virtual-dtor"
            "-Warray-bounds"
            "-Wold-style-cast"
            "-Wimplicit-fallthrough=5"
            "-Wconversion"
            "$<$<CONFIG:RELEASE>:-O3>"
            )
elseif (${IS_MSVC})
    if (${${PROJECT_NAME}_OPTIMISATION})
        set(${PROJECT_NAME}_OPTIMISATION_LEVEL "/O2")
    endif ()
    set(${PROJECT_NAME}_CXX_FLAGS
            "/EHsc"
            "/WX"
            "/W4"
            "/w14640"
            "/permissive"
            "/w14242"
            "/w14265"
            "/w14287"
            "$<$<CONFIG:RELEASE>:/O3>"
            )
else ()
    message(ERROR "Unsupported compiler: " ${CMAKE_CXX_COMPILER_ID})
endif ()



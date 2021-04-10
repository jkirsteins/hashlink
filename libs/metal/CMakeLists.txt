add_library(metal.hdll SHARED
    metal.c
)
set_as_hdll(metal)
target_include_directories(metal.hdll
    PRIVATE
)
target_link_libraries(metal.hdll
    libhl
)

if(APPLE)
    macro(ADD_OSX_FRAMEWORK fwname target)
        find_library(FRAMEWORK_${fwname}
        NAMES ${fwname}
        PATHS ${CMAKE_OSX_SYSROOT}/System/Library
        PATH_SUFFIXES Frameworks
        NO_DEFAULT_PATH
        REQUIRED)
        if( ${FRAMEWORK_${fwname}} STREQUAL FRAMEWORK_${fwname}-NOTFOUND)
            MESSAGE(ERROR ": Framework ${fwname} not found")
        else()
            TARGET_LINK_LIBRARIES(${target} libhl "${FRAMEWORK_${fwname}}/${fwname}")
            MESSAGE(STATUS "Framework ${fwname} found at ${FRAMEWORK_${fwname}}")
        endif()
    endmacro(ADD_OSX_FRAMEWORK)

    ADD_OSX_FRAMEWORK(Metal metal.hdll)
endif()


install(
    TARGETS metal.hdll
    DESTINATION ${HDLL_DESTINATION}
)

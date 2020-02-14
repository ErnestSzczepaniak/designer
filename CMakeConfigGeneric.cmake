# //---------------------------------------------| definitions |---------------------------------------------//

collect_files(
    source_files
    EXTENSION s S c C cxx CXX cpp CPP
    COMMON ${source_common} source/
    TARGET ${source_target}
    HOST ${source_host} test/
)

# //---------------------------------------------| definitions |---------------------------------------------//

if (CMAKE_SOURCE_DIR STREQUAL CMAKE_CURRENT_SOURCE_DIR AND EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/main.cpp")

    list(APPEND source_files main.cpp)

    add(
        public_scope
        EXECUTABLE 
        NAME ${name_executable} 
        FILES ${source_files}
    )

    link(
        NAME ${name_executable}
        SCOPE ${dependency_scope}
        TARGET startup_${architecture}
    )

    dump()
    image()

    set(name_target ${name_executable})

else()

    add(
        public_scope
        LIBRARY
        NAME ${name_library}
        FILES ${source_files}
    )

    set(name_target ${name_library})

endif()

# //---------------------------------------------| definitions |---------------------------------------------//

link(
    NAME ${name_target}
    SCOPE ${dependency_scope}
    COMMON ${dependency_common}
    HOST ${dependency_host}
)

# //---------------------------------------------| definitions |---------------------------------------------//

target_set(
    COMPILE_DEFINITIONS
    NAME ${name_target}
    SCOPE ${public_scope}
    COMMON ${public_definition_common}
    TARGET ${public_definition_target}
    HOST ${public_definition_host}
)

if (source_files)

    target_set(
        COMPILE_DEFINITIONS
        NAME ${name_target}
        SCOPE PRIVATE
        COMMON ${private_definition_common} build_name=${name_library} build_platform_${platform_cached} build_type_${type_cached} build_version_major=${version_major} build_version_minor=${version_minor} build_version_revision=${version_revision}
        TARGET ${private_definition_target} build_architecture_${architecture_cached} build_core_${core_cached} build_gic_${gic_cached} build_family_${family_cached} build_board_${board_cached}
        HOST ${private_definition_host}
    )

endif()

# //---------------------------------------------| options |---------------------------------------------//

target_set(
    COMPILE_OPTIONS
    NAME ${name_target}
    SCOPE ${public_scope}
    COMMON ${public_option_common}
    TARGET ${public_option_target} -mcpu=cortex-${core}
    HOST ${public_option_host}
)

if (source_files)

    target_set(
        COMPILE_OPTIONS
        NAME ${name_target}
        SCOPE PRIVATE
        COMMON ${private_option_common}
        TARGET ${private_option_target}
        HOST ${private_option_host}
    )

endif()

# //---------------------------------------------| include |---------------------------------------------//

target_set(
    INCLUDE_DIRECTORIES
    NAME ${name_target}
    SCOPE ${public_scope}
    COMMON ${public_include_common} include/
    TARGET ${public_include_target} 
    HOST ${public_include_host}
)

if (source_files)

    target_set(
        INCLUDE_DIRECTORIES
        NAME ${name_target}
        SCOPE PRIVATE
        COMMON ${private_include_common} ${CMAKE_CURRENT_SOURCE_DIR}/../designer/
        TARGET ${private_include_target} 
        HOST ${private_include_host} test/
    )

endif()

# //---------------------------------------------| link |---------------------------------------------//

target_set(
    LINK_OPTIONS
    NAME ${name_target}
    SCOPE ${public_scope}
    COMMON ${public_link_common}
    TARGET ${public_link_target}
    HOST ${public_link_host}
)

if (source_files)

    target_set(
        LINK_OPTIONS
        NAME ${name_target}
        SCOPE PRIVATE
        COMMON ${private_link_common}
        TARGET ${private_link_target}
        HOST ${private_link_host}
    )

endif()
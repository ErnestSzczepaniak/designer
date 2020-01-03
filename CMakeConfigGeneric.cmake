
collect_files(
    source_files
    EXTENSION ${source_extensions}
    COMMON ${source_common}
    V7 ${source_v7}
    V8 ${source_v8}
    X86 ${source_x86}
)

add(
    LIBRARY
    TARGET ${name}
    TYPE ${library_type}
    COMMON ${source_files}
)

link(
    TARGET ${name}
    SCOPE ${dependency_scope}
    LIBRARY ${dependency_soft}
)

link(
    TARGET ${name}
    SCOPE ${dependency_scope}
    LIBRARY ${dependency_hard}
    HARD
)

if (CMAKE_SOURCE_DIR STREQUAL CMAKE_CURRENT_SOURCE_DIR)

    add(EXECUTABLE TARGET ${name_executable} COMMON main.cpp)
    target_link_libraries(${name_executable} ${name})
    output()

endif()

# //---------------------------------------------| definitions |---------------------------------------------//

target_set(
    COMPILE_DEFINITIONS
    TARGET ${name}
    SCOPE PUBLIC
    COMMON ${public_definition_common}
    V7 ${public_definition_v7}
    V8 ${public_definition_v8}
    X86 ${public_definition_x86}
)

target_set(
    COMPILE_DEFINITIONS
    TARGET ${name}
    SCOPE PRIVATE
    COMMON ${private_definition_common} 
    V7 ${private_definition_v7} 
    V8 ${private_definition_v8} 
    X86 ${private_definition_x86}
)

# //---------------------------------------------| options |---------------------------------------------//

target_set(
    COMPILE_OPTIONS
    TARGET ${name}
    SCOPE PUBLIC
    COMMON ${public_option_common}
    V7 ${public_option_v7}
    V8 ${public_option_v8}
    X86 ${public_option_x86}
)

target_set(
    COMPILE_OPTIONS
    TARGET ${name}
    SCOPE PRIVATE
    COMMON ${private_option_common}
    V7 ${private_option_v7}
    V8 ${private_option_v8}
    X86 ${private_option_x86}
)

# //---------------------------------------------| include |---------------------------------------------//

target_set(
    INCLUDE_DIRECTORIES
    TARGET ${name}
    SCOPE PUBLIC
    COMMON ${public_include_common}
    V7 ${public_include_v7} 
    V8 ${public_include_v8}
    X86 ${public_include_x86}
)

target_set(
    INCLUDE_DIRECTORIES
    TARGET ${name}
    SCOPE PRIVATE
    COMMON ${private_include_common}
    V7 ${private_include_v7} 
    V8 ${private_include_v8}
    X86 ${private_include_x86}
)

# //---------------------------------------------| link |---------------------------------------------//

target_set(
    LINK_OPTIONS
    TARGET ${name}
    SCOPE PUBLIC
    COMMON ${public_link_common}
    V7 ${public_link_v7}
    V8 ${public_link_v8}
    X86 ${public_link_x86}
)

target_set(
    LINK_OPTIONS
    TARGET ${name}
    SCOPE PRIVATE
    COMMON ${private_link_common}
    V7 ${private_link_v7}
    V8 ${private_link_v8}
    X86 ${private_link_x86}
)

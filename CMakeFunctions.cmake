# //---------------------------------------------| link |---------------------------------------------//

function(collect_files output)

    set(options)
    set(args)
    set(list_args EXTENSION COMMON TARGET HOST)

    cmake_parse_arguments(
        PARSE_ARGV 0
        each
        "${options}"
        "${args}"
        "${list_args}"
    )

    foreach(directory ${each_COMMON})

        foreach(extension ${each_EXTENSION})

            list(APPEND expression ${directory}*.${extension})

        endforeach()

    endforeach()

    if (${platform_cached} STREQUAL target)

        foreach(directory ${each_TARGET})

            foreach(extension ${each_EXTENSION})

                list(APPEND expression ${directory}*.${extension})

            endforeach()

        endforeach()

    elseif (${platform_cached} STREQUAL host)

        foreach(directory ${each_HOST})

            foreach(extension ${each_EXTENSION})

                list(APPEND expression ${directory}*.${extension})

            endforeach()

        endforeach()     

    endif()

    file(GLOB glob ${expression})
    set(${output} ${glob} PARENT_SCOPE)

endfunction()

# //---------------------------------------------| target set |---------------------------------------------//

function(target_set)

    set(options COMPILE_DEFINITIONS INCLUDE_DIRECTORIES COMPILE_OPTIONS LINK_OPTIONS COMPILE_FEATURES)
    set(args NAME SCOPE)
    set(list_args COMMON TARGET HOST)

    cmake_parse_arguments(
        PARSE_ARGV 0
        each
        "${options}"
        "${args}"
        "${list_args}"
    )

    if (${each_COMPILE_DEFINITIONS})

        target_compile_definitions(${each_NAME} ${each_SCOPE} ${each_COMMON})

        if (${platform_cached} STREQUAL target)
            target_compile_definitions(${each_NAME} ${each_SCOPE} ${each_TARGET})
        elseif (${platform_cached} STREQUAL host)
            target_compile_definitions(${each_NAME} ${each_SCOPE} ${each_HOST})
        endif()

    endif()

    if (${each_INCLUDE_DIRECTORIES})

        target_include_directories(${each_NAME} ${each_SCOPE} ${each_COMMON})

        if (${platform_cached} STREQUAL target)
            target_include_directories(${each_NAME} ${each_SCOPE} ${each_TARGET})
        elseif (${platform_cached} STREQUAL host)
            target_include_directories(${each_NAME} ${each_SCOPE} ${each_HOST})
        endif()

    endif()

    if (${each_COMPILE_OPTIONS})

        if (${type_cached} STREQUAL debug)
            target_compile_options(${each_NAME} ${each_SCOPE} ${each_COMMON} -g -gstrict-dwarf)
        elseif (${type_cached} STREQUAL release)
            target_compile_options(${each_NAME} ${each_SCOPE} ${each_COMMON})
        endif()
        
        if (${platform_cached} STREQUAL target)
            target_compile_options(${each_NAME} ${each_SCOPE} ${each_TARGET})
        elseif (${platform_cached} STREQUAL host)
            target_compile_options(${each_NAME} ${each_SCOPE} ${each_HOST})
        endif()

    endif()

    if (${each_LINK_OPTIONS})

            target_link_options(${each_NAME} ${each_SCOPE} ${each_COMMON})

        if (${platform_cached} STREQUAL target)
            target_link_options(${each_NAME} ${each_SCOPE} ${each_TARGET})
        elseif (${platform_cached} STREQUAL host)
            target_link_options(${each_NAME} ${each_SCOPE} ${each_HOST})
        endif()

    endif()

endfunction()

# //---------------------------------------------| link |---------------------------------------------//

function(add output)

    set(options LIBRARY EXECUTABLE)
    set(args NAME)
    set(list_args FILES)

    cmake_parse_arguments(
        PARSE_ARGV 0
        each
        "${options}"
        "${args}"
        "${list_args}"
    )

    if (${each_LIBRARY})
    
        if (each_FILES)

            add_library(${each_NAME} STATIC ${each_FILES})
            set(${output} PUBLIC PARENT_SCOPE)

        else()

            add_library(${each_NAME} INTERFACE)
            set(${output} INTERFACE PARENT_SCOPE)

        endif()

    endif()

    if (${each_EXECUTABLE})

        add_executable(${each_NAME} ${each_FILES})
        set(${output} PUBLIC PARENT_SCOPE)

    endif()

endfunction()

# //---------------------------------------------| link |---------------------------------------------//

function (link)

    set(options HARD)
    set(args NAME SCOPE)
    set(list_args INTERNAL_COMMON INTERNAL_HOST INTERNAL_TARGET EXTERNAL_COMMON EXTERNAL_TARGET EXTERNAL_HOST)

    cmake_parse_arguments(
        PARSE_ARGV 0
        each
        "${options}"
        "${args}"
        "${list_args}"
    )

    foreach (library ${each_INTERNAL_COMMON})

        add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/../${library}/ ${CMAKE_CURRENT_BINARY_DIR}/${library}/)

        if (${each_HARD})
            target_link_libraries(${each_NAME} ${each_SCOPE} -Wl,--whole-archive ${library} -Wl,--no-whole-archive)
        else()
            target_link_libraries(${each_NAME} ${each_SCOPE} ${library})
        endif()

    endforeach()

    foreach (library ${each_EXTERNAL_COMMON})

        if (${each_HARD})
            target_link_libraries(${each_NAME} ${each_SCOPE} -Wl,--whole-archive ${library} -Wl,--no-whole-archive)
        else()
            target_link_libraries(${each_NAME} ${each_SCOPE} ${library})
        endif()

    endforeach()


    if (${platform_cached} STREQUAL target)

        foreach (library ${each_INTERNAL_TARGET})

            add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/../${library}/ ${CMAKE_CURRENT_BINARY_DIR}/${library}/)

            if (${each_HARD})
                target_link_libraries(${each_NAME} ${each_SCOPE} -Wl,--whole-archive ${library} -Wl,--no-whole-archive)
            else()
                target_link_libraries(${each_NAME} ${each_SCOPE} ${library})
            endif()

        endforeach()

        foreach (library ${each_EXTERNAL_TARGET})

            if (${each_HARD})
                target_link_libraries(${each_NAME} ${each_SCOPE} -Wl,--whole-archive ${library} -Wl,--no-whole-archive)
            else()
                target_link_libraries(${each_NAME} ${each_SCOPE} ${library})
            endif()

        endforeach()

    endif()

    if (${platform_cached} STREQUAL host)

        foreach (library ${each_INTERNAL_HOST})

            add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/../${library}/ ${CMAKE_CURRENT_BINARY_DIR}/${library}/)

            if (${each_HARD})
                target_link_libraries(${each_NAME} ${each_SCOPE} -Wl,--whole-archive ${library} -Wl,--no-whole-archive)
            else()
                target_link_libraries(${each_NAME} ${each_SCOPE} ${library})
            endif()

        endforeach()

        foreach (library ${each_EXTERNAL_HOST})

            if (${each_HARD})
                target_link_libraries(${each_NAME} ${each_SCOPE} -Wl,--whole-archive ${library} -Wl,--no-whole-archive)
            else()
                target_link_libraries(${each_NAME} ${each_SCOPE} ${library})
            endif()

        endforeach()

    endif()

endfunction()

function(dump)

    if (${dump} AND ${platform_cached} STREQUAL target AND ${architecture_cached} STREQUAL v7a)

        add_custom_command(
            TARGET executable.elf POST_BUILD
            COMMAND arm-none-eabi-readelf -S ../binary/executable.elf > ../dump/read_sections.txt
            COMMAND arm-none-eabi-readelf -h ../binary/executable.elf > ../dump/read_headers.txt
            COMMAND arm-none-eabi-readelf -s ../binary/executable.elf > ../dump/read_symbols.txt
            COMMAND arm-none-eabi-objdump -S ../binary/executable.elf > ../dump/dump_assembly.txt
            COMMAND arm-none-eabi-objdump -s ../binary/executable.elf > ../dump/dump_sections_content.txt
            COMMAND arm-none-eabi-objdump -h ../binary/executable.elf > ../dump/dump_sections.txt
            COMMAND arm-none-eabi-objdump -t ../binary/executable.elf > ../dump/dump_symbols.txt
        )

    endif()

endfunction()

function (image)

    if (${image} AND ${platform_cached} STREQUAL target AND ${architecture_cached} STREQUAL v7a)
        add_custom_command(
            TARGET executable.elf POST_BUILD
            COMMAND arm-none-eabi-objcopy -O binary ../binary/executable.elf ../binary/executable.bin
            COMMAND mkimage -A arm -T standalone -C none -a 0 -e 0 -n "executable.elf" -d ../binary/executable.bin ../binary/executable.img
        )
        
    endif()

endfunction()

function (documentation)

    if (${documentation})

        add_custom_command(
            TARGET executable.elf POST_BUILD
            COMMAND doxygen ../doxygen/DoxygenConfigBasic
        )

    endif()

endfunction()
function(collect_files output)

    set(options)
    set(args)
    set(list_args EXTENSION COMMON V7 V8 X86)

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

    if (${architecture_cached} STREQUAL v7)
        foreach(directory ${each_V7})
            foreach(extension ${each_EXTENSION})
                list(APPEND expression ${directory}*.${extension})
            endforeach()
        endforeach()
    elseif (${architecture_cached} STREQUAL v8)
        foreach(directory ${each_V8})
            foreach(extension ${each_EXTENSION})
                list(APPEND expression ${directory}*.${extension})
            endforeach()
        endforeach()     
    elseif (${architecture_cached} STREQUAL x86)
        foreach(directory ${each_X86})
            foreach(extension ${each_EXTENSION})
                list(APPEND expression ${directory}*.${extension})
            endforeach()
        endforeach()     
    endif()

    file(GLOB glob ${expression})
    set(${output} ${glob} PARENT_SCOPE)

endfunction()

function(target_set)

    set(options COMPILE_DEFINITIONS INCLUDE_DIRECTORIES COMPILE_OPTIONS LINK_OPTIONS COMPILE_FEATURES)
    set(args SCOPE)
    set(list_args TARGET COMMON V7 V8 X86)

    cmake_parse_arguments(
        PARSE_ARGV 0
        each
        "${options}"
        "${args}"
        "${list_args}"
    )

    if (${each_COMPILE_DEFINITIONS})

        foreach (target ${each_TARGET})

            target_compile_definitions(${target} ${each_SCOPE} ${each_COMMON})

            if (${architecture_cached} STREQUAL v7)
                target_compile_definitions(${target} ${each_SCOPE} ${each_V7})
            elseif (${architecture_cached} STREQUAL v8)
                target_compile_definitions(${target} ${each_SCOPE} ${each_V8})
            elseif (${architecture_cached} STREQUAL x86)
                target_compile_definitions(${target} ${each_SCOPE} ${each_X86})
            endif()

        endforeach()

    endif()

    if (${each_INCLUDE_DIRECTORIES})

        foreach (target ${each_TARGET})

            target_include_directories(${target} ${each_SCOPE} ${each_COMMON})

            if (${architecture_cached} STREQUAL v7)
                target_include_directories(${target} ${each_SCOPE} ${each_V7})
            elseif (${architecture_cached} STREQUAL v8)
                target_include_directories(${target} ${each_SCOPE} ${each_V8})
            elseif (${architecture_cached} STREQUAL x86)
                target_include_directories(${target} ${each_SCOPE} ${each_X86})
            endif()

        endforeach()

    endif()

    if (${each_COMPILE_OPTIONS})

        foreach(target ${each_TARGET})

            if (${type_cached} STREQUAL debug)
                target_compile_options(${target} ${each_SCOPE} ${each_COMMON} -g)
            elseif (${type_cached} STREQUAL release)
                target_compile_options(${target} ${each_SCOPE} ${each_COMMON})
            endif()
            
            if (${architecture_cached} STREQUAL v7)
                target_compile_options(${target} ${each_SCOPE} ${each_V7})
            elseif (${architecture_cached} STREQUAL v8)
                target_compile_options(${target} ${each_SCOPE} ${each_V8})
            elseif (${architecture_cached} STREQUAL x86)
                target_compile_options(${target} ${each_SCOPE} ${each_X86})
            endif()

        endforeach()

    endif()

    if (${each_LINK_OPTIONS})

        foreach (target ${each_TARGET})

            target_link_options(${target} ${each_SCOPE} ${each_COMMON})

            if (${architecture_cached} STREQUAL v7)
                target_link_options(${target} ${each_SCOPE} ${each_V7})
            elseif (${architecture_cached} STREQUAL v8)
                target_link_options(${target} ${each_SCOPE} ${each_V8})
            elseif (${architecture_cached} STREQUAL x86)
                target_link_options(${target} ${each_SCOPE} ${each_X86})
            endif()

        endforeach()

    endif()

endfunction()

function(add)

    set(options LIBRARY EXECUTABLE)
    set(args TARGET TYPE)
    set(list_args COMMON V7 V8 X86)

    cmake_parse_arguments(
        PARSE_ARGV 0
        each
        "${options}"
        "${args}"
        "${list_args}"
    )

    if (${each_LIBRARY})
    
        if (${architecture_cached} STREQUAL v7)
            add_library(${each_TARGET} ${each_TYPE} ${each_COMMON} ${each_V7})
        elseif (${architecture_cached} STREQUAL v8)
            add_library(${each_TARGET} ${each_TYPE} ${each_COMMON} ${each_V8})
        elseif (${architecture_cached} STREQUAL x86)
            add_library(${each_TARGET} ${each_TYPE} ${each_COMMON} ${each_X86})
        endif()

    endif()

    if (${each_EXECUTABLE})

        if (${architecture_cached} STREQUAL v7)
            add_executable(${each_TARGET} ${each_TYPE} ${each_COMMON} ${each_V7})
        elseif (${architecture_cached} STREQUAL v8)
            add_executable(${each_TARGET} ${each_TYPE} ${each_COMMON} ${each_V8})
        elseif (${architecture_cached} STREQUAL x86)
            add_executable(${each_TARGET} ${each_TYPE} ${each_COMMON} ${each_X86})
        endif()

    endif()

endfunction()

function (link)

    set(options HARD)
    set(args TARGET SCOPE)
    set(list_args LIBRARY)

    cmake_parse_arguments(
        PARSE_ARGV 0
        each
        "${options}"
        "${args}"
        "${list_args}"
    )

    foreach (library ${each_LIBRARY})

        add_subdirectory(${root}${library}/ ${CMAKE_CURRENT_BINARY_DIR}/${library}/)

        if (${each_HARD})
            target_link_libraries(${each_TARGET} ${each_SCOPE} -Wl,--whole-archive ${library} -Wl,--no-whole-archive)
        else()
            target_link_libraries(${each_TARGET} ${each_SCOPE} ${library})
        endif()
        
    endforeach()

endfunction()

function(output)

    if (${private_dump})

        if (${architecture_cached} STREQUAL v7)
            add_custom_command(
                TARGET executable.elf POST_BUILD
                COMMAND ${root}designer/toolchain/v7/bin/arm-none-eabi-readelf -S ../binary/executable.elf > ../dump/read_sections.txt
                COMMAND ${root}designer/toolchain/v7/bin/arm-none-eabi-readelf -h ../binary/executable.elf > ../dump/read_headers.txt
                COMMAND ${root}designer/toolchain/v7/bin/arm-none-eabi-readelf -s ../binary/executable.elf > ../dump/read_symbols.txt
                COMMAND ${root}designer/toolchain/v7/bin/arm-none-eabi-objdump -S ../binary/executable.elf > ../dump/dump_assembly.txt
                COMMAND ${root}designer/toolchain/v7/bin/arm-none-eabi-objdump -s ../binary/executable.elf > ../dump/dump_sections_content.txt
                COMMAND ${root}designer/toolchain/v7/bin/arm-none-eabi-objdump -h ../binary/executable.elf > ../dump/dump_sections.txt
                COMMAND ${root}designer/toolchain/v7/bin/arm-none-eabi-objdump -t ../binary/executable.elf > ../dump/dump_symbols.txt
            )
        elseif(${architecture_cached} STREQUAL v8)
            add_custom_command(
                TARGET executable.elf POST_BUILD
                COMMAND ${root}designer/toolchain/v8/bin/aarch64-none-elf-readelf -S ../binary/executable.elf > ../dump/read_sections.txt
                COMMAND ${root}designer/toolchain/v8/bin/aarch64-none-elf-readelf -h ../binary/executable.elf > ../dump/read_headers.txt
                COMMAND ${root}designer/toolchain/v8/bin/aarch64-none-elf-readelf -s ../binary/executable.elf > ../dump/read_symbols.txt
                COMMAND ${root}designer/toolchain/v8/bin/aarch64-none-elf-objdump -S ../binary/executable.elf > ../dump/dump_assembly.txt
                COMMAND ${root}designer/toolchain/v8/bin/aarch64-none-elf-objdump -s ../binary/executable.elf > ../dump/dump_sections_content.txt
                COMMAND ${root}designer/toolchain/v8/bin/aarch64-none-elf-objdump -h ../binary/executable.elf > ../dump/dump_sections.txt
                COMMAND ${root}designer/toolchain/v8/bin/aarch64-none-elf-objdump -t ../binary/executable.elf > ../dump/dump_symbols.txt
            )
        elseif (${architecture_cached} STREQUAL x86)
            add_custom_command(
                TARGET executable.elf POST_BUILD
                COMMAND usr/bin/readelf -S ../binary/executable.elf > ../dump/read_sections.txt
                COMMAND usr/bin/readelf -h ../binary/executable.elf > ../dump/read_headers.txt
                COMMAND usr/bin/readelf -s ../binary/executable.elf > ../dump/read_symbols.txt
                COMMAND usr/bin/objdump -S ../binary/executable.elf > ../dump/dump_assembly.txt
                COMMAND usr/bin/objdump -s ../binary/executable.elf > ../dump/dump_sections_content.txt
                COMMAND usr/bin/objdump -h ../binary/executable.elf > ../dump/dump_sections.txt
                COMMAND usr/bin/objdump -t ../binary/executable.elf > ../dump/dump_symbols.txt
            )
        endif()

    endif()

    if (${private_image})

        if (${architecture_cached} STREQUAL v7)
            add_custom_command(
                TARGET executable.elf POST_BUILD
                COMMAND ${root}designer/toolchain/v7/bin/arm-none-eabi-objcopy -O binary ../binary/executable.elf ../binary/executable.bin
                COMMAND mkimage -A arm -T standalone -C none -a 0 -e 0 -n "executable.elf" -d ../binary/executable.bin ../binary/executable.img
            )
        elseif (${architecture_cached} STREQUAL v8)
            add_custom_command(
                TARGET executable.elf POST_BUILD
                COMMAND ${root}designer/toolchain/v8/bin/aarch64-none-elf-objcopy -O binary ../binary/executable.elf ../binary/executable.bin
                COMMAND mkimage -A arm -T standalone -C none -a 0 -e 0 -n "executable.elf" -d ../binary/executable.bin ../binary/executable.img
            )
        elseif (${architecture_cachedd} STREQUAL x86)

        endif()


    endif()

endfunction()
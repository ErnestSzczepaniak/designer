if (CMAKE_SOURCE_DIR STREQUAL CMAKE_CURRENT_SOURCE_DIR)

    set(platform_cached ${platform} CACHE STRING "")
    set(architecture_cached ${architecture} CACHE STRING "")
    set(core_cached ${core} CACHE STRING "")
    set(gic_cached ${gic} CACHE STRING "")
    set(family_cached ${family} CACHE STRING "")
    set(board_cached ${board} CACHE STRING "")
    set(type_cached ${type} CACHE STRING "")
    set(sdram_start_cached ${sdram_start} CACHE STRING "")
    set(sdram_size_cached ${sdram_size} CACHE STRING "")
    set(sdram_size_stack_cached ${sdram_size_stack} CACHE STRING "")
    set(sdram_size_pool_cached ${sdram_size_pool} CACHE STRING "")
    set(ocram_start_cached ${ocram_start} CACHE STRING "")
    set(ocram_size_cached ${ocram_size} CACHE STRING "")
    set(ocram_size_stack_cached ${ocram_size_stack} CACHE STRING "")
    set(ocram_size_pool_cached ${ocram_size_pool} CACHE STRING "")

    if (${platform} STREQUAL host)

        set(CMAKE_SYSTEM_NAME Linux)
        set(CMAKE_C_COMPILER /usr/bin/gcc)
        set(CMAKE_CXX_COMPILER /usr/bin/g++)

    else()

        if (${architecture} STREQUAL v7a)

            set(CMAKE_SYSTEM_NAME Generic)
            set(CMAKE_C_COMPILER arm-none-eabi-gcc)
            set(CMAKE_CXX_COMPILER arm-none-eabi-g++)

        elseif (${architecture} STREQUAL v8a)

            set(CMAKE_SYSTEM_NAME Generic)
            set(CMAKE_C_COMPILER aarch64-none-elf-gcc)
            set(CMAKE_CXX_COMPILER aarch64-none-elf-g++)
            
        endif()

        set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

    endif()

    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/binary)

endif()

if (CMAKE_SOURCE_DIR STREQUAL CMAKE_CURRENT_SOURCE_DIR)

    set(architecture_cached ${architecture} CACHE STRING "")
    set(target_cached ${target} CACHE STRING "")
    set(type_cached ${type} CACHE STRING "")
    set(target_sdram_start_cached ${target_sdram_start} CACHE STRING "")
    set(target_sdram_size_cached ${target_sdram_size} CACHE STRING "")
    set(target_ocram_start_cached ${target_ocram_start} CACHE STRING "")
    set(target_ocram_size_cached ${target_ocram_size} CACHE STRING "")
    set(target_stack_size_cached ${target_stack_size} CACHE STRING "")
    set(target_pool_size_cached ${target_pool_size} CACHE STRING "")

    if (${architecture_cached} STREQUAL x86)

        set(CMAKE_SYSTEM_NAME Linux)
        set(CMAKE_C_COMPILER /usr/bin/gcc)
        set(CMAKE_CXX_COMPILER /usr/bin/g++)

    elseif(${architecture_cached} STREQUAL v7)

        set(CMAKE_SYSTEM_NAME Generic)
        set(CMAKE_C_COMPILER ${root}/designer/toolchain/v7/bin/arm-none-eabi-gcc)
        set(CMAKE_CXX_COMPILER ${root}designer/toolchain/v7/bin/arm-none-eabi-g++)

        set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

    elseif(${architecture_cached} STREQUAL v8)

        set(CMAKE_SYSTEM_NAME Generic)
        set(CMAKE_C_COMPILER ${root}designer/toolchain/v8/bin/aarch64-none-elf-gcc)
        set(CMAKE_CXX_COMPILER ${root}designer/toolchain/v8/bin/aarch64-none-elf-g++)

        set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

    endif()

    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/binary)

endif()
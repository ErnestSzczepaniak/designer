#build_target_
set(public_target                 c5)

#memory
set(public_target_sdram_start     0x00000000)
set(public_target_sdram_size      1024M)
set(public_target_ocram_start     0xffff0000)
set(public_target_ocram_size      64K)
set(public_target_stack_size      128K)
set(public_target_pool_size       900M)

#root
set(public_root                  /home/en2/Documents/programs/)

# ---------------------------------------------| build source |--------------------------------------------- #

#build_source
set(private_source_extensions     s S c C cxx CXX cpp CPP)
set(private_source_common         source/)
set(private_source_v7             )
set(private_source_v8             )
set(private_source_x86            test/)

# ---------------------------------------------| build definition |--------------------------------------------- #

#build_definition
set(public_definition_common      )
set(public_definition_v7          )
set(public_definition_v8          )
set(public_definition_x86         )

#build_definition
set(private_definition_common     build_name=${private_name} build_architecture_${public_architecture_cached} build_type_${public_type_cached} build_version_major=${private_version_major} build_version_minor=${private_version_minor} build_version_revision=${private_version_revision})
set(private_definition_v7         build_target_${public_target_cached})
set(private_definition_v8         build_target_${public_target_cached})
set(private_definition_x86        )

# ---------------------------------------------| build option |--------------------------------------------- #

#build_option
set(public_option_common          )
set(public_option_v7              -Og -gstrict-dwarf -mcpu=cortex-a9)
set(public_option_v8              -Og -gstrict-dwarf -mcpu=cortex-a53)
set(public_option_x86             )

#build_option
set(private_option_common         -std=c++1z)
set(private_option_v7             )
set(private_option_v8             )
set(private_option_x86            )

# ---------------------------------------------| build include |--------------------------------------------- #

#build_include
set(public_include_common         include/)
set(public_include_v7             )
set(public_include_v8             )
set(public_include_x86            )

#build_include
set(private_include_common        build/)
set(private_include_v7            )
set(private_include_v8            )
set(private_include_x86           test/)

# ---------------------------------------------| build include |--------------------------------------------- #

#build_include
set(public_link_common         )
set(public_link_v7             --specs=nosys.specs -nostartfiles -T ${CMAKE_CURRENT_SOURCE_DIR}/linker/script.ld
                                -Wl,--defsym=__sdram_start=${public_target_sdram_start}
                                -Wl,--defsym=__sdram_size=${public_target_sdram_size}
                                -Wl,--defsym=__ocram_start=${public_target_ocram_start}
                                -Wl,--defsym=__ocram_size=${public_target_ocram_size}
                                -Wl,--defsym=__stack_size=${public_target_stack_size}
                                -Wl,--defsym=__pool_size=${public_target_pool_size}
                                
                                )
set(public_link_v8             )
set(public_link_x86            )

#build_include
set(private_link_common        )
set(private_link_v7            )
set(private_link_v8            )
set(private_link_x86           )

#library_type
set(private_library_type          OBJECT)

set(public_dependency_scope      PUBLIC)

set(private_name_executable       executable.elf)

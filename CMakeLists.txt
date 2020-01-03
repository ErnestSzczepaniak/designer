#cmake_version
cmake_minimum_required(VERSION 3.15)

#includes
include(CMakeConfigBasic.cmake)
include(CMakeConfigAdvanced.cmake)
include(${public_root}cmake/CMakeToolchain.cmake)
include(${public_root}cmake/CMakeFunctions.cmake)

#build_name
project(${private_name} LANGUAGES CXX C ASM)

include(${public_root}cmake/CMakeConfigGeneric.cmake)


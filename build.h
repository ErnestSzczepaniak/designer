#ifndef _build_h
#define _build_h

#define STRING_(X) #X
#define STRING(X) STRING_(X)

enum class Build_platform
{
    target,
    host
};

enum class Build_architecture
{
    v7a,
    v8a,
    v7r,
    v8r,
    v6m,
    v7m,
    v7em,
    x86
};

enum class Build_core
{
    a9,
    a53,
    m0,
    m0plus,
    m1,
    m3,
    m4,
    m7
};

enum class Build_gic
{
    pl390
};

enum class Build_family
{
    c5,
    a10,
    s10,
    z7000
};

enum class Build_board
{
    de10standard,
    de10nano
};

enum class Build_type
{
    debug,
    release
};

struct Build_version
{
    int major;
    int minor;
    int revision;
};

struct Build
{
    Build_platform platform;
    #ifdef build_platform_target
    Build_architecture architecture;
    Build_core core;
    Build_gic gic;
    Build_family family;
    Build_board board;
    #endif
    Build_type type;
    Build_version version;
    const char * name;
    const char * date;
    const char * time;
};

static constexpr Build build
{
    #ifdef build_platform_target
    .platform = Build_platform::target,
    #elif build_platform_host
    .platform = Build_platform::host,
    #endif

    #ifdef build_platform_target

    #ifdef build_architecture_v7a
    .architecture = Build_architecture::v7a,
    #elif build_architecture_v8a
    .architecture = Build_architecture::v8a,
    #elif build_architecture_v7r
    .architecture = Build_architecture::v7r,
    #elif build_architecture_v8r
    .architecture = Build_architecture::v8r,
    #elif build_architecture_v6m
    .architecture = Build_architecture::v6m,
    #elif build_architecture_v7m
    .architecture = Build_architecture::v7m,
    #elif build_architecture_v7me
    .architecture = Build_architecture::v7me,
    #elif build_architecture_x86
    .architecture = Build_architecture::x86,
    #endif

    #ifdef build_core_a9
    .core = Build_core::a9,
    #elif build_core_a53
    .core = Build_core::a53,
    #elif build_core_m0
    .core = Build_core::m0,
    #elif build_core_m0plus
    .core = Build_core::m0plus,
    #elif build_core_m1
    .core = Build_core::m1,
    #elif build_core_m3
    .core = Build_core::m3,
    #elif build_core_m3
    .core = Build_core::m3,
    #elif build_core_m4
    .core = Build_core::m4,
    #elif build_core_m7
    .core = Build_core::m7,
    #endif

    #ifdef build_gic_pl390
    .gic = Build_gic::pl390,
    #endif

    #ifdef build_family_c5
    .family = Build_family::c5,
    #elif build_family_a10
    .family = Build_family::a10,
    #elif build_family_s10
    .family = Build_family::s10,
    #elif build_family_z7000
    .family = Build_family::z7000,
    #endif

    #ifdef build_board_de10standard
    .board = Build_board::de10standard,
    #elif build_board_de10nano
    .board = Build_boardde10nano,
    #endif

    #endif

    #ifdef build_type_debug
    .type = Build_type::debug,
    #elif build_type_release
    .type = Build_type::release,
    #endif

    .version = {build_version_major, build_version_minor, build_version_revision},
    .name = STRING(build_name),
    .date = __DATE__,
    .time = __TIME__
};

#endif
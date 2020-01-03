#ifndef _build_h
#define _build_h

enum class Build_architecture
{
    v7,
    v8,
    x86
};

enum class Build_target
{
    c5,
    a10,
    s10,
    z7000
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
    Build_architecture architecture;
    Build_target target;
    Build_type type;
    Build_version version;
    const char * name;
    const char * date;
    const char * time;
};

#define STRING_(X) #X
#define STRING(X) STRING_(X)

static constexpr Build build
{
    #ifdef build_architecture_v7
    .architecture = Build_architecture::v7,
    #elif build_architecture_v8
    .architecture = Build_architecture::v8,
    #elif build_architecture_x86
    .architecture = Build_architecture::x86,
    #endif

    #ifdef build_target_c5
    .target = Build_target::c5,
    #elif build_target_a10
    .target = Build_target::a10,
    #elif build_target_s10
    .target = Build_target::s10,
    #elif build_target_z7000
    .target = Build_target::z7000,
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
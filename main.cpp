#if build_architecture_x86

#include "build.h"
#include "test.h"

#else

#include "build.h"
#include "string.h"

int main()
{

    while(1);
}

#endif
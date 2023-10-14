#include "lib.h"
#include <stdio.h>

int test_lib_functions()
{
    unsigned char *memory1 = (unsigned char *)_malloc(1); // malloc 1 byte
    if (memory1 == 0)
    {
        printf("Unit-test test_lib_functions failed becasue memory1 was 0\n");
        return 1;
    }

    *memory1 = 200;

    if (*memory1 != 200)
    {
        printf("Unit-test test_lib_functions failed becasue memory1 was not equal to 200\n");
        return 1;
    }

    unsigned char *memory2 = (unsigned char *)_malloc(1); // malloc another byte
    _memcpy(memory2, memory1, 1);

    if (*memory2 != 200)
    {
        printf("Unit-test test_lib_functions failed becasue memory2 was not equal to 200\n");
        return 1;
    }

    _free(memory1, 1);
    _free(memory2, 1);

    printf("Unit-test test_lib_functions was sucessful\n");

    return 0;
}

int main()
{
    return test_lib_functions();
}
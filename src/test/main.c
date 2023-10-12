#include "lib.h"
#include <stdio.h>

int test_lib_functions()
{
    unsigned char *memory = (unsigned char *)_malloc(1); // malloc 1 byte
    if (memory == 0)
    {
        printf("Unit-test test_lib_functions failed becasue memory was 0\n");
        return 1;
    }

    *memory = 200;

    if (*memory != 200)
    {
        printf("Unit-test test_lib_functions failed becasue memory was not equal to 200\n");
        return 1;
    }

    _free(memory, 1);
    printf("Unit-test test_lib_functions was sucessful\n");

    return 0;
}

int main()
{
    return test_lib_functions();
}
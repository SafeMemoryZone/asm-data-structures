#include "lib.h"
#include <stdio.h>
#include <assert.h>

int test_lib_functions()
{
    unsigned char *memory1 = (unsigned char *)_malloc(1); // malloc 1 byte

    *memory1 = 200;

    assert(*memory1 == 200); // make sure it has been set

    unsigned char *memory2 = (unsigned char *)_malloc(1); // malloc another byte

    _memcpy(memory2, memory1, 1);
    assert(*memory2 == 200);

    _free(memory1, 1);
    _free(memory2, 1);

    printf("Unit-test test_lib_functions was sucessful\n");

    return 0;
}

int main()
{
    return test_lib_functions();
}
#include "lib.h"
#include "data_structures.h"
#include <stdio.h>
#include <assert.h>

void test_lib_functions()
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
}

void test_data_structures()
{
    void *arr = _arr_new();
    _arr_append(arr, 2);
    _arr_append(arr, 1);

    unsigned long long poppedVal = _arr_pop(arr);
    assert(poppedVal == 1);

    poppedVal = _arr_pop(arr);
    assert(poppedVal == 2);

    printf("Unit-test test_data_structures was sucessful\n");
}

int main()
{
    test_lib_functions();
    test_data_structures();

    return 0;
}
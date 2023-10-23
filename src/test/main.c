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

void printBits(unsigned long long n)
{
    int bitCount = sizeof(unsigned long long) * 8; // Number of bits in unsigned long long

    for (int i = 0; i < bitCount; i++)
    {
        printf("%llu", (n & 1)); // Print the rightmost bit
        n >>= 1;                 // Right shift by 1 to check the next bit
    }
    printf("\n");
}

void test_data_structures()
{
    void *arr = _arr_new();
    printf("Header:\n");
    printBits(*(unsigned long long *)arr);
    arr = _arr_append(arr, 100);
    printf("Header:\n");
    printBits(*(unsigned long long *)arr);
    arr = _arr_append(arr, 40);
    printf("Header:\n");
    printBits(*(unsigned long long *)arr);
    arr = _arr_append(arr, 120);
    printf("Header:\n");
    printBits(*(unsigned long long *)arr);

    printf("header: %llu\n", *(unsigned long long *)arr);

    unsigned long long *ptr = (unsigned long long *)arr;
    for (int i = 0; i < 10; ++i)
    {
        printf("Value: %llu\n", ptr[i]);
        printBits(ptr[i]);
    };

    unsigned long long popped = _arr_pop(arr);
    printf("Popped: %llu\n", popped);

    printf("Unit-test test_data_structures was sucessful\n");
}

int main()
{
    test_lib_functions();
    test_data_structures();

    return 0;
}
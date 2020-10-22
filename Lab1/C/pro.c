#include <stdio.h>
#include <stdlib.h>

int main(int argc, char const *argv[])
{
    int a = 183;
    long int b;
    b = a * 152 >> (5);
    printf("%d \n", b);
    printf("%d     %d\n", sizeof(int), sizeof(long int));
    return 0;
}

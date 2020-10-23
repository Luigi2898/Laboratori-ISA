#include <stdio.h>
#include <stdlib.h>

int main(int argc, char const *argv[])
{
    int a, b, o;
    while(1){
	    printf("A:\t");
	    scanf("%d", &a);
   	    printf("B:\t");
	    scanf("%d", &b);
	    o = (a * b) >> (11 - 1);
	    printf("%d\n", o);
    }

    return 0;
}

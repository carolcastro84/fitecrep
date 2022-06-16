#include <stdio.h>

int main()
{
    for (int i = 1; i < 101; i++){
        if (i % 3 == 0){
            printf("Foo");
        }
        if (i % 5 == 0){
            printf("Baa");
        }
        if (!(i % 3 == 0 | i % 5 == 0)){
            printf("%d \n", i);
        }else{
            printf("\n");
        }
        
    }
    return 0;
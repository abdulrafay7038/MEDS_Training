#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

void printBits(unsigned int num) {

    for (int i = sizeof(num) * 8 - 1; i >= 0; i--) {
        printf("%d", (num >> i) & 1);
    }
    printf("\n");

}

int main(int argc, char * argv[]){

    if (argc < 2){
        printf("Please input a number");
        return -1;
    } 

    // strtoul(const char *str, char **endptr, int base);

    int32_t in = strtoul(argv[1], NULL, 16);  //16 for hexadecimal

    printf("Decimal (Signed): %d\n", in);
    printf("Decimal (Unsigned): %u\n", in);
    printf("Hexadecimal: 0x%08X\n", in);
    printf("Binary: ");
    printBits(in);
    return 0;

}
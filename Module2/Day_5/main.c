#include<stdio.h>
#include<stdint.h>
#include"decoder.h"
#include"decoder.h"

int main(){
    uint32_t instruction;

    printf("Enter 32-bit Instruction: ");
    scanf("%X",&instruction);
    
    decode_print_r_type(instruction);
}
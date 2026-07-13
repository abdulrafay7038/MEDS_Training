/* Exercise 4: Write a program that takes an RV32 instruction as hex input and prints 
all fields: opcode, rd, funct3, rs1, rs2, funct7. Test with at least 5 different 
instructions. */


#include <stdio.h>
#include <stdint.h>

#define EXTRACT_BITS(val, high, low) \
(((val) >> (low)) & ((1U << ((high)-(low)+1)) - 1))

uint32_t extract_field(uint32_t instruction, int high, int low) {
    return EXTRACT_BITS(instruction, high, low);
}

int main(){
    uint32_t instruction;
    printf("Enter an RV32 instruction: ");
    scanf("%X", &instruction);
    uint32_t opcode = extract_field(instruction,6,0);
    uint32_t rd = extract_field(instruction,11,7);
    uint32_t funct3 = extract_field(instruction,14,12);
    uint32_t rs1 = extract_field(instruction,19,15);
    uint32_t rs2 = extract_field(instruction,24,20);
    uint32_t funct7 = extract_field(instruction,31,25);

    printf("opcode: 0x%X\n", opcode);
    printf("destination register (rd): 0x%X\n", rd);
    printf("operation (funct3): 0x%X\n", funct3);
    printf("source register 1 (rs1): 0x%X\n", rs1);
    printf("source register 2 (rs2): 0x%X\n", rs2);
    printf("sub operation (funct7): 0x%X\n", funct7);
}
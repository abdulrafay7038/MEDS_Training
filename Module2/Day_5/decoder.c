#include<stdint.h>
#include<stdio.h>

#define EXTRACT_BITS(val, high, low) \
(((val) >> (low)) & ((1U << ((high)-(low)+1)) - 1))

void decode_print_r_type(uint32_t instruction){
    uint32_t opcode = EXTRACT_BITS(instruction,6,0);
    uint32_t rd = EXTRACT_BITS(instruction,11,7);
    uint32_t funct3 = EXTRACT_BITS(instruction,14,12);
    uint32_t rs1 = EXTRACT_BITS(instruction,19,15);
    uint32_t rs2 = EXTRACT_BITS(instruction,24,20);
    uint32_t funct7 = EXTRACT_BITS(instruction,31,25);

    printf("opcode: 0x%X\n", opcode);
    printf("destination register (rd): 0x%X\n", rd);
    printf("operation (funct3): 0x%X\n", funct3);
    printf("source register 1 (rs1): 0x%X\n", rs1);
    printf("source register 2 (rs2): 0x%X\n", rs2);
    printf("sub operation (funct7): 0x%X\n", funct7);
}

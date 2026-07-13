#include <stdio.h>
#include <stdint.h>

#define EXTRACT_BITS(val, high, low) \
(((val) >> (low)) & ((1U << ((high)-(low)+1)) - 1))

uint32_t extract_field(uint32_t instruction, int high, int low) {
    return EXTRACT_BITS(instruction, high, low);
}

int main(){
    uint32_t opcode = extract_field(0x00A28233,6,0);
    uint32_t rd = extract_field(0x00A28233,11,7);
    uint32_t funct3 = extract_field(0x00A28233,14,12);
    uint32_t rs1 = extract_field(0x00A28233,19,15);
    uint32_t rs2 = extract_field(0x00A28233,24,20);
    uint32_t funct7 = extract_field(0x00A28233,31,25);

    printf("opcode: 0x%X\n", opcode);
    printf("destination register (rd): 0x%X\n", rd);
    printf("operation (funct3): 0x%X\n", funct3);
    printf("source register 1 (rs1): 0x%X\n", rs1);
    printf("source register 2 (rs2): 0x%X\n", rs2);
    printf("sub operation (funct7): 0x%X\n", funct7);
}
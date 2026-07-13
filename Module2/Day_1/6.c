#include <stdio.h>
#include <stdint.h>

#define EXTRACT_BITS(val, high, low) \
(((val) >> (low)) & ((1U << ((high)-(low)+1)) - 1))

uint32_t pack_r_type(uint32_t opcode, uint32_t rd, uint32_t funct3, uint32_t rs1, uint32_t rs2, uint32_t funct7){
    return opcode | (rd << 7) | (funct3 << 12) | (rs1 << 15) | (rs2 << 20) | (funct7 << 25);
}

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

int main(){
    uint32_t opcode = 0x33;
    uint32_t rd = 0x4;
    uint32_t funct3 = 0x0;
    uint32_t rs1 = 0x5;
    uint32_t rs2 = 0xA;
    uint32_t funct7 = 0x0;
    // packing instruction
    uint32_t instruction = pack_r_type(opcode, rd, funct3, rs1, rs2, funct7);
    printf("RV32 Instruction: 0x%08X\n", instruction);
    //verify by decoding
    decode_print_r_type(instruction);

}
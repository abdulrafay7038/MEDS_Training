/*Exercise 1: Define a decoded_instr_t struct. Write a function 
decode_r_type(uint32_t raw, decoded_instr_t *out) that fills all fields. Test with 
0x00A28233 (add x4, x5, x10). */


#include<stdio.h>
#include<stdint.h>

#define EXTRACT_BITS(val, high, low) \
(((val) >> (low)) & ((1U << ((high)-(low)+1)) - 1))

typedef struct{ 
    uint32_t opcode; 
    uint32_t rd; 
    uint32_t funct3; 
    uint32_t rs1; 
    uint32_t rs2; 
    uint32_t funct7; 
} decoded_instr_t; 

void decode_r_type(uint32_t raw, decoded_instr_t *out){
    out->opcode = EXTRACT_BITS(raw,6,0);
    out->rd = EXTRACT_BITS(raw,11,7);
    out->funct3 = EXTRACT_BITS(raw,14,12);
    out->rs1 = EXTRACT_BITS(raw,19,15);
    out->rs2 = EXTRACT_BITS(raw,24,20);
    out->funct7 = EXTRACT_BITS(raw,31,25);
}


int main(){
    decoded_instr_t instr;
    decode_r_type(0x00A28233, &instr);
    printf("opcode = 0x%X\n", instr.opcode);
    printf("rd = 0x%X\n", instr.rd);
    printf("funct3 = 0x%X\n", instr.funct3);
    printf("rs1 = 0x%X\n", instr.rs1);
    printf("rs2 = 0x%X\n", instr.rs2);
    printf("funct7 = 0x%X\n", instr.funct7);
    return 0;
}
/*Exercise 5: Use a union to create an instruction_t with both raw access and 
R-type/I-type struct views. Decode 0x00500113 (addi x2, x0, 5) using the I-type 
view.*/


#include <stdio.h>
#include <stdint.h>

typedef union { 
    uint32_t raw;          // Full 32-bit word 
    struct {               // R-type fields 
        uint32_t opcode : 7; 
        uint32_t rd     : 5; 
        uint32_t funct3 : 3; 
        uint32_t rs1    : 5; 
        uint32_t rs2    : 5; 
        uint32_t funct7 : 7; 
    } r_type; 
    struct {               // I-type fields 
        uint32_t opcode : 7; 
        uint32_t rd     : 5; 
        uint32_t funct3 : 3; 
        uint32_t rs1    : 5; 
        uint32_t imm    : 12; 
    } i_type; 
} instruction_t; 
 
// Usage: 
int main(){
    instruction_t inst; 
    inst.raw = 0x00500113;           // Load full instruction 
    printf("opcode = 0x%u\n", inst.i_type.opcode);    // Access as I-type 
    printf("rd = x%u\n", inst.i_type.rd);
    printf("funct3 = %u\n", inst.i_type.funct3);
    printf("rs1 = x%u\n", inst.i_type.rs1);
    printf("imm = %u\n", inst.i_type.imm);
}

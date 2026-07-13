/*Exercise 2: Define the opcode_t enum with all RV32I opcodes. Write const char 
*opcode_to_string(opcode_t op) that returns the mnemonic. Test with all opcodes*/

#include<stdio.h>
#include<stdint.h>

typedef enum { 
    OP_R_TYPE  = 0x33,  // Register-register 
    OP_I_TYPE  = 0x13,  // Immediate arithmetic 
    OP_LOAD    = 0x03,  // Load from memory 
    OP_STORE   = 0x23,  // Store to memory 
    OP_BRANCH  = 0x63,  // Conditional branch 
    OP_JAL     = 0x6F,  // Jump and link 
    OP_JALR    = 0x67,  // Jump and link register 
    OP_LUI     = 0x37,  // Load upper immediate 
    OP_AUIPC   = 0x17,  // Add upper immediate to PC 
    OP_SYSTEM  = 0x73,  // System instructions (ECALL, CSR) 
} opcode_t; 

const char *opcode_to_string(opcode_t op){
    switch(op)
    {
    case OP_R_TYPE: return "R-Type";
    case OP_I_TYPE: return "I-Type";
    case OP_LOAD:   return "Load from memory";
    case OP_STORE:  return "Store to memory ";
    case OP_BRANCH: return "Conditional branch ";
    case OP_JAL:    return "Jump and Link";
    case OP_JALR:   return "Jump and link register";
    case OP_LUI:    return "Load upper immediate";
    case OP_AUIPC:  return "Add upper immediate to PC";
    case OP_SYSTEM: return "System Instructions (ECALL, CSR)";
    }

}

int main(){
    opcode_t op[] = {OP_R_TYPE,OP_I_TYPE,OP_LOAD,OP_STORE,OP_BRANCH,OP_JAL,OP_JAL,OP_JAL,OP_LUI,OP_AUIPC,OP_SYSTEM}; 
    for(int i = 0; i<11; i++){
    printf("%s\n", opcode_to_string(op[i]));
    }

}
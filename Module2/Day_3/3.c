/*Exercise 3: Create a cpu_state_t struct. Write cpu_init(), reg_write(), reg_read(). 
Write dump_registers() that prints all 32 registers with their ABI names (x0/zero, 
x1/ra, x2/sp, etc.). */

#include<stdio.h>
#include<stdint.h>
#include<stdlib.h>
#include<string.h>

typedef struct { 
    uint32_t x[32];       // 32 general-purpose registers 
    uint32_t pc;          // Program counter 
    uint8_t  *memory;     // Pointer to memory (allocated on heap) 
    size_t   mem_size;    // Memory size in bytes 
 
    // Statistics 
    uint64_t instr_count;  // Instructions executed 
    uint64_t cycle_count;  // Cycles simulated 
} cpu_state_t; 
 
// Initialize CPU 
void cpu_init(cpu_state_t *cpu, size_t mem_size) { 
    memset(cpu->x, 0, sizeof(cpu->x));  // All regs = 0 
    cpu->pc = 0x00000000; 
    cpu->memory = calloc(mem_size, 1);   // Zero-initialized memory 
    cpu->mem_size = mem_size; 
    cpu->instr_count = 0; 
    cpu->cycle_count = 0; 
} 
 
// Write register (enforcing x0 = 0) 
void reg_write(cpu_state_t *cpu, uint8_t rd, uint32_t value) { 
    if (rd != 0) { 
        cpu->x[rd] = value; 
    } 
} 

// Read register
uint32_t reg_read(cpu_state_t *cpu, uint8_t rd) {
    return cpu->x[rd];
}

// Dump Registers
void dump_registers(cpu_state_t *cpu) {
    const char *abi[32] = {
        "zero","ra","sp","gp","tp",
        "t0","t1","t2",
        "s0","s1",
        "a0","a1","a2","a3","a4","a5","a6","a7",
        "s2","s3","s4","s5","s6","s7","s8","s9","s10","s11",
        "t3","t4","t5","t6"
    };
    for(int i = 0; i<32; i++){
        printf("x%d:0x%X/%s, ", i, cpu->x[i], abi[i]);
    }
}

int main(){
    cpu_state_t cpu;
    cpu_init(&cpu,2048);
    reg_write(&cpu,6,0x5);
    dump_registers(&cpu);
    return 0;
}
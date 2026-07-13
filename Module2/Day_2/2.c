/*Exercise 2: Implement a simulated 32-register file as uint32_t regs[32]. Write 
functions: void write_reg(uint32_t *regs, uint8_t rd, uint32_t value) that enforces 
x0=0, and uint32_t read_reg(const uint32_t *regs, uint8_t rs). */


#include<stdio.h>
#include<stdint.h>

void write_reg(uint32_t *regs, uint8_t rd, uint32_t value){
    if (rd == 0) printf("x0 enforced to 0\n");
    else if (rd > 31) printf("index out of range\n");
    else regs[rd] = value;
}

uint32_t read_reg(const uint32_t *regs, uint8_t rs){
    if (rs > 31) printf("Index out of range\n");
    else return regs[rs];
}

int main(){
    uint32_t regs[32];
    regs[0] = 0;
    write_reg(regs,5,15);
    printf("x5 = %u", read_reg(regs,5));
    return 0;
}
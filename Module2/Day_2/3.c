/*Exercise 3: Write a function void memory_dump(const uint8_t *mem, size_t size) 
that prints memory as a hex dump with addresses (like xxd). Format: 0x0000: DE 
AD BE EF  CA FE BA BE  |........|*/

#include<stdio.h>
#include<stdint.h>

void memory_dump(const uint8_t *mem, size_t size){
    for(int i = 0; i<size; i++){
        printf("0x%04X:%02X  ", i, mem[i]);
    }
} 

int main(){
    uint8_t mem[4] = {0x32,0x33,0x34,0x35};
    memory_dump(mem,4);
    return 0;
}
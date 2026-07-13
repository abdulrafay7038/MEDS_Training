/*Exercise 6 (Bonus): Write a simulated 256-byte memory (uint8_t mem[256]). 
Implement load_word(mem, addr) and store_word(mem, addr, value) that handle 
byte-addressed access with proper alignment checks. */

#include <stdio.h>
#include <stdint.h>

uint8_t load_word (const uint8_t *mem, uint8_t addr){
    if (addr % 4 != 0) printf("Address not alligned\n");
    else if(addr + 3 > 255) printf("Address out of bounds\n");
    else return mem[addr];
}

void store_word (uint8_t *mem, uint8_t addr, uint8_t value){
    if (addr % 4 != 0) printf("Address not alligned\n");
    else if(addr + 3 > 255) printf("Address out of bounds\n");
    else mem[addr] = value;
}

int main(){
    uint8_t mem[256];

    store_word(mem, 8, 0xF5);  // OK
    store_word(mem, 10, 0xF6); // Error: not 4-byte aligned

    printf("%X\n", load_word(mem, 8));   // OK
    load_word(mem, 254); // Error: out of bounds
    return 0;
    
}
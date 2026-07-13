/*Exercise 1: Write a program that allocates a 64KB memory array, loads a hex file 
into it, dumps the first 64 bytes, and frees the memory. Run with Valgrind to verify 
zero leaks. */

#include<stdio.h>
#include<stdint.h>
#include<stdlib.h>


int load_hex_file(const char *filename, uint8_t *memory, size_t mem_size) 
{ 
    FILE *fp = fopen(filename, "r"); 
    if (!fp) { 
    perror("Cannot open hex file"); 
        return -1; 
    } 
 
    char line[32]; 
    uint32_t addr = 0; 
    while (fgets(line, sizeof(line), fp) && addr + 3 < mem_size) { 
        uint32_t word = (uint32_t)strtoul(line, NULL, 16); 
        // Store as little-endian (RISC-V convention) 
        memory[addr + 0] = (word >>  0) & 0xFF; 
        memory[addr + 1] = (word >>  8) & 0xFF; 
        memory[addr + 2] = (word >> 16) & 0xFF; 
        memory[addr + 3] = (word >> 24) & 0xFF; 
        addr += 4; 
    } 
    fclose(fp); 
    return (int)(addr / 4);  // Number of words loaded 
}

int main(){

    uint8_t *mem = malloc(65536 * sizeof(uint8_t));
    if (mem == NULL) { 
    fprintf(stderr, "Memory allocation failed!\n"); 
    exit(EXIT_FAILURE); 
    } 
    int amt = load_hex_file("mem.txt", mem, 65536);
    for (int i = 0; i<64;i++){
        printf("0x%X  ", mem[i]);
    }
    free (mem);
    return 0;
}
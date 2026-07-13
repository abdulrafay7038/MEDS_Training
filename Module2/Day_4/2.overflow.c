#include<stdio.h>
#include<stdlib.h>
#include<stdint.h>

int main(){
uint8_t *mem = malloc(32 * sizeof(uint8_t));
mem[32] = 0x33;
free(mem);
}
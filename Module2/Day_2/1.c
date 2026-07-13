/*Exercise 1: Write a program that declares variables in different segments (local, 
global, static, malloc’d). Print their addresses and verify they match the memory 
layout diagram. */

#include<stdio.h>
#include<stdint.h>
#include <stdlib.h>

uint32_t a = 0x33;

int main(){

    uint32_t *b = malloc(4096 * sizeof(uint32_t)); 
    int c = 5;
    static int d = 10;

    printf("Address of a: %p\n", &a);
    printf("Address of b: %p\n", b);
    printf("Address of c: %p\n", &c);
    printf("Address of d: %p\n", &d);
    return 0;
}
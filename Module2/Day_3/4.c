/*Exercise 4: Create a struct with mixed types and predict its size by hand accounting 
for padding. Verify with sizeof(). Reorder fields to minimize size. */

#include<stdio.h>
#include<stdint.h>


struct Student{
    char name[12];    //12 Bytes
    float height;     //4 Byte
    uint8_t age;      //1 Byte 
    uint16_t id;      //2 Byte + 1 byte padding
} s1;

int main(){
    printf("%d", sizeof(s1));
}
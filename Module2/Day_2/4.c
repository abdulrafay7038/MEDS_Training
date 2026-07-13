/*Exercise 4: Write a function that reverses an array of uint32_t in-place using pointer 
arithmetic (no array indexing []). Test with {1, 2, 3, 4, 5}. */

#include<stdio.h>
#include<stdint.h>

void reverse_array(uint32_t *arr, size_t size){
    uint32_t temp;
    for(int i=0; i<size/2; i++){
        temp = *(arr + i);
        *(arr+i) = *(arr + size - 1 - i);
        *(arr + size - 1 - i) = temp;
    }
}
int main(){
    uint32_t arr[5] = {1,2,3,4,5};
    reverse_array(arr,5);
    printf("%d ", arr[0]);
    printf("%d ", arr[1]);
    printf("%d ", arr[2]);
    printf("%d ", arr[3]);
    printf("%d ", arr[4]);
}
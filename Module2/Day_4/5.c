#include <stdio.h>
#include <stdlib.h>

int average(int *arr, int size) {
    int sum = 0;

    for (int i = 0; i < size; i++) {   // Bug #1
        sum += arr[i];
    }

    return sum / size;
}

int main() {
    int n = 5;

    int *numbers = malloc(n * sizeof(int));


    for (int i = 0; i < n; i++) {
        numbers[i] = i + 1;
    }

    printf("Average = %d\n", average(numbers, n));  // Bug #2
    free(numbers);
    return 0;
}
/*Exercise 6 (Bonus): Model a RISC-V UART peripheral as a struct with control, 
status, tx_data, and rx_data registers. Write uart_putchar() and uart_getchar() 
functions that read/write through the struct.*/


#include<stdio.h>
#include<stdint.h>

typedef struct{
    uint32_t control;
    uint32_t status;
    uint32_t tx_data;
    uint32_t rx_data;
} riscv_uart;

void uart_putchar(riscv_uart *u, char character) {
    u->tx_data = character;
}

void uart_getchar(riscv_uart *u) {
    return u->rx_data;
}

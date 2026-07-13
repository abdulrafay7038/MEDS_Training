.text
.globl main

power:
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   a0, 8(sp)          # save base

    beqz a1, base_case

    addi a1, a1, -1
    call power

    lw   t0, 8(sp)          # restore base
    mul  a0, a0, t0         # result *= base

    lw   ra, 12(sp)
    addi sp, sp, 16
    ret

base_case:
    li   a0, 1
    lw   ra, 12(sp)
    addi sp, sp, 16
    ret

main:
    li a0, 5
    li a1, 2
    call power

    mv a1, a0
    li a0, 1
    ecall
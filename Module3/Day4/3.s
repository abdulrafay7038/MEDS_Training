.text
.globl main
avg:
    addi sp, sp, -16
    sw   ra, 12(sp)

    call sum
    srli a0, a0, 1

    lw   ra, 12(sp)
    addi sp, sp, 16
    ret
sum:
    addi sp, sp, -16
    sw   ra, 12(sp)

    add a0, a0, a1

    lw   ra, 12(sp)
    addi sp, sp, 16
    ret    
main:
    li   a0, 5
    li   a1, 12
    call avg
    mv   a1, a0
    li   a0, 1
    ecall


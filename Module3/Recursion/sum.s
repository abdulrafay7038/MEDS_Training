# #include <stdio.h>

# int sum(int n)
# {
#     if (n == 0)
#         return 0;

#     return n + sum(n - 1);
# }
.globl main
.text
sum:    #sum(a1 = n)
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   a1, 8(sp)
    beqz a1, base_case

    addi a1, a1, -1
    call sum              # a0 = sum(n-1)

    lw   t0, 8(sp)        # Retrive original n
    add  a0, t0, a0       # a0 = n + sum(n-1)

    lw   ra, 12(sp)
    addi sp, sp, 16
    ret
    base_case:
        li   a0, 0
        lw   ra, 12(sp)
        addi sp, sp, 16
        ret
main:
    li a1, 2
    call sum    # Returns sum in a0
    mv a1, a0
    li a0, 1
    ecall
        
# #include <stdio.h>

# int sum(int n)
# {
#     if (n == 0)
#         return 0;

#     return n + sum(n - 1);
# }

.text
sum:    #sum(a1 = n)
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   a1, 8(sp)
    beqz a1, base_case

    addi a1, a1, -1
    call sum              # a0 = sum(n-1)

    lw   a1, 8(sp)        # Retrive original n
    add  a0, a0, a1       # a0 = n + sum(n-1)
    base_case:
        
# Exercise 1: Write a program that computes (b * 8) - (c / 4) using ONLY shifts and 
# add/sub. Let b=12, c=64. Expected: 80.

.text
    addi t0, zero, 12 #b
    addi t1, zero, 64 #c
    slli t3, t0, 3
    srli t4, t1, 2
    sub  t5, t3, t4
    add  a1, zero, t5
    addi a0, zero, 1
    ecall 

# Exercise 2: Write a program that extracts the lower byte, second byte, and upper 
# half-word from 0xDEADBEEF using AND/shift. Print each. 
.data
    word: .word 0xDEADBEEF
.text
    la t1, word
    lbu t2, 0(t1) #Lower Byte
    lbu t3, 1(t1) #Second Byte
    lhu t4, 2(t1) #Upper half word


    add  a1, zero, t2
    addi a0, zero, 1
    ecall

    add  a1, zero, t3
    ecall

    add  a1, zero, t4
    ecall

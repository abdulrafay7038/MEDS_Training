.data
 even: .string "EVEN"
 odd:  .string "ODD"
.text
.globl main
main:
     addi a1, zero, 73
     addi a0, zero, 1
     ANDI a1, a1, 1
     beq a1,a0, n_odd 
     la a1, even
     j print
     n_odd: 
        la a1, odd
     print:
     addi a0, zero, 4
     ecall
     exit:
     addi a0, zero, 10
     ecall
     
     
     
     
    
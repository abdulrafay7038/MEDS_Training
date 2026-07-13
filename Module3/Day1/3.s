.data
message:  .string "Hello MEDS!" 
.text
.globl main
main:
     la   a1, message
     addi a0, zero, 4
     ecall
     addi a0, zero, 10
     ecall
    
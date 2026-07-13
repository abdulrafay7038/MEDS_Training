 .text 
 main: 
 #Add
 addi a0,zero,42
 addi a1,zero,58
 add  a1,a1,a0
 #Print
 addi a0,zero,1
 ecall
 #Exit
 addi a0,zero,10
 ecall
.text
.globl main
main:
     addi t0, zero, 10
     addi t1, zero, 0  #Counter
     addi a1, zero, 0  #Sum Reg
     
     loop_start:
            bgt t1, t0, loop_end
            add a1,a1,t1
            addi t1,t1,1
            j loop_start
     loop_end:    
    
    addi a0, zero, 1
    ecall
    addi a0, zero, 10
    ecall
     
    
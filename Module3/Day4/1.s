.data
    array: .word 1,2,3,4,5
.text
.globl main
max:
    addi sp, sp, -16       
    sw ra, 12(sp)             
    bgt a0,a1, return_max
    beq a0,a1, return_max
    mv  a0,a1
    return_max:
        lw ra, 12(sp) 
        addi sp, sp, 16
        ret
sum_array:
    addi sp, sp, -16       
    sw ra, 12(sp)  
    li t1, 0     #i=0
    li t2, 0     #sum=0
    slli a1, a1, 2
    loop:
        bge t1, a1, end #if (i >= size *4) end
        add t0, a0, t1  #&array[i]
        lw  t4, 0(t0)   #t4 = array[i]
        add t2, t2, t4  #sum = sum + array[i]
        addi t1, t1, 4  #i = i + 4
        j loop
    end:  
        lw ra, 12(sp) 
        addi sp, sp, 16
        mv a0, t2
        ret  
main:
    li a0, 5
    li a1, 10
    call max
    mv a1, a0
    li a0, 1
    ecall
    la a0, array
    li a1, 5
    call sum_array
    mv a1, a0
    li a0, 1
    ecall


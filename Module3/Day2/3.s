#Exercise 3: Create a .data array of 8 words. Write a program that computes and 
#prints the sum. Verify in Venus memory panel. 

.data 
    array: .word 1,2,3,4,5,6,7,8
.text   
    la s0, array #array
    li t1, 0     #i=0
    li t2, 0     #sum=0
    li t3, 8     #size=8
    slli t3, t3, 2
    loop:
        bge t1, t3, end #if (i >= size *4) end
        add t0, s0, t1  #&array[i]
        lw  t4, 0(t0)   #t4 = array[i]
        add t2, t2, t4  #sum = sum + array[i]
        addi t1, t1, 4  #i = i + 4
        j loop
    end:    

    mv a1, t2
    addi a0, zero, 1
    ecall

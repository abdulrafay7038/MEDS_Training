.data   
    array: .word 1,2,3,4,5
.text
    la t1, array
    li t0, 5         #size  = 5
    addi t1, t1, 0   #left  = &array[0]
    addi t2, t0, -1  #t2 = size - 1
    slli t2, t2, 2
    add t3, t1, t2   #right = &array[size - 1]
    srli t0, t0, 1   #size/2
    li t4, 0         #i = 0
    for:
        bgt t4, t0, end_for
        swap:
            lw t5, 0(t1)
            lw t6, 0(t3)
            sw t5, 0(t3)
            sw t6, 0(t1)
        addi t3, t3, -4
        addi t1, t1,  4
        addi t4, t4,  1
        j for
    end_for: 

    
.data 

    array: .word 1,-10,3,-20,11,-12,7,8,-8,14
.text   

    la   s0, array         #array
    li   t1, 0             #i=0
    li   t2, 10            #size=10
    slli t2, t2, 2         #t2 = size * 4
    lw   t4, 0(s0)         #t4 = array[0]
    add  t6, t4, zero      #t5/max = array[0]
    j loop
    max:
        add  t6, t5, zero   #max = array[i]
    loop:
        bge  t1, t2, end   #if (i >= size *4) end
        addi t1, t1, 4     #i = i + 4
        add  s1, s0, t1    #s1=&array[i]
        lw   t5, 0(s1)     #t5=array[i]  
        bgt  t5, t6, max   #if(array[i]>array[0])
        j loop
    end:    

    mv   a1, t6
    addi a0, zero, 1
    ecall
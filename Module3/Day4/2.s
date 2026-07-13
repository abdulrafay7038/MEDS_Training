.globl main
#fibonacci(n = a1)
fibonacci: 
    #Allocate Stack
    addi sp, sp, -16
    sw   ra, 12(sp)   #Save Return address
    sw   a1, 8(sp)
    sw   s0, 4(sp)
    li   t0, 1        #t0 = 1

    beqz a1, fib0     #if (n==0) return 0
    beq  a1, t0, fib1 #if (n==1) return 1

    #call fibonacci(n-1)
    addi a1, a1, -1    # a1 = n - 1
    call fibonacci
    add  s0, a0, zero  #Save result of fibonnaci(n-1)

    lw   a1, 8(sp)
    #call fibonacci(n-2)
    addi a1, a1, -2   # a1 = n - 2
    call fibonacci

    add s0, s0, a0     #fibonacci(n-1) + fibonacci(n-2)
    mv  a0, s0
    j done

    fib0:
        li a0, 0
        j done
    fib1:
        li a0, 1 
        j done   
    done:
        lw s0, 4(sp)
        lw ra, 12(sp)
        addi sp, sp, 16
        ret 
main:
    li  a1, 5
    call fibonacci
    mv  a1, a0
    li  a0, 1
    ecall        

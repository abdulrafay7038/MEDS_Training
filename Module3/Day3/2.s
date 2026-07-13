.text
    li  a0, 5
    ecall
    li  t0, 1   # fact = 0
    for:
        beqz a1, end_for
        mul t0, a1,t0
        addi a1, a1, -1
        j for
    end_for:
        mv a1,t0
        li a0,1
        ecall
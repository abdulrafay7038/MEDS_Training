# int arraySum(int arr[], int n)
# {
#     if (n == 0)
#         return 0;

#     return arr[n - 1] + arraySum(arr, n - 1);
# }

.data
    array: .word 1,2,3,4,5
.globl main
.text
arraysum:  #arraysum(a0 = arr, a1 = n)
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   a1, 8(sp)
    sw   a0, 4(sp)

    beqz a1, base_case
    addi a1, a1, -1
    call arraysum     #a0 = arraysum(arr, n-1)

    lw a1, 8(sp)        # restore n
    lw t2, 4(sp)        # restore arr pointer

    addi a1, a1, -1

    slli t0, a1, 2      # (n-1)*4
    add  t0, t2, t0     # &arr[n-1]
    lw   t1, 0(t0)      # arr[n-1]

    add  a0, a0, t1     # return_value + arr[n-1]

    lw   ra, 12(sp)
    addi sp, sp, 16
    ret
    base_case:
        li   a0, 0
        lw   ra, 12(sp)
        addi sp, sp, 16
        ret
main:
    la a0, array
    li a1, 5
    call arraysum 
    mv a1, a0
    li a0, 1
    ecall       

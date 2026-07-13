# #include <stdio.h>

# void selectionSort(int arr[], int n)
# {
#     int i, j, minIndex, temp;

#     for (i = 0; i < n - 1; i++)
#     {
#         minIndex = i;

#         for (j = i + 1; j < n; j++)
#         {
#             if (arr[j] < arr[minIndex])
#             {
#                 minIndex = j;
#             }
#         }

#         if (minIndex != i)
#         {
#             temp = arr[i];
#             arr[i] = arr[minIndex];
#             arr[minIndex] = temp;
#         }
#     }
# }

.data
    array: .word 5,4,3,2,1
.globl main
.text

selectionsort:  #selectionsort(a0 = arr[], a1 = n)
    addi sp, sp, -16
    sw   ra, 12(sp)

    li   t0, 0                # i  = t0 = 0
    addi t1, a1, -1           # t1 = n - 1
    slli t1, t1, 2            # t1 * 4
    
    outerloop:
        bge  t0, t1, outerloop_end
        mv   t2, t0            # minIndex = i
        addi t3, t0, 4         # j = i + 4
        slli t4, a1, 2            # t4 = n * 4
        innerloop:
            bge t3, t4, innerloop_end
            add t5, a0, t3     # t5 = &arr[j]
            add t6, a0, t2     # t6 = &arr[minIndex]
            lw  s0, 0(t5)      # s0 = arr[j]
            lw  s1, 0(t6)      # s1 = arr[minIndex]
            blt s0, s1, updateminIndex
            j noupdate
            updateminIndex:
                mv t2, t3
            noupdate:
                addi t3, t3, 4   # j = j + 4
                j innerloop    
        innerloop_end:  
            bne t2, t0, swap
            j noswap
            swap:
                add t6, a0, t2
                add s7, t0, a0
                lw  s0, 0(t6)
                lw  s1, 0(s7)
                sw  s0, 0(s7)
                sw  s1, 0(t6)
            noswap:
            addi t0, t0, 4    # i = i + 4
            j outerloop
    outerloop_end:
            lw   ra, 12(sp)
            addi sp, sp, 16
            ret

main:
    la  a0, array
    li  a1, 5
    call selectionsort
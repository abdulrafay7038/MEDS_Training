.data
    array: .word 10, 20, 30, 40, 50
.text
    li   s1, 10          # key = 10
    li   t0, 0           # t0 = low offset = 0
    li   t1, 16          # t1 = high offset = 16 (4 bytes * 4)
    la   s2, array       # s2 = base address of array

while:  
    bgt  t0, t1, not_found   # if low > high, key is not in array
    
    # Calculate mid offset: mid = ((low + high) / 2) aligned to 4 bytes
    add  t2, t0, t1      # t2 = low + high
    srli t2, t2, 1       # t2 = (low + high) / 2
    andi t2, t2, -4      # Clear lower 2 bits to force 4-byte alignment

    # Load array[mid]
    add  t3, s2, t2      # t3 = base address + mid offset
    lw   t4, 0(t3)       # t4 = array[mid]

    # Compare key with array[mid]
    beq  s1, t4, found   # if key == array[mid], branch to found
    blt  s1, t4, update_h # if key < array[mid], search left half
    
    # Else, search right half: low = mid + 4
    addi t0, t2, 4
    j    while

update_h:
    # Search left half: high = mid - 4
    addi t1, t2, -4
    j    while    

not_found:
    li   a1, -1          # Return -1 if not found
    j    end

found:
    srli a1, t2, 2       # Convert byte offset (t2) back to index (0-4)

end:    
    li   a0, 1           # Environment call to print integer
    ecall                # Prints the index of the found element (0)

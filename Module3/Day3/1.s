.data   
    positive: .string "Positive"
    negative: .string "Negative"
    zero:     .string "Zero"
.text
    li  a0, 5
    ecall
    bgt a1, zero, num_pos
    blt a1, zero, num_neg
    beq a1, zero, num_zero

    num_pos:
        la a1, positive
        j end
    num_neg:
        la a1, negative    
        j end
    num_zero:
        la a1, zero
        j end    
    end:
        li a0, 4
        ecall

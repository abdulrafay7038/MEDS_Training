.text

addi a0,zero,5
ecall

add a1,zero,a0

addi a0,zero,5
ecall

add a1,a1,a0

#Print

addi a0,zero,1
ecall

#Exit

addi a0,zero,10
ecall

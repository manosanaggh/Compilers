square(int*, unsigned int):
        addi    sp,sp,-48 # Allocating space at stack for 8 words of 64 bits
        sd      s0,40(sp) # Store s0 (callee)
        addi    s0,sp,48 # s0 = fp
        sd      a0,-40(s0) # Store arr (callee)
        mv      a5,a1 # a5 = size
        sw      a5,-44(s0) # Store size
        sw      zero,-20(s0) # sum = 0
        sw      zero,-24(s0) # i = 0
        j       .L2 # jump to .L2
.L3:
        lw      a5,-24(s0) # load i
        slli    a5,a5,2 # i=i*4 (index*word size=offset)
        ld      a4,-40(s0) # load arr to a4
        add     a5,a4,a5 # arr+=offset
        lw      a5,0(a5) # a5 = arr[offset]
        lw      a4,-20(s0) # load sum
        addw    a5,a4,a5 # sum+=arr[offset]
        sw      a5,-20(s0) # store sum
        lw      a5,-24(s0) # load i
        addiw   a5,a5,1 # i++
        sw      a5,-24(s0) # store i
.L2:
        lw      a4,-24(s0) # load i
        lw      a5,-44(s0) # load size
        sext.w  a5,a5 # sign extend size (uint), because it is compared with an sint
        bgtu    a5,a4,.L3 # jump to .L3 if size > i (condition to continue looping) 
        lw      a5,-20(s0) # load sum
        mv      a0,a5 # mv sum to a0 (return value)
        ld      s0,40(sp) # load arr (array base address) to s0
        addi    sp,sp,48 # deallocate stack
        jr      ra # return from square
.LC1:
        .string "%d\n" # printf syntax
.LC0: # array initialization
        .word   0
        .word   1
        .word   2
        .word   3
        .word   4
main:
        addi    sp,sp,-48 # Allocating space for 6 words (6*8 bytes) = (6*64 bits)
        sd      ra,40(sp) # Store ra (caller)
        sd      s0,32(sp) # Store s0 (caller)
        addi    s0,sp,48 # s0 = fp
        lui     a5,%hi(.LC0) # Higher 32 bits of the array are stored in a5
        addi    a5,a5,%lo(.LC0) # Lower 32 bits of the array are stored in a5 
        ld      a4,0(a5) # a4 = arr[0-1]
        sd      a4,-40(s0) # Store arr[0-1]
        ld      a4,8(a5) # a4 = arr[2-3]
        sd      a4,-32(s0) # Store arr[2-3]
        lw      a5,16(a5) # a5 = arr[4]
        sw      a5,-24(s0) # Store arr[4]
        addi    a5,s0,-40 # a5 = fp - 40
        li      a1,5 # Preparing arg1 (size)
        mv      a0,a5 # Preparing arg0 (arr)
        call    square(int*, unsigned int) # Call square
        mv      a5,a0 # a5=a0(return value) 
        mv      a1,a5 # a1=a1(return value)
        lui     a5,%hi(.LC1) # prepare printf
        addi    a0,a5,%lo(.LC1) # prepare printf
        call    printf # call printf
        li      a5,0 # a5=0
        mv      a0,a5 # a0=a5
        ld      ra,40(sp) # Load ra (caller)
        ld      s0,32(sp) # Load s0 (caller)
        addi    sp,sp,48 # deallocate stack
        jr      ra # return from main

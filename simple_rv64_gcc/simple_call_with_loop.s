#rv64gc GCC 12.2.0
#-O0 -march=rv64gc_zba_zbb_zbs

square(int*, unsigned int):
        addi    sp,sp,-48 # Allocating 6 words at the stack for the callee saves 
        sd      s0,40(sp) # Store s0 (callee) 
        addi    s0,sp,48 # s0 = frame pointer
        sd      a0,-40(s0) # Store arg0 (arr) (callee)
        mv      a5,a1 # a5 = size 
        sw      a5,-44(s0) # Store arg1 (size) (callee)
        sw      zero,-20(s0) # Store i
        j       .L2 # Execute L2
.L3:
        lw      a5,-20(s0) # Load i
        addiw   a5,a5,1 # i++
        sw      a5,-20(s0) # Store i
.L2:
        lw      a4,-20(s0) # Load i
        lw      a5,-44(s0) # Load size
        sext.w  a5,a5 # size needs to be sign extended in order to be compared with a signed integer (i)
        bgtu    a5,a4,.L3 # if size > i then execute L3
        nop # else
        nop
        ld      s0,40(sp) # Load previous s0
        addi    sp,sp,48 # Free the 6 words allocated by the callee
        jr      ra # return from square
main:
        addi    sp,sp,-16 # Allocating 2 words at the stack for the caller saves
        sd      ra,8(sp) # Save ra (caller)
        sd      s0,0(sp) # Save s0 (caller)
        addi    s0,sp,16 # s0 becomes the frame pointer
        li      a1,0 # Preparing arg1
        li      a0,0 # Preparing arg0
        call    square(int*, unsigned int) # Call square
        li      a5,0 # a5 = 0
        mv      a0,a5 # a0 is the value to be returned by main
        ld      ra,8(sp) # Load ra
        ld      s0,0(sp) # Load s0
        addi    sp,sp,16 # Free the 2 words allocated by the caller
        jr      ra # return from main

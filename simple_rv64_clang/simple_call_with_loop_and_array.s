square(int*, unsigned int):                           # @square(int*, unsigned int)
        addi    sp, sp, -48
        sd      ra, 40(sp)                      # 8-byte Folded Spill
        sd      s0, 32(sp)                      # 8-byte Folded Spill
        addi    s0, sp, 48
        sd      a0, -24(s0)
        sw      a1, -28(s0)
        li      a0, 0
        sw      a0, -32(s0)
        sw      a0, -36(s0)
        j       .LBB0_1
.LBB0_1:                                # =>This Inner Loop Header: Depth=1
        lw      a0, -36(s0)
        lw      a1, -28(s0)
        bgeu    a0, a1, .LBB0_4
        j       .LBB0_2
.LBB0_2:                                #   in Loop: Header=BB0_1 Depth=1
        ld      a1, -24(s0)
        lw      a0, -36(s0)
        sh2add  a0, a0, a1
        lw      a1, 0(a0)
        lw      a0, -32(s0)
        addw    a0, a0, a1
        sw      a0, -32(s0)
        j       .LBB0_3
.LBB0_3:                                #   in Loop: Header=BB0_1 Depth=1
        lw      a0, -36(s0)
        addiw   a0, a0, 1
        sw      a0, -36(s0)
        j       .LBB0_1
.LBB0_4:
        lw      a0, -32(s0)
        ld      ra, 40(sp)                      # 8-byte Folded Reload
        ld      s0, 32(sp)                      # 8-byte Folded Reload
        addi    sp, sp, 48
        ret
main:                                   # @main
        addi    sp, sp, -48 # Allocate stack for main stack frame
        sd      ra, 40(sp)                      # 8-byte Folded Spill, store return address to sp+40 (stack, caller)
        sd      s0, 32(sp)                      # 8-byte Folded Spill, store s0 to sp+32 (stack, caller)
        addi    s0, sp, 48
        li      a0, 0
        sd      a0, -48(s0)                     # 8-byte Folded Spill
        sw      a0, -20(s0)
        li      a0, 4
        sw      a0, -24(s0)
        bseti   a0, zero, 32
        sd      a0, -40(s0)
        li      a0, 3
        slli    a0, a0, 32
        addi    a0, a0, 2
        sd      a0, -32(s0)
        addi    a0, s0, -40
        li      a1, 5
        call    square(int*, unsigned int)
        mv      a1, a0
.LBB1_1:                                # Label of block must be emitted
        auipc   a0, %pcrel_hi(.L.str)
        addi    a0, a0, %pcrel_lo(.LBB1_1)
        call    printf@plt
        ld      a0, -48(s0)                     # 8-byte Folded Reload
        ld      ra, 40(sp)                      # 8-byte Folded Reload
        ld      s0, 32(sp)                      # 8-byte Folded Reload
        addi    sp, sp, 48
        ret

.L.str:
        .asciz  "%d\n"

# 1 "start.S"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "start.S"
# 1 "include/asm.h" 1



# 1 "include/regdef.h" 1
# 5 "include/asm.h" 2
# 1 "include/sysdep.h" 1
# 6 "include/asm.h" 2
# 2 "start.S" 2
# 1 "include/regdef.h" 1
# 3 "start.S" 2
# 1 "include/cpu_cde.h" 1
# 1 "include/test_config.h" 1
# 2 "include/cpu_cde.h" 2
# 4 "start.S" 2
# 1 "include/test_config.h" 1
# 5 "start.S" 2
# 13 "start.S"
##$r23, number
##$r24, number adress
##$r25, exception use
##$r26, score
##$r27, exception pc
 .globl _start
 .globl start
 .globl __main
_start:
start:
    li.w $r12, 0xffffffff
    addi.w $r12, $r0, -1




 b locate

##avoid "j locate" not taken
    lu12i.w $r12, -0x80000
    addi.w $r13, $r13, 1
    or $r14, $r12, $r0
    add.w $r15, $r17, $r18
    ld.w $r16, $r12, 0

##avoid cpu run error
.org 0x0ec
    lu12i.w $r12, -0x80000
    addi.w $r13, $r13, 1
    or $r14, $r12, $r0
    add.w $r15, $r17, $r18
    ld.w $r16, $r12, 0
.org 0x100
test_finish:
    addi.w $r12, $r12, 1
    lu12i.w $r14 , (((0xbfafff10>>12)+((0xbfafff10&0x00000800)>>11))&0x000fffff)&0x80000?(((0xbfafff10>>12)+((0xbfafff10&0x00000800)>>11))&0x000fffff)-0x100000:(((0xbfafff10>>12)+((0xbfafff10&0x00000800)>>11))&0x000fffff); ;;;; addi.w $r14, $r14, (0xbfafff10 & 0x00000fff)&0x800?(0xbfafff10 & 0x00000fff)-0x1000:(0xbfafff10 & 0x00000fff)
    st.w $r0, $r14, 0
1:
    b 1b

   
    b 1f
.org 0x130
1:
    syscall 0x11

##avoid cpu run error
    lu12i.w $r12, -0x80000
    addi.w $r13, $r13, 1
    or $r14, $r12, $r0
    add.w $r15, $r17, $r18
    ld.w $r16, $r12, 0





.org 0x8000
1:
    li.w $r13, (0x100000 +0xd0000); ld.w $r13, $r13, 0
    li.w $r12, 0x1
    beq $r13, $r12, syscall_ex #syscall
    li.w $r12, 0x2
    beq $r13, $r12, brk_ex #break
    li.w $r12, 0x3
    beq $r13, $r12, ine_ex #reserved inst
    li.w $r12, 0x4
    beq $r13, $r12, int_ex #interrupt
    li.w $r12, 0x5
    beq $r13, $r12, adef_ex #adef
    li.w $r12, 0x6
    beq $r13, $r12, ale_ex #ale
    li.w $r12, 0x7
    beq $r13, $r12, pme_ex #pme
    li.w $r12, 0x8
    beq $r13, $r12, ld_page_invalid
    li.w $r12, 0x9
    beq $r13, $r12, st_page_invalid
    li.w $r12, 0xa
    beq $r13, $r12, tlb_prl_error
    li.w $r12, 0xb
    beq $r13, $r12, tlb_page_modified_error
    li.w $r12, 0xc
    beq $r13, $r12, fetch_page_invalid
    li.w $r12, 0xd
    beq $r13, $r12, tlb_adem_error
    li.w $r12, 0xe
    beq $r13, $r12, tlb_adef_error
    li.w $r12, 0xf
    beq $r13, $r12, syscall_bak_kernel_mode
 b test_end

syscall_ex:
    add.w $r25, $r0, $r0
    csrrd $r12, 0x6
    bne $r27, $r12, ex_finish
    csrrd $r12, 0x5
    li.w $r13, 0x7fff0000
    and $r12, $r12, $r13
    li.w $r13, 0x000b0000
    bne $r13, $r12, ex_finish
    csrrd $r12, 0x0
    li.w $r13, 0x7
    and $r12, $r12, $r13
    li.w $r13, 0x0
    bne $r13, $r12, ex_finish
    csrrd $r12, 0x1
    li.w $r13, 0x7
    and $r12, $r12, $r13
    bne $r12, $r17, ex_finish
    lu12i.w $r25, 0x10
    b ex_finish

brk_ex:
    add.w $r25, $r0, $r0
    csrrd $r12, 0x6
    bne $r27, $r12, ex_finish
    csrrd $r12, 0x5
    li.w $r13, 0x7fff0000
    and $r12, $r12, $r13
    li.w $r13, 0x000c0000
    bne $r13, $r12, ex_finish
    csrrd $r12, 0x0
    li.w $r13, 0x7
    and $r12, $r12, $r13
    li.w $r13, 0x0
    bne $r13, $r12, ex_finish
    csrrd $r12, 0x1
    li.w $r13, 0x7
    and $r12, $r12, $r13
    bne $r12, $r17, ex_finish
    lu12i.w $r25, 0x20
    b ex_finish

ine_ex:
    add.w $r25, $r0, $r0
    csrrd $r12, 0x6
    bne $r27, $r12, ex_finish
    csrrd $r12, 0x5
    li.w $r13, 0x7fff0000
    and $r12, $r12, $r13
    li.w $r13, 0xd0000
    bne $r13, $r12, ex_finish
    csrrd $r12, 0x0
    li.w $r13, 0x7
    and $r12, $r12, $r13
    li.w $r13, 0x0
    bne $r13, $r12, ex_finish
    csrrd $r12, 0x1
    li.w $r13, 0x7
    and $r12, $r12, $r13
    bne $r12, $r17, ex_finish
    lu12i.w $r25, 0x30
    b ex_finish

int_ex:
    add.w $r25, $r0, $r0
    csrrd $r12, 0x6
    bne $r27, $r12, ex_finish
    csrrd $r12, 0x5
    li.w $r13, 0x7fff0000
    and $r12, $r12, $r13
    li.w $r13, 0x00000000
    bne $r13, $r12, ex_finish
    csrrd $r12, 0x0
    li.w $r13, 0x7
    and $r12, $r12, $r13
    li.w $r13, 0x0
    bne $r13, $r12, ex_finish
    csrrd $r12, 0x1
    li.w $r13, 0x7
    and $r12, $r12, $r13
    bne $r12, $r17, ex_finish
    li.w $r13, 0x1
    csrwr $r13, 0x44
    bne $r13, $r0, ex_finish
    li.w $r13, 0x0
    li.w $r12, 0x3
    csrxchg $r13, $r12, 0x5
    csrrd $r13, 0x5
    li.w $r12, 0x1fff
    and $r12, $r12, $r13
    bne $r12, $r0, ex_finish
    lu12i.w $r25, 0x40
    b ex_finish

adef_ex:
    add.w $r25, $r0, $r0
    csrwr $r28, 0x6
    bne $r27, $r28, ex_finish
    csrrd $r12, 0x5
    li.w $r13, 0x7fff0000
    and $r12, $r12, $r13
    li.w $r13, 0x00080000
    bne $r13, $r12, ex_finish
    csrrd $r12, 0x0
    li.w $r13, 0x7
    and $r12, $r12, $r13
    li.w $r13, 0x0
    bne $r13, $r12, ex_finish
    csrrd $r12, 0x1
    li.w $r13, 0x7
    and $r12, $r12, $r13
    bne $r12, $r17, ex_finish
    lu12i.w $r25, 0x50
    b ex_finish

ale_ex:
    add.w $r25, $r0, $r0
    csrrd $r12, 0x6
    bne $r27, $r12, ex_finish
    csrrd $r12, 0x5
    li.w $r13, 0x7fff0000
    and $r12, $r12, $r13
    li.w $r13, 0x00090000
    bne $r13, $r12, ex_finish
    csrrd $r12, 0x0
    li.w $r13, 0x7
    and $r12, $r12, $r13
    li.w $r13, 0x0
    bne $r13, $r12, ex_finish
    csrrd $r12, 0x1
    li.w $r13, 0x7
    and $r12, $r12, $r13
    bne $r12, $r17, ex_finish
    lu12i.w $r25, 0x60
    b ex_finish

pme_ex:
    add.w $r25, $r0, $r0
    csrrd $r12, 0x6
    bne $r27, $r12, ex_finish
    csrrd $r12, 0x5
    li.w $r13, 0x7fff0000
    and $r12, $r12, $r13
    li.w $r13, 0x00040000
    csrrd $r12, 0x0
    li.w $r13, 0x7
    and $r12, $r12, $r13
    li.w $r13, 0x0
    bne $r13, $r12, ex_finish
    csrrd $r12, 0x1
    li.w $r13, 0x7
    and $r12, $r12, $r13
    bne $r12, $r17, ex_finish
    csrrd $r12, 0x7
    bne $r12, $r31, ex_finish
    srli.w $r31, $r31, 13
    slli.w $r31, $r31, 13
    csrrd $r12, 0x11
    bne $r12, $r31, ex_finish
    lu12i.w $r25, 0x70
    b ex_finish

ld_page_invalid:
    add.w $r25, $r0, $r0
    csrrd $r12, 0x6
    bne $r27, $r12, ex_finish
    csrrd $r12, 0x5
    li.w $r13, 0x7fff0000
    and $r12, $r12, $r13
    li.w $r13, 0x00010000
    bne $r13, $r12, ex_finish
    csrrd $r12, 0x0
    li.w $r13, 0x7
    and $r12, $r12, $r13
    li.w $r13, 0x0
    bne $r13, $r12, ex_finish
    csrrd $r12, 0x1
    li.w $r13, 0x7
    and $r12, $r12, $r13
    bne $r12, $r17, ex_finish
    csrrd $r12, 0x7
    bne $r12, $r31, ex_finish
    csrrd $r12, 0x11
    bne $r12, $r31, ex_finish
    lu12i.w $r25, 0x1
    b ex_finish

st_page_invalid:
    add.w $r25, $r0, $r0
    csrrd $r12, 0x6
    bne $r27, $r12, ex_finish
    csrrd $r12, 0x5
    li.w $r13, 0x7fff0000
    and $r12, $r12, $r13
    li.w $r13, 0x00020000
    bne $r13, $r12, ex_finish
    csrrd $r12, 0x0
    li.w $r13, 0x7
    and $r12, $r12, $r13
    li.w $r13, 0x0
    bne $r13, $r12, ex_finish
    csrrd $r12, 0x1
    li.w $r13, 0x7
    and $r12, $r12, $r13
    bne $r12, $r17, ex_finish
    csrrd $r12, 0x7
    bne $r12, $r31, ex_finish
    csrrd $r12, 0x11
    bne $r12, $r31, ex_finish
    lu12i.w $r25, 0x2
    b ex_finish

tlb_prl_error:
    add.w $r25, $r0, $r0
    csrrd $r12, 0x6
    bne $r27, $r12, ex_finish
    csrrd $r12, 0x5
    li.w $r13, 0x7fff0000
    and $r12, $r12, $r13
    li.w $r13, 0x00070000
    bne $r13, $r12, ex_finish
    csrrd $r12, 0x0
    li.w $r13, 0x7
    and $r12, $r12, $r13
    li.w $r13, 0x0
    bne $r13, $r12, ex_finish
    csrrd $r12, 0x1
    li.w $r13, 0x7
    and $r12, $r12, $r13
    bne $r12, $r17, ex_finish
    csrrd $r12, 0x7
    bne $r12, $r31, ex_finish
    csrrd $r12, 0x11
    bne $r12, $r31, ex_finish
    lu12i.w $r25, 0x7
    b ex_finish

tlb_page_modified_error:
    add.w $r25, $r0, $r0
    csrrd $r12, 0x6
    bne $r27, $r12, ex_finish
    csrrd $r12, 0x5
    li.w $r13, 0x7fff0000
    and $r12, $r12, $r13
    li.w $r13, 0x00040000
    bne $r13, $r12, ex_finish
    csrrd $r12, 0x0
    li.w $r13, 0x7
    and $r12, $r12, $r13
    li.w $r13, 0x0
    bne $r13, $r12, ex_finish
    csrrd $r12, 0x1
    li.w $r13, 0x7
    and $r12, $r12, $r13
    bne $r17, $r12, ex_finish
    csrrd $r12, 0x7
    bne $r12, $r31, ex_finish
    csrrd $r12, 0x11
    bne $r12, $r31, ex_finish
    lu12i.w $r25, 0x4
    b ex_finish

fetch_page_invalid:
    add.w $r25, $r0, $r0
    li.w $r12, 0xffffffff
    csrrd $r12, 0x6
    bne $r31, $r12, ex_finish
    addi.w $r12, $r27, 0x0
    csrwr $r12, 0x6
    csrrd $r12, 0x5
    li.w $r13, 0x7fff0000
    and $r12, $r12, $r13
    li.w $r13, 0x00030000
    bne $r13, $r12, ex_finish
    csrrd $r12, 0x0
    li.w $r13, 0x7
    and $r12, $r12, $r13
    li.w $r13, 0x0
    bne $r13, $r12, ex_finish
    csrrd $r12, 0x1
    li.w $r13, 0x7
    and $r12, $r12, $r13
    bne $r17, $r12, ex_finish
    csrrd $r12, 0x7
    bne $r12, $r31, ex_finish
    csrrd $r12, 0x11
    bne $r12, $r31, ex_finish
    lu12i.w $r25, 0x3
    b ex_finish

tlb_adem_error:
    add.w $r25, $r0, $r0
    csrrd $r12, 0x6
    bne $r27, $r12, ex_finish
    csrrd $r12, 0x5
    li.w $r13, 0x7fff0000
    and $r12, $r12, $r13
    li.w $r13, 0x00480000
    bne $r13, $r12, ex_finish
    csrrd $r12, 0x0
    li.w $r13, 0x7
    and $r12, $r12, $r13
    li.w $r13, 0x0
    bne $r13, $r12, ex_finish
    csrrd $r12, 0x1
    li.w $r13, 0x7
    and $r12, $r12, $r13
    bne $r12, $r17, ex_finish
    csrrd $r12, 0x7
    bne $r12, $r31, ex_finish
    csrrd $r12, 0x11
    bne $r12, $r0, ex_finish
    lu12i.w $r25, 0x81
    b ex_finish

tlb_adef_error:
    add.w $r25, $r0, $r0
    csrrd $r12, 0x6
    bne $r31, $r12, ex_finish
    addi.w $r12, $r27, 0x0
    csrwr $r12, 0x6
    csrrd $r12, 0x5
    li.w $r13, 0x7fff0000
    and $r12, $r12, $r13
    li.w $r13, 0x00080000
    bne $r13, $r12, ex_finish
    csrrd $r12, 0x0
    li.w $r13, 0x7
    and $r12, $r12, $r13
    li.w $r13, 0x0
    bne $r13, $r12, ex_finish
    csrrd $r12, 0x1
    li.w $r13, 0x7
    and $r12, $r12, $r13
    bne $r17, $r12, ex_finish
    csrrd $r12, 0x7
    bne $r12, $r31, ex_finish
    csrrd $r12, 0x11
    bne $r12, $r0, ex_finish
    lu12i.w $r25, 0x80
    b ex_finish

syscall_bak_kernel_mode:
    li.w $r12, 0x3
    csrxchg $r0, $r12, 0x1
    csrrd $r13, 0x6
    addi.w $r13, $r13, 0x4
    csrwr $r13, 0x6
    ertn

.org 0xf000
    add.w $r25, $r0, $r0
    csrrd $r12, 0x6
    bne $r27, $r12, ex_finish
    csrrd $r12, 0x5
    li.w $r13, 0x7fff0000
    and $r12, $r12, $r13
    li.w $r13, 0x003f0000
    bne $r13, $r12, ex_finish
    csrrd $r12, 0x0
    li.w $r13, 0x7
    and $r12, $r12, $r13
    li.w $r13, 0x0
    bne $r13, $r12, ex_finish
    csrrd $r12, 0x1
    li.w $r13, 0x7
    and $r12, $r12, $r13
    bne $r12, $r17, ex_finish
    csrrd $r12, 0x7
    bne $r12, $r31, ex_finish
    csrrd $r12, 0x11
    bne $r12, $r31, ex_finish
    lu12i.w $r25, 0xe
    b ex_finish

ex_finish:
    add.w $r0, $r0, $r0
    csrrd $r13, 0x6
    addi.w $r13, $r13, 0x4
    csrwr $r13, 0x6
    addi.w $r13, $r25, 0x0
    bne $r25, $r0, ex_ret
    lu12i.w $r25, 0xffff
ex_ret:
    ertn



locate:

    lu12i.w $r4 , (((0xbfaff040>>12)+((0xbfaff040&0x00000800)>>11))&0x000fffff)&0x80000?(((0xbfaff040>>12)+((0xbfaff040&0x00000800)>>11))&0x000fffff)-0x100000:(((0xbfaff040>>12)+((0xbfaff040&0x00000800)>>11))&0x000fffff); ;;;; addi.w $r4, $r4, (0xbfaff040 & 0x00000fff)&0x800?(0xbfaff040 & 0x00000fff)-0x1000:(0xbfaff040 & 0x00000fff)
    lu12i.w $r5 , (((0xbfaff030>>12)+((0xbfaff030&0x00000800)>>11))&0x000fffff)&0x80000?(((0xbfaff030>>12)+((0xbfaff030&0x00000800)>>11))&0x000fffff)-0x100000:(((0xbfaff030>>12)+((0xbfaff030&0x00000800)>>11))&0x000fffff); ;;;; addi.w $r5, $r5, (0xbfaff030 & 0x00000fff)&0x800?(0xbfaff030 & 0x00000fff)-0x1000:(0xbfaff030 & 0x00000fff)
    lu12i.w $r6 , (((0xbfaff020>>12)+((0xbfaff020&0x00000800)>>11))&0x000fffff)&0x80000?(((0xbfaff020>>12)+((0xbfaff020&0x00000800)>>11))&0x000fffff)-0x100000:(((0xbfaff020>>12)+((0xbfaff020&0x00000800)>>11))&0x000fffff); ;;;; addi.w $r6, $r6, (0xbfaff020 & 0x00000fff)&0x800?(0xbfaff020 & 0x00000fff)-0x1000:(0xbfaff020 & 0x00000fff)
    lu12i.w $r24 , (((0xbfaff050>>12)+((0xbfaff050&0x00000800)>>11))&0x000fffff)&0x80000?(((0xbfaff050>>12)+((0xbfaff050&0x00000800)>>11))&0x000fffff)-0x100000:(((0xbfaff050>>12)+((0xbfaff050&0x00000800)>>11))&0x000fffff); ;;;; addi.w $r24, $r24, (0xbfaff050 & 0x00000fff)&0x800?(0xbfaff050 & 0x00000fff)-0x1000:(0xbfaff050 & 0x00000fff)

    lu12i.w $r13 , (((0x0002>>12)+((0x0002&0x00000800)>>11))&0x000fffff)&0x80000?(((0x0002>>12)+((0x0002&0x00000800)>>11))&0x000fffff)-0x100000:(((0x0002>>12)+((0x0002&0x00000800)>>11))&0x000fffff); ;;;; addi.w $r13, $r13, (0x0002 & 0x00000fff)&0x800?(0x0002 & 0x00000fff)-0x1000:(0x0002 & 0x00000fff)
    lu12i.w $r14 , (((0x0001>>12)+((0x0001&0x00000800)>>11))&0x000fffff)&0x80000?(((0x0001>>12)+((0x0001&0x00000800)>>11))&0x000fffff)-0x100000:(((0x0001>>12)+((0x0001&0x00000800)>>11))&0x000fffff); ;;;; addi.w $r14, $r14, (0x0001 & 0x00000fff)&0x800?(0x0001 & 0x00000fff)-0x1000:(0x0001 & 0x00000fff)
    lu12i.w $r15 , (((0x0000ffff>>12)+((0x0000ffff&0x00000800)>>11))&0x000fffff)&0x80000?(((0x0000ffff>>12)+((0x0000ffff&0x00000800)>>11))&0x000fffff)-0x100000:(((0x0000ffff>>12)+((0x0000ffff&0x00000800)>>11))&0x000fffff); ;;;; addi.w $r15, $r15, (0x0000ffff & 0x00000fff)&0x800?(0x0000ffff & 0x00000fff)-0x1000:(0x0000ffff & 0x00000fff)
    lu12i.w $r26, 0
    ;;;

    st.w $r13, $r4, 0
    st.w $r14, $r5, 0
    st.w $r15, $r6, 0
    st.w $r26, $r24, 0
    lu12i.w $r23, 0
    ;;;
inst_test:
############################
###1 test

    bl n1_lu12i_w_test #lu12i.w
    bl idle_1s

    bl n2_add_w_test #add.w
    bl idle_1s

    bl n3_addi_w_test #add.w
    bl idle_1s

    bl n4_sub_w_test #sub.w
    bl idle_1s

    bl n5_slt_test #slt
    bl idle_1s

    bl n6_sltu_test #sltu
    bl idle_1s

    bl n7_and_test #and
    bl idle_1s

    bl n8_or_test #or
    bl idle_1s

    bl n9_xor_test #xor
    bl idle_1s

    bl n10_nor_test #nor
    bl idle_1s

    bl n11_slli_w_test #slli.w
    bl idle_1s

    bl n12_srli_w_test #srli.w
    bl idle_1s

    bl n13_srai_w_test #srai.w
    bl idle_1s

    bl n14_ld_w_test #ld.w
    bl idle_1s

    bl n15_st_w_test #st.w
    bl idle_1s

    bl n16_beq_test #beq
    bl idle_1s

    bl n17_bne_test #bne
    bl idle_1s

    bl n18_bl_test #bl
    bl idle_1s

    bl n19_jirl_test #jirl
    bl idle_1s

    bl n20_b_test #b
    bl idle_1s


############################
############################
###0 test
# 630 "start.S"
############################
############################
###0 test
# 665 "start.S"
############################
############################
###0 test
# 680 "start.S"
############################
############################
###0 test
# 867 "start.S"
test_end:
    lu12i.w $r23 , ((((1*20 + 0*16 + 0*10 + 0*1 + 0*11 + 0*12 + 0*2 + 0*7 + 0*2)>>12)+(((1*20 + 0*16 + 0*10 + 0*1 + 0*11 + 0*12 + 0*2 + 0*7 + 0*2)&0x00000800)>>11))&0x000fffff)&0x80000?((((1*20 + 0*16 + 0*10 + 0*1 + 0*11 + 0*12 + 0*2 + 0*7 + 0*2)>>12)+(((1*20 + 0*16 + 0*10 + 0*1 + 0*11 + 0*12 + 0*2 + 0*7 + 0*2)&0x00000800)>>11))&0x000fffff)-0x100000:((((1*20 + 0*16 + 0*10 + 0*1 + 0*11 + 0*12 + 0*2 + 0*7 + 0*2)>>12)+(((1*20 + 0*16 + 0*10 + 0*1 + 0*11 + 0*12 + 0*2 + 0*7 + 0*2)&0x00000800)>>11))&0x000fffff); ;;;; addi.w $r23, $r23, ((1*20 + 0*16 + 0*10 + 0*1 + 0*11 + 0*12 + 0*2 + 0*7 + 0*2) & 0x00000fff)&0x800?((1*20 + 0*16 + 0*10 + 0*1 + 0*11 + 0*12 + 0*2 + 0*7 + 0*2) & 0x00000fff)-0x1000:((1*20 + 0*16 + 0*10 + 0*1 + 0*11 + 0*12 + 0*2 + 0*7 + 0*2) & 0x00000fff)
    ;;;
    beq $r23, $r26, 1f
   

    lu12i.w $r4 , (((0xbfaff020>>12)+((0xbfaff020&0x00000800)>>11))&0x000fffff)&0x80000?(((0xbfaff020>>12)+((0xbfaff020&0x00000800)>>11))&0x000fffff)-0x100000:(((0xbfaff020>>12)+((0xbfaff020&0x00000800)>>11))&0x000fffff); ;;;; addi.w $r4, $r4, (0xbfaff020 & 0x00000fff)&0x800?(0xbfaff020 & 0x00000fff)-0x1000:(0xbfaff020 & 0x00000fff)
   lu12i.w $r5 , (((0xbfaff040>>12)+((0xbfaff040&0x00000800)>>11))&0x000fffff)&0x80000?(((0xbfaff040>>12)+((0xbfaff040&0x00000800)>>11))&0x000fffff)-0x100000:(((0xbfaff040>>12)+((0xbfaff040&0x00000800)>>11))&0x000fffff); ;;;; addi.w $r5, $r5, (0xbfaff040 & 0x00000fff)&0x800?(0xbfaff040 & 0x00000fff)-0x1000:(0xbfaff040 & 0x00000fff)
    lu12i.w $r6 , (((0xbfaff030>>12)+((0xbfaff030&0x00000800)>>11))&0x000fffff)&0x80000?(((0xbfaff030>>12)+((0xbfaff030&0x00000800)>>11))&0x000fffff)-0x100000:(((0xbfaff030>>12)+((0xbfaff030&0x00000800)>>11))&0x000fffff); ;;;; addi.w $r6, $r6, (0xbfaff030 & 0x00000fff)&0x800?(0xbfaff030 & 0x00000fff)-0x1000:(0xbfaff030 & 0x00000fff)

    lu12i.w $r13 , (((0x0002>>12)+((0x0002&0x00000800)>>11))&0x000fffff)&0x80000?(((0x0002>>12)+((0x0002&0x00000800)>>11))&0x000fffff)-0x100000:(((0x0002>>12)+((0x0002&0x00000800)>>11))&0x000fffff); ;;;; addi.w $r13, $r13, (0x0002 & 0x00000fff)&0x800?(0x0002 & 0x00000fff)-0x1000:(0x0002 & 0x00000fff)
    ;;;

   st.w $r0, $r4, 0
    st.w $r13, $r5, 0
    st.w $r13, $r6, 0
    li.w $r4, 0x1
    b 2f
   
1:
    lu12i.w $r13 , (((0x0001>>12)+((0x0001&0x00000800)>>11))&0x000fffff)&0x80000?(((0x0001>>12)+((0x0001&0x00000800)>>11))&0x000fffff)-0x100000:(((0x0001>>12)+((0x0001&0x00000800)>>11))&0x000fffff); ;;;; addi.w $r13, $r13, (0x0001 & 0x00000fff)&0x800?(0x0001 & 0x00000fff)-0x1000:(0x0001 & 0x00000fff)
    lu12i.w $r4 , (((0xbfaff040>>12)+((0xbfaff040&0x00000800)>>11))&0x000fffff)&0x80000?(((0xbfaff040>>12)+((0xbfaff040&0x00000800)>>11))&0x000fffff)-0x100000:(((0xbfaff040>>12)+((0xbfaff040&0x00000800)>>11))&0x000fffff); ;;;; addi.w $r4, $r4, (0xbfaff040 & 0x00000fff)&0x800?(0xbfaff040 & 0x00000fff)-0x1000:(0xbfaff040 & 0x00000fff)
   lu12i.w $r5 , (((0xbfaff030>>12)+((0xbfaff030&0x00000800)>>11))&0x000fffff)&0x80000?(((0xbfaff030>>12)+((0xbfaff030&0x00000800)>>11))&0x000fffff)-0x100000:(((0xbfaff030>>12)+((0xbfaff030&0x00000800)>>11))&0x000fffff); ;;;; addi.w $r5, $r5, (0xbfaff030 & 0x00000fff)&0x800?(0xbfaff030 & 0x00000fff)-0x1000:(0xbfaff030 & 0x00000fff)
    ;;;
    st.w $r13, $r4, 0
    st.w $r13, $r5, 0
    li.w $r4, 0

2:




 bl test_finish

idle_1s:



    lu12i.w $r12 , (((0xbfaff090>>12)+((0xbfaff090&0x00000800)>>11))&0x000fffff)&0x80000?(((0xbfaff090>>12)+((0xbfaff090&0x00000800)>>11))&0x000fffff)-0x100000:(((0xbfaff090>>12)+((0xbfaff090&0x00000800)>>11))&0x000fffff); ;;;; addi.w $r12, $r12, (0xbfaff090 & 0x00000fff)&0x800?(0xbfaff090 & 0x00000fff)-0x1000:(0xbfaff090 & 0x00000fff)
    lu12i.w $r13 , (((0xaaaa>>12)+((0xaaaa&0x00000800)>>11))&0x000fffff)&0x80000?(((0xaaaa>>12)+((0xaaaa&0x00000800)>>11))&0x000fffff)-0x100000:(((0xaaaa>>12)+((0xaaaa&0x00000800)>>11))&0x000fffff); ;;;; addi.w $r13, $r13, (0xaaaa & 0x00000fff)&0x800?(0xaaaa & 0x00000fff)-0x1000:(0xaaaa & 0x00000fff)

    #initial $r15
    ld.w $r14, $r12, 0 #switch_interleave: {switch[7],1'b0, switch[6],1'b0...switch[0],1'b0}
    ;;;
    xor $r14, $r14, $r13
    ;;;
    slli.w $r15, $r14, 9 #$r15 = switch interleave << 9
    ;;;
    addi.w $r15, $r15, 1
    ;;;

sub1:
    addi.w $r15, $r15, -1

    #select min{$r15, switch_interleave}
    ld.w $r14, $r12, 0 #switch_interleave: {switch[7],1'b0, switch[6],1'b0...switch[0],1'b0}
    ;;;
    xor $r14, $r14, $r13
    ;;;
    slli.w $r14, $r14, 9 #switch interleave << 9
    ;;;
    sltu $r16, $r15, $r14
    ;;;
    bne $r16, $r0, 1f
    addi.w $r15, $r14, 0
    ;;;
1:
    bne $r15, $r0, sub1
    jirl $r0, $r1, 0

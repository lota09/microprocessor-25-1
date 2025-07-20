;**********************************************************************
;  - Project          : Project - ARM Code for Image Converting
;  - File name        : sub2_relocation.s
;  - Description      : Image Negative (memory relocation)
;  - Owner            : Microprocessor Application team 4
;  - Revision history : 1) 2025.03.27 : Initial release
;**********************************************************************
        AREA    RESET, CODE, READONLY
        EXPORT  _main
        ENTRY

_main
        LDR     R0, =0x40000036   ; Load base address of RGBA pixel data
        MOV     R1, #0         ; Number of pixels


RelocateLoop
        ;pixel 1
        LDRH    r3, [r0], #2
        ROR     r3, r3, #16
        LDRH    r2, [r0], #2
        ORR     r3, r2, r3
        ROR     r3, r3, #16

        ;pixel 2
        LDRH    r4, [r0], #2
        ROR     r4, r4, #16
        LDRH    r2, [r0], #2
        ORR     r4, r2, r4
        ROR     r4, r4, #16

        ;pixel 3
        LDRH    r5, [r0], #2
        ROR     r5, r5, #16
        LDRH    r2, [r0], #2
        ORR     r5, r2, r5
        ROR     r5, r5, #16

        ;pixel 4
        LDRH    r6, [r0], #2
        ROR     r6, r6, #16
        LDRH    r2, [r0], #2
        ORR     r6, r2, r6
        ROR     r6, r6, #16

        ;pixel 5
        LDRH    r7, [r0], #2
        ROR     r7, r7, #16
        LDRH    r2, [r0], #2
        ORR     r7, r2, r7
        ROR     r7, r7, #16

        ;pixel 6
        LDRH    r8, [r0], #2
        ROR     r8, r8, #16
        LDRH    r2, [r0], #2
        ORR     r8, r2, r8
        ROR     r8, r8, #16

        ;pixel 7
        LDRH    r9, [r0], #2
        ROR     r9, r9, #16
        LDRH    r2, [r0], #2
        ORR     r9, r2, r9
        ROR     r9, r9, #16

        ;pixel 8
        LDRH    r10, [r0], #2
        ROR     r10, r10, #16
        LDRH    r2, [r0], #2
        ORR     r10, r2, r10
        ROR     r10, r10, #16

        ;pixel 9
        LDRH    r11, [r0], #2
        ROR     r11, r11, #16
        LDRH    r2, [r0], #2
        ORR     r11, r2, r11
        ROR     r11, r11, #16

        ;pixel 10
        LDRH    r12, [r0], #2
        ROR     r12, r12, #16
        LDRH    r2, [r0], #2
        ORR     r12, r2, r12
        ROR     r12, r12, #16
        
        ;Store RGBA sequence to word aligned location
        MOV     r2, r1, LSL #2           ; r2 = r1 << 2
        ADD     r2, r2, #0x10000         ; r2 += 0x10000
        ADD     r2, r2, #0x40000000      ; r2 += 0x40000000
        STMIA   r2, {r3-r12}

        ADD     r1, r1, #10              ; pixel count += 10
        CMP     r1, #9600
        BLT     RelocateLoop


        LDR     R0, =0x40010000   ; Load base address of RGBA pixel data
        MOV     R1, #9600         ; Number of pixels

InvertLoop
        ; Load 10 pixels from memory (RGBA format, 4 bytes each)
        LDMIA r0, {r3-r12}            

        ; pixel 1 (r3): invert RGB bits, keep A unchanged
        AND r2, r3, #0xFF000000        ; Save alpha value
        MVN r3, r3                     ; Invert all bits
        BIC r3, r3, #0xFF000000        ; Clear lower 8 bits (alpha)
        ORR r3, r3, r2                 ; Restore original alpha

        ; pixel 2 (r4)
        AND r2, r4, #0xFF000000
        MVN r4, r4
        BIC r4, r4, #0xFF000000
        ORR r4, r4, r2

        ; pixel 3 (r5)
        AND r2, r5, #0xFF000000
        MVN r5, r5
        BIC r5, r5, #0xFF000000
        ORR r5, r5, r2

        ; pixel 4 (r6)
        AND r2, r6, #0xFF000000
        MVN r6, r6
        BIC r6, r6, #0xFF000000
        ORR r6, r6, r2

        ; pixel 5 (r7)
        AND r2, r7, #0xFF000000
        MVN r7, r7
        BIC r7, r7, #0xFF000000
        ORR r7, r7, r2

        ; pixel 6 (r8)
        AND r2, r8, #0xFF000000
        MVN r8, r8
        BIC r8, r8, #0xFF000000
        ORR r8, r8, r2

        ; pixel 7 (r9)
        AND r2, r9, #0xFF000000
        MVN r9, r9
        BIC r9, r9, #0xFF000000
        ORR r9, r9, r2

        ; pixel 8 (r10)
        AND r2, r10, #0xFF000000
        MVN r10, r10
        BIC r10, r10, #0xFF000000
        ORR r10, r10, r2

        ; pixel 9 (r11)
        AND r2, r11, #0xFF000000
        MVN r11, r11
        BIC r11, r11, #0xFF000000
        ORR r11, r11, r2

        ; pixel 10 (r12)
        AND r2, r12, #0xFF000000
        MVN r12, r12
        BIC r12, r12, #0xFF000000
        ORR r12, r12, r2

        STMIA r0!, {r3-r12}

        SUBS R1, R1, #10     ; Decrease pixel count
        BNE InvertLoop

STOP
        B       STOP

        END

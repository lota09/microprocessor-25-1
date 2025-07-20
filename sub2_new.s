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
        LDR     R1, =0x40010000   ; Load word aligned location
        MOV     R4, #9600         ; Number of pixels


RelocateLoop
        ;In order to move to word aligned location
        LDRH    r5, [r0], #2
        STRH    r5, [r1], #2
        LDRH    r5, [r0], #2
        STRH    r5, [r1], #2
        SUBS    r4, r4, #1
        BNE     RelocateLoop


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

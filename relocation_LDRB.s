;**********************************************************************
;  - Project          : Project - ARM Code for Image Converting
;  - File name        : relocation_LDRB.s
;  - Description      : optimized relocation using LDRB (2.56 ms)
;  - Owner            : Microprocessor Application team 4
;  - Revision history : 1) 2025.07.19 : Initial release
;**********************************************************************
        
        AREA RESET, CODE, READONLY
        ENTRY
        EXPORT _main

_main
        LDR     r0, =0x40000036     ; RGBA base address (unaligned)
        MOV     r2, #0              ; Pixel counter (r2 = 0)

RelocateLoop
        ; === First group of 4 pixels ===
        ; Pixel 1 - R
        LDRB    r4, [r0], #1
        ROR     r4, r4, #8
        ; Pixel 1 - G
        LDRB    r5, [r0], #1
        ROR     r5, r5, #8
        ; Pixel 1 - B
        LDRB    r6, [r0], #2
        ROR     r6, r6, #8

        ; Pixel 2
        LDRB    r3, [r0], #1
        ORR     r4, r4, r3
        ROR     r4, r4, #8
        LDRB    r3, [r0], #1
        ORR     r5, r5, r3
        ROR     r5, r5, #8
        LDRB    r3, [r0], #2
        ORR     r6, r6, r3
        ROR     r6, r6, #8

        ; Pixel 3
        LDRB    r3, [r0], #1
        ORR     r4, r4, r3
        ROR     r4, r4, #8
        LDRB    r3, [r0], #1
        ORR     r5, r5, r3
        ROR     r5, r5, #8
        LDRB    r3, [r0], #2
        ORR     r6, r6, r3
        ROR     r6, r6, #8

        ; Pixel 4
        LDRB    r3, [r0], #1
        ORR     r4, r4, r3
        ROR     r4, r4, #8
        LDRB    r3, [r0], #1
        ORR     r5, r5, r3
        ROR     r5, r5, #8
        LDRB    r3, [r0], #2
        ORR     r6, r6, r3
        ROR     r6, r6, #8
        
        ; === Second group (r7,r8,r9) ===
        ; Pixel 1 - R
        LDRB    r7, [r0], #1
        ROR     r7, r7, #8
        ; Pixel 1 - G
        LDRB    r8, [r0], #1
        ROR     r8, r8, #8
        ; Pixel 1 - B
        LDRB    r9, [r0], #2
        ROR     r9, r9, #8

        ; Pixel 2
        LDRB    r3, [r0], #1
        ORR     r7, r7, r3
        ROR     r7, r7, #8
        LDRB    r3, [r0], #1
        ORR     r8, r8, r3
        ROR     r8, r8, #8
        LDRB    r3, [r0], #2
        ORR     r9, r9, r3
        ROR     r9, r9, #8

        ; Pixel 3
        LDRB    r3, [r0], #1
        ORR     r7, r7, r3
        ROR     r7, r7, #8
        LDRB    r3, [r0], #1
        ORR     r8, r8, r3
        ROR     r8, r8, #8
        LDRB    r3, [r0], #2
        ORR     r9, r9, r3
        ROR     r9, r9, #8

        ; Pixel 4
        LDRB    r3, [r0], #1
        ORR     r7, r7, r3
        ROR     r7, r7, #8
        LDRB    r3, [r0], #1
        ORR     r8, r8, r3
        ROR     r8, r8, #8
        LDRB    r3, [r0], #2
        ORR     r9, r9, r3
        ROR     r9, r9, #8

        ; === Third group (r10,r11,r12) ===
        ; Pixel 1 - R
        LDRB    r10, [r0], #1
        ROR     r10, r10, #8
        ; Pixel 1 - G
        LDRB    r11, [r0], #1
        ROR     r11, r11, #8
        ; Pixel 1 - B
        LDRB    r12, [r0], #2
        ROR     r12, r12, #8

        ; Pixel 2
        LDRB    r3, [r0], #1
        ORR     r10, r10, r3
        ROR     r10, r10, #8
        LDRB    r3, [r0], #1
        ORR     r11, r11, r3
        ROR     r11, r11, #8
        LDRB    r3, [r0], #2
        ORR     r12, r12, r3
        ROR     r12, r12, #8

        ; Pixel 3
        LDRB    r3, [r0], #1
        ORR     r10, r10, r3
        ROR     r10, r10, #8
        LDRB    r3, [r0], #1
        ORR     r11, r11, r3
        ROR     r11, r11, #8
        LDRB    r3, [r0], #2
        ORR     r12, r12, r3
        ROR     r12, r12, #8

        ; Pixel 4
        LDRB    r3, [r0], #1
        ORR     r10, r10, r3
        ROR     r10, r10, #8
        LDRB    r3, [r0], #1
        ORR     r11, r11, r3
        ROR     r11, r11, #8
        LDRB    r3, [r0], #2
        ORR     r12, r12, r3
        ROR     r12, r12, #8

        ; === Store results ===
        
        ADD     r1, r2, #0x40000000     
        ADD     r1, r1, #0x10000        ; R base
        STMIA   r1, {r4, r7, r10}

        ADD     r1, r1, #0x10000        ; G base
        STMIA   r1, {r5, r8, r11}

        ADD     r1, r1, #0x10000        ; B base
        STMIA   r1, {r6, r9, r12}

        ADD     r2, r2, #12              ; pixel count += 12
        CMP     r2, #9600
        BNE     RelocateLoop

End
        B       End

        END

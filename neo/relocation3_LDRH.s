;**********************************************************************
;  - Project          : Project - ARM Code for Image Converting
;  - File name        : relocation_LDRB.s
;  - Description      : optimized relocation using LDRH (2.4 ms)
;  - Owner            : Microprocessor Application team 4
;  - Revision history : 1) 2025.07.19 : Initial release
;**********************************************************************
        
        AREA RESET, CODE, READONLY
        ENTRY
        EXPORT _main

_main
        LDR     r0, =0x40000036     ; RGBA base address (unaligned)
        MOV     r1, #0              ; Pixel counter (r1 = 0)

RelocateLoop
        ; === First group of 4 pixels ===
        ; Pixel 1 - R
        LDRH    r2, [r0], #2
        AND     r4, r2, #0xFF
        ROR     r4, r4, #8
        ; Pixel 1 - G
        LSR     r5, r2, #8
        ROR     r5, r5, #8
        ; Pixel 1 - B
        LDRB    r6, [r0], #2
        ROR     r6, r6, #8

        ; Pixel 2
        LDRH    r2, [r0], #2
        AND     r3, r2, #0xFF
        ORR     r4, r4, r3
        ROR     r4, r4, #8
        LSR     r3, r2, #8
        ORR     r5, r5, r3
        ROR     r5, r5, #8
        LDRB    r3, [r0], #2
        ORR     r6, r6, r3
        ROR     r6, r6, #8

        ; Pixel 3
        LDRH    r2, [r0], #2
        AND     r3, r2, #0xFF
        ORR     r4, r4, r3
        ROR     r4, r4, #8
        LSR     r3, r2, #8
        ORR     r5, r5, r3
        ROR     r5, r5, #8
        LDRB    r3, [r0], #2
        ORR     r6, r6, r3
        ROR     r6, r6, #8

        ; Pixel 4
        LDRH    r2, [r0], #2
        AND     r3, r2, #0xFF
        ORR     r4, r4, r3
        ROR     r4, r4, #8
        LSR     r3, r2, #8
        ORR     r5, r5, r3
        ROR     r5, r5, #8
        LDRB    r3, [r0], #2
        ORR     r6, r6, r3
        ROR     r6, r6, #8

        ; === Second group (r7,r8,r9) ===
        ; Pixel 1 - R
        LDRH    r2, [r0], #2
        AND     r7, r2, #0xFF
        ROR     r7, r7, #8
        ; Pixel 1 - G
        LSR     r8, r2, #8
        ROR     r8, r8, #8
        ; Pixel 1 - B
        LDRB    r9, [r0], #2
        ROR     r9, r9, #8

        ; Pixel 2
        LDRH    r2, [r0], #2
        AND     r3, r2, #0xFF
        ORR     r7, r7, r3
        ROR     r7, r7, #8
        LSR     r3, r2, #8
        ORR     r8, r8, r3
        ROR     r8, r8, #8
        LDRB    r3, [r0], #2
        ORR     r9, r9, r3
        ROR     r9, r9, #8

        ; Pixel 3
        LDRH    r2, [r0], #2
        AND     r3, r2, #0xFF
        ORR     r7, r7, r3
        ROR     r7, r7, #8
        LSR     r3, r2, #8
        ORR     r8, r8, r3
        ROR     r8, r8, #8
        LDRB    r3, [r0], #2
        ORR     r9, r9, r3
        ROR     r9, r9, #8

        ; Pixel 4
        LDRH    r2, [r0], #2
        AND     r3, r2, #0xFF
        ORR     r7, r7, r3
        ROR     r7, r7, #8
        LSR     r3, r2, #8
        ORR     r8, r8, r3
        ROR     r8, r8, #8
        LDRB    r3, [r0], #2
        ORR     r9, r9, r3
        ROR     r9, r9, #8

        ; === Third group (r10,r11,r12) ===
        ; Pixel 1 - R
        LDRH    r2, [r0], #2
        AND     r10, r2, #0xFF
        ROR     r10, r10, #8
        ; Pixel 1 - G
        LSR     r11, r2, #8
        ROR     r11, r11, #8
        ; Pixel 1 - B
        LDRB    r12, [r0], #2
        ROR     r12, r12, #8

        ; Pixel 2
        LDRH    r2, [r0], #2
        AND     r3, r2, #0xFF
        ORR     r10, r10, r3
        ROR     r10, r10, #8
        LSR     r3, r2, #8
        ORR     r11, r11, r3
        ROR     r11, r11, #8
        LDRB    r3, [r0], #2
        ORR     r12, r12, r3
        ROR     r12, r12, #8

        ; Pixel 3
        LDRH    r2, [r0], #2
        AND     r3, r2, #0xFF
        ORR     r10, r10, r3
        ROR     r10, r10, #8
        LSR     r3, r2, #8
        ORR     r11, r11, r3
        ROR     r11, r11, #8
        LDRB    r3, [r0], #2
        ORR     r12, r12, r3
        ROR     r12, r12, #8

        ; Pixel 4
        LDRH    r2, [r0], #2
        AND     r3, r2, #0xFF
        ORR     r10, r10, r3
        ROR     r10, r10, #8
        LSR     r3, r2, #8
        ORR     r11, r11, r3
        ROR     r11, r11, #8
        LDRB    r3, [r0], #2
        ORR     r12, r12, r3
        ROR     r12, r12, #8

        ; === Store results ===
        
        ADD     r2, r1, #0x40000000     
        ADD     r2, r2, #0x10000        ; R base
        STMIA   r2, {r4, r7, r10}

        ADD     r2, r2, #0x10000        ; G base
        STMIA   r2, {r5, r8, r11}

        ADD     r2, r2, #0x10000        ; B base
        STMIA   r2, {r6, r9, r12}

        ADD     r1, r1, #12              ; pixel count += 12
        CMP     r1, #9600
        BLT     RelocateLoop

End
        B       End

        END
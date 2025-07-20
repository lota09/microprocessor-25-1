;**********************************************************************
;  - Project          : Project - ARM Code for Image Converting
;  - File name        : sub3_relocation.s
;  - Description      : Grayscale
;  - Owner            : Microprocessor Application team 4
;  - Revision history : 1) 2025.03.27 : Initial release
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

        ;===========================================
        ; Step 2. Grayscale  (Gray = 3R + 6G + B)
        ;===========================================

        LDR     r0, =0x40100000     ; Red values start address
        LDR     r1, =0x40102580     ; Green values start address
        LDR     r2, =0x40104B00     ; Blue values start address
        LDR     r3, =0x40110000     ; Address to store grayscale result
        MOV     r4, #9600

       

LoopPixel
        ;load 8 pixel of B
        LDMIA   R2!, {R10, R11}

        ;1 pixel init
        MOV     R9, R10
        AND     R9, R9, #0xFF
        MOV     R5, R9

        ;2 pixel init
        MOV     R9, R10, LSR #8
        AND     R9, R9, #0xFF
        ORR     R5, R5, R9, LSL #16

        ;3 pixel init
        MOV     R9, R10, LSR #16
        AND     R9, R9, #0xFF
        MOV     R6, R9

        ;4 pixel init
        MOV     R9, R10, LSR #24
        AND     R9, R9, #0xFF
        ORR     R6, R6, R9, LSL #16

        ;5 pixel init
        MOV     R9, R11
        AND     R9, R9, #0xFF
        MOV     R7, R9

        ;6 pixel init
        MOV     R9, R11, LSR #8
        AND     R9, R9, #0xFF
        ORR     R7, R7, R9, LSL #16

        ;7 pixel init
        MOV     R9, R11, LSR #16
        AND     R9, R9, #0xFF
        MOV     R8, R9

        ;8 pixel init
        MOV     R9, R11, LSR #24
        AND     R9, R9, #0xFF
        ORR     R8, R8, R9, LSL #16


        ;load 8 pixel of G
        LDMIA   R1!, {R10, R11}           ; R10 = G3 G2 G1 G0, R11 = G7 G6 G5 G4 (Little Endian)

        ; pixel 0 (G0): R5[7:0] += 6 * G0
        MOV     R9, R10
        AND     R9, R9, #0xFF             ; R9 = G0
        ADD     R9, R9, R9, LSL #1        ; R9 = 3 * G0
        ADD     R5, R5, R9, LSL #1        ; R5[7:0] += 6 * G0

        ; pixel 1 (G1): R5[15:8] += 6 * G1
        MOV     R9, R10, LSR #8
        AND     R9, R9, #0xFF             ; R9 = G1
        ADD     R9, R9, R9, LSL #1        ; R9 = 3 * G1
        ADD     R5, R5, R9, LSL #17       ; R5[15:8] += 6 * G1

        ; pixel 2 (G2): R6[7:0] += 6 * G2
        MOV     R9, R10, LSR #16
        AND     R9, R9, #0xFF             ; R9 = G2
        ADD     R9, R9, R9, LSL #1        ; R9 = 3 * G2
        ADD     R6, R6, R9, LSL #1        ; R6[7:0] += 6 * G2

        ; pixel 3 (G3): R6[15:8] += 6 * G3
        MOV     R9, R10, LSR #24
        AND     R9, R9, #0xFF             ; R9 = G3
        ADD     R9, R9, R9, LSL #1        ; R9 = 3 * G3
        ADD     R6, R6, R9, LSL #17       ; R6[15:8] += 6 * G3

        ; pixel 4 (G4): R7[7:0] += 6 * G4
        MOV     R9, R11
        AND     R9, R9, #0xFF             ; R9 = G4
        ADD     R9, R9, R9, LSL #1        ; R9 = 3 * G4
        ADD     R7, R7, R9, LSL #1        ; R7[7:0] += 6 * G4

        ; pixel 5 (G5): R7[15:8] += 6 * G5
        MOV     R9, R11, LSR #8
        AND     R9, R9, #0xFF             ; R9 = G5
        ADD     R9, R9, R9, LSL #1        ; R9 = 3 * G5
        ADD     R7, R7, R9, LSL #17       ; R7[15:8] += 6 * G5

        ; pixel 6 (G6): R8[7:0] += 6 * G6
        MOV     R9, R11, LSR #16
        AND     R9, R9, #0xFF             ; R9 = G6
        ADD     R9, R9, R9, LSL #1        ; R9 = 3 * G6
        ADD     R8, R8, R9, LSL #1        ; R8[7:0] += 6 * G6

        ; pixel 7 (G7): R8[15:8] += 6 * G7
        MOV     R9, R11, LSR #24
        AND     R9, R9, #0xFF             ; R9 = G7
        ADD     R9, R9, R9, LSL #1        ; R9 = 3 * G7
        ADD     R8, R8, R9, LSL #17       ; R8[15:8] += 6 * G7


        ; Load 8 pixels of R: R10 = R3 R2 R1 R0, R11 = R7 R6 R5 R4
        LDMIA   R0!, {R10, R11}

        ; Pixel 0 (R0): R5[7:0] += 3*R0
        MOV     R9, R10
        AND     R9, R9, #0xFF
        ADD     R9, R9, R9, LSL #1
        ADD     R5, R5, R9

        ; Pixel 1 (R1): R5[15:8] += 3*R1
        MOV     R9, R10, LSR #8
        AND     R9, R9, #0xFF
        ADD     R9, R9, R9, LSL #1
        ADD     R5, R5, R9, LSL #16

        ; Pixel 2 (R2): R6[7:0] += 3*R2
        MOV     R9, R10, LSR #16
        AND     R9, R9, #0xFF
        ADD     R9, R9, R9, LSL #1
        ADD     R6, R6, R9

        ; Pixel 3 (R3): R6[15:8] += 3*R3
        MOV     R9, R10, LSR #24
        AND     R9, R9, #0xFF
        ADD     R9, R9, R9, LSL #1
        ADD     R6, R6, R9, LSL #16

        ; Pixel 4 (R4): R7[7:0] += 3*R4
        MOV     R9, R11
        AND     R9, R9, #0xFF
        ADD     R9, R9, R9, LSL #1
        ADD     R7, R7, R9

        ; Pixel 5 (R5): R7[15:8] += 3*R5
        MOV     R9, R11, LSR #8
        AND     R9, R9, #0xFF
        ADD     R9, R9, R9, LSL #1
        ADD     R7, R7, R9, LSL #16

        ; Pixel 6 (R6): R8[7:0] += 3*R6
        MOV     R9, R11, LSR #16
        AND     R9, R9, #0xFF
        ADD     R9, R9, R9, LSL #1
        ADD     R8, R8, R9

        ; Pixel 7 (R7): R8[15:8] += 3*R7
        MOV     R9, R11, LSR #24
        AND     R9, R9, #0xFF
        ADD     R9, R9, R9, LSL #1
        ADD     R8, R8, R9, LSL #16


        STMIA   R3!, {R5-R8}         ;load 8 pixel of grayscale
        SUBS    R4, R4, #8           ; Decrease pixel count
        BNE     LoopPixel            ; Repeat until done

End
        B       End

        END

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
        ;===========================================
        ; Step 1. Separate RGBA -> R, G, B
        ;===========================================

        LDR     r0, =0x40000036     ; Base address of RGBA data
        LDR     r1, =0x40100000     ; Address to store Red values
        LDR     r2, =0x40102580     ; Address to store Green values
        LDR     r3, =0x40104B00     ; Address to store Blue values
        MOV     r4, #9600           ; Total number of pixels

RelocateLoop
        LDRB    r5, [r0], #1        ; Load Red
        STRB    r5, [r1], #1        ; Store Red
        LDRB    r5, [r0], #1        ; Load Green
        STRB    r5, [r2], #1        ; Store Green
        LDRB    r5, [r0], #1        ; Load Blue
        STRB    r5, [r3], #1        ; Store Blue
        ADD     r0, r0, #1          ; Skip Alpha (1 byte)
        SUBS    r4, r4, #1
        BNE     RelocateLoop

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

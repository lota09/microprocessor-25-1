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
        LDR     r3, =0x40107000     ; Address to store grayscale result
        MOV     r4, #9600

GrayscaleLoop
        ; R: 3 * R
        LDRB    r5, [r0], #1
        MOV     r6, r5
        ADD     r5, r5, r6          ; 2R
        ADD     r5, r5, r6          ; 3R

        ; G: 6 * G
        LDRB    r6, [r1], #1
        MOV     r7, r6
        ADD     r6, r6, r7          ; 2G
        ADD     r6, r6, r7          ; 3G
        ADD     r6, r6, r7          ; 4G
        ADD     r6, r6, r7          ; 5G
        ADD     r6, r6, r7          ; 6G

        ; Add B
        ADD     r5, r5, r6
        LDRB    r6, [r2], #1        ; Load Blue
        ADD     r5, r5, r6          ; Gray = 3R + 6G + B

        ; Store result (as 2-byte halfword)
        STRH    r5, [r3], #2

        SUBS    r4, r4, #1
        BNE     GrayscaleLoop

End
        B       End

        END

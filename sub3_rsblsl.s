;**********************************************************************
;  - Project          : Project - ARM Code for Image Converting
;  - File name        : sub3.s
;  - Description      : Grayscale
;  - Owner            : Microprocessor Application team 4
;  - Revision history : 1) 2025.03.27 : Initial release
;**********************************************************************
        AREA    RESET, CODE, READONLY
        ENTRY
        EXPORT  _main

_main
        LDR     R0, =0x40000036      ; Address of RGBA image data
        LDR     R1, =0x40100000      ; Address to store grayscale result
        MOV     R2, #9600            ; Number of pixels

LoopPixel  
        ; ---- Add B ----
        LDRB    R4, [R0, #2]         ; Load Blue value
        MOV     R3, R4               ; Initialize result with B

        ; ---- Add 3 * R using LSL and RSB ----
        LDRB    R4, [R0]             ; Load Red value
        RSB     R5, R4, R4, LSL #2   ; 3 * R
        ADD     R3, R3, R5           ; B + 3R

        ; ---- Add 6 * G using LSL and RSB ----
        LDRB    R4, [R0, #1]         ; Load Green value
        MOV     R5, R4, LSL #1       ; R5 = 2 * G
        RSB     R5, R5, R4, LSL #3   ; R5 = 8 * G - 2 * G
        ADD     R3, R3, R5

        ; ---- Store grayscale result ----
        STRH    R3, [R1]             ; Store 16-bit grayscale value
        ADD     R0, R0, #4           ; Move to next RGBA pixel (skip Alpha)
        ADD     R1, R1, #2           ; Move to next grayscale storage location
        SUBS    R2, R2, #1           ; Decrease pixel count
        BNE     LoopPixel            ; Repeat until done

End
        B       End

        END

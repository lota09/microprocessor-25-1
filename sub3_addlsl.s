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
        ADD     R3, R3, R4, LSL #1   ; R3 = B + 2R
        ADD     R3, R3, R4           ; R3 = B + 2R + R

        ; ---- Add 6 * G using LSL and RSB ----
        LDRB    R4, [R0, #1]         ; Load Green value
        ADD     R3, R3, R4, LSL #1   ; R3 = B + 3R + 2G
        ADD     R3, R3, R4, LSL #2   ; R3 = B + 3R + 2G + 4G

        ; ---- Store grayscale result ----
        STRH    R3, [R1]             ; Store 16-bit grayscale value
        ADD     R0, R0, #4           ; Move to next RGBA pixel (skip Alpha)
        ADD     R1, R1, #2           ; Move to next grayscale storage location
        SUBS    R2, R2, #1           ; Decrease pixel count
        BNE     LoopPixel            ; Repeat until done

End
        B       End

        END

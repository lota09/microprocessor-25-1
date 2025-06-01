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
        ; ---- Load B and initialize result ----
        LDRB    R4, [R0, #2]         ; Load Blue value
        MOV     R3, R4               ; Initialize R3 = B

        ; ---- Multiply-accumulate: R * 3 ----
        LDRB    R4, [R0]             ; Load Red value
        MOV     R5, #3
        MLA     R3, R4, R5, R3       ; R3 = R4 * 3 + R3

        ; ---- Multiply-accumulate: G * 6 ----
        LDRB    R4, [R0, #1]         ; Load Green value
        MOV     R5, #6
        MLA     R3, R4, R5, R3       ; R3 = R4 * 6 + R3
        
        ; ---- Store grayscale result ----
        STRH    R3, [R1]             ; Store 16-bit grayscale value
        ADD     R0, R0, #4           ; Move to next RGBA pixel (skip Alpha)
        ADD     R1, R1, #2           ; Move to next grayscale storage location
        SUBS    R2, R2, #1           ; Decrease pixel count
        BNE     LoopPixel            ; Repeat until done

End
        B       End

        END

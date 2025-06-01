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
        ; ---- Calculate 3 * R ----
        LDRB    R3, [R0]             ; Load Red value
        MOV     R4, R3
        ADD     R3, R3, R4           ; 2 * R
        ADD     R3, R3, R4           ; 3 * R

        ; ---- Add 6 * G ----
        LDRB    R4, [R0, #1]         ; Load Green value
        MOV     R5, R4
        ADD     R4, R4, R5           ; 2 * G
        ADD     R4, R4, R5           ; 3 * G
        ADD     R4, R4, R5           ; 4 * G
        ADD     R4, R4, R5           ; 5 * G
        ADD     R4, R4, R5           ; 6 * G
        ADD     R3, R3, R4           ; Add 6 * G to result

        ; ---- Add B ----
        LDRB    R4, [R0, #2]         ; Load Blue value
        ADD     R3, R3, R4           ; Final Gray = 3R + 6G + B

        ; ---- Store grayscale result ----
        STRH    R3, [R1]             ; Store 16-bit grayscale value
        ADD     R0, R0, #4           ; Move to next RGBA pixel (skip Alpha)
        ADD     R1, R1, #2           ; Move to next grayscale storage location
        SUBS    R2, R2, #1           ; Decrease pixel count
        BNE     LoopPixel            ; Repeat until done

End
        B       End

        END

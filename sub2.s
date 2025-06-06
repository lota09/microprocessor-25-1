;**********************************************************************
;  - Project          : Project - ARM Code for Image Converting
;  - File name        : sub2.s
;  - Description      : Image Negative
;  - Owner            : Microprocessor Application team 4
;  - Revision history : 1) 2025.03.27 : Initial release
;**********************************************************************

        AREA RESET, CODE, READONLY
        EXPORT _main

_main
        LDR     R0, =0x40000036   ; Load base address of RGBA pixel data
        MOV     R1, #9600         ; Number of pixels
        MOV     R2, #255          ; Constant for inversion (255 - value)

LoopPixel

        LDRB    R3, [R0]          ; Load Red value
        RSB     R3, R3, #255      ; Invert Red (255 - R)
        STRB    R3, [R0]          ; Store inverted Red

        LDRB    R3, [R0, #1]      ; Load Green value
        RSB     R3, R3, #255      ; Invert Green (255 - G)
        STRB    R3, [R0, #1]      ; Store inverted Green

        LDRB    R3, [R0, #2]      ; Load Blue value
        RSB     R3, R3, #255      ; Invert Blue (255 - B)
        STRB    R3, [R0, #2]      ; Store inverted Blue

        ADD     R0, R0, #4        ; Move to next pixel (skip alpha)
        SUBS    R1, R1, #1        ; Decrement pixel count
        BNE     LoopPixel         ; Repeat if pixels remain

End
        B       End              ; Infinite loop to end program

        END

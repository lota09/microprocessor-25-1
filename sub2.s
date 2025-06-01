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
        LDR     R0, =0x40000036   
        MOV     R1, #9600          
        MOV     R2, #255          

        CMP     R1, #0
        BEQ     End

LoopPixel
R
        LDRB    R3, [R0]
        RSB     R3, R3, #255
        STRB    R3, [R0]
G
        LDRB    R3, [R0, #1]
        RSB     R3, R3, #255
        STRB    R3, [R0, #1]
B
        LDRB    R3, [R0, #2]
        RSB     R3, R3, #255
        STRB    R3, [R0, #2]

        
        ADD     R0, R0, #4         
        SUBS    R1, R1, #1
        BNE     LoopPixel

End
        B       End

        END
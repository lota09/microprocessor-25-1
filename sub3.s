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
        LDR     R0, =0x40000036      
        LDR     R1, =0x40100000      
        MOV     R2, #9600           

        CMP     R2, #0
        BEQ     End

LoopPixel
        
        LDRB    R3, [R0]            
        MOV     R4, R3
        ADD     R3, R3, R4           
        ADD     R3, R3, R4           

       
        LDRB    R4, [R0, #1]         ; G
        MOV     R5, R4
        ADD     R4, R4, R5           ; 2*G
        ADD     R4, R4, R5           ; 3*G
        ADD     R4, R4, R5           ; 4*G
        ADD     R4, R4, R5           ; 5*G
        ADD     R4, R4, R5           ; 6*G
        ADD     R3, R3, R4

        LDRB    R4, [R0, #2]         
        ADD     R3, R3, R4           
        STRH    R3, [R1]
        ADD     R0, R0, #4
        ADD     R1, R1, #2
        SUBS    R2, R2, #1
        BNE     LoopPixel

End
        B       End

        END
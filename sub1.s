;**********************************************************************
;  - Project          : Project - ARM Code for Image Converting
;  - File name        : sub1.s
;  - Description      : Red pixel counter
;  - Owner            : Microprocessor Application team 4
;  - Revision history : 1) 2025.03.27 : Initial release
;**********************************************************************

        AREA RESET, CODE, READONLY
        EXPORT _main

_main
        LDR     r0, =0x40000036
        MOV     r1, #0
        MOV     r2, #0

LOOP
        LDRB    r3, [r0], #4
        CMP     r3, #128
        BGE     COUNT_UP
        B       SKIP

COUNT_UP
        ADD     r2, r2, #1

SKIP
        ADD     r1, r1, #1
        CMP     r1, #9600
        BLT     LOOP


        LDR     r4, =0x4012FFF0
        STR     r2, [r4]

STOP
        B       STOP

        END
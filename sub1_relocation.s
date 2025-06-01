;**********************************************************************
;  - Project          : Project - ARM Code for Image Converting
;  - File name        : sub1_relocation.s
;  - Description      : Red pixel counter (memory relocation)
;  - Owner            : Microprocessor Application team 4
;  - Revision history : 1) 2025.03.27 : Initial release
;**********************************************************************

        AREA RESET, CODE, READONLY
        ENTRY
        EXPORT _main

_main
        ; Step 1. RGBA ? Red? relocation
        LDR     r0, =0x40000036      ; ????? RGBA ??? ?
        LDR     r1, =0x40110000      ; Red ?? ?? (?? ?? + ??? ?? ??)
        MOV     r2, #0

RelocateLoop
        LDRB    r3, [r0]             ; Red ??
        STRB    r3, [r1]             ; ??
        ADD     r0, r0, #4
        ADD     r1, r1, #1
        ADD     r2, r2, #1
        CMP     r2, #9600
        BLT     RelocateLoop

        ; Step 2. Red ? ??
        LDR     r0, =0x40110000
        MOV     r1, #0
        MOV     r2, #0

CountLoop
        ; 8?? ??? ? ?? ???
        LDMIA   r0!, {r3-r10}

        ; ? ????? ?? CMP & ADD
        CMP     r3, #128
        ADDGE   r2, r2, #1

        CMP     r4, #128
        ADDGE   r2, r2, #1

        CMP     r5, #128
        ADDGE   r2, r2, #1

        CMP     r6, #128
        ADDGE   r2, r2, #1

        CMP     r7, #128
        ADDGE   r2, r2, #1

        CMP     r8, #128
        ADDGE   r2, r2, #1

        CMP     r9, #128
        ADDGE   r2, r2, #1

        CMP     r10, #128
        ADDGE   r2, r2, #1

        ; ?? ??? ??
        ADD     r1, r1, #8
        CMP     r1, #9600
        BLT     CountLoop

        ; Step 3. ?? ??
        LDR     r4, =0x4012FFF0
        STR     r2, [r4]

STOP
        B       STOP

        END
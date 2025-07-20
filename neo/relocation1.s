       
        AREA RESET, CODE, READONLY
        ENTRY
        EXPORT _main

_main
        ; Step 1: Extract red bytes from RGBA and store
        LDR     r0, =0x40000036      ; RGBA source
        MOV     r1, #0
        
RelocateLoop
        ;pixel 1-4
        LDRB    r3, [r0], #4
        ROR     r3, r3, #8
        LDRB    r2, [r0], #4
        ORR     r3, r2, r3
        ROR     r3, r3, #8
        LDRB    r2, [r0], #4
        ORR     r3, r2, r3
        ROR     r3, r3, #8
        LDRB    r2, [r0], #4
        ORR     r3, r2, r3
        ROR     r3, r3, #8

        ;pixel 5-8  
        LDRB    r4, [r0], #4
        ROR     r4, r4, #8
        LDRB    r2, [r0], #4
        ORR     r4, r2, r4
        ROR     r4, r4, #8
        LDRB    r2, [r0], #4
        ORR     r4, r2, r4
        ROR     r4, r4, #8
        LDRB    r2, [r0], #4
        ORR     r4, r2, r4
        ROR     r4, r4, #8

        ; pixel 9-12
        LDRB    r5, [r0], #4
        ROR     r5, r5, #8
        LDRB    r2, [r0], #4
        ORR     r5, r2, r5
        ROR     r5, r5, #8
        LDRB    r2, [r0], #4
        ORR     r5, r2, r5
        ROR     r5, r5, #8
        LDRB    r2, [r0], #4
        ORR     r5, r2, r5
        ROR     r5, r5, #8

        ; pixel 13-16
        LDRB    r6, [r0], #4
        ROR     r6, r6, #8
        LDRB    r2, [r0], #4
        ORR     r6, r2, r6
        ROR     r6, r6, #8
        LDRB    r2, [r0], #4
        ORR     r6, r2, r6
        ROR     r6, r6, #8
        LDRB    r2, [r0], #4
        ORR     r6, r2, r6
        ROR     r6, r6, #8

        ; pixel 17-20
        LDRB    r7, [r0], #4
        ROR     r7, r7, #8
        LDRB    r2, [r0], #4
        ORR     r7, r2, r7
        ROR     r7, r7, #8
        LDRB    r2, [r0], #4
        ORR     r7, r2, r7
        ROR     r7, r7, #8
        LDRB    r2, [r0], #4
        ORR     r7, r2, r7
        ROR     r7, r7, #8

        ; pixel 21-24
        LDRB    r8, [r0], #4
        ROR     r8, r8, #8
        LDRB    r2, [r0], #4
        ORR     r8, r2, r8
        ROR     r8, r8, #8
        LDRB    r2, [r0], #4
        ORR     r8, r2, r8
        ROR     r8, r8, #8
        LDRB    r2, [r0], #4
        ORR     r8, r2, r8
        ROR     r8, r8, #8

        ; pixel 25-28
        LDRB    r9, [r0], #4
        ROR     r9, r9, #8
        LDRB    r2, [r0], #4
        ORR     r9, r2, r9
        ROR     r9, r9, #8
        LDRB    r2, [r0], #4
        ORR     r9, r2, r9
        ROR     r9, r9, #8
        LDRB    r2, [r0], #4
        ORR     r9, r2, r9
        ROR     r9, r9, #8

        ; pixel 29-32
        LDRB    r10, [r0], #4
        ROR     r10, r10, #8
        LDRB    r2, [r0], #4
        ORR     r10, r2, r10
        ROR     r10, r10, #8
        LDRB    r2, [r0], #4
        ORR     r10, r2, r10
        ROR     r10, r10, #8
        LDRB    r2, [r0], #4
        ORR     r10, r2, r10
        ROR     r10, r10, #8

        ; pixel 33-36
        LDRB    r11, [r0], #4
        ROR     r11, r11, #8
        LDRB    r2, [r0], #4
        ORR     r11, r2, r11
        ROR     r11, r11, #8
        LDRB    r2, [r0], #4
        ORR     r11, r2, r11
        ROR     r11, r11, #8
        LDRB    r2, [r0], #4
        ORR     r11, r2, r11
        ROR     r11, r11, #8

        ; pixel 37-40
        LDRB    r12, [r0], #4
        ROR     r12, r12, #8
        LDRB    r2, [r0], #4
        ORR     r12, r2, r12
        ROR     r12, r12, #8
        LDRB    r2, [r0], #4
        ORR     r12, r2, r12
        ROR     r12, r12, #8
        LDRB    r2, [r0], #4
        ORR     r12, r2, r12
        ROR     r12, r12, #8

        ADD     r2, r1, #0x40000000     
        ADD     r2, r2, #0x10000        ; R base
        STMIA   r2, {r3-r12}

        ADD     r1, r1, #40              ; pixel count += 40
        CMP     r1, #9600
        BLT     RelocateLoop

End
        B       End

        END

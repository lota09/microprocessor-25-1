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

        ; Step 2: Count red bytes with MSB = 1
        LDR     r0, =0x40010000
        MOV     r1, #0               ; Offset
        MOV     r2, #0               ; Count

CountLoop
        LDMIA   r0!, {r3-r10}        ; Load 8 words (32 bytes)

        ; Check MSB of each byte (bit 7 of each byte in r3–r10)
        TST     r3, #0x00000080     ; Byte 0
        ADDNE   r2, r2, #1
        TST     r3, #0x00008000     ; Byte 2
        ADDNE   r2, r2, #1
        TST     r3, #0x00800000     ; Byte 3
        ADDNE   r2, r2, #1
        TST     r3, #0x80000000     ; Byte 4
        ADDNE   r2, r2, #1

        ; r4
		
        TST     r4, #0x00000080
        ADDNE   r2, r2, #1
        TST     r4, #0x00008000
        ADDNE   r2, r2, #1
        TST     r4, #0x00800000
        ADDNE   r2, r2, #1
        TST     r4, #0x80000000
        ADDNE   r2, r2, #1
		
		;r5
		
        TST     r5, #0x00000080
        ADDNE   r2, r2, #1
        TST     r5, #0x00008000
        ADDNE   r2, r2, #1
        TST     r5, #0x00800000
        ADDNE   r2, r2, #1
        TST     r5, #0x80000000
        ADDNE   r2, r2, #1
		
		;r6

        TST     r6, #0x00000080
        ADDNE   r2, r2, #1
        TST     r6, #0x00008000
        ADDNE   r2, r2, #1
        TST     r6, #0x00800000
        ADDNE   r2, r2, #1
        TST     r6, #0x80000000
        ADDNE   r2, r2, #1
		
		;r7
		
        TST     r7, #0x00000080
        ADDNE   r2, r2, #1
        TST     r7, #0x00008000
        ADDNE   r2, r2, #1
        TST     r7, #0x00800000
        ADDNE   r2, r2, #1
        TST     r7, #0x80000000
        ADDNE   r2, r2, #1
		
		;r8

        TST     r8, #0x00000080
        ADDNE   r2, r2, #1
        TST     r8, #0x00008000
        ADDNE   r2, r2, #1
        TST     r8, #0x00800000
        ADDNE   r2, r2, #1
        TST     r8, #0x80000000
        ADDNE   r2, r2, #1
		
		;r9

        TST     r9, #0x00000080
        ADDNE   r2, r2, #1
        TST     r9, #0x00008000
        ADDNE   r2, r2, #1
        TST     r9, #0x00800000
        ADDNE   r2, r2, #1
        TST     r9, #0x80000000
        ADDNE   r2, r2, #1
		
		;r10

        TST     r10, #0x00000080
        ADDNE   r2, r2, #1
        TST     r10, #0x00008000
        ADDNE   r2, r2, #1
        TST     r10, #0x00800000
        ADDNE   r2, r2, #1
        TST     r10, #0x80000000
        ADDNE   r2, r2, #1
		
		; add pixel counter

        ADD     r1, r1, #32
        CMP     r1, #9600
        BLT     CountLoop

        ; Step 3: Save result
        LDR     r4, =0x4012FFF0
        STR     r2, [r4]

STOP
        B       STOP

        END

        AREA RESET, CODE, READONLY
        ENTRY
        EXPORT _main

_main
        ; Step 1: Extract red bytes from RGBA and store
        LDR     r0, =0x40000036      ; RGBA source
        LDR     r1, =0x40110000      ; Red destination
        MOV     r2, #0

RelocateLoop
        LDRB    r3, [r0]             ; Load red byte
        STRB    r3, [r1]             ; Store red byte
        ADD     r0, r0, #4           ; Next pixel
        ADD     r1, r1, #1
        ADD     r2, r2, #1
        CMP     r2, #9600
        BLT     RelocateLoop

        ; Step 2: Count red bytes with MSB = 1
        LDR     r0, =0x40110000
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
		
		r10;

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

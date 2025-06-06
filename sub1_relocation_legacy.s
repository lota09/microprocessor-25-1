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
        ; Step 1. Extract Red channel from RGBA and relocate
        LDR     r0, =0x40000036      ; Start address of RGBA data
        LDR     r1, =0x40110000      ; Red channel output address (contiguous memory area)
        MOV     r2, #0               ; Counter initialization

RelocateLoop
        LDRB    r3, [r0]             ; Load Red byte
        STRB    r3, [r1]             ; Store Red byte
        ADD     r0, r0, #4           ; Move to next pixel (skip G, B, A)
        ADD     r1, r1, #1           ; Move output pointer
        ADD     r2, r2, #1           ; Increment counter
        CMP     r2, #9600            ; Check if all pixels processed
        BLT     RelocateLoop

        ; Step 2. Count Red values >= 128
        LDR     r0, =0x40110000      ; Red channel data start
        MOV     r1, #0               ; Loop counter
        MOV     r2, #0               ; Count of red pixels >= 128

CountLoop
        ; Load 8 Red values in one batch
        LDMIA   r0!, {r3-r10}

        ; Compare each value to 128 and conditionally increment count
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

        ; Update processed pixel count
        ADD     r1, r1, #8
        CMP     r1, #9600
        BLT     CountLoop

        ; Step 3. Store the final count to memory-mapped location
        LDR     r4, =0x4012FFF0
        STR     r2, [r4]

STOP
        B       STOP

        END

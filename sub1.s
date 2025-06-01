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
        LDR     r0, =0x40000036      ; Load base address of RGBA image data
        MOV     r1, #0               ; Pixel counter (loop index)
        MOV     r2, #0               ; Counter for Red values >= 128

LOOP
        LDRB    r3, [r0], #4         ; Load Red value (skip G, B, A by incrementing +4)
        CMP     r3, #128             ; Compare Red value with 128
        BGE     COUNT_UP             ; If Red >= 128, increment count
        B       SKIP                 ; Otherwise, skip to next

COUNT_UP
        ADD     r2, r2, #1           ; Increment counter for qualifying Red value

SKIP
        ADD     r1, r1, #1           ; Increment pixel index
        CMP     r1, #9600            ; Check if all pixels are processed
        BLT     LOOP                 ; Loop if not done

        LDR     r4, =0x4012FFF0      ; Address to store final count
        STR     r2, [r4]             ; Store the count

STOP
        B       STOP                ; Infinite loop (end of program)

        END

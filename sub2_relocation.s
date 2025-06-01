;**********************************************************************
;  - Project          : Project - ARM Code for Image Converting
;  - File name        : sub2_relocation.s
;  - Description      : Image Negative (memory relocation)
;  - Owner            : Microprocessor Application team 4
;  - Revision history : 1) 2025.03.27 : Initial release
;**********************************************************************
        AREA    RESET, CODE, READONLY
        EXPORT  _main
        ENTRY

_main
        ; ===================================
        ; Step 1: Separate RGBA into R, G, B channels
        ; ===================================
        LDR     R0, =0x40000036      ; RGBA input address
        LDR     R1, =0x40110000      ; R channel output address
        LDR     R2, =0x40118000      ; G channel output address
        LDR     R3, =0x40120000      ; B channel output address
        MOV     R4, #9600            ; Loop count (pixels)

RelocateLoop
        LDRB    R5, [R0], #1         ; Load R
        STRB    R5, [R1], #1         ; Store R

        LDRB    R5, [R0], #1         ; Load G
        STRB    R5, [R2], #1         ; Store G

        LDRB    R5, [R0], #1         ; Load B
        STRB    R5, [R3], #1         ; Store B

        ADD     R0, R0, #1           ; Skip A channel
        SUBS    R4, R4, #1
        BNE     RelocateLoop

        ; ===================================
        ; Step 2: Invert color (255 - value)
        ; ===================================
        LDR     R0, =0x40110000      ; R channel address
        LDR     R1, =0x40118000      ; G channel address
        LDR     R2, =0x40120000      ; B channel address
	LDR     R3, =0x40000036      ; RGBA output address
        MOV     R4, #9600            ; Loop count

InvertLoop
        ; Load 8 pixels of R channel
        LDMIA r0!, {r5, r8}
        MVN r5, r5
        MVN r8, r8

        ; Load 8 pixels of G channel
        LDMIA r1!, {r6, r9}
        MVN r6, r6
        MVN r9, r9

        ; Load 8 pixels of B channel
        LDMIA r2!, {r7, r10}
        MVN r7, r7
        MVN r10, r10

        ; Store 4 inverted RGB pixels
        ; Pixel 0
        STRB r5, [r3], #1
        STRB r6, [r3], #1
        STRB r7, [r3], #2

        ; Pixel 1
        LSR r5, r5, #8
        LSR r6, r6, #8
        LSR r7, r7, #8
        STRB r5, [r3], #1
        STRB r6, [r3], #1
        STRB r7, [r3], #2

        ; Pixel 2
        LSR r5, r5, #8
        LSR r6, r6, #8
        LSR r7, r7, #8
        STRB r5, [r3], #1
        STRB r6, [r3], #1
        STRB r7, [r3], #2

        ; Pixel 3
        LSR r5, r5, #8
        LSR r6, r6, #8
        LSR r7, r7, #8
        STRB r5, [r3], #1
        STRB r6, [r3], #1
        STRB r7, [r3], #2

        ; Pixel 4
        STRB r8, [r3], #1
        STRB r9, [r3], #1
        STRB r10, [r3], #2

        ; Pixel 5
        LSR r8, r8, #8
        LSR r9, r9, #8
        LSR r10, r10, #8
        STRB r8, [r3], #1
        STRB r9, [r3], #1
        STRB r10, [r3], #2

        ; Pixel 6
        LSR r8, r8, #8
        LSR r9, r9, #8
        LSR r10, r10, #8
        STRB r8, [r3], #1
        STRB r9, [r3], #1
        STRB r10, [r3], #2

        ; Pixel 7
        LSR r8, r8, #8
        LSR r9, r9, #8
        LSR r10, r10, #8
        STRB r8, [r3], #1
        STRB r9, [r3], #1
        STRB r10, [r3], #2

        SUBS R4, R4, #8     ; Decrease pixel count
        BNE InvertLoop

STOP
        B       STOP

        END

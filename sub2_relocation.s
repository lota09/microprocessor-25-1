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
        ; Step 1: RGBA ? R, G, B ?? ??
        ; ===================================
        LDR     R0, =0x40000036      ; RGBA ?? ??
        LDR     R1, =0x40110000      ; R ?? ??
        LDR     R2, =0x40118000      ; G ?? ??
        LDR     R3, =0x40120000      ; B ?? ??
        MOV     R4, #9600            ; ?? ?

RelocateLoop
        LDRB    R5, [R0], #1         ; R
        STRB    R5, [R1], #1

        LDRB    R5, [R0], #1         ; G
        STRB    R5, [R2], #1

        LDRB    R5, [R0], #1         ; B
        STRB    R5, [R3], #1

        ADD     R0, R0, #1           ; A ??
        SUBS    R4, R4, #1
        BNE     RelocateLoop

        ; ===================================
        ; Step 2: ? ?? (255 - ?)
        ; ===================================
        LDR     R0, =0x40110000      ; R ??
        LDR     R1, =0x40118000      ; G ??
        LDR     R2, =0x40120000      ; B ??
		LDR     R3, =0x40000036      ; RGBA ??
        MOV     R4, #9600

InvertLoop
        ; R ?? 4?? ?? ? ??
        LDMIA r0!, {r5, r8}
        MVN r5, r5
        MVN r8, r8

        ; G ??
        LDMIA r1!, {r6, r9}
        MVN r6, r6
        MVN r9, r9

        ; B ??
        LDMIA r2!, {r7, r10}
        MVN r7, r7
        MVN r10, r10

        ; RGB ?? ?4?? ?? ??
        ; ?? 0
        STRB r5, [r3], #1
        STRB r6, [r3], #1
        STRB r7, [r3], #2

        ; ?? 1
        LSR r5, r5, #8
        LSR r6, r6, #8
        LSR r7, r7, #8
        STRB r5, [r3], #1
        STRB r6, [r3], #1
        STRB r7, [r3], #2

        ; ?? 2
        LSR r5, r5, #8
        LSR r6, r6, #8
        LSR r7, r7, #8
        STRB r5, [r3], #1
        STRB r6, [r3], #1
        STRB r7, [r3], #2

        ; ?? 3
        LSR r5, r5, #8
        LSR r6, r6, #8
        LSR r7, r7, #8
        STRB r5, [r3], #1
        STRB r6, [r3], #1
        STRB r7, [r3], #2
		
		
		
        ; ?? 4
        STRB r8, [r3], #1
        STRB r9, [r3], #1
        STRB r10, [r3], #2

        ; ?? 5
        LSR r8, r8, #8
        LSR r9, r9, #8
        LSR r10, r10, #8
        STRB r8, [r3], #1
        STRB r9, [r3], #1
        STRB r10, [r3], #2

        ; ?? 6
        LSR r8, r8, #8
        LSR r9, r9, #8
        LSR r10, r10, #8
        STRB r8, [r3], #1
        STRB r9, [r3], #1
        STRB r10, [r3], #2

        ; ?? 7
        LSR r8, r8, #8
        LSR r9, r9, #8
        LSR r10, r10, #8
        STRB r8, [r3], #1
        STRB r9, [r3], #1
        STRB r10, [r3], #2
		
		
        SUBS R4, R4, #8     ; 4?? ??
        BNE InvertLoop

STOP
        B       STOP

        END
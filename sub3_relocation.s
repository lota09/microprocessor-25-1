;**********************************************************************
;  - Project          : Project - ARM Code for Image Converting
;  - File name        : sub3_relocation.s
;  - Description      : Grayscale
;  - Owner            : Microprocessor Application team 4
;  - Revision history : 1) 2025.03.27 : Initial release
;**********************************************************************
        
        AREA RESET, CODE, READONLY
        ENTRY
        EXPORT _main

_main
        ;===========================================
        ; Step 1. RGBA -> R, G, B 따로 저장
        ;===========================================

        LDR     r0, =0x40000036     
        LDR     r1, =0x40100000      ; R값 저장 주소
        LDR     r2, =0x40102580      ; G값 저장 주소
        LDR     r3, =0x40104B00      ; B값 저장 주소
        MOV     r4, #9600            ; 총 픽셀 수

RelocateLoop
        LDRB    r5, [r0], #1         ; R
        STRB    r5, [r1], #1
        LDRB    r5, [r0], #1         ; G
        STRB    r5, [r2], #1
        LDRB    r5, [r0], #1         ; B
        STRB    r5, [r3], #1
        ADD     r0, r0, #1           ; A 값 건너뛰기(1바이트 이동)
        SUBS    r4, r4, #1
        BNE     RelocateLoop

        ;===========================================
        ; Step 2. Grayscale  (Gray = 3R + 6G + B)
        ;===========================================

        LDR     r0, =0x40100000      ; R 시작 주소
        LDR     r1, =0x40102580      ; G 시작 주소
        LDR     r2, =0x40104B00      ; B 시작 주소
        LDR     r3, =0x40107000      ; Grayscale 결과 저장 주소
        MOV     r4, #9600

GrayscaleLoop
        ; R: 3 * R
        LDRB    r5, [r0], #1
        MOV     r6, r5
        ADD     r5, r5, r6           ; 2R
        ADD     r5, r5, r6           ; 3R

        ; G: 6 * G
        LDRB    r6, [r1], #1
        MOV     r7, r6
        ADD     r6, r6, r7           ; 2G
        ADD     r6, r6, r7           ; 3G
        ADD     r6, r6, r7           ; 4G
        ADD     r6, r6, r7           ; 5G
        ADD     r6, r6, r7           ; 6G

        ; B 더하기
        ADD     r5, r5, r6
        LDRB    r6, [r2], #1         ; B
        ADD     r5, r5, r6           ; Gray = 3R + 6G + B

        ; 결과 저장(2바이트 단위로)
        STRH    r5, [r3], #2

        SUBS    r4, r4, #1
        BNE     GrayscaleLoop

       
End
        B       End

        END
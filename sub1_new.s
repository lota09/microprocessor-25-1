        AREA RESET, CODE, READONLY
        EXPORT _main

_main
        LDR     r0, =0x40000036      ; 픽셀 시작 주소
        MOV     r1, #9600            ; 총 반복 횟수
        MOV     r2, #0               ; count

Loop
        LDRB    r3, [r0], #4         ; R값 읽고 다음 픽셀로

        CMP     r3, #128
        ADDGE   r2, r2, #1           ; 조건 충족 시 count 증가

        SUBS    r1, r1, #1
        BNE     Loop

        LDR     r4, =0x4012FFF0
        STR     r2, [r4]

STOP
        B       STOP

        END
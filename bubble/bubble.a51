ORG 0000H

; Data
MOV 30H,#25
MOV 31H,#10
MOV 32H,#40
MOV 33H,#15
MOV 34H,#30

MOV R7,#04

L1:
    MOV R0,#30H
    MOV R6,#04

L2:
    MOV A,@R0
    MOV R5,A

    INC R0
    MOV A,@R0

    CLR C
    SUBB A,R5
    JNC L3

    MOV A,@R0
    XCH A,R5
    MOV @R0,A

    DEC R0
    MOV A,R5
    MOV @R0,A
    INC R0

L3:
    DJNZ R6,L2
    DJNZ R7,L1

STOP:
    SJMP STOP

END
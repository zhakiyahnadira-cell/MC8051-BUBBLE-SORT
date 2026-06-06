ORG 0000H

; --- INisialisasi Data Awal ke External RAM (X:0100H) ---
MOV DPTR,#0100H
MOV A,#25
MOVX @DPTR,A

INC DPTR
MOV A,#10
MOVX @DPTR,A

INC DPTR
MOV A,#40
MOVX @DPTR,A

INC DPTR
MOV A,#15
MOVX @DPTR,A

INC DPTR
MOV A,#30
MOVX @DPTR,A
; -------------------------------------------------------

MOV R7,#04          ; Outer loop counter

L1:
    MOV DPTR,#0100H ; Reset pointer ke awal array eksternal
    MOV R6,#04      ; Inner loop counter

L2:
    MOVX A,@DPTR    
    MOV R5,A        

    INC DPTR        ; Maju ke elemen ke-(n+1)
    MOVX A,@DPTR    ; Baca data elemen ke-(n+1) dari External RAM

    CLR C
    SUBB A,R5       ; Bandingkan elemen(n+1) - elemen(n)
    JNC L3          ; Jika sudah benar urutannya (tidak borrow), skip swap

    ; --- PROSES SWAP (Penukaran Data di External RAM) ---
    MOVX A,@DPTR    ; Ambil lagi nilai elemen ke-(n+1)
    XCH A,R5        ; Tukar nilai di Accumulator dengan R5 (elemen ke-n)
    MOVX @DPTR,A    ; Tulis nilai baru ke elemen ke-(n+1)

    
    MOV A,DPL
    CLR C
    SUBB A,#01
    MOV DPL,A       ; DPTR sekarang mundur 1 alamat ke elemen ke-n
    
    MOV A,R5
    MOVX @DPTR,A    ; Tulis nilai baru ke elemen ke-n
    
    ; Kembalikan DPTR maju lagi ke elemen ke-(n+1) untuk melanjutkan loop
    INC DPTR

L3:
    DJNZ R6,L2
    DJNZ R7,L1

STOP:
    SJMP STOP

END
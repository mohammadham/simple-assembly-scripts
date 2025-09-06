.model small
.stack 100
.data
 a1 dw 64
 a2 dw 56
 b1 dw 87
 b2 dw 96
 c1 dw 0
 c2 dw 0
 c3 dw 0
 c4 dw 0  
 counter db 32
 
.code
  main proc far
    push ds
    push 0
    mov ax , @data
    mov ds , ax
   ;-----------------
    mov AX , 0
    mov BX , 0
    ;mov ch , 32
loop1:cmp counter , 0
    JLE endloop
    TEST b1 , 1
    JZ next
   ; AX , BX  <--- a1 , a2  + AX , BX
    ADD AX , a1
    ADC BX , a2 
next:mov cl ,1
    RCR BX , cl
    RCR AX , cl
    RCR b2 , cl
    RCR b1 , cl
    ;DEC ch
    DEC counter
    jmp loop1  
endloop: mov DX , b1 
    mov c1 , DX
    mov DX , b2   
    mov c2 , DX
    mov c3 , AX
    mov c4 , BX
    
    ret
  main endp
end main
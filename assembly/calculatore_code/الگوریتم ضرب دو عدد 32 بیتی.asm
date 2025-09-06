.model small
.stack 100
.data
 a1  dw 6547
 a2  dw 541
 b1  dw 352
 b2  dw 21
 c1  dw 0
 c2  dw 0
 c3  dw 0
 c4  dw 0
.code
  main proc far
    push ds
    push 0
    mov ax , @data
    mov ds , ax
   ;------------------------
    mov ax , 0
    mov bx , 0
    mov ch , 32
loop1: cmp ch , 0
    JLE endloop
    test b2 , 1
    JZ next
   ; AX , BX  <-- a1 , a2  + AX , BX
    ADD bx , a2
    ADC ax , a1
next:mov cl , 1
    RCR  AX , cl
    RCR  BX , cl 
    RCR  b1 , cl
    RCR  b2 , cl
    DEC  ch
    jmp loop1 
endloop:mov DX , b2 
    mov c1 , DX  
    mov DX , b1
    mov c2 , DX
    mov c3 , BX
    mov c4 , AX
    ret
  main endp
end main
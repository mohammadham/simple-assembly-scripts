.model small
.stack 100
.data
 buffer db 10, 10  dup(?)
 d      dw ?
 ten    dw 10 
 h      dw 0

.code
  main proc far
    push ds
    push 0
    mov ax , @data
    mov ds , ax
   ;----------------
    mov ah , 0AH
    LEA DX , buffer
    INT 21h
   ;----------------
    mov ax , 0
    mov si ,2
    mov dl , buffer[1]
    mov dh , 0
    add dx , 2
    mov h , dx
loop1:cmp si , h
    JNL endloop
    mov bl , buffer[si]
    SUB bl , 48 
    mov bh , 0
    MUL ten 
    add AX , bx
    inc si
    jmp loop1
endloop: mov d , ax
     
    mov ah ,1
    int 21h
   ret
   main endp
 end main
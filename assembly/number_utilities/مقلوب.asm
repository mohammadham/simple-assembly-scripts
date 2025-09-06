.model small
.stack 100
.data
  a dw 458
  d dw 0 
  ten dw 10
.code

 main proc far
    push ds
    push 0
    mov ax , @data
    mov ds , ax
   ;------------------
    mov bx , 0
    mov ax , a
loop1:cmp ax , 0
    JE endloop
    CWD
    DIV ten
    mov cx , ax
    mov d , dx
    mov ax , bx
    mul ten
    mov bx , ax
    add bx , d
    mov ax , cx
    jmp loop1 
endloop: mov d , bx
   ret
 main endp
end main
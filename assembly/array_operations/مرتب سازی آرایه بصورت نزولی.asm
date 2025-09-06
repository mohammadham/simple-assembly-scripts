.model small
.stack 100
.data
  x dw 6,89,56,24,95,126,261,12,816,4  
.code
main proc far
    push ds
    push 0
    mov ax , @data
    mov ds , ax
    ;------------------
    mov si , 0
loop2:cmp si , 18
    jnl endloop2
    mov di , si
    add di , 2
loop1:cmp di , 20
    jge endloop1
    mov dx , x[di]
    cmp x[si] , dx
    jnl endif
    ;mov dh , x[si]
    ;mov x[si] , dl
    ;mov x[di] ,dh 
    xchg x[si] , dx
    mov x[di] , dx
endif:add di, 2
    jmp loop1
endloop1:add si , 2
    jmp loop2
    
endloop2:ret
 main endp
end main
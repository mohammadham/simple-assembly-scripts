.model small
.stack 100
.data
  a dw 25,89,12,6,2,56,117,48,95,13
  
.code

 main proc far
    push ds
    push 0
    mov ax , @data
    mov ds , ax
   ;------------------
    mov si , 0
loop2:cmp si , 18
    JNL endloop2
    mov di , si
    add di , 2
loop1:cmp di , 20
    JGE endloop1
    mov ax , a[di]
    cmp a[si] , ax
    JG endif
    ;mov bl , a[si]
    ;mov a[si] , al
    ;mov a[di] , bl 
    xchg ax , a[si]
    mov a[di] , ax
    
endif:add di , 2
    jmp loop1  
endloop1:add si , 2
    jmp loop2     
   
endloop2:   
   ret
 main endp
end main
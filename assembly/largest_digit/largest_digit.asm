.model small

.data
 buffer db 10 dup(?)
 b      dw 00  ;print number
 ten    dw 10   
 a dw  00
 buffer1 db 10, 10  dup(?)    
 h      dw 0   
 d      dw ? ;maghlob number

.code 
    main proc far
        
     MOV AX, @DATA                ; initialize DS
     MOV DS, AX
    ;-----------------

    call input_num       
    mov a , ax
    lab1:
    mov d , 00
    mov ax, a
    call maghlob
    mov ax , a
    cmp ax, d 
    jne lab2
    
    call print_num 
    lab2:
    
    dec a
    cmp a, 99ش
    jne lab1
    

      mov ah ,1
    int 21h
   ret

 main endp
    
 maghlob proc   ;mov input number in ax  and out put proc in d
    mov bx , 0
    mov ax , a
loop11:cmp ax , 0
    JE endloop2
    CWD
    DIV ten
    mov cx , ax
    mov d , dx
    mov ax , bx
    mul ten
    mov bx , ax
    add bx , d
    mov ax , cx
    jmp loop11 
endloop2: mov d , bx
ret
maghlob endp   
    
input_num proc ; a number in ax
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
loop12:cmp si , h
    JNL endloop1
    mov bl , buffer[si]
    SUB bl , 48 
    mov bh , 0
    MUL ten 
    add AX , bx
    inc si
    jmp loop12
endloop1: ;mov d , ax
ret
input_num endp









 print_num proc ; str is a number for print
    
   ;----------------
    mov buffer1[9] , '$'
    mov si , 8
    ;mov ax ,str
loop1:cmp ax , 0
    JE endloop 
    CWD 
    div ten
    mov buffer[si] , dl
    add buffer[si] , 48 
    dec si
    jmp loop1
endloop:inc si
    ;edit
   ; printstr buffer[si]  
    MOV AH,09H
LEA DX,buffer[si]  
INT 21H
ret
print_num endp  
 
PRINTSTR MACRO STR

MOV AH,09H
LEA DX,STR
INT 21H

ENDM    
 end main
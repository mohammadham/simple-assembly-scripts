.model small
.stack 100
.data
 buffer    db 10, 10  dup(?) 
 buffer1   db 'Enter a Number: $'  
 buffer2   db 15 dup(?)
 d         dw ?
 ten       dw 10 
 h         dw 0
 half      dw ?
 two       dw 2 
 sum       dw 0

.code   
;--------------------------------
;   Read Number
;--------------------------------
  read proc
    mov ah , 0AH
    LEA DX , buffer
    INT 21h  
    ret
  read endp  
;--------------------------------
;   Print
;--------------------------------
  print proc
    mov ah , 9
    LEA DX , buffer1
    INT 21h 
    ret
  print endp 
;--------------------------------
;   Convert String To Number
;--------------------------------  
  convert_string_to_number proc
    mov ax , 0
    mov si ,2
    mov dl , buffer[1]
    mov dh , 0
    add dx , 2
    mov h , dx
loop1:cmp si , h
    JNL endloop1
    mov bl , buffer[si]
    SUB bl , 48 
    mov bh , 0
    MUL ten 
    add AX , bx
    inc si
    jmp loop1
endloop1: mov d , ax  
    ret
  convert_string_to_number endp  
  
;--------------------------------
;   Convert String To Number
;-------------------------------- 

  convert_number_to_string proc
    mov buffer2[14] , '$' 
    mov buffer2[13] , ' ' 
    mov buffer2[12] , ' '
    mov buffer2[11] , ' '
    mov buffer2[10] , ' ' 
    mov buffer2[9]  , ' '
    mov si , 8
    mov ax , sum
loop4:cmp ax , 0
    JE endloop4 
    CWD 
    div ten
    mov buffer2[si] , dl
    add buffer2[si] , 48 
    dec si
    jmp loop4
endloop4:inc si
    mov ah ,9
    lea dx , buffer2[si]  
    int 21h
    ret
  convert_number_to_string endp  
;--------------------------------
;      getch
;--------------------------------
   getch  proc
    mov ah ,1
    int 21h
    ret
   getch  endp                     
;--------------------------------
;      goto
;--------------------------------   
 goto macro
    mov ah , 2
    mov dl , 1
    mov dh , 2
    INT 10h
 goto endm
;--------------------------------
;     Main
;--------------------------------    
  main proc far
    push ds
    push 0
    mov ax , @data
    mov ds , ax
   ;----------------   
    call print
    call read 
    goto
   ;----------------
    call convert_string_to_number
    mov si , 2
loop2:cmp si , d
    JNL endloop2
    mov bx , 1
    mov di , 2
    mov ax , si
    CWD
    DIV two
    mov half , ax
loop3:cmp di , half
    JG  endloop3
    mov ax , si
    CWD
    DIV di
    cmp dx , 0
    JNE endif1
    add bx , di
endif1:INC di
    jmp loop3           
endloop3:cmp bx , si
    JNE endif2 
    mov sum , bx
    ;---------- 
    pusha
    call convert_number_to_string  
    popa
    ;----------
endif2:INC si
    jmp loop2              
endloop2:               
    call getch
    ret
   main endp
 end main
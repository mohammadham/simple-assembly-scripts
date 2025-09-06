.model small
.stack 100
.data 
 readNO       db 'Enter a Number: $'
 buffer       db 10, 10  dup(?) 
 buffer_print db 15 dup(?)
 n            dw ?
 ten          dw 10    
 ten1         db 10
 h            dw 0  
 r            dw ?
 t            db 1  
 two          dw 2    
 NO           dw ?

.code    

  print proc 
    mov ah , 9 
    LEA dx , readNO
    Int 21h 
    ret
  print endp    
  
  read proc
    mov ah , 0AH
    LEA DX , buffer
    INT 21h
    ret
  read endp 
  
  convert_string_to_Number macro
    mov ax , 0
    mov si ,2
    mov dl , buffer[1]
    mov dh , 0
    add dx , 2
    mov h , dx
loop3:cmp si , h
    JNL endloop3
    mov bl , buffer[si]
    SUB bl , 48 
    mov bh , 0
    MUL ten 
    add AX , bx
    inc si
    jmp loop3
endloop3: mov n , ax
  convert_string_to_Number endm   
;-------------------------------------------  
  convert_number_to_string macro
    mov buffer_print[14] , '$' 
    mov buffer_print[13] , ' '
    mov buffer_print[12] , ' '
    mov buffer_print[11] , ' '
    mov buffer_print[10] , ' '
    mov buffer_print[9]  , ' '
    mov si , 8
    mov ax , NO
loop4:cmp ax , 0
    JE endloop4  
    div ten1
    mov buffer_print[si] , ah
    add buffer_print[si] , 48
    cbw 
    dec si
    jmp loop4
endloop4:inc si
    mov ah ,9
    lea dx , buffer_print[si]  
    int 21h
  convert_number_to_string endm  
  ;----------------------------------------
  
  calculate_prime macro
    
    mov bx , 2
loop2:cmp bx , n
    JNL endloop2
    mov t , 1
    mov cx , 2
    mov ax , bx
    CWD
    DIV two
    mov r , ax
loop1:cmp cx , r
    JG endloop1
    mov ax , bx
    CWD
    DIV cx
    cmp dx , 0
    jne endif
    mov t , 0
    jmp endloop1  
endif: INC cx
    jmp loop1  
endloop1: cmp t , 1 
    jne next   
    mov NO , bx
    
  calculate_prime endm
;--------------------------------------------  
  gotoxy  macro
    
    mov ah , 2
    mov dl , 0
    mov dh , 1
    Int 10h
  gotoxy endm

  getch macro
    mov ah ,1
    int 21h
  getch endm
  
  main proc far
    push ds
    push 0
    mov ax , @data
    mov ds , ax
   ;----------------   
    call print
    
    call read  
    
    gotoxy
    
    convert_string_to_Number
   ;----------------
    calculate_prime 
    
    convert_number_to_string 

next:INC bx
    jmp  loop2
    
endloop2:     
    getch
   ret
   main endp
 end main
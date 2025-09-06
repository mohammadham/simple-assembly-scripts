.model small 
.stack 50
.data
  line1  db '*****************************$'
  line2  db '*    Microprocessor Class   *$'
.code
   
   gotoxy macro row , col
    mov ah , 2
    mov dh , row
    mov dl , col
    INT 10h
   gotoxy endm 
   
   print macro buffer
    mov ah , 9
    LEA dx , buffer
    INT 21h
   print endm
   
   getch  macro
    mov ah , 1
    int 21h
   getch endm
  
   main proc far
    push ds
    push 0
    mov ax , @data
    mov ds , ax
   ;------------------
    gotoxy  10 , 26
   ;------------------
    print line1
   ;------------------
    gotoxy 11 , 26
   ;------------------
    print line2
   ;------------------
    gotoxy 12 , 26  
   ;------------------
    print line1
   ;-----------------
    getch
    
    ret
  main endp  
   
  
 
end main
.model small 
.stack 100
.data
  line1  db '*****************************$'
  line2  db '*    Microprocessor Class   *$'
.code
   
   
   
  
   
   getch  proc
    mov ah , 1
    int 21h
    ret
   getch endp
  
   main proc far
    push ds
    push 0
    mov ax , @data
    mov ds , ax
   ;------------------ 
    mov dl , 26
    mov dh , 10
    push dx
    call gotoxy  
   ;------------------ 
    lea ax , line1
    push ax
    call print
   ;------------------
    mov dl , 26
    mov dh , 11
    push dx
    call gotoxy 
   ;------------------
    lea ax , line2
    push ax
    call print
   ;------------------
    mov dl , 26
    mov dh , 12
    push dx
    call gotoxy
   
   ;------------------
    lea ax , line1
    push ax
    call print
   ;-----------------
    call getch
    
    ret
  main endp  
   
  gotoxy proc 
    push bp
    mov bp , sp
    
    mov ah , 2
    mov dx , [BP + 4] 
    INT 10h  
    pop bp
    ret
   gotoxy endp  
   print proc 
    push bp
    mov bp , sp
    
    mov ah , 9
    mov dx , [BP + 4] 
    pop bp
    INT 21h    
    ret
   print endp
 
end main
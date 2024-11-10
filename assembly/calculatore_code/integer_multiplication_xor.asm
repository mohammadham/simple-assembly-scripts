                                   .MODEL SMALL
 .STACK 100H

 .DATA
    
 .CODE
   MAIN PROC
     MOV AX, @DATA                ; initialize DS
     MOV DS, AX        
    
   mov ax , 0dcbah
   mov bx , 0a6h
   mul bx
   push ax
   push dx
   mov ax , 0fe15h
   mul bx
   mov si , ax
   mov di ,dx
   pop dx
   pop ax
   xor ax , si 
   xor dx, di 
  push dx
   
   mov dx , ax 
    
    
    
     
hlt      
     
     
     
  ret   

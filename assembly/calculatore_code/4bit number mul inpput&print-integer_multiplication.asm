                                   .MODEL SMALL
 .STACK 100H

 .DATA  
 RES  DB 10 DUP ('$')
 buffer1 db 7,?,6 dup(0)
buffer2 db 7,?,6 dup(0) 

msg1 db 0Dh,0Ah, " enter any number from -32768 to 65535 inclusive, or zero to stop: $"
 ;binary1 dw ?
; binary2 dw ?  

num dw ?
num2 dw ? 
num3 dd ?
    
 .CODE
   MAIN PROC
     MOV AX, @DATA                ; initialize DS
     MOV DS, AX 
     
     
         
     
     ; print welcome message:
mov dx, offset msg1
mov ah, 9
int 21h

; input string:
mov dx, offset buffer1
mov ah, 0ah
int 21h  
mov num ,0000
mov ah , 00
mov cl , buffer1[1] 
mov ch , 00
mov di ,2h 
mov bx , 10
startlop:  
    mov ax , num
    mul bx  
    mov num , ax
   mov al ,buffer1[di]
   sub al , 30h  
   mov ah , 00
   add num , ax
   inc di 
   loop startlop 
 



; print welcome message:
mov dx, offset msg1
mov ah, 9
int 21h

; input string:
mov dx, offset buffer2
mov ah, 0ah
int 21h 

mov num2 ,0000
mov ah , 00
mov cl , buffer2[1] 
mov ch , 00
mov di ,2h 
mov bx , 10
startlop2:  
    mov ax , num2
    mul bx  
    mov num2 , ax
   mov al ,buffer2[di]
   sub al , 30h  
   mov ah , 00
   add num2, ax
   inc di 
   loop startlop2 
 
      
    
   mov ax , num
   mov bx , num2
   mul bx
    mov num3 , ax 
    mov ax , dx
    mul 10000h
    add num3, ax
    
    
    
    
     
hlt      
     
     
     
  ret   

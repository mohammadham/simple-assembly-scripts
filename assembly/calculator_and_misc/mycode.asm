name "CALCULATOR"
org 100h
jmp start    
include 'emu8086.inc'  
DEFINE_SCAN_NUM
 DEFINE_PRINT_STRING
 DEFINE_GET_STRING
 DEFINE_CLEAR_SCREEN
 DEFINE_PRINT_NUM
 DEFINE_PRINT_NUM_UNS 
 

PRINTSTR MACRO STR
push ax
push dx
MOV AH,09H
LEA DX,STR
INT 21H
pop dx
pop ax
ENDM 



PrtHex     proc near uses ax bx cx

           mov  bx,offset Hex
           mov  cx,04h
HexLoop:   push  ax
           mov  al,ah
           shr  al,04h
           xlatb
           mov  dl,al
           mov  ah,02
           int  21h
           pop  ax
           shl  ax,04h
           loop HexLoop

           ret
PrtHex     endp



msg1 db 'number(1): $'
msg2 db  0dh,0ah ,"operator(+ - * /): $"
msg3 db  0dh,0ah ,"number(2): $"
msg4 db  0dh,0ah , 'result  : $' 
msg5 db  'large number to hex :$'
exitmsg db  0dh,0ah ,'e or E for exit or press any key to continue... ', 0Dh,0Ah, '$'
div_sing db  " / $"
err db  0dh,0ah ,"please enter an operator(+ - * /) or e or E for exit :", 0Dh,0Ah , '$'       
BREAK DB 10, 13,'$'
Hex        db  '0123456789ABCDEF'

opr db '?'


num1 dw ?
num2 dw ?
temp dw ?

start:  
call CLEAR_SCREEN
PRINTSTR MSG1


call scan_num

mov num1, cx 


printstr break


printstr msg2 

operator:

mov ah, 1   
int 21h
mov opr, al



printstr break


cmp opr, 'e'  
je exit
cmp opr, 'E'  
je exit
cmp opr, 2ah  
jb fail
cmp opr, 2fh
ja fail



printstr msg3  


call scan_num


mov num2, cx 




printstr msg4



cmp opr, '+'
je sum1

cmp opr, '-'
je sub1

cmp opr, '*'
je mul1

cmp opr, '/'
je div1

fail:

printstr err   
jmp operator

sum1:


mov ax, num1                                                                                                 
add ax, num2
call print_num    

jmp ex


sub1:

mov ax, num1
sub ax, num2
call print_num    

jmp ex




mul1:
mov dx,0
mov ax, num1
imul num2 
cmp dx , 0
je mul2 

printstr msg5
mov temp , ax
mov ax , dx
call PrtHex 
mov ax , temp
call PrtHex 
 mov  ah,02
 mov  dl,'h'
 int  21h
jmp ex

mul2: 
call print_num   

jmp ex


div1:

mov dx, 0
mov ax, num1
idiv num2 
cmp dx, 0
jnz float
call print_num   
jmp ex

float:   
mov ax, num1
call print_num   

printstr div_sing
mov ax, num2
call print_num   


ex: 

printstr exitmsg 
mov ah, 1  
int 21h

cmp al, 'e'    
je exit
cmp al, 'E'    
je exit
jmp start

exit:

ret

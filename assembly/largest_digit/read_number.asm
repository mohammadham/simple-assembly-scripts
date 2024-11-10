jmp code
 
input_num proc ; a number in ax
   ; mov ah , 0AH
   ; LEA DX , buffer
   ; INT 21h        
   getstr1 buffer
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
                
                
GETSTR1 MACRO STR

LEA SI , STR
MOV DX , SI
MOV AH, 0AH
INT 21H
ENDM  

OUTDEC MACRO
   ; this procedure will display a decimal number
   ; input : AX
   ; output : none

 ;  PUSH BX                        ; push BX onto the STACK
 ;  PUSH CX                        ; push CX onto the STACK
 ;  PUSH DX                        ; push DX onto the STACK

   CMP AX, 0                      ; compare AX with 0
   JGE @START                     ; jump to label @START if AX>=0

   PUSH AX                        ; push AX onto the STACK

   MOV AH, 2                      ; set output function
   MOV DL, "-"                    ; set DL='-'
   INT 21H                        ; print the character

   POP AX                         ; pop a value from STACK into AX

   NEG AX                         ; take 2's complement of AX

   @START:                        ; jump label

   XOR CX, CX                     ; clear CX
   MOV BX, 10                     ; set BX=10

   @OUTPUT:                       ; loop label
     XOR DX, DX                   ; clear DX
     DIV BX                       ; divide AX by BX
     PUSH DX                      ; push DX onto the STACK
     INC CX                       ; increment CX
     OR AX, AX                    ; take OR of Ax with AX
   JNE @OUTPUT                    ; jump to label @OUTPUT if ZF=0

   MOV AH, 2                      ; set output function

   @DISPLAY:                      ; loop label
     POP DX                       ; pop a value from STACK to DX
     OR DL, 30H                   ; convert decimal to ascii code
     INT 21H                      ; print a character
   LOOP @DISPLAY                  ; jump to label @DISPLAY if CX!=0

  ; POP DX                         ; pop a value from STACK into DX
  ; POP CX                         ; pop a value from STACK into CX
  ; POP BX                         ; pop a value from STACK into BX

                            ; return control to the calling procedure
ENDM



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
 

;data
 m1  db 00
 m2  db 00
 m3  db 00  
 
 buffer db 10 dup(?)
 b      dw 00  ;print number
 ten    dw 10   
 a dw  00
 buffer1 db 10, 10  dup(?)    
 h      dw 0   


 

  main proc far
code:

   ;------------------------
   call input_num
   mov m1 ,al
   
   call input_num
   mov m2 ,al 
   mov ah , 00
   mov al , m1  

lab1: 
cmp m2,00
je lab2


div m2
 mov  dl, m2
 mov m1, dl
 mov m2, ah
 mov al , m1
 
 jmp lab1    
    
    
    lab2:
    mov ah , 00
    mov al , m1
    outdec
    hlt
    
    ret
  main endp
  
  
  
end main
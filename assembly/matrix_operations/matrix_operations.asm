  .MODEL SMALL 
;//////////////////////////////////////////////// 
PRINTSTR MACRO STR
push ax
push dx
MOV AH,09H
LEA DX,STR
INT 21H
pop dx
pop ax
ENDM   

;//////////////////////////////////////////////////
GETSTR1 MACRO STR
push si
push dx
push ax
LEA SI , STR
MOV DX , SI
MOV AH, 0AH
INT 21H
pop ax
pop dx
pop si
ENDM 

;//////////////////////////////////////////////


;///////////////////////////////////////////////////////
INPUTNUM MACRO STR	;GIVE 4 DIGIT NUMBER STORE IN AX
PUSHA
PRINTSTR MASS2

MOV AH,1
INT 21H  
cmp al , 0dh
jNe CONTINUE
MOV AX , 00
jmp convert

CONTINUE:
cmp al , 2dh
je manfi

;----------------mosbat

SUB AL,30H
MOV AH,0

ne:
MOV BL,10
MOV BH , 00
MUL BX

MOV Bx,Ax

MOV AH,1
INT 21H
cmp al , 0DH  ;-------newl
je en
cmp al , 0AH  ;-------newl
je en
cmp al , ' ' ;-------space
je en
SUB AL,30H
MOV AH,0
ADD Ax,Bx
jmp ne



en:
MOV AL,BL
MOV BL,10  
MOV AH,0
DIV BL

jmp convert



;------------------ manfi
manfi:  

MOV AH,1
INT 21H
SUB AL,30H
MOV AH,0
MOV BL,10
MUL BL

MOV BX,AX

MOV AH,1
INT 21H 
cmp al , 0DH  ;-------newl
jne ne1
MOV AL,BL
MOV BL,10 
MOV AH,0
DIV BL 

jmp MANFI2
ne1:

SUB AL,30H
MOV AH,0
ADD AX,BX 

MANFI2:
not ax
inc ax

convert: 
;MOV AH,0
MOV STR , AX

POPA 

ENDM
;///////////////////////////////////////////
PRINTSTR1 MACRO STR ; STRING FROM USER

LEA si , STR
ADD si , 2
MOV DX , si 
MOV AH , 09H
INT 21H
ENDM
;//////////////////////////////////////////////
 PRINT_MATRIX MACRO STR , M, N
   ; this procedure will print the elements of a given array
   ; input : SI=offset address of the array ==>STR
   ;       : M= COL && N=ROW
   ; output : none

   PUSHA

   MOV SI , OFFSET STR	
   MOV CX, M                     ; set CX=AX

   @PRINT_ARRAY:                  ; loop label
        MOV BX , N
	@LABEL1:
     MOV AX, [SI]                 ; set AX=AX+[SI] 

     CALL OUTDEC

     MOV AH, 2                    ; set output function
     MOV DL, 20H                  ; set DL=20H
     INT 21H                      ; print a character
     
     ADD SI, 2                    ; set SI=SI+2
     DEC BX
     CMP BX , 0000
     JNE @LABEL1
   LOOP @PRINT_ARRAY              ; jump to label @PRINT_ARRAY while CX!=0

POPA
                              ; return control to the calling procedure
 ENDM 
 ;//////////////////////////////////////////////
 PRINT_MATRIX2 MACRO STR , M, N
   ; this procedure will print the elements of a given array
   ; input : SI=offset address of the array ==>STR
   ;       : M= COL && N=ROW
   ; output : none

   PUSHA

   MOV SI , OFFSET STR	
   MOV CX, M                     ; set CX=AX

   @PRINT_ARRAY1:                  ; loop label
        MOV BX , N
	@LABEL11:
     MOV AX, [SI]                 ; set AX=AX+[SI] 
     MOV DX , 80H
     NEG DX
     CMP AX , DX
     JG GRATER1
     PRINTSTR EP                     ; call the procedure OUTDEC
     JMP PRINTS1
    
     GRATER1:
    
     CALL OUTDEC
   
    PRINTS1: 
     MOV AH, 2                    ; set output function
     MOV DL, 20H                  ; set DL=20H
     INT 21H                      ; print a character
     
     ADD SI, 2                    ; set SI=SI+2
     DEC BX
     CMP BX , 0000
     JNE @LABEL11
   LOOP @PRINT_ARRAY1              ; jump to label @PRINT_ARRAY while CX!=0

POPA
                              ; return control to the calling procedure
ENDM

;//////////////////////////////////////////////
 PRINT_ARRAY MACRO STR , STR2
   ; this procedure will print the elements of a given array
   ; input : SI=offset address of the array ==>STR
   ;       : BX=size of the array ==> STR2
   ; output : none

   PUSHA
   MOV BX, STR2
   MOV SI , OFFSET STR	
   MOV CX, BX                     ; set CX=BX

   @PRINT_ARRAY:                  ; loop label
     MOV AX, [SI]                 ; set AX=AX+[SI]

        CALL OUTDEC                  ; call the procedure OUTDEC

     MOV AH, 2                    ; set output function
     MOV DL, 20H                  ; set DL=20H
     INT 21H                      ; print a character

     ADD SI, 2                    ; set SI=SI+2
   LOOP @PRINT_ARRAY              ; jump to label @PRINT_ARRAY while CX!=0

POPA
                              ; return control to the calling procedure
ENDM

;//////////////////////////////////////////////////////////////////////////////
 CONVERT_CELSIUS_TO_FAHRENHEIT MACRO STR,STR2,STR3
   ; this procedure will read the elements for an array
   ; input : SI=offset address of the array==>STR
   ;    DI=offset address of the array==>STR2
   ;       : BX=size of the array==>STR3
   ; output : none

PUSHA           
MOV CX , STR3
MOV SI , OFFSET STR
MOV DI , OFFSET STR2   

@LOOOPL:
; to this formula: c = (f - 32) * 5 / 9   
MOV AX , 00
mov BX, [SI]
sub BX, 32
mov AX, 5
imul BX 
MOV BX , 00
mov BX, 9
idiv BX 

mov [DI], AX
ADD SI, 2
ADD DI, 2
LOOP @LOOOPL
      



POPA
 ENDM  
 ;//////////////////////////////////////////////////////////////////////////////
 READ_ARRAY MACRO STR,STR2
   ; this procedure will read the elements for an array
   ; input : SI=offset address of the array==>STR
   ;       : BX=size of the array==>STR2
   ; output : none

PUSHA
   MOV SI , OFFSET STR
   MOV CX, STR2                     ; set CX=BX

   @READ_ARRAY:                   ; loop label
    INPUTNUM T                  ; call the procedure INDEC
     MOV AX , T
     MOV [SI], AX                ; set [SI]=AX
     ADD SI, 2                    ; set SI=SI+2
   PRINTSTR BREAK
   ;  MOV DL, 0AH                  ; line feed
   ;  MOV AH, 2                    ; set output function
    ; INT 21H                      ; print a character
   LOOP @READ_ARRAY               ; jump to label @READ_ARRAY while CX!=0

POPA
ENDM

;////////////////////////////////////////////////////




 .STACK 100H

 .DATA 
    ;DONT DELETE
    ;----------------------------------------------------------------------------
    mass db 13,10,"Enter a unsinged number !! ",0DH,0AH,'ENTER NEW NUMBER POSTIVED 0-99 :$'
    MASS2 DB "Enter a singed number (-999 : 999) :$" 
    BREAK DB 10, 13,'$' 
    T    DW 00
    NUMBER db 6 dup('$') 
    ;ARRAY   DW  60 DUP(0)                      
    ;-----------------------------------------------------------------------------
    ;YOUR DATA
    ;==========================================================================
    COL DW 00
    ROW DW 00 
    TOTAL DW 00
    ARRAY   DW  100 DUP(0)
    ARRAY2   DW  100 DUP(0) 
    MASS_AR1 DB "COL:$" 
    MASS_AR2 DB "ROW:$"  
    MASS_AR3 DB "INPUT MATRIX:$" 
    MASS_AR4 DB "CILICUS MATRIX:$" 
    MASS_AR5 DB "FARENHIT MATRIX:$"
    EP DB "E$"
     

    ;==========================================================================

 .CODE
   MAIN PROC
     MOV AX, @DATA                ; initialize DS
     MOV DS, AX
;=====================================================================
    PRINTSTR MASS_AR1
        mov ax,00   ;RETURN NUMBER IN AX
    @lAl2:
    GETSTR1 NUMBER
	mov si , 02   
	mov ax,00 
	cmp NUMBER[si],0DH
	jE  @ERROR1
	cmp NUMBER[si],'-'
	jNE @mosbat1
	@ERROR1:
	PRINTSTR mass
	
	mov ax , 00
	jmp @lAl2
	
	@mosbat1:
	mov bx, 00
	mov bl , NUMBER[si]
	CMP BL , 57
	JG @EX2
	CMP BL , 48
	JL @EX2
	sub bl , 30h
	add ax, bx
	inc si   
	cmp NUMBER[si], 57
	jg @ex2
	cmp NUMBER[si], 48
	jl @ex2
	mov bx , 10
	mul bx
	jmp @mosbat1 
@ex2:  
    MOV COL ,AX
           
    PRINTSTR BREAK
    PRINTSTR MASS_AR2
         mov ax,00   ;RETURN NUMBER IN AX
    @lAl1:
    GETSTR1 NUMBER
	mov si , 02   
	mov ax,00 
	cmp NUMBER[si],0DH
	jE  @ERROR
	cmp NUMBER[si],'-'
	jNE @mosbat
	@ERROR:
	PRINTSTR mass
	
	mov ax , 00
	jmp @lAl1
	
	@mosbat:
	mov bx, 00
	mov bl , NUMBER[si]
	CMP BL , 57
	JG @EX1
	CMP BL , 48
	JL @EX1
	sub bl , 30h
	add ax, bx
	inc si   
	cmp NUMBER[si], 57
	jg @ex1
	cmp NUMBER[si], 48
	jl @ex1 
	mov bx , 10
	mul bx
	jmp @mosbat 
@ex1: 
    MOV ROW ,AX
         
    PRINTSTR BREAK
    MOV AX , COL
    MOV BX , ROW 
    MUL BX
    MOV TOTAL , AX
    PRINTSTR MASS_AR3
    READ_ARRAY ARRAY,TOTAL   
    CONVERT_CELSIUS_TO_FAHRENHEIT ARRAY,ARRAY2,TOTAL
    PRINTSTR BREAK
    PRINTSTR MASS_AR4
    PRINT_MATRIX ARRAY,COL,ROW
    PRINTSTR BREAK 
    PRINTSTR BREAK
    PRINTSTR MASS_AR5
    PRINT_MATRIX2 ARRAY2,COL,ROW
    
HLT
;======================================================================
  

;////////////////////////////////////////////////////
OUTDEC PROC
   ; this procedure will display a decimal number
   ; input : AX
   ; output : none

   PUSH BX                        ; push BX onto the STACK
   PUSH CX                        ; push CX onto the STACK
   PUSH DX                        ; push DX onto the STACK

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

   POP DX                         ; pop a value from STACK into DX
   POP CX                         ; pop a value from STACK into CX
   POP BX                         ; pop a value from STACK into BX

RET                            ; return control to the calling procedure 


OUTDEC ENDP
END MAIN
end
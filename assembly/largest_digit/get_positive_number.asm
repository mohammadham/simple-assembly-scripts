jmp code



GETNUM proc  ;GET POSTIVE NUM 0-99
;PUSHA     
    mov ax,00   ;RETURN NUMBER IN AX
    ll1:
    GETSTR1 NUMBER
	mov si , 02   
	mov ax,00 
	cmp NUMBER[si],0DH
	jE  @ERROR
	cmp NUMBER[si],'-'
	jNE mosbat
	@ERROR:
	PRINTSTR mass
	
	mov ax , 00
	jmp ll1
	
	mosbat:
	mov bx, 00
	mov bl , NUMBER[si]
	CMP BL , 57
	JG EX1
	CMP BL , 48
	JL EX1
	sub bl , 30h
	add ax, bx
	inc si   
	cmp NUMBER[si], 57
	jg ex1
	cmp NUMBER[si], 48
	jl ex1 
	mov bx , 10
	mul bx
	jmp mosbat 
ex1:                                
  ;MOV STR , AX   
; POPA                     
getnum ENDp  


;data

    mass db 13,10,"Enter a unsinged number !! ",0DH,0AH,'ENTER NEW NUMBER POSTIVED 0-255 :$'  
    NUMBER db 6 dup('$')
    a dw 00


code :
 call getnum 
 mov a, ax
 test ax , 00010000
 jnz end
 
 and dx, 10000111
 
 
 
 
 end:
   hlt
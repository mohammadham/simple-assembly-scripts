GETSTR MACRO STR
MOV AH,0AH
LEA DX,STR
INT 21H
ENDM   

GETSTR2 MACRO STR
            lea si, filename
            mov ah, 01h     
    char_input:

            int 21h

            cmp al, 0dh      
            je zero_terminator

            mov [si], al
            inc si

            jmp char_input

    zero_terminator:

            mov byte ptr [si], 0 
            xor si ,si 
            xor ax,ax
            xor dx, dx
ENDM 

GETSTR1 MACRO STR
LEA SI , STR
MOV DX , SI
MOV AH, 0AH
INT 21H
ENDM 

PRINTSTR MACRO STR
MOV AH,09H
LEA DX,STR
INT 21H
ENDM
  
PRINTSTR1 MACRO STR

LEA si , STR
ADD si , 2
MOV DX , si 
MOV AH , 09H
INT 21H

ENDM


stacksg segment para stack 
   sb    db       1024 dup('0')
  
stacksg ends

datasg  segment para common 'data'
    ;/-----------------------------------------------print menu--------     
    p1 db 'Please enter name file:',0DH,0AH,'$'
    
    BREAK DB 10, 13,'$'
    PR_2  DB  'Please enter key saerch : ',0DH,0AH,'$'
    PR_3  DB   0DH,0AH,'The key saerch found in this line:) ',0DH,0AH,'$'
    PR_5  DB  'The key saerch NOT found :( ',0DH,0AH,'$'
  
    PR_7  DB  '=========================================  ',0DH,0AH,'$'
    PR_8  DB  '####****THANKS FOR TIME****####  ',0DH,0AH,'$'
    ;/--------------------------------------------------MAIN DATA---------
    word db 80 dup('$'),'$' ;/word  
    line db 80 dup('$'),'$' ;/line  
    Tline db 280 dup('$'),'$' ;/lineT
    filename db "TEST.TXT" ;/file name
     filehandle  dw ?
     cot dW 00,'$'
     
     TCOUNT DW ? 
     T2COUNT DW 00 
     
     char        db ?
 

    

datasg  ends

codesg  segment para common 'code'
main    proc    far
assume  ds:datasg,cs:codesg,es:datasg  


        MOV AX,dataSG
        MOV DS,AX
        MOV ES,AX
        
        PRINTSTR p1
        getstr2 filename  
        PRINTSTR BREAK
        PRINTSTR pr_2
        getstr word   
        PRINTSTR BREAK
         PRINTSTR PR_7
         PRINTSTR BREAK
        
        
       ;------------------------- open_file:

            lea dx, filename
            mov ax,3d00h
           int 21h

            mov filehandle, ax  
            XOR AX, AX                    
            MOV COT , 30H
                  
            MOV   TCOUNT,1        
       
            
            

           

    read_line: 
    
            lea si, line 
            INC SI
            INC SI 
        
            MOV CX,32h ;tcount
            LOP: 
            MOV [SI],'$'
            INC SI
            LOOP LOP  
      
            
            
            lea si, line 
            INC SI
            INC SI
            MOV   TCOUNT,00
            
            
         READ:
            mov ah, 3Fh     
            mov bx, filehandle
            lea dx, char
            mov cx, 1

            int 21h

            TEST ax, AX       ;EOF
            jZ EO_file

            mov al, char

            cmp al, 0ah     ; line feed
            je LF 
            
            cmp al, 20h     
            je SPAcE
            

            mov [si], al 
       
            inc si 
         
        INC TCOUNT
            

            jmp READ
            
            
    SPAcE:
   
        LEA DI , LINE
        ADD  DI , 2  
        LEA  SI , WORD
        ADD  SI , 2  
        
    
        MOV AL, WORD+1
        DEC TCOUNT       
        MOV CX, TCOUNT  
        CMP AL , CL         
        JNE READ_LINE                    
     
         MOV CH,00
         REPE CMPSB
         JNE READ_LINE          
        JMP PRINT
    
    EO_file:

        LEA DI , LINE
        ADD  DI , 2  
        LEA  SI , WORD
        ADD  SI , 2  
    
        MOV AL, WORD+1     
        MOV CL, LINE+1  
        CMP AL , CL         
        JNE EXIT                    
     
         MOV CH,00
         REPE CMPSB
         JNE EXIT            
         inc t2count
        PRINTSTR pr_3 
        PRINTSTR BREAK
           XOR AX ,AX
             MOV AH , 2
            MOV DX,COT
            INT 21H
            
         JMP EXIT
   EXIT: 
            cmp t2count, 00h
            jne exit_ne 
            PRINTSTR pr_5
            
            
       exit_ne:
       PRINTSTR pr_8     
            mov ah, 4ch
            int 21h

    LF:     
    
        INC COT   
        JMP SPAcE
            jmp read_line  
            
            
    PRINT:    
              PRINTSTR pr_3
              PRINTSTR BREAK
              XOR AX ,AX
             MOV AH , 2
            MOV DX,COT
            INT 21H
          inc t2count  
        PRINTSTR BREAK
        JMP read_line  
        

        
 MAIN ENDP

   
end main
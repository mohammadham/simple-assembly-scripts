


stacksg segment para stack 
   sb    db       80 dup('0')
  
stacksg ends

datasg  segment para common 'data'
  

     word db 80 dup('$'),'$' ;word  
     line db 280 dup('$'),'$' ;line  
     SEARCHKEY db 80 dup('$'),'$' ;SEARCH
     filename db "TEST.TXT" ;file name
     filehandle  dw ?
     COUNT dW 00 ; found or not found
     
     I DW 00 
     J DW 00 
     
     char        db ? 
     
    BREAK DB 10, 13,'$'
    P1  DB  'Please enter key saerch : ',0DH,0AH,'$'
    P2  DB  'NOT Found!! ',0DH,0AH,'$'
 

    

datasg  ends

codesg  segment para common 'code'
main    proc    far
assume  ds:datasg,cs:codesg,es:datasg  


        MOV AX,dataSG
        MOV DS,AX
        MOV ES,AX
        
     
        MOV AH,09H
        LEA DX,P1
        INT 21H
         
        MOV AH,0AH
        LEA DX,SEARCHKEY
        INT 21H   
        MOV AH,09H
        LEA DX,BREAK
        INT 21H 
        MOV AH,09H
        LEA DX,BREAK
        INT 21H 
        
        
       

            lea dx, filename
            mov ax,3d00h         ; open_file
           int 21h
            mov filehandle, ax   
            
            
            XOR AX, AX                    
            XOR SI, SI                    
            XOR DI, DI
            MOV I , 00
            MOV J , 00
            MOV COUNT , 00            
                        
    
            lea si, WORD 
            INC SI
            INC SI 

            
            
            lea Di, line 
            INC DI
            INC DI
            
            
            
         READ:
            mov ah, 3Fh     
            mov bx, filehandle
            lea dx, char
            mov cx, 1

            int 21h 
            
            ; IF 
           

            TEST ax, AX       ;EOT
            jZ ENDTEXT

             mov al, char

            cmp al, 0ah     ; line feed
            je LINEFEED 
            
            cmp al, 20h     ;SPACE    
            je SPACE
            

            mov [si], al 
            mov [Di], al 
            inc si 
            inc Di
            inc i
            inc J
            
       

            jmp READ
            
            
    SPACE:    ;CHEK FOR SEARCH KEY
        
        MOV BP , DI 
        
        
        LEA SI , WORD 
        ADD  SI , 2  
        LEA  DI , SEARCHKEY
        ADD  DI , 2  
        
    
        MOV AL, SEARCHKEY+1       
        
        MOV CX, I  
        CMP AL , CL         
        JNE READ_LINE                    
     
         MOV CH,00
         REPE CMPSB
         JNE READ_LINE
         
           
           
            INC COUNT
            
            
            MOV DI , BP
            MOV al, 20H
            mov [Di], al 
            INC DI
              
            LINELOOP:   ;COMPLET LINE
            mov ah, 3Fh     
            mov bx, filehandle
            lea dx, char
            mov cx, 1

            int 21h 
            
            ; IF

            TEST ax, AX       ;EOF
            jZ READ_LINE22

            mov al, char

            cmp al, 0ah     ; line feed
            je  READ_LINE11
            
             mov [Di], al 
             inc Di
             inc J
           JMP LINELOOP  
             
 
        
         
         READ_LINE:         ; READY FOR LOOP
            LEA SI , WORD
            ADD  SI , 2
            
            INC I
            MOV CX,I
            LOP: 
            MOV [SI],'$'
            INC SI
            LOOP LOP
             
            MOV I ,  00
            
            LEA SI , WORD
            ADD  SI , 2 
            
          MOV DI , BP
          MOV al, 20H
          mov [Di], al 
          INC DI 
            
            
                   
        JMP READ
    
    ENDTEXT:            ;END OF FILE

        LEA SI , WORD
        ADD  SI , 2  
        LEA  DI , SEARCHKEY
        ADD  DI , 2  
        
    
        MOV AL, SEARCHKEY+1       
        MOV CX, I  
        CMP AL , CL         
        JNE READ_LINE2                    
     
         MOV CH,00
         REPE CMPSB
         JNE READ_LINE2
         
  READ_LINE22:                     ;PRINT LINE
        MOV AH,09H 
        LEA DI,LINE
        ADD DI , 2
        MOV DX,DI
        INT 21H   
        MOV AH,09H
        LEA DX,BREAK
        INT 21H  
        
         INC COUNT
         
         READ_LINE2:        ;FOUND OR NOT FOUND

            cmp count, 00h
            jne exit 
            
            MOV AH,09H
            LEA DX,p2
            INT 21H  
             
            MOV AH,09H
            LEA DX,BREAK
            INT 21H  
            
       Exit:     
            mov ah, 4ch
            int 21h

    LINEFEED:       ; BREAK LINE CHEK FOR KEY SEARCH
        
        LEA DI , WORD
        ADD  DI , 2  
        LEA  SI , SEARCHKEY
        ADD  SI , 2  
        
    
        MOV AL, SEARCHKEY+1       
        MOV CX, I  
        CMP AL , CL         
        JNE READ_LINE1                    
     
         MOV CH,00
         REPE CMPSB
         JNE READ_LINE1
  READ_LINE11:   ;PRINT LINE
        
        MOV AH,09H
        LEA DI,LINE
        ADD DI , 2
        MOV DX,DI
        INT 21H   
        MOV AH,09H
        LEA DX,BREAK
        INT 21H  
        
         INC COUNT
         
         READ_LINE1:  ; READY FOR LOOP
         
            LEA SI , WORD
            ADD  SI , 2
            
            INC I
            MOV CX,I
            LOP1: 
            MOV [SI],'$'
            INC SI
            LOOP LOP1
             
            MOV I ,  00 
            
            LEA SI , LINE
            ADD  SI , 2
            
            INC J
            MOV CX,J
            LOP2: 
            MOV [SI],'$'
            INC SI
            LOOP LOP2
             
            MOV J ,  00
            
            LEA SI , WORD
            ADD  SI , 2 
            
            LEA DI , LINE
            ADD  DI , 2
            
                   
        JMP READ
            
            

        
 MAIN ENDP

   
end main
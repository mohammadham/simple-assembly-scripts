.stack
.data
	R db ?
	C db ?
	massage db 13,10,"Enter number for Row and Col(1-9):$"
	massage2 db 13,10,"Enter number for matrix: $"
	massage3 db 13,10,"matrix: $"
	buffer db 100,?,100 dup(0)
.code
main proc
	mov ax, @data
	mov ds,ax	
l:
	mov dx, offset massage
	mov ah,9
	int 21h
	
	lea dx, buffer
	mov ah, 0ah
	int 21h
	mov al, buffer[2]
	sub al, 30h
	mov R, al
	mov al, buffer[4] 
	sub al, 30h
	mov C, al
	
	cmp R, 9
	jg l
	cmp R, 1
	jl l
	cmp C, 9
	jg l
	cmp C, 1
	jl l
	
	mov dx, offset massage2
	mov ah, 9
	int 21h

	mov dx, offset buffer
	mov ah, 0ah
	int 21h  
	
	mov dx, offset massage3
	mov ah, 9
	int 21h
	
	mov cl, buffer[1]
	mov ch,0
	mov si , 2  
	mov bh, R
l2:

l3:	
	mov ah, 2
	mov dl, 10
	int 21h
	mov ah, 2
	mov dl, 13
	int 21h 
	mov bl, C
l4:	
	mov al, buffer[si]
	cmp al, ' '
	je space
	mov ah, 2 
	mov dl,al
	int 21h
	inc si
	dec cx
	cmp cx, 0
	je end
	jmp l4
space:
	mov ah, 2 
	mov dl,al
	int 21h 
	inc si
	dec cx
	cmp cx, 0
	je end
	dec bl
	cmp bl,0
	jne l4 
	dec bh
	cmp bh,0
	jne l3

end:	
	hlt
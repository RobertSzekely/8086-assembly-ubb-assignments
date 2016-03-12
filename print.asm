assume cs:code, ds:data
data segment
	numar db 33h
	i db ?
data ends
code segment
start:
	mov ax, data
	mov ds, ax
	mov si, 1
	mov numar[si], '$'

	mov al,4
    ;or al,30h ;Important! =>Convert Character to Number!
    mov i,al

    MOV AH, 2 ;
    MOV DL, i ; Print Character.
    INT 21H   ;


	mov ax, 4c00h
	int 21h

code ends
end start
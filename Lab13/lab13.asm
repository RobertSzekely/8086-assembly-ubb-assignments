assume cs:code, ds:data
data segment 
	cifra db 31
	tmp db 3 dup (?), 13, 10, '$'
data ends
code segment 
start:
	mov ax, data
	mov ds, ax
	mov al, cifra
	mov ah, 0
	; calculam reprezentarea in baza 10
	mov bx, offset tmp+3  ; bx=adresa ultimei cifre scrise deja
	mov cx, 10	; cx = 10 (constant)
bucla:
	mov dx, 0
	div cx	; dl=cifra curenta, ax=restul numarului
	dec bx
	add dl, '0'
	mov byte ptr [bx], dl
	cmp ax, 0
	jne bucla
; tiparim
	mov dx, bx
	mov ah, 09h
	int 21h



	mov ax, 4C00h
	int 21h
code ends
end start
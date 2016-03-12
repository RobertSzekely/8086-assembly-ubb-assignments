assume cs:code, ds:data
data segment
	mesaj db 'Dati un string', 10, 13, '$'
	maxString db 100
	lString db ?
	s db 100 dup (?)
	mesaj2 db 'Dati un caracter', 10, 13, '$'
	c db ?
	newline db 10, 13, '$'
	counter db 0
	i dw ?
	mesaj3 db 'Caracterul se gaseste de $'
	mesaj4 db ' ori.$'
data ends
code segment
start:
	mov ax, data
	mov ds, ax

	;afisam mesaj
	mov ah, 09h
	mov dx, offset mesaj
	int 21h
	;citim string
	mov ah, 0ah
	mov dx, offset maxString
	int 21h
	;transformam stringul citit in ASCIIZ
	mov al, lString
	xor ah, ah
	mov si, ax
	mov s[si], 0
	;new line 
	mov ah, 09h
	mov dx, offset newline
	int 21h
	;afisam al 2lea mesaj
	mov ah, 09h
	mov dx, offset mesaj2
	int 21h
	;citim un caracter
	mov ah, 01h
	int 21h
	mov c, al

	;loop
	mov si,0
	mov dl, lString
	cbw
	repeta:
		mov al, s[si]
		cmp al, c
		je incrementeaza
		continua:
			inc si
			cmp si, dx
			jb repeta
	jmp afiseaza

	incrementeaza:
		inc counter
		jmp continua


	afiseaza:
		mov ah, 09h
		mov dx, offset newline
		int 21h
		
		mov ah, 09h
		mov dx, offset mesaj3
		int 21h
		
		mov dl, counter
		add dl, '0'
		mov ah, 02h
		int 21h

		mov ah, 09h
		mov dx, offset mesaj4
		int 21h

	
	mov ax, 4c00h
	int 21h

code ends
end start
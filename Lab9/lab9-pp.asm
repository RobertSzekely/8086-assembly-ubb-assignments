;8. Sa se afiseze, pentru fiecare numar de la 32 la 126, valoarea numarului (in baza 10) si caracterul cu acel cod ASCII. 
assume cs:code, ds:data

data segment public
	cifra db 31
data ends

code segment public
extrn	tipar:proc
start:
	mov ax, data
	mov ds, ax

	bucla:
		inc cifra
		cmp cifra, 127
		je final
		mov al, cifra
		mov ah, 0
		call tipar
	jmp bucla
	final:
	mov ax, 4C00h
	int 21h
code ends
end start
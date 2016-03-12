assume cs:code, ds:data
data segment
	s db 1, 2, 3, 4, 5, 6
	l equ $-s
	d db l-1 dup(?)
data ends
code segment
start:
	mov ax,data
	mov ds,ax
	mov cx,l
	mov si,0
	mov di,1
	jcxz sfarsit
	repeta:
		mov al, s[si]
		add al, s[di]
		mov d[si], al
		inc di
		inc si
		
		loop repeta
		
	sfarsit:
		mov ax, 4c00h
		int 21h
code ends
end start
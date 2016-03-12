assume cs:code, ds:data
data segment
	b1 db 2, 3 dup(2)
	b2 dw 1, 2, 3
	len equ $-b2
	b3 dd b2 + 7
	b4 dw b3
	;a dw 'abcde'    ;**Error** Value out of range
	a1 db '24','68'
	a2 dw '24','68'
	a3 db 2,4,6,8
	;a db shl ax,1   ;**Error** Undefined symbol shl
	;a4 db a2        ;**Error** Expecting scalar type
	a5 dw 2,4,6,8
	;a6 db 2468h     ;**Error** Value out of range
	a7 dw a3+2
	;b db 1,3
	a8 db 2 and 0010b
	a9 db 5 eq 5
	;b1 db 10 and 10
	;b2 db 5 gt 4
	;b3 db 5 lt 3 
	a10 dw 24h, 68h
	a11 dd 02040608h
	a12 dd a3
	a13 db 24h, 68h
	a14 dw 2468h
	beta dw ?
	divisor db 1
data ends
code segment
start:
	mov ax,data
	mov ds,ax

	mov ax, 01h 
	mov cl, 1
	shr ax

	mov ax, len
	mov ax, -1
	;shl ax, 1
	;shl ax, 2
	;mov cl, 5
	;shl ax, cl
	shl ax, 15
	shl ax, 1
	shl ax, 1
	;shl ax, 33
	;shl ax, al
	mov ax, -1
	add ax, 2
	adc beta, ax
	mov ax,84h
	div divisor
	idiv divisor

	mov ax,132
	cbw
	cwd
	xor ah,ah
	stc
	adc ah,0
	imul ah
	
	mov ah,7ch
	imul ah
	
	mov ax,0180h
	imul ah
	
	mov ax,0180h
	mul ah
	
	mov ax,0179h
	mul ah
	
	mov ax,0179h
	imul ah
	
	mov ch,10b-01h
	clc
	div ch

	mov ax,01CCh
	mul ah

	mov ax,01CCh
	imul ah

	mov ax,0280h
	mul ah

	mov ax,0280h
	imul ah

	mov ax, 7c84h
	mul ah

	mov ax, 7c84h
	imul ah

	mov ax, 0a84h
	mul ah

	mov ax,0a84h
	imul ah

	mov ax,4c00h
	int 21h
code ends
end start

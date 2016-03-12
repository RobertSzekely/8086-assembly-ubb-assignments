;14. 

assume ds:data,cs:code
data segment
	sir1 db 1,2,3,4,5             ;primul sir
	len1 equ $ - sir1             ;dimensiunea primului sir
	sir2 db 2,4,5,6,1,9,8,8,4,2   ;al doilea sir
	len2 equ $ - sir2             ;dimensiunea celui de-al doilea sir
	sir3 db 20 dup(?)             ;rezultatul
	
data ends

code segment
start:
	;incarcare registri cu adresele necesare
	mov ax,data
	mov ds,ax	
	
	mov es,ax
	mov bx,len1
	cmp bx,len2			;compar lungimile celor doua siruri initiale
	mov bx,len2
	jg maimare
	jl maimic
	
	maimare:
		mov cx,len2		;vom parcurge elementele sirului intr-o bucla loop cu len2 iteratii.
		mov dx,len1
		jmp cont	
	maimic:
		mov cx,len1		;vom parcurge elementele sirului intr-o bucla loop cu len1 iteratii.
		mov dx,len2
		jmp cont
	
	cont:
	push cx             ;salvare cx
	push dx             ;salvare dx
	mov di, offset sir3	
	mov si, offset sir2
	push si             ;salvare si
	
	mov si,offset sir1
	push si             ;salvare si
	cld					;parcurgem sirul de la stanga la dreapta (DF=0).    
	repeta:
		pop si
		lodsb			
		mov ah,al
		pop bx
		push si
		mov si,bx
		lodsb
		push si     	;salvare si
		cmp al,ah		;gasesc elementul de rang maxim
		jg prim
		jl doi
		prim:
			stosb
			jmp dep
		doi:
			mov al,ah
			stosb
		dep:
		loop repeta	
	pop ax    ;refacere ax
	pop ax    ;refacere ax
	pop ax    ;refacere ax
	pop cx    ;refacere cx
	sub ax,cx
	mov cx,ax
	mov dl,2
	div dl
	cmp ah,0
	je par
	jmp impar
	par:
		mov ax,cx
		mov dl,2
		div dl
		cmp ah,0
		je pun_unu
		jmp pun_zero
		pun_zero:
			mov al,'0'
			stosb
			jmp exitt
		pun_unu:
			mov al,'1'
			stosb
		exitt:
		loop par
		jmp sf
	impar:
		mov ax,cx
		mov dl,2
		div dl
		cmp ah,0
		je pun_zeroo
		jmp pun_unuu
		pun_zeroo:
			mov al,'0'
			stosb
			jmp exittt
		pun_unuu:
			mov al,'1'
			stosb
		exittt:
		loop impar
	sf:

	mov ax,4C00h
	int 21h
code ends
end start

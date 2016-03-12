;Se da un sir de cuvinte. Sa se construiasca doua siruri de octeti, s1 si s2, astfel: pentru fiecare cuvant, 
;- daca numarul de biti 1 din octetul high al cuvantului este mai mare decat numarul de biti 1 din octetul low, atunci s1 va contine octetul high, iar s2 octetul low al cuvantului 
;- daca numarul de biti 1 din cei doi octeti ai cuvantului sunt egali, atunci s1 va contine numarul de biti 1 din octet, iar s2 valoarea 0 
;- altfel, s1 va contine octetul low, iar s2 octetul high al cuvantului.

assume cs:code, ds:data
data segment
	sir dw 1111000100100111b, 48bfh, 1251h, 0ffffh 
	;           F127h            
	;sir dw 0101h, 0f0fh
	len equ ($-sir)/2
	;s1 db len dup(?)
	s1 db len dup (?)
	s2 db len dup (?)
	nobitslow db ?
	nobitshigh db ?
	a dw ?
data ends
code segment
start:
	mov ax,data
	mov ds,ax
	mov es,ax

	cld ;parcurgem de la stanga la dreapta
	mov si, offset sir
	mov cx,len
	mov di, offset s2 
	push di        ;la baza stivei am offset s2
	mov di, offset s1 
	push di        ;in varful stivei am offset s1
	;-----------------------------------------------------------------
	repeta: 
		lodsw        ;ax =1111 0001 0010 0111
		mov dh, ah   ;salvez partea high in dh
		mov dl, al   ;salvez partea low in dl
		mov di, 0    ;folosesc di pe post de counter
		jmp lowbyte
		
		continuareloop:
			mov nobitslow,0
			mov nobitshigh,0
		    loop repeta
	;-----------------------------------------------------------------
	jmp sfarsit ;dupa ce termin de executat loop, se termina programul
	;-----------------------------------------------------------------
	
	lowbyte:
		shr dl,1     ;shiftez pt a calcula bitii de 1
		adc nobitslow,0     ;adun bitul din CF
		inc di       ;incrementez di 
		cmp di,8h    ;repet procesul de 8 ori (8bits)
		jb lowbyte
	;----------------------------------------------------------------
	mov di, 0  ;folosesc di pe post de counter
	
	highbyte:
		shr dh,1     
		adc nobitshigh,0          ;------''-------
		inc di
		cmp di,8h
		jb highbyte
	;---------------------------------------------------------------

	push cx  ;salvez cx pt a ma putea folosi de registru
	mov cl, nobitshigh
	mov bl, nobitslow
	cmp cl, bl     ;cl=nr biti highbyte  bl=nr biti lowbyte
	
	je equal       ;nr egal de biti 1
	ja highgtlow   ;no bits 1 highbyte > no bits 1 lowbyte
	
	;altfel ---------------------------------------------------------
	pop cx   ;restaurez valoarea din cx
	pop di  ;offsetul lui s1
	stosb   ;s1 va contile partea low a cuvantului
	mov bx,di ; mut temporar di in bx
	
	pop di  ;offsetul lui s2
	mov al,ah
	stosb   ;s2 va contine partea high a cuvantului
	
	push di ;salvez offsetul s2 la baza stivei
	push bx ;salvez offsetul s1 in varful stivei

	jmp continuareloop
    ;----------------------------------------------------------------
	equal:    ; nr egal de biti 1
		pop cx   ;restaurez valoarea din cx
		pop di    ;s1 va contine numar de biti 1
		mov al, nobitslow ;este stocat nr de biti 1
		stosb
		mov bx,di ;mut di, in bx pt a salva pe stiva mai tarziu
		
		pop di    ;s2 va contine valoare 0
		mov al,0
		stosb

		push di ;salvez offsetul s2 la baza stivei
		push bx ;salvez offsetul s1 in varful stivei
		jmp continuareloop
    ;----------------------------------------------------------------
	highgtlow: 
		pop cx   ;restaurez valoarea din cx
		pop di  ;s1 va contine octetul high 
		;push dx
		;mov a, dx
		mov dl,al ;salvez octetul low pentru s2
		
		mov al,ah ;pun octetul high in s1
		stosb
		mov bx,di ;mut di in bx pt a salva pe stiva mai tarziu

		pop di    ;s2 va contine octetul low
		mov al,dl ;care era salvat in dl
		stosb
		;pop dx
		;mov dx, a

		push di   ;offset s2 la baza stivei
		push bx   ;offset s1 in varful stivei
		jmp continuareloop
	;----------------------------------------------------------------
	sfarsit:
		mov ax,4c00h
		int 21h
code ends
end start
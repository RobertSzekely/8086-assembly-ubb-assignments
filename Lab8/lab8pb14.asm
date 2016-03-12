;14. Sa se citeasca de la tastatura un cuvant si un nume de fisier. Sa se afiseze daca cuvantul exista sau nu in fisierul dat.

assume cs:code, ds:data
data segment
	msg1 db 'Numele fisierului: ', 13, 10, '$'
	maxFileName db 12
	lFileName db ?
	filename db 12 dup (?)
	msg2 db 'Introduceti cuvantul:', 13, 10, '$'
	maxCuvLen db 12
	lCuv db ?
	cuv db 12 dup (?)
	randNou db 13, 10, '$'
	openErrorMessage db 'Eroare la deschiderea fisierului!$'
	buffer db 50 dup (?)
	nuAFostGasit db 'Cuvantul nu a fost gasit in fisier.$'
	gasit db 'Cuvantul a fost gasit.$'
	lCuvWord dw ?

data ends
code segment
start:
	mov ax, data
	mov ds, ax

	;afisez mesajul "Numele fisierului: "
	mov ah, 09h
	mov dx, offset msg1 ; dx - pointer la sir
	int 21h
	;citim de la tastatura numele fisierului
	mov ah, 0ah
	mov dx, offset maxFileName
	int 21h
	;in urma citirii la adresa maxFileName + 2 = fileName se memoreaza numele fisierului citit
	;la adresa maxFileName + 1 = lFileName se memoreaza dimensiunea sirului de caractere care reprezinta numele fisierului
    mov ah, 09h
	mov dx, offset randNou ; dx - pointer la sir
	int 21h

   ;afisez mesajul "Introduceti cuvantul: "
	mov ah, 09h
	mov dx, offset msg2
	int 21h
	;citim de la tastatura cuvantul
	mov ah, 0ah
	mov dx, offset maxCuvLen
	int 21h

	mov ah, 09h
	mov dx, offset randNou ; dx - pointer la sir
	int 21h
	

    ;transformam numele fisierului intr-un sir ASCIIZ (sir ce se termina cu byte-ul zero)
	mov al, lFileName
	xor ah, ah
	mov si, ax
	mov fileName[si], 0

	;in urma citirii la adresa maxFileName + 2 = fileName se memoreaza numele fisierului citit
	;la adresa maxFileName + 1 = lFileName se memoreaza dimensiunea sirului de caractere care reprezinta numele fisierului
	; deschidem fisierul cu functia 3dh, int 21h
	mov ah, 3dh
	mov al, 0 ; deschidem fisierul pentru citire
	mov dx, offset fileName
	int 21h

	jc openError ; eroare la deschiderea fisierului daca CF e setat
	
	;formez bufferul cu continutul fisierului 
    mov ah,3fh
    mov cx,50    ; numar de octeti de citit
    mov dx,offset buffer  ;adresa buffer
    mov bx,ax  ; in ax este numarul de octeti cititi
    int 21h
	
	;verific daca cuvantul e in buffer
    mov si,0
    mov di,0
    mov cl,lFileName      
    bucla:
        mov ah,cuv[si]
        cmp ah,buffer[di]
        je bucla_egal
        inc di 
        cmp cx, di
        je nueste
        jmp bucla
        
        bucla_egal:
            inc si
            inc di
            push ax
            mov al, lCuv
            xor ah,ah
            cmp si, ax
            pop ax
            je este
            jmp bucla
        
        nueste:
            mov ah,09h
            mov dx,offset nuAFostGasit
            int 21h
            jmp endPrg
        
        este:
            mov ah,09h
            mov dx,offset gasit
            int 21h
            jmp endPrg          
	
	openError: 
		mov ah, 09h
		mov dx, offset openErrorMessage
		int 21h
		jmp endPrg


	endPrg:
		mov ax, 4c00h
		int 21h
code ends
end start
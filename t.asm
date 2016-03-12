assume cs:code, ds:data
data segment
	;s dw 7, 5, 2
	;x dw $
	a db -15, 4, -128, 2, 199, -1
	b dw 0ff52h
	c dd 3
	;d db a
	e dd b
	f dw c
	;g db a+2
	sir dw 0FFh, 0FEh, 0FDh, 0FCh, 0FBh, 0FAh
data ends
code segment
start:
 	mov ax, data
 	mov ds, ax

 	mov si, 1
 	mov bx, 1
 	;segmentul de date unde este sirul ar arata asa
 	;|  FF | 00  |  FE | 00  |  FD | 00  |  FC | 00  | FB | 00 | FA |00
 	;|sir+0|sir+1|sir+2|sir+3|sir+4|sir+5|sir+6|sir+7| ...etc.
 	
 	mov ax, sir [si] 
 	;incarca in ax, BYTE-ul de la adresa sir+1, adica 00FE,
 	;doar ca in ax se aplica big endien si atunci apare inversat AX = FE00

 	mov ax, sir [si+1]
 	;echivalent cu mov ax, sir [si][1]
 	          ;sau mov ax, sir [si]+1
 	          ;sau mov ax, sir 1 + [si]
 	          ;sau mov ax, sir [1 + si]
 	          ;practic [ ] sunt exchivalente cu +

 	mov ax, sir [si][bx]
 	mov ax, sir [bx]+[si]
 	;echivalent cu mov ax, sir [si]+[bx]
 	          ;sau mov ax, sir [bx][si]
 	          ;sau mov ax, sir [bx]+[si]
 	mov ax, sir [si][bx][4]
 	mov ax, sir [bx]+4
 	mov bx, 1
 	lea ax, [bx]
 	mov si, ax
 	mov al, [si]
 	mov si, ax
 	lodsb
 	les bx, c 
 	mov cx, [bx]
 	xor ch, ch

 	dinnou:
 		dec ax
 		xor cx, 0
 		loop dinnou
 	

 	mov ax, 4c00h
 	int 21h
code ends
end start
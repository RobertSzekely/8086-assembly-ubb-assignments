;9. Se de cuvantul A si octetul B. Sa se obtina octetul C astfel:
;- bitii 0-3 ai lui C coincid cu bitii 6-9 ai lui A
;- bitii 4-5 ai lui C au valoatrea 1
;- bitii 6-7 ai lui C coincid cu bitii 1-2 ai lui B

assume cs:code, ds: data
data segment
	a dw 0000001111000000b
	b db 00000110b
	c db ?
data ends
code segment
start:
	mov ax,data
	mov ds,ax
	
	;mov bl,0; in bx vom calcula rezultatul
	mov bl,0
	
	mov ax,a
	and ax,0000001111000000b ;izolam bitii 6-9 al alui a
	mov cl,6
	ror ax,cl ;rotim  6 pozitii spre dreapta
	or bl,al ;punem bitii |a9|a8|a7|a6| in rezultat |c3|c2|c1|c0|
	
	or bl, 00110000b ; facem bitii 4-5 sa aiba valoarea 1 |c5|c4|
	
	mov al,b
	and al, 00000110b ;izolam bitii 1-2 al lui B
	mov cl, 5
	rol al,cl ; rotim 5 pozitii spre stanga
	or bl, al ; punem bitii |b2|b1| in rezultat |c7|c6|
	
	mov c, bl
	
	mov ax, 4C00h
	int 21h
code ends
end start

	
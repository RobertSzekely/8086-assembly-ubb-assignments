assume cs:code,ds:data

data segment
mesf db 10,13,'da nume de fisier: $'
nu db 10,13,'cuvantul nu se afla in fisier $'
da db 10,13,'cuvantul se afla in fisier $' 
mes2 db 10,13,'da cuvant $'
lmax db 13
l db ?
nume db 13 dup(?),' $'
dm dw $-offset nume
lm db 13
ll db ?
cuvant db 13 dup(?),' $'
buff db 20 dup(?),' $'
er db 10,13,'eroare $'
c dw ?
data ends

code segment
start:
mov ax,data
mov ds,ax

mov ah,09h
mov dx,offset mesf
int 21h

mov ah,0ah
mov dx,offset lmax
int 21h

mov al,l
mov ah,0
mov si,ax
mov nume[si],0

mov ah,09h
mov dx,offset mes2
int 21h

mov ah,0ah
mov dx,offset lm 
int 21h

mov al,ll
mov ah,0
mov si,ax
mov cuvant[si],0
mov c,si

mov ah,3dh
mov dx,offset nume
mov al,0
int 21h
mov bx,ax
jc eroare1

mov ah,3fh
mov cx,20
mov dx,offset buff
int 21h

mov si,0
mov di,0
mov bx,c

repeta:
 mov ah,cuvant[si]
 cmp ah,buff[di]
 je cont
 ;mov si,0
 inc di
 cmp di,dm
 je sfb
 jb repeta

cont:
 inc si
 inc di
 cmp si,bx
 je gasit
 mov ah,cuvant[si]
 cmp ah,buff[di]
 je cont
 mov si,0 
 jmp repeta

sfb:
 mov ah,3fh
 mov cx,20
 mov dx,offset buff
 int 21h
 cmp ax,0
je sfbu
jmp repeta

gasit:
mov ah,09h
mov dx,offset da
int 21h
jmp sf

sfbu:
mov ah,09h
mov dx,offset nu
int 21h
jmp sf

eroare1:
mov ah,09h
mov dx,offset er
int 21h
jmp sf
sf:
mov ax,4c00h
int 21h
code ends
end start
  
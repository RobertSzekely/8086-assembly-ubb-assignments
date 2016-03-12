;9. (a-b+c*128)/(a+b)+e
;a,b-byte; c-word; e-doubleword

assume cs:code, ds:data
data segment
  a db 1
  b db 2
  c dw 1 
  e dd 1 
  v db 128
  x dw ?
  
data ends
code segment
start:
  mov ax,data
  mov ds,ax
  
  mov al, a
  add al, b
  cbw ; ax = a+b
  mov x, ax ; x=a+b
  
  mov ax,c 
  imul v ;dx:ax = c*128
  mov cx, ax
  mov bx, dx ;bx:cx = c*128
  
  mov al, a
  sub al, b ; al=a-b
  cbw ; ax = a-b
  cwd ; dx:ax = a-b 
  add ax, cx
  adc dx, bx ; bx:cx = a-b+c*128
  
  idiv x ;ax
  cwd
  add ax, word ptr e
  adc dx, word ptr e+2
   
  
  
  mov ax,4c00h
  int 21h
code ends
end start
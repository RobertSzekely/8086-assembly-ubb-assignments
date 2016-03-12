;N+M+(2P-3N)+2M
assume cs:code, ds:data
data segment
  n dw 10
  m db 1
  p db 1 
  two db 2
  three db 3
  a dw ?
  b dw ?
  c dw ?
  rez dd ?
data ends
code segment
start:
  mov ax,data
  mov ds, ax
  
  mov al,p
  mul two
  mov a, ax ;a = 2P
  
  mov ax, n
  mul three ;ax:dx 
  mov word ptr rez, ax
  mov word ptr rez+2,dx
  
  
  
  
  mov ax, 4c00h
  int 21h
code ends
end start
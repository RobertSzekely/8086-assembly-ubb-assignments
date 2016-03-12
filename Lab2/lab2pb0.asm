; (N+M-P)-(P-M), N [0,300]  M[-5,15]  P[10,2000]

assume cs:code, ds:data
data segment
  n dw 100
  m db -5
  p dw 10
  x dw ?
  y dw ?
  r dw ?
data ends
code segment
start:
  mov ax,data
  mov ds,ax
  
  mov al, m
  cbw ;in ax we have the value of m 
  ;mov ah,0
  add ax, n ;ax = m+n
  sub ax, p ;ax = m+n-p
  mov x,ax  ;x = m+n-p
  
  mov al, m
  cbw 
  ;mov ah,0
  mov y, ax ;in y we have the value of m
  mov ax,p  ; p = m
  sub ax,y ;ax = p-m
  mov y, ax ;y=p-m
  
  mov ax, x ;ax = m+m-p
  sub ax, y ;ax = (m+m-p)-(p-m)
  
  mov r, ax ;the final result is stored in r
  
  mov ax, 4c00h
  int 21h
code ends
end start
  
  
  
  
  
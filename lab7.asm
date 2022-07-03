.MODEL small         
.Stack 100h           
datas segment             
  a   dw 45
  b   dw 45
  two dw 2
  eight dw 8
  nine dw 9
  g   dw ?
  mess db 'Error! Devision by zero.$'
datas ends   
              
codes segment               
assume cs:codes, ds:datas         
Begin:                 
  mov   ax, datas             
  mov   ds,ax             
  mov ax, a
  mov bx, b
  cmp ax, bx
  jg first
  je second
  jl third
first:
  ;a/b + 2 a>b
  xor ax, ax
  mov ax, b
  cmp ax, 0
  je @err
  xor ax, ax
  mov ax, a
  cwd
  idiv b 
  adc ax, two 
  mov g, ax
  jmp @@end
second:
  mov ax, eight
  mov g, ax
  jmp @@end
third:
; (b-9)/a a<b
  xor ax, ax
  mov ax, a
  cmp ax, 0
  je @err
  xor ax, ax
  mov ax, b
  sub ax, nine
  cwd
  idiv a
  mov g, ax
  jmp @@end
  
@@end:
  xor   ax,ax           
  mov   ax,g           
  push   ax             
  cmp   ax, 0           
  jns   @plus             
  mov   ah, 02h             
  mov   dl, '-'
  int   21h
  pop   ax             
  neg   ax             
  @plus:
  xor   cx, cx             
  mov   bx,10               
  @dvsn:
  xor   dx,dx             
  div   bx               
  push   dx           

  inc   cx           
  test   ax,ax             
  jnz   @dvsn             
  mov   ah,02h             
  @vivod: 
  pop   dx               
  add   dl, 30h           
  int   21h
  loop   @vivod
  jmp @end 
  @err: 
  mov dx, offset mess 
  mov ah, 09h
  int 21h
  @end:  
  mov   ax,4c00h 
  int   21h
  codes   ends             
end Begin
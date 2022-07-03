
.MODEL small         
.Stack 100h           
datas segment             
  a   dw 8
  b   dw -8
  one dw 1
  fifteen dw -15
  four dw 4
  k   dw ?
  l   dw ?
  g   dw ?
  zm   dw ?
  mess db 'Error! Devision by zero.$'
datas ends   
              
codes segment               
assume cs:codes, ds:datas         
Begin:    
;(-15*a + b - a/4)/(b*a-1)               
  mov   ax, datas             
  mov   ds,ax             
  mov ax, b
  cwd
  imul a ; ax = b*a
  cmp ax, 1
  je @err
  sbb ax, one
  mov zm, ax ; zm = b*a-1
  
  mov ax, a ; ax = a
  cwd
  imul fifteen ; ax = -15*a
  adc ax, b ; ax = -15*a+b
  mov k, ax ; k = -15*a+b
  mov ax, a
  cwd
  idiv four ; ax = a/4
  mov l, ax ; l = a/4
  mov ax, k ; ax = -15*a+b
  sbb ax, l ; ax = -15*a+b-a/4
  cwd
  idiv zm 
  mov g, ax
  
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
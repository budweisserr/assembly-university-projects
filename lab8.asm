dataen Macro
	mov ax, @data
	mov ds, ax
endm

printMessage Macro
	mov ah, 9h
	mov dx, offset mes 
	int 21h
endm

printMatrix Macro
	local @column, @row
	xor ax, ax
	mov ax, row
	mov counter, ax
	@row:
		mov cx, column
		xor si, si
		@column:
			mov ax, array[bx][si]
			printNum 
			add si, 2
		loop @column
		mov ah, 9h
		mov dx, offset cr_lf
		int 21h
		add bx, row
		add bx, row
		mov cx, counter
		dec counter
	loop @row
	int 21h
endm

printNum Macro 
	local @plus, @push, @print
	push bx
	cmp ax, 0
	jns @plus
	push ax
	mov dl, "-"
	mov ah, 2h
	int 21h
	pop ax
	neg ax
	@plus:
		push cx
		xor cx, cx
		mov bx, 10
		@push:
			xor dx, dx
			div bx
			push dx
			inc cx
			test ax, ax
			jnz @push
		mov ah, 2h
		@print:
			pop dx
			add dx, 30h
			int 21h
			loop @print
	mov dl, " "
	int 21h
	pop cx
	pop bx
endm

findMax Macro
	local @@column, @@row
	xor ax, ax
	xor bx, bx
	xor si, si
	mov ax, array[bx][si]
	mov max, ax
	mov ax, row
	mov counter, ax
	@@row:
		mov cx, column
		xor si, si
		@@column:
			mov ax, array[bx][si]
			isMax
			add si, 2
		loop @@column
		add bx, row
		add bx, row
		mov cx, counter
		dec counter
	loop @@row
endm 

isMax Macro
	local @maxim, @skiup
	push bx
	mov bx, max
	cmp bx, ax
	jl @maxim
	jmp @skiup
	@maxim:
		mov max, ax
	@skiup:
		pop bx
endm

printMax Macro
	mov ah, 9h
	mov dx, offset mes2
	int 21h
	xor ax, ax
	mov ax, max
	printNum
endm

exit Macro
	mov ax, 4c00h
	int 21h
endm

.MODEL small         
.Stack 100h           
.data
  column dw 5
  row dw 5
  cr_lf db 0dh, 0ah, "$"
  counter dw ?
  max dw ?  
  mes db "Matrix:", 0dh, 0ah, "$"
  mes2 db "Max number:", 0dh, 0ah, "$"
  array dw 43, 56, 12, 14, 90, 23, 84, 68, 23, 64, 78, 43, 16, 78, 43, 90, 69, 54, 56, 34, 54, 86, 98, 42, 62
  
.code
  start:
	dataen
	printMessage
	printMatrix
	findMax
	printMax
    exit
  end start
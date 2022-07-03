.model small
.stack 100h
Datas segment
	String db "97154823"
	CR_LF db 0dh, 0ah, '$'
Datas ends

Codes segment
Assume cs:Codes, ds:Datas

First:
	mov ax, Datas
	mov ds, ax
	mov ah, 40h
	mov bx, 1
	mov cx, 8
	lea dx, String
	int 21h
	mov ah, 9h
	mov dx, offset CR_LF
	int 21h
	mov al, String+2 
	xchg string, al 
	xchg string+7, al 
	xchg string+2, al 
	mov al, string+6 
	xchg string+1, al 
	xchg string+5, al 
	xchg string+6, al
	mov al, string+3 
	xchg string+4, al
	xchg string+3, al
	mov bx, 1
	mov cx, 8
	lea dx, String
	int 21h
	mov ah, 4ch
	int 21h
Codes ends
	end First

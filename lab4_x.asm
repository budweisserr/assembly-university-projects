.model small
.stack 100h

.data
message db "Hello World!", 0Dh, 0Ah, '$'

.code
start:
mov ax, @data
mov ds, ax
mov ah,09h
mov dx, offset message
int 21h
mov ax, 4c00h
int 21h
end start
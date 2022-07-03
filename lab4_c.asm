.model tiny
.code
org 100h
start:
mov ah,09h
mov dx, offset message
int 21h
ret
message db "Hello World!", 0Dh, 0Ah, '$'
end start
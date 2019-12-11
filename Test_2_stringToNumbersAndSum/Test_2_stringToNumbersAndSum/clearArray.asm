includelib Irvine32.lib
include irvine32.inc
include change.inc

.code
clearArray PROC
push ebp
mov ebp, esp
mov esi, [ebp+8]	; offset of changeNum
mov ecx, [ebp+12]	; size of changeNum (maxNumbersNum)
mov ebx, 0			; for clearing

clear:
	mov [esi], ebx
	add esi, 4
loop clear

mov esp, ebp
pop ebp
ret 8
clearArray ENDP
END
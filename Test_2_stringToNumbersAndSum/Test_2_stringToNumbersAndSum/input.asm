includelib Irvine32.lib
include irvine32.inc
include change.inc

.code
inputArray PROC
push ebp
mov ebp, esp
mov edx, [ebp+8]		; offset of originString
mov ecx, [ebp+12]		; maxStringNum

call ReadString

mov esp, ebp
pop ebp
ret 8
inputArray ENDP
END
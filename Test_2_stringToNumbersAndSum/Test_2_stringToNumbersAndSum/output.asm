include irvine32.inc
include change.inc

.code
outputAns PROC
push ebp
mov ebp, esp
mov esi, [ebp+8]	; offset of changeNum
mov ecx, [ebp+12]	; numbers in changeNum
mov eax, 0			; clear output number

cmp ecx, 0			
je positive			; output 0 if no numbers in changeNum

whileStart:
	add eax, sdword ptr [esi]
	add esi, 4	
loop whileStart

cmp eax, 0			; check whether output is positive
jge positive		
call WriteInt
jmp outP

positive:
	call WriteDec

outP:
	call Crlf

mov esp, ebp
pop ebp
ret 8
outputAns ENDP
END
includelib Irvine32.lib
include irvine32.inc
include change.inc

.code
changeString PROC

totalNum EQU dword ptr [ebp-4]		; count how many numbers are there in this string
flag EQU dword ptr [ebp-8]			; record whether the number is negative
digitFlag EQU dword ptr [ebp-12]	; record whether a number exits before space

push ebp
mov ebp, esp
mov esi, [ebp + 8]					; offset of changeNum
mov ebx, [ebp + 12]					; offset of originString
mov ecx, [ebp + 16]					; stringSize
inc ecx								; check until '\0'

sub esp, 12
mov totalNum, 0
mov flag, 0
mov digitFlag, 0

whileStart:
	checkDigit:
		mov al, [ebx]
		call IsDigit
		jz forloop
		cmp digitFlag, 0
		je checkSpace

	numGenerated :
		inc totalNum
		cmp flag, 0
		je clear					; jump if it is not a negative number

	negative:
		neg sdword ptr [esi]

	clear:
		mov flag, 0
		mov digitFlag, 0

		add esi, 4
		jmp checkDigit				; in case "-5-5"

	checkSpace:
		mov al, [ebx]
		cmp al, ' '
		jne checkNegative
		inc ebx
		jmp outC

	checkNegative:
		mov al, [ebx]
		cmp al, '-'
		jne forLoop
		mov flag, 1					; record negative
		inc ebx
		jmp outC

	forLoop :
		inc digitFlag				; number appears
		push ecx					; save outer loop counter

		mov cl, [ebx]
		sub cl, '0'
		mov eax, [esi]		
		cdq
		push ecx			
		mov ecx, 10
		imul ecx					; num *= 10
		pop ecx
		add eax, ecx				; num += ([ebx] - '0')
		mov [esi], eax

		pop ecx
		inc ebx

outC:
loop whileStart		

mov eax, totalNum					; return totalNum

mov esp, ebp
pop ebp
ret 12
changeString ENDP
END
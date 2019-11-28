.386
.model flat, stdcall
.stack 4096

include sort.inc
includelib ucrt.lib
includelib Irvine32.lib
includelib legacy_stdio_definitions.lib

.code
inputArray PROC

inputFormatLocal equ byte ptr [ebp-4]

push esi
push ebx
push ebp
mov ebp, esp
mov esi, [ebp+16]						; get array offset
mov ebx, [ebp+20]						; get N

localVariableSpace:
    sub esp, 4							; reserve local space
    mov dword ptr [ebp-4], "0d%"		; inputFormatLocal = "%d0"

inputNumbers:
    invoke scanf, addr inputFormatLocal, esi
    add esi, 4
    dec ebx
    cmp ebx, 0
    jne inputNumbers

mov esp, ebp
pop ebp
pop ebx
pop esi
ret 8
inputArray ENDP

;-----------------------------------------------------

.code
outputArray PROC

spaceLocal EQU DWORD PTR [ebp-4]

push esi
push ecx
push eax
push ebp
mov ebp, esp
mov esi, [ebp+20]					; get array offset
mov ecx, [ebp+24]					; get N
dec ecx								; in order to fit output form

localVariableSpace:
    sub esp, 4						; reserve space for locals
    mov spaceLocal, ' '		; spaceLocal = " "

outputNumbers:
    mov eax, [esi]
    call WriteInt
    add esi, 4
    mov eax, spaceLocal
    call WriteChar					; output space
    loop outputNumbers

mov eax, [esi]
call WriteInt						; last number with \n
call Crlf
mov esp, ebp
pop ebp
pop eax
pop ecx
pop esi
ret 8
outputArray ENDP

;-----------------------------------------------------

.code
selectionSort PROC

push esi
push edx
push ecx
push ebx
push eax
push ebp
mov ebp, esp
mov esi, [ebp+28]					; get array offset
mov ecx, [ebp+32]					; get N

whileStart:
    mov ebx, 7FFFFFFFh				; be used to store minimum
    push esi						; store outer array addr
    push ecx						; store outer loop counter
    
    forLoop:
        cmp ebx, [esi]				; find minimum
        jl L1
        mov ebx, [esi]				; store minimum
		mov eax, esi				; store minimum addr
        L1:
            add esi, 4
        loop forLoop

    pop ecx							; restore outer loop counter
    pop esi							; restore outer array addr
	mov edx, [esi]					; exchange minimum and head
    mov [esi], ebx
	mov [eax], edx
    add esi, 4						; head++
    loop whileStart
    
mov esp, ebp
pop ebp
pop eax
pop ebx
pop ecx
pop edx
pop esi
ret 8
selectionSort ENDP
END
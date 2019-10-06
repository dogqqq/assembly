; Program Prime Generator
; Program Description: input n, output all prime number less than n 
; Author: 407262512
; Creation Date: 2019/10/07

.386
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword

INCLUDE Irvine32.inc
INCLUDELIB legacy_stdio_definitions.lib

isPrime PROTO C,
	input:DWORD

.data
inInt BYTE "%d", 0 
strInt BYTE "%d ", 0
strIntN BYTE "%d", 0dh, 0ah, 0
inputInt DWORD 0

.code
asmMain PROC C	
	INVOKE scanf, ADDR inInt, ADDR inputInt
	MOV ebx, 0
While_start:
	SUB inputInt, 1
	CMP inputInt, 1
	JE While_end
	INVOKE isPrime, inputInt
	CMP eax, 0
	JE L1
	CMP ebx, 10
	JE NewLine
	INVOKE printf, ADDR strInt, inputInt
	ADD ebx, 1
	JMP L1
NewLine:
	INVOKE printf, ADDR strIntN, inputInt
	SUB ebx, 10
L1:
	JMP While_start
While_end:
    exit
asmMain ENDP 

END 
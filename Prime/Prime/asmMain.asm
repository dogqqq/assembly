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
	MOV ebx, 0		;innitialize counter
While_start:
	SUB inputInt, 1	
	CMP inputInt, 1	
	JE While_end	;end while if check value equals to 1
	INVOKE isPrime, inputInt	;check if it is a prime number
	CMP eax, 0		;check the return value from C funtion
	JE L1			;if it is not a prime number, jump to L1
	CMP ebx, 10		;check if it had already output 10 numbers
	JE NewLine		;change to new line when output 10 prime numbers
	INVOKE printf, ADDR strInt, inputInt	;otherwise, just output a number with a space
	ADD ebx, 1		;count how many number had been outputed
	JMP L1
NewLine:	
	INVOKE printf, ADDR strIntN, inputInt	;output a number with \n
	SUB ebx, 10		;reduce counter to 0
L1:
	JMP While_start
While_end:
    exit
asmMain ENDP 

END 

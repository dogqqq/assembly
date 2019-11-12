; Program: Prime Factorization
; Program Description: Given signed number N, output its all prime factors and their powers.
; Author: 407262512
; Creation Date: 2019 / 11 / 11

.386
.model flat, stdcall
.stack 4096
option casemap: none

includelib legacy_stdio_definitions.lib
includelib ucrt.lib

printf PROTO C, format : PTR BYTE, args : VARARG
scanf PROTO C, format : PTR BYTE, args : VARARG

.data
inputF BYTE "%d", 0
outputF BYTE "%d", 0
outputFPower BYTE "^%d", 0
outputFMul BYTE " * ", 0
outputFN BYTE 0dh, 0ah, 0
input SDWORD ?
divisor SDWORD ?
power SDWORD ?

.code
asmMain PROC
whileStart:
	invoke scanf, addr inputF, addr input
	cmp input, 0
	jl whileEnd						;if input < 0, then end program
	cmp input, 1
	jle changeLine					;if input == 1, output \n

innitialize:
	mov divisor, 2
	mov power, 0

division:
	mov edx, 0
	mov eax, input
	idiv divisor
	cmp edx, 0
	jg outputAns					;if it is not divisible, jump to outputAns
	mov input, eax
	inc power
	jmp division

outputAns:
	cmp power, 1					;check if power >= 1
	jl L2
	invoke printf, addr outputF, divisor
	cmp power, 1					;check if power == 1
	je L1							;if power == 1, no need to output power
	invoke printf, addr outputFPower, power
L1:
	cmp input, 1
	je changeLine					;if input == 1, it means finish checking 
	invoke printf, addr outputFMul	;otherwise, output " * "
	mov power, 0
L2:
	inc divisor
	jmp division

changeLine:
	invoke printf, addr outputFN
	jmp whileStart

whileEnd:
	ret		
asmMain ENDP
END asmMain
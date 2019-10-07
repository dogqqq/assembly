; Program Minimum and Maximum Numbers
; Program Description: Given series of numbers, output the minimum and maximum numbers
; Author: 407262512
; Creation Date: 2019/10/07

.386
.model flat, stdcall
.stack 4096
option casemap : none
ExitProcess proto, dwExitCode:dword


INCLUDE Irvine32.inc
INCLUDELIB legacy_stdio_definitions.lib

.data

strInt BYTE "%d", 0
outputAns BYTE "Min = %d Max = %d", 0dh, 0ah, 0
cases DWORD 0
tmp SDWORD 0
Min SDWORD 2147483647
Max SDWORD -2147483648

.code

main PROC 
   	INVOKE scanf, ADDR strInt, ADDR cases
While_start:
	INVOKE scanf, ADDR strInt, ADDR tmp
	MOV ebx, tmp
	CMP ebx, Min 	
	JGE L1			; if tmp is not smaller than Min, then jump to L1 to check if it is the Max 
	MOV Min, ebx	; Min = tmp
L1:
	CMP ebx, Max 	
	JLE L2			; if tmp is not greater than Max, then jump to L2
	MOV Max, ebx	; Max = tmp
L2:
	CMP cases, 1	
	JE While_end	; check if the case ends
	SUB cases, 1
	JMP While_start
While_end:
	INVOKE printf, ADDR outputAns, Min, Max
    ret
main ENDP

END main
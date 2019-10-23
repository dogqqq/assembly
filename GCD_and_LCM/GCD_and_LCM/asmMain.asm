; Program GCD and LCM
; Program Description: Given a pair of numbers, output their GCD and LCM
; Author: 407262512
; Creation Date: 2019/10/23

.386

include Irvine32.inc

GCD PROTO,	: sdword, : sdword
LCM PROTO,	: sdword, : sdword

.data
M sdword ?
N sdword ?
GCDNum sdword ?
Space byte " ", 0

.code
GCD PROC, in1: sdword, in2: sdword
checkMNOrder:				;in1 should be greater than in2
	mov eax, in1
	cmp eax, in2
	jg division

changeMN:
	mov ebx, in2 
	mov in1, ebx
	mov in2, eax

division:
	mov eax, in1
	cdq						;convert the value in eax to edx:eax
	mov ecx, in2
	idiv ecx
	mov ebx, in2
	mov in1, ebx			;in1 = in2
	mov in2, edx			;in2 = remainder

checkRemainder:
	cmp in2, 0
	jg division

calFinish:
	mov eax, in1
	ret  
GCD ENDP

.code
LCM PROC, in1: sdword, in2: sdword
multiplication:
	mov eax, in1
	imul eax, in2

division:
	cdq
	mov ecx, GCDNum
	idiv ecx
	ret
LCM ENDP

.code
asmMain PROC
read:
	call ReadInt
	cmp eax, 0				;check if input is negative
	JL finish	
	mov M, eax
	call ReadInt
	mov N, eax

	invoke GCD, M, N 
	mov GCDNum, eax			;store GCD to calculate LCM
	call WriteInt
	mov edx, offset Space	
	call WriteString		;output space

	invoke LCM, M, N
	call WriteInt
	call Crlf				;output \r\n
	jmp read

finish:
	ret
asmMain ENDP
END asmMain
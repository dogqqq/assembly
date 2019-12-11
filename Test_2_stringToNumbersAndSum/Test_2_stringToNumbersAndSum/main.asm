;Program Description: Convert string to number and output sum

includelib Irvine32.lib
include irvine32.inc
include change.inc

.data
maxStringNum EQU 2000
maxNumbersNum EQU 100
originString byte maxStringNum+1 dup(10)
changeNum sdword maxNumbersNum+1 dup(0)

.code
main PROC

start:
	push maxNumbersNum
	push offset changeNum
	call clearArray

	push maxStringNum
	push offset originString
	call inputArray

	cmp eax, 0
	je outP

	push eax
	push offset originString
	push offset changeNum
	call changeString

	push eax
	push offset changeNum
	call outputAns

jmp start

outP:
	ret
main ENDP
END main

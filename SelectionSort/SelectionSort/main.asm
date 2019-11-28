; Program: Selection Sort using Multimodule Program
; Program description: Sort a set of integers in ascending order
; Author: 407262512
; Creation Date: 2019/11/27

.386
.model flat, stdcall
.stack 4096

include sort.inc
includelib ucrt.lib
includelib Irvine32.lib
includelib legacy_stdio_definitions.lib

.data
N sdword ?
arr sdword 1005 DUP(?)
inputFormat byte "%d", 0

.code
main PROC

inputN:
    invoke scanf, addr inputFormat, addr N

checkN:
    cmp N, 0
    jle outP

push N
push offset arr
call inputArray

push N
push offset arr
call selectionSort

push N
push offset arr
call outputArray

jmp inputN

outP:
    ret
    
main ENDP
END main
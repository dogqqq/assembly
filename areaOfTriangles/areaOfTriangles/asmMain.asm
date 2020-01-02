;Program: Area of triangles
;Program Description: Given three points, output the triangle's area.
;Author: 407262512
;Creation Date: 2020/01/01

include irvine32.inc
includelib Irvine32.lib
includelib legacy_stdio_definitions.lib
includelib ucrt.lib

Point2D STRUCT
	X sdword ?
	Y sdword ?
Point2D ENDS

Triangle STRUCT
	a real8 ?
	b real8 ?
	d real8 ?
	area real8 ?
Triangle ENDS

.data
point1 Point2D <>
point2 Point2D <>
point3 Point2D <>
tri Triangle <>
inputFormat byte "%d %d %d %d %d %d", 0
inputF byte "%d", 0
outputFormat byte "%.3f", 0

.code
calDistance PROC, pointF:Point2D, pointS:Point2D
	LOCAL tmp:real8

	fild pointF.X
	fild pointS.X
	fsub
	fst tmp
	fmul tmp
	
	fild pointF.Y
	fild pointS.Y
	fsub
	fst tmp
	fmul tmp

	fadd
	fsqrt
	ret
calDistance ENDP

.code
calArea PROC, trian:Triangle
	LOCAL S:real8, TWO:sdword

calculateS:
	mov TWO, 2
	fld trian.a
	fld trian.b
	fld trian.d
	fadd
	fadd
	fidiv TWO
	fstp S

calculateArea:
	fld S
	fld trian.a
	fld S
	fsub

	fld trian.b
	fld S
	fsub

	fld trian.d
	fld S
	fsub

	fmul 
	fmul 
	fmul 
	fabs
	fsqrt

	ret
calArea ENDP

.code
main PROC
inputPoint:
	invoke scanf, addr inputFormat, addr point1.X, addr point1.Y, addr point2.X, addr point2.Y, addr point3.X, addr point3.Y
	cmp eax, 6
	jne outP

	invoke calDistance, point1, point2
	fstp tri.a

	invoke calDistance, point2, point3
	fstp tri.b
	
	invoke calDistance, point3, point1
	fstp tri.d

	invoke calArea, tri
	fstp tri.area

	invoke printf, addr outputFormat, tri.area
	call Crlf
	jmp inputPoint

outP:
	ret
main ENDP
END main


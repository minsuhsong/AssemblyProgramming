TITLE hw3
Include Irvine32.inc
.data
Include hw3.inc
sum DWORD 0
temp DWORD 0

.code
main PROC	
	mov ecx, Y	
	mov eax, X
	sub ecx, 1
	mov sum, eax

L1:
	mov temp, ecx
	mov ecx, X
	mov eax, sum
	mov sum, 0
	
L2:
	add sum, eax	;3
	loop L2
	mov ecx, temp
	loop L1
	mov eax, sum

	mov ecx, X	
	mov ebx, Y
	sub ecx, 1
	mov sum, ebx

L3:
	mov temp, ecx
	mov ecx, Y
	mov ebx, sum
	mov sum, 0
	
L4:
	add sum, ebx	
	loop L4
	mov ecx, temp
	loop L3
	mov ebx, sum

	call DumpRegs
	exit
main ENDP
END main

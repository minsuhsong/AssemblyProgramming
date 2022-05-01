TITLE hw2
Include Irvine32.inc
.data
Include hw2.inc
fib1 DWORD 1
fib2 DWORD 1
temp DWORD 0
temp2 DWORD 2

.code
main PROC
	mov		ecx, fib
	sub		ecx, temp2

	mov		eax, fib2
	mov		ebx, fib1

L1:
	mov		temp, eax
	add		eax, ebx
	mov		ebx, temp
	loop L1

	call DumpRegs

	exit
main ENDP
END main
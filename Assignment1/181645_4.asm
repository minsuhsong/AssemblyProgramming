TITLE hw4
Include Irvine32.inc
.data
Include hw4.inc
count DWORD LENGTHOF source  
.code
main PROC
	mov esi, 0
	sub count, 1
	mov ecx, count    
	mov al, source[ecx]
	mov target[ecx], al	

L1:
	mov al, source[esi]
	mov target[ecx-1], al
	inc esi
	loop L1
		
	mov edx, OFFSET target
	call WriteString

	call DumpRegs

	exit
main ENDP
END main

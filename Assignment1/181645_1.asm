TITLE hw1
Include Irvine32.inc
.data
	var1 BYTE "365", 0


.code
main PROC
mov esi, 0				;esi = 0
	mov ecx, SIZEOF var1	;ecx = 4
	sub ecx, 2				;ecx = 2
	mov eax, 0				;eax = 0
	mov ebx, 7				;ebx = 7
	
L1:
	add eax, var1[esi]		;eax = 3			3*7 + 6				
	mul ebx					;eax = 3*7			(3*7 + 6)*7
	inc esi					;esi = 1			2
	loop L1

	add eax, var1[esi]		;eax = (3*7 + 6)*7 + 5


   call DumpRegs
   exit
main ENDP
END main
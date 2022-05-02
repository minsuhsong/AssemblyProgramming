TITLE hw1
Include Irvine32.inc
.data
	var1 BYTE "65", 0
	temp BYTE 48

.code
main PROC

	mov esi, 0
	mov eax, 0
	mov bl, 7	
	mov ecx, SIZEOF var1
	sub ecx, 2

L1:
	add al, var1[esi]
	sub al, temp
	mul bl
	inc esi
	loop L1

	add al, var1[esi]
	sub al, temp

   call DumpRegs
   exit
main ENDP
END main
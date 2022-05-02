TITLE hw2
Include Irvine32.inc
.data
	prompt BYTE "Enter a Multiplier: ", 0
	hexVal DWORD ?
	prompt2 BYTE "Enter a Multiplicand: ", 0
	hexVal2 DWORD ?
	temp DWORD 0
	count BYTE 0
	temp2 DWORD 0
	prompt3 BYTE "Produce: ", 0
	prompt4 BYTE "Bye!", 0
.code
main PROC	
L4:
	mov edx, OFFSET prompt
	call WriteString
	call ReadHex
	jz FINISH
	mov hexVal, eax
	mov temp, eax

	cmp eax,28h
	ja L4	

L5:	
	mov edx, OFFSET prompt2
	call WriteString
	call ReadHex
	mov hexVal2, eax
	mov ebx, eax
	mov eax, temp				

	call Sub1	
	
	mov edx, OFFSET prompt3
	call WriteString	
	mov eax, temp2
	call WriteHex
	call crlf
	mov temp2, 0
	mov count, 0
	jmp L4

FINISH:
	mov edx,OFFSET prompt4
	call WriteString
	
   exit
main ENDP

Sub1 PROC
	mov ecx, 32
L2:
	inc count
	shr ebx,1
	jc L1
	loop L2
	ret
	
L1:
	dec count
	push ecx
	mov cl, count
	shl eax, cl
	add temp2, eax
	mov eax, temp
	inc count
	pop ecx
	jmp L2

Sub1 ENDP
END main
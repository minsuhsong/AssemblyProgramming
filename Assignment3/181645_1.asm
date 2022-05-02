TITLE ASSEMBLY

INCLUDE Irvine32.inc

.data
INCLUDE hw3.inc
string1 BYTE "Before sort : ",0
string2 BYTE "After sort : ",0
string3 BYTE "Bye!",0
string4 BYTE ", ",0

.code

WriteArr PROC
	mov edx,0
	mov ecx,LenData

L1: 
mov eax, Arrdata[edx]
	call WriteHex
	cmp ecx,1
	je L2
	push edx
	mov edx,OFFSET string4
	call WriteString
	pop edx

L2:	
add edx,TYPE ArrData
	loop L1
	ret
WriteArr ENDP

main PROC
	mov edx, OFFSET string1	
	call WriteString
	call WriteArr
	call Crlf

	mov edx, OFFSET string2
	call WriteString
	call MySub1
	call MySub2
	call WriteArr
	call Crlf

	mov edx, OFFSET string3
	call WriteString
main ENDP

MySub1 PROC 
	mov edx,0
	push eax
	mov eax,LenData
	push ecx
	mov ecx,2
	div cx
	mov ecx,eax
	push esi
L1: 
	push ecx
	mov esi, OFFSET ArrData
L2: 
	mov eax, [esi]
	ror eax,16
	mov ebx, [esi+8]
	ror ebx,16

	cmp ax, bx
	je L3
	jl L4

	rol eax,16
	rol ebx,16
	mov ebx, eax
	xchg eax, [esi+8]
	mov [esi], eax
	jmp L4
L3: 
	rol eax,16
	rol ebx,16
	cmp ax,bx
	jge L4
	mov ebx, eax
	xchg eax, [esi+8]
	mov [esi], eax
L4: 
	add esi,8
	loop L2

	pop ecx
	loop L1
L5: 
	pop eax
	pop ecx
	pop esi
	ret
MySub1 ENDP

MySub2 PROC
	mov edx,0
	push eax
	mov eax,LenData
	push ecx
	mov ecx,2
	div cx
	mov ecx,eax
	dec ecx
	push esi
L1:
	push ecx
	mov esi, OFFSET ArrData
L2: 
	mov eax, [esi+4]
	ror eax,16
	mov ebx, [esi+12]
	ror ebx,16
	cmp ax, bx
	je L3
	jg L4
	rol eax,16
	rol ebx,16
	mov ebx, eax
	xchg eax, [esi+12]
	mov [esi+4], eax
	jmp L4
L3: 
	rol eax,16
	rol ebx,16
	cmp ax,bx
	jle L4
	mov ebx, eax
	xchg eax, [esi+12]
	mov [esi+4], eax
L4: 
	add esi,8
	loop L2

	pop ecx
	loop L1
L5: 
	pop eax
	pop ecx
	pop esi
	ret

MySub2 ENDP

END main
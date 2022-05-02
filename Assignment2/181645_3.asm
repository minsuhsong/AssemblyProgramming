TITLE hw3

INCLUDE Irvine32.inc

.data
tmp BYTE 43 DUP(?)
Count DWORD 0
tmpsrch BYTE 12 DUP(?)
srchCount DWORD ?
string1 BYTE "Type_A_String : ",0
string2 BYTE "A_Word_for_Search : ",0
string3 BYTE "Found",0
string4 BYTE "Not Found",0
string5 BYTE "Changed : ",0
string6 BYTE "Bye!",0
index DWORD 0

.code
main PROC
L0:
	mov edx, OFFSET string1
	call WriteString
	mov edx, OFFSET tmp
	mov ecx, SIZEOF tmp
	call ReadString
	mov Count, eax

	cmp Count,28h
	ja L0
	cmp Count,00h
	je FINISH

		mov ecx, Count
		mov esi,0
	L1: movzx eax, tmp[esi]
		push eax
		inc esi
		Loop L1

	mov edx, OFFSET string2
	call WriteString
	mov edx, OFFSET tmpsrch
	mov ecx, SIZEOF tmpsrch
	call ReadString
	mov srchCount, eax
	
		mov ecx, Count
		mov esi,0
	L2: movzx eax, tmpsrch[esi]
		push eax
		inc esi
		Loop L2			;string 입력 받음, tempstring도 입력받음

	call search
	jmp L0

	FINISH:
		mov edx,OFFSET string6
		call WriteString

exit
main ENDP


search PROC

mov eax,-1
L3:		
		mov ecx, srchCount
		mov esi, 0
		inc eax

	L0:	mov bl, tmp[eax]
		cmp bl, tmpsrch[esi]
		je L1
		jne NFOUND

	L1: 
		mov index, eax
		inc esi
		inc eax
		cmp esi, srchCount
		je DONE
		jne L0

	L2: mov esi,0
		inc eax
		jmp L0

	DONE: cmp tmpsrch[esi-1], "."
		  je NFOUND
		  cmp tmp[eax], " "
		  je FOUND
		  cmp tmp[eax], "."
		  je FOUND
		  cmp tmp[eax], 00
		  je FOUND
		  jmp NFOUND

	FOUND: 
		   mov edx, OFFSET string3
		   call WriteString
		   call Crlf
		   ;jmp LAST
		   jmp CHANGE

	NFOUND: cmp eax, Count
			jb L3
			mov edx, OFFSET string4
		    call WriteString
			call Crlf
			jmp LAST

	LAST: ret

	CHANGE: 
			mov edx, OFFSET string5
			call WriteString
			mov eax, 0
			mov esi, 0
			mov ebx, index
			sub ebx, srchCount
			inc ebx
	
	L4:	
			cmp ebx, esi
			je L5
			mov al, tmp[esi]
			call WriteChar
			inc esi
			jmp L4

	L5:
			inc esi
			cmp index, esi
			ja L5
			jb L8
			je L9
	L8:
			add esi, 1
			jmp L6
	L9:
			add esi, 2
	
	L6:
			mov al, tmp[esi]
			call WriteChar
			inc esi
			cmp Count, esi
			je L7
			ja L6
	L7:
			call Crlf
			jmp LAST

					   
search ENDP
END main
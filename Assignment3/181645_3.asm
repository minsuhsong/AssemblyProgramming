TITLE hw3

INCLUDE Irvine32.inc

.data
	MenuPrompt	     BYTE "1. x AND y"     ,0dh,0ah
                     BYTE "2. x OR y"      ,0dh,0ah
                     BYTE "3. NOT x"       ,0dh,0ah
                     BYTE "4. X XOR y"     ,0dh,0ah
                     BYTE "5. Exit program",0

	string1 BYTE "Enter x : ",0
	string2 BYTE "Enter y : ",0
	choose		BYTE "Choose Calculation Mode : ",0
	change		BYTE "Do you want to change the mode(Y/N)? : ",0
	string3	BYTE "Bye!",0
	resultAND   BYTE "Result of x AND y : ",0
	resultOR    BYTE "Result of x OR y : ",0
	resultNOT   BYTE "Result of x NOT y : ",0
	resultXOR   BYTE "Result of x XOR y : ",0
	temp	BYTE 5 DUP(0)

	caseTable BYTE 1
		   DWORD AND_op
	EntrySize = ($ - caseTable )
		   BYTE 2
		   DWORD OR_op
		   BYTE 3
		   DWORD NOT_op
		   BYTE 4
		   DWORD XOR_op
		   BYTE 5
		   DWORD exitProgram
	NumberOfEntries = ($ - caseTable) / EntrySize

.code
main PROC
	L1:
		   mov edx, OFFSET MenuPrompt
		   call WriteString
		   call Crlf
		   call Crlf
	L2:
		   mov edx, OFFSET choose
		   call WriteString
		   call ReadInt
		   cmp al, 5
		   ja L2
		   cmp ax, 1
		   jb L2

		   call select
		   jc L3
		   call Crlf
		   jmp L1
	L3:    exit
main ENDP

select PROC USES ebx ecx
		   mov ebx, OFFSET caseTable
		   mov ecx, NumberOfEntries

	L1:	   cmp al, [ebx]
		   jne L2
		   call NEAR PTR [ebx + 1]
		   jmp L3

	L2:    add ebx, EntrySize
		   loop L1

	L3:	   ret
select ENDP

AND_op PROC
       pushad
       mov edx, OFFSET string1
       call WriteString
       call ReadHex
       mov ebx, eax
       mov edx, OFFSET string2
       call WriteString
       call ReadHex
       and eax, ebx
       mov edx, OFFSET resultAND
       call WriteString
       call WriteHex
	   call Crlf
	   call Crlf
	   
	   change_loop:
			mov edx, OFFSET change
			call WriteString
		
			mov ecx, 2
			mov edx, OFFSET temp
			call ReadString	
			call Crlf

			mov dl, temp[0]			

			cmp dl, 'Y'
			je main
			cmp dl, 'N'
			je AND_op
		jmp change_loop
	   
       popad
       ret
AND_op ENDP

OR_op PROC
       pushad
       mov edx, OFFSET string1
       call WriteString
       call ReadHex
       mov ebx, eax
       mov edx, OFFSET string2
       call WriteString
       call ReadHex
       or eax, ebx
       mov edx, OFFSET resultOR
       call WriteString
       call WriteHex
       call Crlf
	   call Crlf

	   change_loop:
			mov edx, OFFSET change
			call WriteString
		
			mov ecx, 2
			mov edx, OFFSET temp
			call ReadString	
			call Crlf

			mov dl, temp[0]		

			cmp dl, 'Y'
			je main
			cmp dl, 'N'
			je OR_op
		jmp change_loop

       popad
       ret
OR_op ENDP

NOT_op PROC
       pushad
       mov edx, OFFSET string1
       call WriteString
       call ReadHex
       not eax
       mov edx, OFFSET resultNOT
       call WriteString
       call WriteHex
       call Crlf
	   call Crlf

	   change_loop:
			mov edx, OFFSET change
			call WriteString
		
			mov ecx, 2
			mov edx, OFFSET temp
			call ReadString
			call Crlf

			mov dl, temp[0]			

			cmp dl, 'Y'
			je main
			cmp dl, 'N'
			je NOT_op
		jmp change_loop

       popad
       ret
NOT_op ENDP

XOR_op PROC
       pushad
       mov edx, OFFSET string1
       call WriteString
       call ReadHex
       mov ebx, eax
       mov edx, OFFSET string2
       call WriteString
       call ReadHex
       xor eax, ebx
       mov edx, OFFSET resultXOR
       call WriteString
       call WriteHex
       call Crlf
	   call Crlf

	   change_loop:
			mov edx, OFFSET change
			call WriteString
		
			mov ecx, 2
			mov edx, OFFSET temp
			call ReadString	
			call Crlf

			mov dl, temp[0]			

			cmp dl, 'Y'
			je main
			cmp dl, 'N'
			je XOR_op
		jmp change_loop

       popad
       ret
XOR_op ENDP  

exitProgram PROC  
      mov edx, OFFSET string3
	  call WriteString
	  stc
      ret

exitProgram ENDP   

END main  
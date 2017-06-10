; Executable code in HAx-main.s files should start at label main

	EXPORT	main		; this line is needed to interface with init.s

; Usable utility functions defined in file init.s
; Importing any label from another source file is necessary
; in order to use that label in this source file

	IMPORT	GetCh		; Input one ASCII character from the UART #1 window (from keyboard)
	IMPORT	PutCh		; Output one ASCII character to the UART #1 window
	IMPORT	PutCRLF		; Output CR and LF to the UART #1 window
    IMPORT	UDivMod		; Perform unsigned division to obtain quotient and remainder
	IMPORT	GetDec		; Input a signed number from the UART #1 window
	IMPORT	PutDec		; Output a signed number to the UART #1 window
	IMPORT	GetStr		; Input a CR-terminated ASCII string from the UART #1 window
	IMPORT	PutStr		; Output null-terminated ASCII string to the UART #1 window

	AREA    MyCode, CODE, READONLY

	ALIGN			; highly recommended to start and end any area with ALIGN

; Start of executable code is at following label: main

main

;-------------------- START OF MODIFIABLE CODE ----------------------

	PUSH	{LR}				;save return address of caller in init.s
RTR    

	BL	GETNUM				;Subroutine to get the user input
	BL	GETOP					;Subroutine to get the operation
	BL	MATH					;Subroutine that performs the operation 
								;and Displays the result value
EXIT POP {PC}					;EXIT After going through the subroutines

;-------------------SUBROUTINE1----------------;
GETNUM PUSH {LR} 
	LDR	R0, =Hello		;Load the memory address of Hello message	
	BL	PutStr			;Display Hello
	LDR	R0, =Prompt1	;Load the memory address of Prompt1
	BL	PutStr			;Display Prompt1
	BL	GetDec			;Get user input for num1
	LDR	R1,	=num1		;Load memory address of num1
	LDR	R2, =num2		;Load memory address of num2
	STR	R0, [R1]		;Store the value of num1
	LDR	R0, =Prompt2	;Load the memory address of Prompt2
	BL	PutStr			;Display Prompt2 to get the num2
	BL	GetDec			;Get num2
	STR	R0,	[R2]		;Store num2 
	POP {PC}			

;-------------------SUBROUTINE2------------------:
GETOP	PUSH {LR}
	LDR R0, =Prompt3	;Load the memory address of Prompt3
	BL PutStr			;Display Propmt3 to asking for Oprtr
	BL GetCh			;Get the user input character
	BL	PutCRLF			;print a new line
	LDR R1, =MATHOP		;Load the memory address of Oprtr
	STR	R0, [R1]		;Store the Oprtr in that memory address
	POP {PC}		

;-------------------SUBROUTINE3------------------:
MATH	PUSH {LR}

	LDR	R0, =num1		;Load the memory address of num1	
	LDR R0, [R0]		;Load the value of num1
	LDR	R1, =num2		;Load the memory address of num2
	LDR R1, [R1]		;Load the value of num2
	LDR	R2, =MATHOP		;Load the memory address of Oprtr
	LDR	R2, [R2]		;Load the value of Oprtr
	CMP	R2, #'+'		;Compare operator HEX VALUE to Char '+'
	BEQ	ADDITION		;IF equal branch to ADDITION level
	CMP	R2, #'-'		;Compare operator HEX VALUE to Char '-'
	BEQ	SUBTRACT		;IF equal branch to SUBTRACT level
	CMP	R2, #'*'		;Compare operator HEX VALUE to Char '*'
	BEQ	MULTIPLICATION	;IF equal branch to MULTIPLICATION level
	CMP R2, #'/'		;Compare operator HEX VALUE to Char '/'
	BEQ	DIVISION		;IF equal branch to DIVISION level
	BNE	NOTOPTN1			;ELSE branch to NotOption 
	BAL	EXIT1			;Branch always to EXIT1
	
;--------------------IF Operation =='+' ----------------------;
ADDITION
	ADD R3, R0, R1		;Add the vlaue of num1 to num2
	LDR	R0, =SumMsg		;Load the memory address of SumMessage
	BL	PutStr			;Display SumMessage	
	MOV	R0, R3			;Move the value of sum to R0
	BL	PutDec			;Display the sum 
	BL	PutCRLF			;Print new line
	BAL PROMPT			;Branch Always to PROMPT
;--------------------IF Operation =='-' ----------------------;
SUBTRACT
	SUB	R3, R0, R1		;Sub the vlaue of num2 from num 1
	LDR	R0, =SubMsg		;load the memory address of SubMsg
	BL 	PutStr			;DISPLAY	
	MOV	R0, R3			;MOV the difference to R0	
	BL 	PutDec			;DISPLAY
	BL	PutCRLF			;Print new line
	BAL PROMPT			;Branch Always to PROMPT
;--------------------IF Operation =='*' ----------------------;	
MULTIPLICATION
	MUL	R3, R0, R1		;Multiply the vlaue of num1 by num2
	LDR	R0, =MulMsg		;Load the memory address of MulMsg
	BL  PutStr			;DISPLAY
	MOV	R0, R3			;Move the product to R0
	BL 	PutDec			;DISPLAY
	BL	PutCRLF			;Print new line
	BAL PROMPT			;Branch Always to PROMPT
;--------------------IF Operation =='/' ----------------------;
DIVISION
	CMP	R1, #0			;check if the Divisor ==0
	BEQ InvalidDiv		;If divisor (R1) ==0, then branch to InvalidDiv
	BL  UDivMod			;Else Divide the vlaue of num1 by num2
	LDR	R0, =DivMsg		;Load the memory address of DivMsg
	BL  PutStr			;DISPLAY
	MOV R0, R1			;Move the product to R0
	BL	PutDec			;DISPLAY
	BL	PutCRLF			;Print new line
	BAL PROMPT			;Branch Always to PROMPT
;--------------------IF Operation =='/' && User input Divisor == 0 ----------------------;
InvalidDiv
	LDR	R0, =InvDivMsg	;Load the memory address of InvDivMsg
	BL	PutStr			;DISPLAY
	BL	PutCRLF			;Print new line
	BAL	PROMPT			;Branch Always to PROMPT
;--------------------IF Operation Success & Want to Prompt ask whether to redo or NOT ----------------------;
PROMPT
	LDR R0, =RtrPrompt	;Load the memory address of Retry Prompt
	BL	PutStr			;DISPLAY IT
	BL 	GetCh			;Get the user response
	BL	PutCRLF			;Print new line
	CMP R0, #'N'		;Compare it to 'N' for No
	BEQ EXIT1			;If equal ==> EXIT1
	CMP	R0, #'n'		;Compare it to 'n' for no
	BEQ	EXIT1			;If equal ==> EXIT1
	CMP R0, #'Y' 		;Compare it to 'Y' for Yes
	BEQ	RTR				;If equal ==> RTR or retry
	CMP	R0, #'y'		;Compare it to 'y' for yes
	BEQ RTR				;If equal ==> RTR or retry
	BAL	INVALID			;Branch always to INVALID
;--------------------IF The choice in PROMPT was not 'Y','N','n'OR'y'----------------------;
INVALID
	LDR	R0, =InvalidRtr	;Load the memory address of InvalidRtr
	BL	PutStr			;DISPLAY
	BL	PutCRLF			;Print new line
	BAL PROMPT			;Branch Always to PROMPT
;--------------------IF Operation !='+','-','*' OR '/' ----------------------;	
NOTOPTN1
	LDR	R0, =NOTOPTNMSG	;Load the memory address of Not an option
	BL	PutStr			;DISPLAY
	BL	PutCRLF			;Print new line
	BAL RTR				;Branch Always to Retry 
;--------------------IF Operation was success and PROMPT=='N'or'n'----------------------;	
EXIT1
	LDR R0, =Bye		;Load the memory address of Bye
	BL	PutStr			;DISPLAY
	BL	PutCRLF			;Print new line
	POP {PC}

; Some commonly used ASCII codes
	
CR	EQU	0x0D	; Carriage Return (to move cursor to beginning of current line)
LF	EQU	0x0A	; Line Feed (to move cursor to same column of next line)

; The following data items are in the CODE area,
; so they are all READONLY (i.e. cannot be modified at run-time),
; but they can be initialized at assembly-time to any value
	AREA    MyData1, DATA, READONLY
Hello	 DCB "Hello there! Welcome to the Calculator Project!",CR, LF,0
Prompt1  DCB "Please enter the first integer: ",0
Prompt2	 DCB "Please enter the second integer: ",0
Prompt3	 DCB "Please enter your desired MATH Operation: ",0
SumMsg   DCB "Sum of NUM1 and NUM2 is: ",0
SubMsg   DCB "Difference between NUM1 and NUM2 is: ",0
MulMsg	 DCB "Product of NUM1 and NUM2 is: ",0	
DivMsg	 DCB "Quotient of NUM1 by NUM2 is: ",0
InvDivMsg DCB "Divide by 0 ERROR occured.", 0
RtrPrompt DCB "Would you like to continue (Y/N): ", 0
InvalidRtr DCB "Please enter 'Y' or 'N'.",0 
NOTOPTNMSG DCB	"Please choose one of four operators +,-,'*' or / : ",0
Bye		DCB "Thanks for your time! Byeeeeeeee!",0
	ALIGN
		
; The following data items are in the DATA area,
; so they are all READWRITE (i.e. can be modified at run-time),
; but are automatically initialized at assembly-time to zeroes 

	AREA    MyData, DATA, READWRITE
		
	ALIGN
num1   SPACE    31
num2   SPACE    31
MATHOP  SPACE	31	

;-------------------- END OF MODIFIABLE CODE ----------------------

	ALIGN

	END			; end of source program in this file

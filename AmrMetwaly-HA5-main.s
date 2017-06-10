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

	PUSH	{LR}		; save return address of caller in init.s

;A= factorial of N!/N
	LDR	R0, =Prompt1	; R0 = address Prompt1 (in code area)
	BL	PutStr		; display prompt for asking number of series
	BL	GetDec		; read into R0 decimal number entered by user
	LDR R5, =value	; we use the value to store our factorial result
	MOV R4, R0		; R4 is a duplicate of R0, for division part
	MOV	R2,#1		; R2 is our factorial result
	
NEXT	MUL	R2,R2,R0    ; Result = Result x i
	SUB	R0,#1			; decrement the counter i and check
	CMP	R0,#1			
	BGE	NEXT			;iterate one more of the level NEXT
	UDIV R0, R2, R4		; divide result of factorial by R4=8, R0= R2/ R4				
    STR R0, [R5]		; store the result of factorial oper. in value
	MOV R4, R0
	LDR R0, =Msg1
	BL PutStr
	MOV R0, R4
	BL PutDec
	
; B =sum of numbers from  to 1000 divided by 1000

	LDR	R6, =value2
	MOV R4, #1	;Our counter i = 1
	MOV R5, #0	; R5 is our sum 

LOOP	ADD   R5, R5, R4	; sum = sum + counter
		ADD	  R4, R4, #1	;increment the counter and check
		CMP   R4, #1000
		BLE	  LOOP
		MOV	  R0, R5		;mov sum to R0
		MOV   R1, #1000		; put a value 1000 in R1
		udiv  R0, R1		; R0 = R0/R1
		STR   R0, [R6]		; Store the value of our division in value2
		LDR   R7, [R6]		; Load the content of memory address [R6] to R7
		
;performing the operation X= A/B
		MOV   R0, #0		;initialize R0 incase
		LDR	  R5, =value	;Load memory address of value into R5
		LDR   R0, [R5]		;Load value in memory address [R5]
		udiv  R0, R7		;perform the division oper. R0= R0/R7
		MOV   R8, R0
		LDR   R0, =Msg2
		BL 	  PutStr
		LDR   R0, =Msg3
		BL 	  PutStr
		MOV	  R0, R8
		BL 	  PutDec		; Display the value in R0
		
	POP	{PC}		; return from main (our last executable instruction)
	
; Some commonly used ASCII codes

CR	EQU	0x0D	; Carriage Return (to move cursor to beginning of current line)
LF	EQU	0x0A	; Line Feed (to move cursor to same column of next line)

; The following data items are in the CODE area,
; so they are all READONLY (i.e. cannot be modified at run-time),
; but they can be initialized at assembly-time to any value

Prompt1	DCB	"Please enter the number of terms in your series: ", 0
Msg1	DCB	"Factorial of N / N is = ", 0
Msg2	DCB	"   Since X = A/ B. ", 0
Msg3	DCB	"   Therefore, X = ", 0

	ALIGN
		
; The following data items are in the DATA area,
; so they are all READWRITE (i.e. can be modified at run-time),
; but are automatically initialized at assembly-time to zeroes 

	AREA    MyData, DATA, READWRITE
		
	ALIGN
	
value	SPACE	31		; 31 bytes for storing value, A
value2	SPACE	31		; 31 bytes for storing value2, B 
;-------------------- END OF MODIFIABLE CODE ----------------------

	ALIGN

	END			; end of source program in this file

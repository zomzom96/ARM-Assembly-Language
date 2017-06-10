*	a more complex subroutine example
*	program passes variables to the routine using the stack

	TTL	Ch10Ex5
	AREA	Program, CODE, READONLY
	ENTRY

StackStart	EQU	0x9000		;declare where top of stack will be
Mask		EQU	0x0000000F	;bit mask for masking out lower nibble

Main	
	LDR	R7, =StackStart		;Top of stack = 9000
	LDR	R0, Number		;Load number to register
	LDR	R1, =String		;load address of string
	STR	R1, [R7], #-4		;and store it
	STR	R0, [R7], #-4		;and store number to stack
	BL	Binhex			;branch/link
	SWI	&11			;all done

*	=========================
*	Binhex subroutine
*	=========================

*	Purpose
*	Binhex subroutine converts a 16 bit value to an ASCII string
*
*	Initial Condition
*	First parameter on the stack is the value
*	Second parameter is the address of the string
*
*	Final Condition
*	the HEX string occupies 4 bytes beginning with 
*	the address passed as the second parameter
*
*	Registers changed
*	No registers are affected
*
*	Sample case
*	Initial condition	top of stack :	4CD0
*				Address of string
*	Final condition		The string '4''C''D''0' in ASCII
*				occupies memory 

Binhex
	MOV	R8, R7			;save stack pointer for later
	STMDA	R7, {R0-R6,R14}		;push contents of R0 to R6, and LR onto the stack
	MOV	R1, #4			;init counter
	ADD	R7, R7, #4		;adjust pointer
	LDR	R2, [R7], #4		;get the number
	LDR	R4, [R7]		;get the address of the string
	ADD	R4, R4, #4		;move past the end of where the string is to be stored

Loop
	MOV	R0, R2			;copy the number
	AND	R0, R0, #Mask		;get the low nibble
	BL	Hexdigit		;convert to ASCII
	STRB	R0, [R4], #-1		;store it
	MOV	R2, R2, LSR #4		;shift to next nibble
	SUBS	R1, R1, #1		;decr counter
	BNE	Loop			;loop while still elements left

	LDMDA	R8, {R0-R6,R14}		;restore the registers 
	MOV	PC, LR			;return from subroutine

*	=========================
*	Hexdigit subroutine
*	=========================

*	Purpose
*	Hexdigit subroutine converts a Hex digit to an ASCII character
*
*	Initial Condition
*	R0 contains a value in the range 00 ... 0F
*
*	Final Condition
*	R0 contains ASCII character in the range '0' ... '9' or 'A' ... 'F'
*
*	Registers changed
*	R0 only
*
*	Sample case
*	Initial condition	R0 = 6
*	Final condition		R0 = 36 ('6')

Hexdigit
	CMP	R0, #0xA		;is the number 0 ... 9?
	BLE	Addz			;if so, branch
	ADD	R0, R0, #"A" - "0" - 0xA	;adjust for A ... F

Addz
	ADD	R0, R0, #"0"		;change to ASCII
	MOV	PC, LR			;return from subroutine

	AREA	Data1, DATA
Number	DCD	&4CD0			;number to convert
String	DCB	4, 0			;counted string for result

	END
*	store a 16bit binary number as an ASCII string of '0's and '1's

	TTL	Ch7Ex7
	AREA	Program, CODE, READONLY
	ENTRY

Main
	LDR	R0, =String		;load startr address of string
	ADD	R0, R0, #16		;adjust for length of string
	LDRB	R6, String		;init counter
	MOV	R2, #"1"		;load character '1' to register
	MOV	R3, #"0"
	LDR	R1, Number		;load the number to process

Loop
	MOVS	R1, R1, ROR #1		;rotate right with carry
	BCS	Loopend			;if carry set branch (LSB was a '1' bit)
	STRB	R3, [R0], #-1		;otherwise store "0"
	BAL	Decr			;and branch to counter code
Loopend
	STRB	R2, [R0], #-1		;store a "1"
Decr
	SUBS	R6, R6, #1		;decrement counter
	BNE	Loop			;loop while not 0

	SWI	&11

	AREA	Data1, DATA
Number	DCD	&31D2			;a 16 bit binary number number
	ALIGN

	AREA	Data2, DATA
String	DCB	16			;storage for result
	ALIGN

	END
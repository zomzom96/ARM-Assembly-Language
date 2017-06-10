*	find the length of a string

	TTL	Ch6Ex3

Blank	EQU	" "
	AREA	Program, CODE, READONLY	
	ENTRY

Main
	ADR	R0, Data1		;load the address of the lookup table
	MOV	R1, #Blank		;store the blank char in R1
Loop
	LDRB	R2, [R0], #1		;load the first byte into R2
	CMP	R2, R1			;is it a blank
	BEQ	Loop			;if so loop

	SUB	R0, R0, #1		;otherwise done - adjust pointer
	STR	R0, Pointer		;and store it
	SWI	&11

	AREA	Data1, DATA

Table
	DCB	"      7   "
	ALIGN

	AREA	Result, DATA
Pointer	DCD	0			;storage for count
	ALIGN

	END
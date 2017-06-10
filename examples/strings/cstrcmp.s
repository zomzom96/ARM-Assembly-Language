*	compare two counted strings for equality

	TTL	Ch6Ex6

	AREA	Program, CODE, READONLY
	ENTRY

Main
	LDR	R0, =Data1		;load the address of the lookup table
	LDR	R1, =Data2
	LDR	R2, Match		;assume strings not equal - set to -1
	LDR	R3, [R0], #4		;store the first string length in R3
	LDR	R4, [R1], #4		;store the second string length in R4
	CMP	R3, R4
	BNE	Done			;if they are different lengths, 
					;they can't be equal
	CMP	R3, #0			;test for zero length if both are
	BEQ	Same			;zero length, nothing else to do

*	if we got this far, we now need to check the string char by char
Loop
	LDRB	R5, [R0], #1		;character of first string		
	LDRB	R6, [R1], #1		;character of second string
	CMP	R5, R6			;are they the same
	BNE	Done			;if not the strings are different
	SUBS	R3, R3, #1		;use the string length as a counter
	BEQ	Same			;if we got to the end of the count
					;the strings are the same
	B	Loop			;not done, loop

Same	MOV	R2, #0			;clear the -1 from match (0 = match)
Done	STR	R2, Match		;store the result
	SWI	&11

	AREA	Data1, DATA
Table1	DCD	3			;data table starts with byte length of string
	DCB	"CAT"			;the string

	AREA	Data2, DATA
Table2	DCD	3			;data table starts with byte length of string
	DCB	"CAT"			;the string

	AREA	Result, DATA
	ALIGN
Match	DCD	&FFFF			;storage for parity characters

	END
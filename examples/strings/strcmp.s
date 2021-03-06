; Compare two null terminated strings for equality

	TTL	Ch6Ex7

	AREA	Program, CODE, READONLY
	ENTRY

Main
	LDR	R0, =Data1		;load the address of the lookup table
	LDR	R1, =Data2
	LDR	R2, Match		;assume strings not equal, set to -1
	MOV	R3, #0			;init register
	MOV	R4, #0
Count1
	LDRB	R5, [R0], #1		;load the first byte into R5
	CMP	R5, #0			;is it the terminator
	BEQ	Count2			;if not, Loop
	ADD	R3, R3, #1		;increment count
	BAL	Count1
Count2
	LDRB	R5, [R1], #1		;load the first byte into R5
	CMP	R5, #0			;is it the terminator
	BEQ	Next			;if not, Loop
	ADD	R4, R4, #1		;increment count
	BAL	Count2

Next	CMP	R3, R4
	BNE	Done			;if they are different lengths, 
					;they can't be equal
	CMP	R3, #0			;test for zero length if both are
	BEQ	Same			;zero length, nothing else to do
	LDR	R0, =Data1		;need to reset the lookup table
	LDR	R1, =Data2

*	if we got this far, we now need to check the string char by char
Loop
	LDRB	R5, [R0], #1		;character of first string		
	LDRB	R6, [R1], #1		;character of second string
	CMP	R5, R6			;are they the same
	BNE	Done			;if not the strings are different
	SUBS	R3, R3, #1		;use the string length as a counter
	BEQ	Same			;if we got to the end of the count
					;the strings are the same
	BAL	Loop			;not done, loop

Same
	MOV	R2, #0			;clear the -1 from match (0 = match)
Done
	STR	R2, Match		;store the result
	SWI	&11

	AREA	Data1, DATA
Table1	DCB	"Hello, World", 0	;the string
	ALIGN

	AREA	Data2, DATA
Table2	DCB	"Hello, worl", 0	;the string

	AREA	Result, DATA
	ALIGN
Match	DCD	&FFFF			;flag for match

	END
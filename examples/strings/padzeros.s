*	supress leading zeros in a string

	TTL	Ch6Ex4

Blank	EQU	' '
Zero	EQU	'0'
	AREA	Program, CODE, READONLY
	ENTRY

Main
	LDR	R0, =Data1		;load the address of the lookup table
	MOV	R1, #Zero		;store the zero char in R1
	MOV	R3, #Blank		;and the blank char in R3
Loop
	LDRB	R2, [R0], #1		;load the first byte into R2
	CMP	R2, R1			;is it a zero
	BNE	Done			;if not, done

	SUB	R0, R0, #1		;otherwise adjust the pointer
	STRB	R3, [R0]		;and store it blank char there
	ADD	R0, R0, #1		;otherwise adjust the pointer
	BAL	Loop			;and loop

Done
	SWI	&11			;all done

	AREA	Data1, DATA

Table
	DCB	"000007000"
	ALIGN

	AREA	Result, DATA
Pointer	DCD	0			;storage for count
	ALIGN

	END
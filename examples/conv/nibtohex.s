*	convert a single hex digit to its ASCII equivalent

	TTL	Ch7Ex1

	AREA	Program, CODE, READONLY
	ENTRY

Main
	LDR	R0, Digit		;load the digit
	LDR	R1, =Result		;load the address for the result
	CMP	R0, #0xA		;is the number < 10 decimal
	BLT	Add_0			;then branch

	ADD	R0, R0, #"A"-"0"-0xA	;add offset for 'A' to 'F'
Add_0
	ADD	R0, R0, #"0"		;convert to ASCII
	STR	R0, [R1]		;store the result
	SWI	&11

	AREA	Data1, DATA
Digit
	DCD	&0C			;the hex digit

	AREA	Data2, DATA
Result	DCD	0			;storage for result

	END

*	convert a decimal number to seven segment binary

	TTL	Ch7Ex3

	AREA	Program, CODE, READONLY
	ENTRY

Main
	LDR	R0, =Data1		;load the start address of the table
	EOR	R1, R1, R1		;clear register for the code
	LDRB 	R2, Digit		;get the digit to encode
	CMP	R2, #9			;is it a valid digit?
	BHI	Done			;clear the result

	ADD	R0, R0, R2		;advance the pointer
	LDRB	R1, [R0]		;and get the next byte
Done
	STR	R1, Result		;store the result
	SWI	&11			;all done

	AREA	Data1, DATA
Table	DCB	&3F			;the binary conversions table
	DCB	&06
	DCB	&5B
	DCB	&4F
	DCB	&66
	DCB	&6D
	DCB	&7D
	DCB	&07
	DCB	&7F
	DCB	&6F
	ALIGN

	AREA	Data2, DATA
Digit	DCB	&05			;the number to convert
	ALIGN

	AREA	Data3, DATA
Result	DCD	0			;storage for result

	END
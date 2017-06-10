*	16 bit binary multiplication

	TTL	Ch8Ex1
	AREA	Program, CODE, READONLY
	ENTRY

Main
	LDR	R0, Number1		;load first number
	LDR	R1, Number2		;and second
	MUL	R0, R1, R0		;x:= y * x
*	MUL	R0, R0, R1		;won't work - not allowed
	STR	R0, Result

	SWI	&11			;all done

	AREA	Data1, DATA
Number1	DCD	&706F			;a 16 bit binary number 
Number2	DCD	&0161			;another
	ALIGN

	AREA	Data2, DATA
Result	DCD	0			;storage for result
	ALIGN

	END
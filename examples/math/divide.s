*	divide a 32 bit binary no by a 16 bit binary no
*	store the quotient and remainder
*	there is no 'DIV' instruction in ARM!

	TTL	Ch8Ex2
	AREA	Program, CODE, READONLY
	ENTRY

Main
	LDR	R0, Number1		;load first number
	LDR	R1, Number2		;and second
	MOV	R3, #0			;clear register for quotient
Loop
	CMP	R1, #0			;test for divide by 0
	BEQ	Err
	CMP	R0, R1			;is the divisor less than the dividend?
	BLT	Done			;if so, finished
	ADD	R3, R3, #1		;add one to quotient
	SUB	R0, R0, R1		;take away the number you first thought of
	B	Loop			;and loop
Err
	MOV	R3, #0xFFFFFFFF		;error flag (-1)
Done
	STR	R0, Remain		;store the remainder
	STR	R3, Quotient		;and the quotient
	SWI	&11			;all done

	AREA	Data1, DATA
Number1	DCD	&0075CBB1		;a 16 bit binary number 
Number2	DCD	&0141			;another
	ALIGN

	AREA	Data2, DATA
Quotient DCD	0			;storage for result
Remain	DCD	0			;storage for remainder
	ALIGN

	END
*	multiply two 32 bit number to give a 64 bit result
*	(corrupts R0 and R1)

	TTL	Ch8Ex4
	AREA	Program, CODE, READONLY
	ENTRY

Main
	LDR	R0, Number1		;load first number
	LDR	R1, Number2		;and second
	LDR	R6, =Result		;load the address of result
	MOV	R5, R0, LSR #16		;top half of R0
	MOV	R3, R1, LSR #16		;top half of R1
	BIC	R0, R0, R5, LSL #16	;bottom half of R0
	BIC	R1, R1, R3, LSL #16	;bottom half of R1
	MUL	R2, R0, R1		;partial result
	MUL	R0, R3, R0		;partial result
	MUL	R1, R5, R1		;partial result
	MUL	R3, R5, R3		;partial result
	ADDS	R0, R1, R0		;add middle parts
	ADDCS	R3, R3, #&10000		;add in any carry from above
	ADDS	R2, R2, R0, LSL #16	;LSB 32 bits
	ADC	R3, R3, R0, LSR #16	;MSB 32 bits

	STR	R2, [R6]		;store LSB
	ADD	R6, R6, #4		;increment pointer
	STR	R3, [R6]		;store MSB
	SWI	&11			;all done

	AREA	Data1, DATA
Number1	DCD	&12345678		;a 16 bit binary number 
Number2	DCD	&ABCDEF01		;another
	ALIGN

	AREA	Data2, DATA
Result	DCD	0			;storage for result
	ALIGN

	END
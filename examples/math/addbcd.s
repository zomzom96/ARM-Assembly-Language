*	add two packed BCD numbers to give a packed BCD result

	TTL	Ch8Ex3
	AREA	Program, CODE, READONLY
	ENTRY

Mask	EQU	0x0000000F

Main
	LDR	R0, =Result		;address for storage
	LDR	R1, BCDNum1		;load the first BCD number
	LDR	R2, BCDNum2		;and the second
	LDRB	R8, Length		;init counter
	ADD	R0, R0, #3		;adjust for offset	
	MOV	R5, #0			;carry

Loop
	MOV	R3, R1			;copy what is left in the data register
	MOV	R4, R2			;and the other number
	AND	R3, R3, #Mask		;mask out everything except low order nibble
	AND	R4, R4, #Mask		;mask out everything except low order nibble
	MOV	R1, R1, LSR #4		;shift the original number one nibble
	MOV	R2, R2, LSR #4		;shift the original number one nibble
	ADD	R6, R3, R4		;add the digits
	ADD	R6, R6, R5		;and the carry
	CMP	R6, #0xA		;is it over 10?
	BLT	RCarry1			;if not, reset the carry to 0
	MOV	R5, #1			;otherwise set the carry
	SUB	R6, R6, #0xA		;and subtract 10
	B	Next
RCarry1
	MOV	R5, #0			;carry reset to 0

Next
	MOV	R3, R1			;copy what is left in the data register
	MOV	R4, R2			;and the other number
	AND	R3, R3, #Mask		;mask out everything except low order nibble
	AND	R4, R4, #Mask		;mask out everything except low order nibble
	MOV	R1, R1, LSR #4		;shift the original number one nibble
	MOV	R2, R2, LSR #4		;shift the original number one nibble
	ADD	R7, R3, R4		;add the digits
	ADD	R7, R7, R5		;and the carry
	CMP	R7, #0xA		;is it over 10?
	BLT	RCarry2			;if not, reset the carry to 0
	MOV	R5, #1			;otherwise set the carry
	SUB	R7, R7, #0xA		;and subtract 10
	B	Loopend

RCarry2
	MOV	R5, #0			;carry reset to 0
Loopend
	MOV	R7, R7, LSL #4		;shift the second digit processed to the left
	ORR	R6, R6, R7		;and OR in the first digit to the ls nibble
	STRB	R6, [R0], #-1		;store the byte, and decrement address
	SUBS	R8, R8, #1		;decrement loop counter
	BNE	Loop			;loop while > 0
	SWI	&11

	AREA	Data1, DATA
Length	DCB	&04
	ALIGN
BCDNum1	DCB	&36, &70, &19, &85	;an 8 digit packed BCD number

	AREA	Data2, DATA
BCDNum2	DCB	&12, &66, &34, &59	;another 8 digit packed BCD number

	AREA	Data3, DATA
Result	DCD	0			;storage for result

	END
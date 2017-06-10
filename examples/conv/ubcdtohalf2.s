*	convert an unpacked BCD number to binary using MUL

	TTL	Ch7Ex6

	AREA	Program, CODE, READONLY
	ENTRY

Main
	LDR	R0, =BCDNum		;load address of BCD number
	MOV	R5, #4			;init counter
	MOV	R1, #0			;clear result register
	MOV	R2, #0			;and final register
	MOV	R7, #10			;multiplication constant

Loop
	MOV	R6, R1			
	MUL	R1, R6, R7		;mult by 10
	LDRB	R4, [R0], #1		;load digit and incr address
	ADD	R1, R1, R4		;add the next digit
	SUBS	R5, R5, #1		;decr counter
	BNE	Loop			;if count != 0, loop

	STR	R1, Result		;store the result
	SWI	&11			;all done

	AREA	Data1, DATA
BCDNum	DCB	&02,&09,&07,&01		;an unpacked BCD number
	ALIGN

	AREA	Data2, DATA
Result	DCD	0			;storage for result

	END
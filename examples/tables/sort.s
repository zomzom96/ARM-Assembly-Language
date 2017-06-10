*	sort a list of values - simple bubble sort

	TTL	Ch9Ex5
	AREA	Program, CODE, READONLY
	ENTRY

Main
	LDR	R6, List		;pointer to start of list
	MOV	R0, #0			;clear register
	LDRB	R0, [R6]		;get the length of list
	MOV	R8, R6			;make a copy of start of list
Sort
	ADD	R7, R6, R0		;get address of last element
	MOV	R1, #0			;zero flag for changes
	ADD	R8, R8, #1		;move 1 byte up the list each
Next					;iteration
	LDRB	R2, [R7], #-1		;load the first byte
	LDRB	R3, [R7]		;and the second
	CMP	R2, R3			;compare them
	BCC	NoSwitch		;branch if r2 less than r3

	STRB	R2, [R7], #1		;otherwise swap the bytes
	STRB	R3, [R7]		;like this
	ADD	R1, R1, #1		;flag that changes made
	SUB	R7, R7, #1		;decrement address to check
NoSwitch
	CMP	R7, R8			;have we checked enough bytes?
	BHI	Next			;if not, do inner loop
	CMP	R1, #0			;did we make changes
	BNE	Sort			;if so check again - outer loop

Done	SWI	&11			;all done

	AREA	Data1, DATA
Start	DCB	6
	DCB	&2A, &5B, &60, &3F, &D1, &19

	AREA	Data2, DATA
List	DCD	Start

	END
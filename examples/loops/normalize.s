*	normalize a binary number

	TTL	Ch5Ex6
	AREA	Program, CODE, READONLY	
	ENTRY

Main
	LDR	R0, =Data1		;load the address of the lookup table
	EOR	R1, R1, R1		;clear R1 to store shifts
	LDR	R3, [R0]		;get the data
	CMP	R3, R1			;bit is 1
	BEQ	Done			;if table is empty
Loop
	ADD	R1, R1, #1		;increment pointer
	MOVS	R3, R3, LSL#0x1		;decrement count with zero set
	BPL	Loop			;if negative flag is not set, loop
Done
	STR	R1, Shifted		;otherwise done - store result
	STR	R3, Normal
	SWI	&11

	AREA	Data1, DATA

Table	
*	DCD	&30001000		;table of values to be tested
*	DCD	&00000001
*	DCD	&00000000
	DCD	&C1234567

	AREA	Result, DATA

Number	DCD	Table
Shifted	DCB	0			;storage for shift
	ALIGN
Normal	DCD	0			;storage for result

	END
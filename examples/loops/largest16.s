*	Scan a series of 16 bit numbers to find the largest

	TTL	Ch5Ex5
	AREA	Program, CODE, READONLY	
	ENTRY

Main
	LDR	R0, =Data1		;load the address of the lookup table
	EOR	R1, R1, R1		;clear R1 to store largest
	LDR	R2, Length		;init element count
	CMP	R2, #0
	BEQ	Done			;if table is empty
Loop
	LDR	R3, [R0]		;get the data
	CMP	R3, R1			;bit is 1
	BCC	Looptest		;skip next line if zero
	MOV	R1, R3			;increment -ve number count
Looptest
	ADD	R0, R0, #+4		;increment pointer
	SUBS	R2, R2, #0x1		;decrement count with zero set
	BNE	Loop			;if zero flag is not set, loop
Done
	STR	R1, Result		;otherwise done - store result
	SWI	&11

	AREA	Data1, DATA

Table	DCW	&A152			;table of values to be tested
	ALIGN
	DCW	&7F61
	ALIGN
	DCW	&F123
	ALIGN
	DCW	&8000
	ALIGN
TablEnd	DCD	0

	AREA	Data2, DATA

Length	DCW	(TablEnd - Table) / 4	;because we're having to align
	ALIGN				;gives the loop count
Result	DCW	0			;storage for result

	END
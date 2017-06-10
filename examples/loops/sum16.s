*	Add a series of 16 bit numbers by using a table address look-up

	TTL	Ch5Ex1
	AREA	Program, CODE, READONLY	
	ENTRY

Main
	LDR	R0, =Data1		;load the address of the lookup table
	EOR	R1, R1, R1		;clear R1 to store sum
	LDR	R2, Length		;init element count
Loop
	LDR	R3, [R0]		;get the data
	ADD	R1, R1, R3		;add it to r1
	ADD	R0, R0, #+4		;increment pointer
	SUBS	R2, R2, #0x1		;decrement count with zero set
	BNE	Loop			;if zero flag is not set, loop
	STR	R1, Result		;otherwise done - store result
	SWI	&11

	AREA	Data1, DATA

Table	DCW	&2040			;table of values to be added
	ALIGN				;32 bit aligned
	DCW	&1C22
	ALIGN
	DCW	&0242
	ALIGN
TablEnd	DCD	0

	AREA	Data2, DATA
Length	DCW	(TablEnd - Table) / 4	;because we're having to align
	ALIGN				;gives the loop count
Result	DCW	0			;storage for result

	END
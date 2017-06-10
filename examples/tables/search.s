*	examine an ordered table for a match 

	TTL	Ch9Ex3
	AREA	Program, CODE, READONLY
	ENTRY

Main			
	LDR	R0, =NewItem		;load the address past the list
	SUB	R0, R0, #4		;adjust pointer to point at last element of list
	LDR	R1, NewItem		;load the item to test
	LDR	R3, Start		;init counter by reading index from list
	CMP	R3, #0			;are there zero items
	BEQ	Missing			;zero items in list - error condition
	LDR	R4, [R0], #-4
Loop
	CMP	R1, R4			;does the item match the list?
	BEQ	Done			;found it - finished
	BHI	Missing			;if the one to test is higher, it's not in the list
	SUBS	R3, R3, #1		;no - decr counter
	LDR	R4, [R0], #-4		;get the next item
	BNE	Loop			;and loop
					;if we get to here, it's not there either
Missing	MOV	R3, #0xFFFFFFFF		;flag it as missing

Done	STR	R3, Index		;store the index (either index or -1)
	SWI	&11			;all done

	AREA	Data1, DATA
Start	DCD	&4			;length of list
	DCD	&0000138A		;items
	DCD	&000A21DC
	DCD	&001F5376
	DCD	&09018613

	AREA	Data2, DATA
NewItem	DCD	&001F5376
Index	DCW	0
List	DCD	Start

	END
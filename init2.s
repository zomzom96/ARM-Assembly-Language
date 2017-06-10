*	initiate a simple stack

	TTL	Ch10Ex2
	AREA	Program, CODE, READONLY
	ENTRY

Main
	LDR	R1, Value1		;put some data into registers
	LDR	R2, Value2
	LDR	R3, Value3
	LDR	R4, Value4

	LDR	R7, =Data2
	STMDB	R7, {R1 - R4}

	SWI	&11			;all done

	AREA	Stack1, DATA
Value1	DCD	0xFFFF
Value2	DCD	0xDDDD
Value3	DCD	0xAAAA
Value4	DCD	0x3333

	AREA	Data2, DATA
Stack	%	40			;reserve 40 bytes of memory for the stack
StackEnd
	DCD	0

	END
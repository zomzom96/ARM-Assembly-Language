*	initiate a simple stack

	TTL	Ch10Ex3
	AREA	Program, CODE, READONLY
	ENTRY

StackStart	EQU	0x9000
Main	
	LDR	R1, Value1		;put some data into registers
	LDR	R2, Value2
	LDR	R3, Value3
	LDR	R4, Value4

	LDR	R7, =StackStart		;Top of stack = 9000
	STMDB	R7, {R1 - R4}		;push R1-R4 onto stack

	SWI	&11			;all done

	AREA	Data1, DATA
Value1	DCD	0xFFFF			;some data to put on stack
Value2	DCD	0xDDDD
Value3	DCD	0xAAAA
Value4	DCD	0x3333

	AREA	Data2, DATA
	^	StackStart		;reserve 40 bytes of memory for the stack
Stack1	DCD	0

	END
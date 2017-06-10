*	now something a little more adventurous - convert a 32 bit
*	hexadecimal number to an ASCII string and output to the terminal

	TTL	Ch7Ex2

	AREA	Program, CODE, READONLY
	ENTRY
Mask	EQU	0x0000000F

start
	LDR	R1, Digit		;load the digit
	MOV	R4, #8			;init counter
	MOV	R5, #28			;control right shift
MainLoop
	MOV	R3, R1			;copy original word
	MOV	R3, R3, LSR R5		;right shift the correct number of bits
	SUB	R5, R5, #4		;reduce the bit shift
	AND	R3, R3, #Mask		;mask out all but the ls nibble
	CMP	R3, #0xA		;is the number < 10 decimal
	BLT	Add_0			;then branch

	ADD	R3, R3, #"A"-"0"-0xA	;add offset for 'A' to 'F'

Add_0	ADD	R3, R3, #"0"		;convert to ASCII
	MOV	R0, R3			;prepare to output
	SWI	&0			;output to console
	SUBS	R4, R4, #1		;decrement counter
	BNE	MainLoop

	MOV	R0, #&0D		;add a CR character
	SWI	&0			;output it
	SWI	&11			;all done

	AREA	Data1, DATA
Digit	DCD	&DEADBEEF		;the hex word

	END
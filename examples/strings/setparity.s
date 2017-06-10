; Set the parity bit on a series of characters store the amended string in Result

	TTL	Ch6Ex5

	AREA	Program, CODE, READONLY	
	ENTRY

Main
	LDR	R0, =Data1		;load the address of the lookup table
	LDR	R5, =Pointer
	LDRB	R1, [R0], #1		;store the string length in R1
	CMP	R1, #0
	BEQ	Done			;nothing to do if zero length
MainLoop
	LDRB	R2, [R0], #1		;load the first byte into R2
	MOV	R6, R2			;keep a copy of the original char
	MOV	R2, R2, LSL #24		;shift so that we are dealing with msb
	MOV	R3, #0			;zero the bit counter
	MOV	R4, #7			;init the shift counter

ParLoop
	MOVS	R2, R2, LSL #1		;left shift
	BPL	DontAdd			;if msb is not a one bit, branch
	ADD	R3, R3, #1		;otherwise add to bit count
DontAdd
	SUBS	R4, R4, #1		;update shift count
	BNE	ParLoop			;loop if still bits to check
	TST	R3, #1			;is the parity even
	BEQ	Even			;if so branch
	ORR	R6, R6, #0x80		;otherwise set the parity bit
	STRB	R6, [R5], #1		;and store the amended char
	BAL	Check
Even	STRB	R6, [R5], #1		;store the unamended char if even pty
Check	SUBS	R1, R1, #1		;decrement the character count
	BNE	MainLoop

Done	SWI	&11

	AREA	Data1, DATA

Table	DCB	6			;data table starts with byte length of string
	DCB	0x31			;the string
	DCB	0x32
	DCB	0x33
	DCB	0x34
	DCB	0x35
	DCB	0x36

	AREA	Result, DATA
	ALIGN
Pointer	DCD	0			;storage for parity characters

	END
; Find the length of a CR terminated string

	TTL	Ch6Ex1 - strlencr

CR	EQU	0x0D

	AREA	Program, CODE, READONLY	
	ENTRY

Main
	LDR	R0, =Data1		; Load the address of the lookup table
	EOR	R1, R1, R1		; Clear R1 to store count
Loop
	LDRB	R2, [R0], #1		; Load the first byte into R2
	CMP	R2, #CR			; Is it the terminator ?
	BEQ	Done			; Yes => Stop loop
	ADD	R1, R1, #1		; No  => Increment count
	BAL	Loop			; Read next char

Done
	STR	R1, CharCount		; Store result
	SWI	&11

	AREA	Data1, DATA

Table
	DCB	"Hello, World", CR
	ALIGN

	AREA	Result, DATA
CharCount
	DCB	0			; Storage for count

	END
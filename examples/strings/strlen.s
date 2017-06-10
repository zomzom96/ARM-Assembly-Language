; Find the length of a null terminated string

	TTL	Ch6Ex1 - strlen
	AREA	Program, CODE, READONLY
	ENTRY

Main
	LDR	R0, =Data1		; Load the address of the lookup table
	MOV	R1, #-1			; Start count at -1
Loop
	ADD	R1, R1, #1		; Increment count
	LDRB	R2, [R0], #1		; Load the first byte into R2
	CMP	R2, #0			; Is it the terminator ?
	BNE	Loop			; No => Next char
	
	LDR R5, =CharCount
	STR	R1, [R5]		; Store result in CharCount
	

	AREA	Data1, DATA
	
Table
	DCB	"Hello, $$ World", 0
	

	AREA	Result, DATA, READWRITE
	ALIGN
CharCount SPACE	31			; Storage for count
	ALIGN
	END
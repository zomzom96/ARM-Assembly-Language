; Lookup the factorial from a table using the address of the memory location

	TTL	Ch4Ex9 - factorial
	AREA	Program, CODE, READONLY
	ENTRY

Main
	LDR	R0, =DataTable		; Load the address of the lookup table
	LDR	R1, Value		; Offset of value to be looked up
	MOV	R1, R1, LSL #0x2	; Data is declared as 32bit - need
					; to quadruple the offset to point at the
					; correct memory location
	ADD	R0, R0, R1		; R0 now contains memory address to store
	LDR	R2, [R0]
	LDR	R3, =Result		; The address where we want to store the answer
	STR	R2, [R3]		; Store the answer

	SWI	&11

	AREA	DataTable, DATA

	DCD	1		;0! = 1		; The data table containing the factorials
	DCD	1		;1! = 1
	DCD	2		;2! = 2
	DCD	6		;3! = 6
	DCD	24		;4! = 24
	DCD	120		;5! = 120
	DCD	720		;6! = 720
	DCD	5040		;7! = 5040
Value	DCB	5
	ALIGN
Result	DCW	0

	END
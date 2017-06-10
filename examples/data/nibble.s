; Disassemble a byte into its high and low order nibbles

	TTL	Ch4Ex6 - nibble
	AREA	Program, CODE, READONLY
	ENTRY

Main
	LDR	R1, Value		; Load the value to be disassembled
	LDR	R2, Mask		; Load the bitmask
	MOV	R3, R1, LSR #0x4	; Copy just the high order nibble into R3
	MOV	R3, R3, LSL #0x8	; Now left shift it one byte
	AND	R1, R1, R2		; AND the original number with the bitmask
	ADD	R1, R1, R3		; Add the result of that to
					; What we moved into R3
	STR	R1, Result		; Store the result
	SWI	&11

Value	DCB	&5F			; Value to be shifted
	ALIGN				; Keep the memory boundaries
Mask	DCW	&000F			; Bitmask = %0000000000001111
	ALIGN
Result	DCD	0			; Space to store result

	END
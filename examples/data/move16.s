; 16-Bit data transfer

	TTL	Ch4ex1 - move16
	AREA	Program, CODE, READONLY
	ENTRY

Main
	LDRB	R1, Value		; Load the value to be moved
	STR	R1, Result		; Store it back in a different location
	SWI	&11

Value	DCW	&C123			; Value to be moved
	ALIGN				; Need to do this because working with 16bit value
Result	DCW	0			; Storage space

	END
*	a simple subroutine example
*	program passes a variable to the routine in a register

	TTL	Ch10Ex4
	AREA	Program, CODE, READONLY
	ENTRY

StackStart	EQU	0x9000
Main
	LDRB	R0, HDigit		;variable stored to register
	BL	Hexdigit		;branch/link
	STRB	R0, AChar		;store the result of the subroutine
	SWI	&0			;output to console
	SWI	&11			;all done

*	=========================
*	Hexdigit subroutine
*	=========================

*	Purpose
*	Hexdigit subroutine converts a Hex digit to an ASCII character
*
*	Initial Condition
*	R0 contains a value in the range 00 ... 0F
*
*	Final Condition
*	R0 contains ASCII character in the range '0' ... '9' or 'A' ... 'F'
*
*	Registers changed
*	R0 only
*
*	Sample case
*	Initial condition	R0 = 6
*	Final condition		R0 = 36 ('6')

Hexdigit
	CMP	R0, #0xA		;is it > 9
	BLE	Addz			;if not skip the next
	ADD	R0, R0, #"A" - "0" - 0xA	;adjust for A .. F

Addz
	ADD	R0, R0, #"0"		;convert to ASCII
	MOV	PC, LR			;return from subroutine

	AREA	Data1, DATA
HDigit	DCB	6			;digit to convert
AChar	DCB	0			;storage for ASCII character

	END
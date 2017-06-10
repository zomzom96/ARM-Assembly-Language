*	a subroutine to find the factorial of a number

	TTL	Ch10Ex6
	AREA	Program, CODE, READONLY
	ENTRY

Main
	LDR	R0, Number		;get number
	BL	Factor			;branch/link
	STR	R0, FNum		;store the factorial

	SWI	&11			;all done


*	=========================
*	Factor subroutine
*	=========================

*	Purpose
*	Recursively find the factorial of a number
*
*	Initial Condition
*	R0 contains the number to factorial
*
*	Final Condition
*	R0 = factorial of number
*
*	Registers changed
*	R0 and R1 only
*
*	Sample case
*	Initial condition
*	Number = 5
*
*	Final condition
*	FNum = 120 = 0x78

Factor
	STR	R0, [R12], #4		;push to stack
	STR	R14, [R12], #4		;push the return address
	SUBS	R0, R0, #1		;subtract 1 from number
	BNE	F_Cont			;not finished

	MOV	R0, #1			;Factorial == 1
	SUB	R12, R12, #4		;adjust stack pointer
	B	Return			;done

F_Cont
	BL	Factor			;if not done, call again
	
Return	
	LDR	R14, [R12], #-4		;return address
	LDR	R1, [R12], #-4		;load to R1 (can't do MUL R0, R0, xxx)
	MUL	R0, R1, R0		;multiply the result
	MOV	PC, LR			;and return

	AREA	Data1, DATA
Number	DCD	5			;number
FNum	DCD	0			;factorial
	END
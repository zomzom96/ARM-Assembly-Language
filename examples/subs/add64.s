*	a 64 bit addition subroutine

	TTL	Ch10Ex6
	AREA	Program, CODE, READONLY
	ENTRY

Main	
	BL	Add64			;branch/link
	DCD	Value1			;address of parameter 1
	DCD	Value2			;address of parameter 2

	SWI	&11			;all done


*	=========================
*	Add64 subroutine
*	=========================

*	Purpose
*	Add two 64 bit values
*
*	Initial Condition
*	The two parameter values are passed immediately 
*	following the subroutine call
*
*	Final Condition
*	The sum of the two values is returned in R0 and R1
*
*	Registers changed
*	R0 and R1 only
*
*	Sample case
*	Initial condition
*	para 1 =   = &0420147AEB529CB8
*	para 2 =   = &3020EB8520473118
*
*	Final condition
*	R0 = &34410000
*	R1 = &0B99CDD0

Add64
	STMIA	R12, {R2, R3, R14}	;save registers to stack
	MOV	R7, R12			;copy stack pointer
	SUB	R7, R7, #4		;adjust to point at LSB of 2nd value
	LDR	R3, [R7], #-4		;load successive bytes
	LDR	R2, [R7], #-4
	LDR	R1, [R7], #-4
	LDR	R0, [R7], #-4

	ADDS	R1, R1, R3		;add LS bytes & set carry flag
	BCC	Next			;branch if carry bit not set
	ADD	R0, R0, #1		;otherwise add the carry
Next
	ADD	R0, R0, R2		;add MS bytes
	LDMIA	R12, {R2, R3, R14}	;pop from stack
	MOV	PC, LR			;and return

	AREA	Data1, DATA
Value1	DCD	&0420147A, &EB529CB8	;number1 to add
Value2	DCD	&3020EB85, &20473118	;number2 to add
	END
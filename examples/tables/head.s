*	remove the first element of a queue

	TTL	Ch9Ex4
	AREA	Program, CODE, READONLY
	ENTRY

Main
	LDR	R0, Queue		;load the head of the queue
	STR	R1, Pointer		;and save it in 'Pointer'
	CMP	R0, #0			;is it NULL?
	BEQ	Done			;if so, nothing to do

	LDR	R1, [R0]		;otherwise get the ptr to next
	STR	R1, Queue		;and make it the start of the queue

Done	SWI	&11

	AREA	Data1, DATA
Queue	DCD	Item1			;pointer to the start of the queue
Pointer	DCD	0			;space to save the pointer

DArea	%	20			;space for new entries

* each item consists of a pointer to the next item, and some data
Item1	DCD	Item2			;pointer
	DCB	30, 20			;data

Item2	DCD	Item3			;pointer 
	DCB	30, 0xFF		;data

Item3	DCD	0			;pointer (NULL)
	DCB	30,&87,&65		;data

	END
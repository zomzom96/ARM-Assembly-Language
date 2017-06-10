; File: HA3-main.s

 
; This file needs to be in a Keil version 5 project, together with file init.s

; This program file is for CS 238 Home Assignment HA3
; Later home assignments will have similar files, like HA4-main.s, HA5-main.s, etc.

	EXPORT	main		; this line is needed to interface with init.s

	AREA    MyCode, CODE, READONLY

	ALIGN			; highly recommended to start and end any area with ALIGN

; Start of executable code is at following label: main

main

	PUSH	{LR}		; save return address of caller in init.s

; Single-step thru the following program in the debugger,
; observe the register contents after each instruction, and
; answer the questions asked.

; WRITE ALL YOUR ANSWERS IN THE HEX NOTATION, e.g. 0xA92C
; THE FIRST LINE IS ALREADY ANSWERED AS AN EXAMPLE

	MOV	R0, #14		; R0 = 0xE

	MOV	R1, #1234	; R1 = 0x4D2

	ADD	R2, R1, R0	; R2 = 0x4E0, R1 = 0x4D2, R0 = 0xE

Five	EQU	5

	LDR	R3, =Data1
	LDR	R3, [R3]	; R3 = 0xA

	ADD	R3, #Five	; R3 = 0xF

	MOV	R4, #-1		; R4 = 0xFFFFFFFF

	ADD	R5, R3, R4	; R5 = 0xE

	LDR	R0, =Data1 + 8	; R0 = 0x73C

	LDR	R6, [R0]	; R6 = 0x29

	LDR	R7, [R0, #4]	; R7 = 0x734

	POP	{PC}		; return from main (our last executable instruction)
	
	ALIGN

; Data for this program (readonly for HA3):

Data1	DCD	10, 26, 41	; Three 32-bit words, containing decimal values 10, 26, and 41

	ALIGN

	END			; end of source program in this file

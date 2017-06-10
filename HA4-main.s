; File: HA4-main.s


; This file needs to be in a Keil version 5 project, together with file init.s

; This is an initial demo program for HA4, which you need to change to complete HA4

; All future CS 238 Home Assignments, will have similar but different files,
; like HA5-main.s, HA6-main.s, etc.

; Executable code in HAx-main.s files should start at label main

	EXPORT	main		; this line is needed to interface with init.s

; Usable utility functions defined in file init.s
; Importing any label from another source file is necessary
; in order to use that label in this source file

	IMPORT	GetCh		; Input one ASCII character from the UART #1 window (from keyboard)
	IMPORT	PutCh		; Output one ASCII character to the UART #1 window
	IMPORT	PutCRLF		; Output CR and LF to the UART #1 window
    IMPORT	UDivMod		; Perform unsigned division to obtain quotient and remainder
	IMPORT	GetDec		; Input a signed number from the UART #1 window
	IMPORT	PutDec		; Output a signed number to the UART #1 window
	IMPORT	GetStr		; Input a CR-terminated ASCII string from the UART #1 window
	IMPORT	PutStr		; Output null-terminated ASCII string to the UART #1 window

	AREA    MyCode, CODE, READONLY

	ALIGN			; highly recommended to start and end any area with ALIGN

; Start of executable code is at following label: main

main

;-------------------- START OF MODIFIABLE CODE ----------------------

	PUSH	{LR}		; save return address of caller in init.s

	MOV R0, #6
	MOV R1, #2
	udiv R0, R1
	BL PutDec
	
	POP	{PC}		; return from main (our last executable instruction)
	
; Some commonly used ASCII codes

CR	EQU	0x0D	; Carriage Return (to move cursor to beginning of current line)
LF	EQU	0x0A	; Line Feed (to move cursor to same column of next line)

; The following data items are in the CODE area,
; so they are all READONLY (i.e. cannot be modified at run-time),
; but they can be initialized at assembly-time to any value

Prompt1	DCB	"Hi, what's your name? ", 0
Msg1	DCB	", please enter an integer number: ", 0
Msg2	DCB	"Well, the number ", 0
Msg3	DCB	" is twice your number!", CR, LF, 0

	ALIGN
		
; The following data items are in the DATA area,
; so they are all READWRITE (i.e. can be modified at run-time),
; but are automatically initialized at assembly-time to zeroes 

	AREA    MyData, DATA, READWRITE
		
	ALIGN

MaxName	EQU	1000		; your name better be within 1000 characters :)

Name	SPACE	MaxName + 1	; storage space for name (and NULL byte at end)
	
Value	SPACE	4		; 4 bytes for storing input number

;-------------------- END OF MODIFIABLE CODE ----------------------

	ALIGN

	END			; end of source program in this file
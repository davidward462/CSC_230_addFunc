;
; addFunc.asm
;
; Created: 08/03/2020 14:35:26
; Author : nkfyn
;

.cseg 
.org 0

;init stack
ldi r16, high(RAMEND)
ldi r17, low(RAMEND)
out SPH, r16
out SPL, r17

ldi r16, 0xff  ;arg A
ldi r17, 0xff ;arg B
push r16
push r17


;takes to 1-byte values on the stack and adds them.
;Returns the sum on the stack in 2 bytes
call addFunc
;get return value
pop r20 ;high
pop r19 ;low

done:
	rjmp done

addFunc:
	push r16
	push r17
	push r18
	push r0

	.equ offset = 7
	.def A = r16
	.def B = r17
	.def sumH = r18
	.def zero = r0

	;set Y
	in YL, SPL
	in YH, SPH	

	add A, B		;get low byte
	adc sumH, zero  ;get high byte

	;store in stack (return)
	std Y+offset+1, sumH ;high
	std Y+offset+2, A	 ;low

	pop r0
	pop r18
	pop r17
	pop r16

	ret

.dseg
.org 0x0200


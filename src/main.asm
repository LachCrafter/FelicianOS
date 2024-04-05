org 0x7C00
bits 16

%define ENDL 0x0D, 0x0A

start:
	jmp main

; print string
puts:
	push si
	push ax


.loop:
	lodsb		; load byte from si to al
	or al, al	; check if al is zero
	jz .done	; if al is zero, we are done

	mov ah, 0x0E
	int 0x10

	jmp .loop


.done:
	pop ax
	pop si
	ret



main:
	; segments setup
	mov ax, 0
	mov ds, ax
	mov es, ax


	; stack setup
	mov ss, ax
	mov sp, 0x7C00

	; print message
	mov si, msg_hello
	call puts


	hlt

.halt:
	jmp .halt

msg_hello db "Hello, World!", ENDL, 0

times 510-($-$$) db 0
dw 0xAA55

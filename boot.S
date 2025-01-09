BITS 16
ORG 0x7c00

section .text
global _start

_start:
	mov si, message ; Change 'message' to another string 
	call print_char
	call hang

print_char:
	mov al, [si] ; Load the string
	cmp al, 0
	je hang
	mov ah, 0x0E ; Teletype output
	int 0x10 ; Print from al
	inc si ; Increment to load next char
	jmp print_char ; Continue until \0

load_disk:
	; TODO : Load disk (int 0x13)
	; TODO 2 : Read input from user,
	; TODO 3 : Print that input,
	; TODO 4 : Store that input to the drive.

hang:
	jmp hang

message:
	db "Basic Bootloader loaded!", 0

times 510-($-$$) db 0 ; Fill
dw 0xAA55

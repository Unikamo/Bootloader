BITS 16
ORG 0x7c00

section .text
global _start

_start:
	mov si, message ; Change 'message' to another string 
	call print_char
	jmp hang

print_char:
	mov al, [si] ; Load the string
	cmp al, 0
	je hang
	mov ah, 0x0E ; Teletype output
	int 0x10 ; Print from al
	inc si ; Increment to load next char
	jmp print_char ; Continue until \0

load_disk:
	mov ah, 15
	mov dl, 0x80 ; 1st HDD
	int 0x13
	
	jc disk_error ; If CF is set, go to disk_error

	mov ah, 0x13 ; Write sector
	mov al, 1 ; To the first sector
	mov ch, 0 ; First Cylinder high byte
	mov cl, 1 ; First sector and High Byte 0
	mov dh, 0 ; First head
	mov dl, 0x80 ; First HD
	mov ax, 0x1000
	mov es, ax ; Idfk what that means, but it will work
	lea bx, [message] ; What message to write
	int 0x13	

	jc disk_error
	
	jmp hang
	
	; TODO 2 : Read input from user,
	; TODO 3 : Print that input,
	; TODO 4 : Store that input to the drive.
	; TODO 5 : Write time && date for every boot

disk_error:
	mov si, error
	call print_char

	mov al, ah
	add al, '0'
	mov ah, 0x0E
	int 0x10

	jmp hang

hang:
	jmp hang

error:
	db "An error occured: ", 0

load_msg:
	db "Wrote to disk!", 0

message:
	db "Basic Bootloader loaded!", 0

times 510-($-$$) db 0 ; Fill
dw 0xAA55

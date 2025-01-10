bits 16
org 0x7c00

%include "print.S" ; to print
%include "graphics.S" ; for graphic colors
; Current : 80x25 text mode

mov ax, 0
mov ds, ax

; FIXME idfk what's the issue, just won't print
jmp change_videomode

jmp green_foreground
mov si, message ; Change 'message' to another string 
call print

jmp red_foreground
mov si, message
call print

jmp grey_foreground
mov si, message
call print


;call load_disk
;call read_disk

jmp hang

read_disk:
	mov ah, 0x2 ; Read sector
	mov al, 5 ; Read 5 sectors
	mov ch, 0 ; From cylinder 0
	mov cl, 2 ; Sector number 2
	mov dh, 0 ; Head #0
	xor bx, bx
	mov es, bx
	mov bx, 0x7e00
	int 0x13
	jmp 0x7e00

	ret
	

load_disk:
	mov ah, 0x13 ; Write sector
	mov al, 1 ; Write 1 sector 
	mov ch, 0 ; First Cylinder high byte
	mov cl, 2 ; Second sector and High Byte 0
	mov dh, 0 ; First head
	mov dl, 0x80 ; First HD
	
	lea bx, [disk_content] ; What message to write
	mov ax, 0x1000
	mov es, ax ; Idfk what that means, but it will work
	int 0x13

	jc disk_error

	mov si, load_msg
	call print
	
	ret
	
	; TODO 2 : Read input from user,
	; TODO 3 : Print that input,
	; TODO 4 : Store that input to the drive.
	; TODO 5 : Write time && date for every boot

disk_error:
	mov si, error
	call print

	mov al, ah
	add al, '0'
	mov ah, 0x0E
	int 0x10

	ret

hang:
	jmp hang

reset_registers:
	xor ah, ah
	xor al, al
	xor ch, ch
	xor dl, dl
	xor cl, cl
	xor dh, dh
	xor dl, dl
	mov ax, 0
	mov es, ax
	xor ax, ax	
	xor bx, bx
	xor si, si



disk_content: db "This was written to the disk!", 0

times 510-($-$$) db 0 ; Fill
dw 0xAA55

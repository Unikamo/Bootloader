print:
	mov ah, 0x0e
.print_loop:
	lodsb
	or al, al ; Check for \0
	jz .done
	int 0x10
	inc si
	jmp .print_loop
.done:
	ret

error: db "An error occured: ", 0
load_msg: db "Wrote to disk", 0xD, 0xA, 0
message: db "Basic bootloader loaded!", 0xD, 0xA, 0

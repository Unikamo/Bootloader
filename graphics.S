jmp graphics_null

change_videomode:
	mov ah, 0x00
	mov al, 0x03 ; 80x25 text mode
	int 0x10 ; Video Mode
	ret

red_foreground:
	mov ah, 0x07
	mov bh, 0x04 ; Color : Black Background + Red Foreground
	int 0x10 ; Change BG and FG color
	ret

green_foreground:
	mov ah, 0x07
	mov bh, 0x02 ; Color : Black Background + Red Foreground
	int 0x10 ; Change BG and FG color
	ret

grey_foreground:
	mov ah, 0x07
	mov bh, 0x07 ; Color : Black Background + Red Foreground
	int 0x10 ; Change BG and FG color
	ret

graphics_null:

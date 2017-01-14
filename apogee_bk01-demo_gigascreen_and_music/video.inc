; (c) 2012 vinxru

vmem dw 0A000h

;----------------------------------------------------------------------------

initGraph1:
	ei
	ld hl, 0EF01h
	ld (hl), 0
	dec hl
	ld (hl), 04Dh ; Линий ; 4D 5D
	ld (hl), 03Fh ; Высота + КСИ
	ld (hl), 033h ; Подчеркивание и высота символа
	ld (hl), 013h ; Обратный ход развертки
	inc hl
	ld (hl), 080h
	dec hl
	ld (hl), 0
	ld (hl), 0
	jp switchVideoPage
	
;----------------------------------------------------------------------------

waitHorzSync:
	ld hl, 0EF01h
	ld (hl), 027h
	ld a, (hl)
waitHorzSync_1:
	ld a, (hl)
	and 20h
	jp z, waitHorzSync_1
	ret

;----------------------------------------------------------------------------

switchVideoPage:
	call waitHorzSync
	ld hl, (vmem)
switchVideoPage2:
	ex hl, de                   // 4992 = 1380
	ld hl, 0F008h               // (78+16)*64 = 6016 = 1780
	ld (hl), 80h
	ld l, 4
	ld (hl), e
	ld (hl), d
	inc l
	ld (hl), 0FFh // low
	ld (hl), 066h // 40 | high
	ld l, 8
	ld (hl), 0A4h
	ret


; (c) 2012 vinxru

	device ZXSPECTRUM48
	org 0h
begin:
	db 0
	db 4
	db end>>8
	db end&0xFF

;----------------------------------------------------------------------------

start:	ld hl, title
	call 0F818h

	call initMusic

	ld a, 6
sdd:	push af
	call doMusicDelay
	pop af
	dec a
	jp nz, sdd

	; Копируем графику
	ld bc, graphT
	ld de, graphTE-graphT
	ld hl, 07000h
	call setGraph

	ld bc, graphF
	ld de, graphFE-graphF
	ld hl, 0A000h
	call setGraph

	call initGraph1

lxx:	call doMusicDelay

	; Change images
	ld a, (gci)
	inc a
	and 63
	ld (gci), a
	jp nz, lxx

	ld hl, 0A000h
	ld a, (gcc)
	xor 1
	ld (gcc), a
	jp nz, lxy
  	  ld hl, 7000h
lxy: 	call switchVideoPage2
	jp lxx

;----------------------------------------------------------------------------

	include "video.inc"

;----------------------------------------------------------------------------

title	db 1Fh,"GIGASCREEN & MUSIC DEMO (C) 24-09-2012 VINXRU",0
gci     db 0
gcc	db 0

setGraph:
l1:	ld a, (bc)
	ld (hl), a
	inc hl
	inc bc
	dec de
	ld a, d
	or e
	jp nz, l1

	ret

;----------------------------------------------------------------------------

	include "music.inc"

;----------------------------------------------------------------------------

graphT: include "image_tiger.inc"
graphTE:
graphF: include "image_flower.inc"
graphFE:

;----------------------------------------------------------------------------

end:    db 0, 0
	savebin "gigascreen.rka", begin, end
; (c) 2012 vinxru

initMusic:	ld hl, music
		ld (musicptr), hl
		ld hl, channelInfo
		xor a
		DUP 6
		ld (hl), a
		inc hl
		EDUP
		ret

doMusic:	ld e, 0
		ld hl, channelInfo
		call processChannel
                ld e, 1
		ld hl, channelInfo+2
		call processChannel
                ld e, 2
		ld hl, channelInfo+4
		jp processChannel		

doMusicDelay:	call doMusic
		DUP 7
		call waitHorzSync
		call doMute	
		EDUP
		ret

;------------------------------------------------------------------

musicptr	dw music
channelInfo	db 0,0,0,0,0,0

;------------------------------------------------------------------


restartMelody:  push hl
		call initMusic
		pop hl

processChannel:	; hl - указатель на channelInfo
		; e - канал

		ld a, (hl)
		or a
		jp nz, channelWait

                ; a = *musicptr++
		push hl
		ld hl, (musicptr)
		ld a, (hl)
		inc hl
		ld (musicptr), hl
		pop hl

		; end of melody
		cp 0FFh
		jp z, restartMelody

		; delay
		ld d, a
		ccf
		rlca
		rlca
		rlca
		and 7
		ld (hl), a		

		; note
		ld a, d
		and 01Fh

		; none
		ret z

		; noise
		cp 1
		jp z, noise

		; bc = word_notes[a]
		push hl
		ld l, a
		ld h, 0
		add hl, hl
		ld bc, notes
		add hl, bc 
		ld c, (hl)
		inc hl
		ld b, (hl)
		pop hl
		
		; Задержа
		ld a, 16

		jp writeFq

;------------------------------------------------------------------

noise:		; Задержа
		ld a, 2

		; Частота
                ld bc, 160

writeFq:	; Задержа
      		inc hl
		ld (hl), a

		; Сдвиг
		ld h, 0
		ld l, e
		add hl, hl
		add hl, hl
		add hl, bc		
		ld bc, hl				

		; Запись частоты
		ld l, e
		ld h, 0xEC		
		ld (hl), 1
		ld (hl), 1

		; Запись частоты
		ld l, e
		ld h, 0xEC		
		ld (hl), c
		ld (hl), b

		ret
		
;------------------------------------------------------------------

channelWait:	dec (hl)
		ret

;------------------------------------------------------------------

doMute:		ld hl, 0EC03h
		ld de, channelInfo+1
		ld b, 3Eh
		call mutex
		ld b, 40h|3Eh
		call mutex
		ld b, 80h|3Eh
mutex:		ld a, (de)
		or a
		jp z, l21
		dec a
		jp nz, l11
		ld (hl), b
l11:		ld (de), a
l21:		inc de
		inc de
		ret

;------------------------------------------------------------------

notes:		include "music_notes.inc";
music:		incbin "music.bin"

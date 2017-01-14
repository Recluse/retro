.org 0

begin:	; Очищаем экран
	mvi c, 1Fh
	call 0F809h
	
	; Начальная глава
	xra a
	sta curChapter

	; Скрываем курсор
	call hideCursor

	; Рисуем рамку
	lxi b, screenS
	lxi h, 0E2C1h
	call prn
	call clearCenter
	lxi b, screenE
	call prn

	; Разархивация главы
loadChapter:
	lhld curChapter
	mvi h, 0
	dad h
	lxi d, map
	dad d
	mov e, m
	inx h
	mov d, m
        lxi b, buffer
        call unmlz

	; Первая страница в главе
	mvi c, 0

	; Поиск страницы
loadPage:
	lxi h, buffer
	; Переход на следующую главу
	mov a, c
	cpi 254
	jz nextChapter	
	; Поиск страницы
	inr c
loadPage_1:
	dcr c
	jz drawPage
loadPage_2:
	mov a, m
	inx h
	ora a
	jnz loadPage_2
	mov a, m
	inx h
	cpi 0FFh
	jnz loadPage_2
	jmp loadPage_1

;----------------------------------------------------------------------------

beep:	; Би-би
	mvi c, 7
	call 0F809h	
hideCursor:
	; Скрываем курсор
	push h
	lxi h, 0EF01h
	mvi m, 80h
	dcx h
	mvi m, 0FFh
	mvi m, 0FFh
	pop h
	ret

;----------------------------------------------------------------------------

clearCenter:
	lxi h, 0E30Fh
	mvi d, 23
clearCenter_1:
	push d
	lxi b, screenL
	call prn
	pop d
	dcr d
	jnz clearCenter_1
	ret

;----------------------------------------------------------------------------
		
drawPage:
	push h
	call clearCenter
	pop b

	lxi h, 0E360h
	call prn

	lxi d, ptrs
drawPage_1:

	ldax b
	inx b
	cpi 0FFh
	jz drawPage_2

	stax d
	inx d
	
	push d
	push b
	lxi b, mark
	call prn
	pop b
	call prn_l
	pop d

	jmp drawPage_1

;----------------------------------------------------------------------------

drawPage_2:
	mvi a, -1
	sta cursorN
	lxi h, 0E2C0h
	lxi b, 1
	jmp move_1

;----------------------------------------------------------------------------

nextChapter:
	lxi h, curChapter
	inr m
	jmp loadChapter	

;----------------------------------------------------------------------------

loop:  	
	lhld cursorPos
	mvi a, 9
	cmp m
	jnz loop_5
	xra a
loop_5:	mov m, a

	
	lxi h, 3000h
wait_2:	dcr l
	jnz wait_2
	dcr h
	jnz wait_2
	
	call 0F81Bh
	cpi 0FFh
	jz loop
	call beep

	lxi h, 5000h
wait_0:	dcr l
	jnz wait_0
	dcr h
	jnz wait_0

	cpi 19h
	jz left
	cpi 1Ah
	jz right
	cpi 'Q'
	jz nextChapter
	cpi 1Bh
	jz begin
	cpi 0Dh
	jz enter

	jmp loop

enter:	lhld cursorN
	mvi h, 0
	lxi d, ptrs
	dad d
	mov c, m	
	jmp loadPage

;----------------------------------------------------------------------------

left:	lxi b, -1
	jmp move

;----------------------------------------------------------------------------

right:	lxi b, 1

move:	lhld cursorPos
	mvi m, '*'
move_1: dad b
	mov a, h
	cpi 0E1h
	jz move_2
	cpi 0EBh
	jz move_2
	mov a, m
	cpi '*'
	jnz move_1
	lda cursorN
	add c
	sta cursorN
move_3: mvi m, 9
        shld cursorPos
	jmp loop

;----------------------------------------------------------------------------

move_2:	lhld cursorPos
	jmp move_3

;----------------------------------------------------------------------------

prn_e:	lxi d, 78
	dad d
prn:	mov d, h
	mov e, l
prn_l:	ldax b
	inx b
	cpi 0
	rz
	cpi 10
	jz prn_e
	stax d
	inx d
	jmp prn_l

;----------------------------------------------------------------------------

.include "unmlz.inc"

;----------------------------------------------------------------------------

screenS:    .db 094h," ","\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/ stanx stalxnoj krysoj \\/\\/\\/\\/\\/\\/\\/\\/\\/\\ ",80h,10,0 ;0
screenL:    .db 094h,' ',80h,"                                                            ",94h,' ',80h,10,0 ;1
screenE:    .db 094h," "," ESC - sna~ala \\/\\/\\/\\/\\/\\/\\/\\/\\ 2014 garri garrison & VINXRU  ",80h,0,0 ; 24
mark:	    .db 10, 10, "* ",0
curChapter: .db 0
cursorPos:  .dw 0E2C0h
cursorN:    .db 0
ptrs:       .db 0,0,0,0

;----------------------------------------------------------------------------

map:    .dw page01, page02, page03, page04, page05, page06, page08, page09,
	.dw page10, page11, page12, page13, page14, page15, page16

page01: .include "scenario/a.inc"
page02: .include "scenario/b.inc"
page03: .include "scenario/c.inc"
page04: .include "scenario/d.inc"
page05: .include "scenario/e.inc"
page06: .include "scenario/f.inc"
page08: .include "scenario/h.inc"
page09: .include "scenario/i.inc"
page10: .include "scenario/i2.inc"
page11: .include "scenario/j.inc"
page12: .include "scenario/k.inc"
page13: .include "scenario/l.inc"
page14: .include "scenario/m.inc"
page15: .include "scenario/n.inc"
page16: .include "scenario/o.inc"

buffer: .db 0

.end begin
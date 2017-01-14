  .include "stdlib8080.inc"
printValue:
  shld printValue_2
  ; 5 puts(text);
  lhld printValue_1
  call 63512
  ; 6 puthex(v>>8);Сдвиг на 8 вправо
  lhld printValue_2
  mov l, h
  mvi h, 0
  mov a, l
  call 63509
  ; 7 puthex(v&0xFF);16 битная арифметическая операция с константой
  lhld printValue_2
  mvi h, 0
  mov a, l
  call 63509
  ; 8 putch(13);
  mvi a, 13
  call putch
  ; 9 putch(10);
  mvi a, 10
  jmp putch
main:
  call clrscr
  ; 17 printValue("FREE MEMORY: ", getMemTop());
  lxi h, string0
  shld printValue_1
  call 63536
  call printValue
  ; 18 setMemTop(0x8000);
  lxi h, 32768
  call 63539
  ; 19 printValue("FREE MEMORY: ", getMemTop());
  lxi h, string0
  shld printValue_1
  call 63536
  call printValue
  ; 21 printValue("BIOS CRC: ", crcTape((char*)0xF000, (char*)0xFFFF));
  lxi h, string1
  shld printValue_1
  lxi h, 61440
  shld crcTape_1
  lxi h, 65535
  call crcTape
  call printValue
  ; 23 for(c=10; c!=55; c++) {
  mvi a, 10
  sta main_c
l0:
  lda main_c
  cpi 55
  jz l1
  ; 24 gotoxy(c,5);
  sta gotoxy_1
  mvi a, 5
  call gotoxy
  ; 25 putch('*');
  mvi a, 42
  call putch
  ; 26 gotoxy(c,20);
  lda main_c
  sta gotoxy_1
  mvi a, 20
  call gotoxy
  ; 27 putch('*');
  mvi a, 42
  call putch
l2:
  lxi h, main_c
  mov a, m
  inr m
  jmp l0
l1:
  ; 29 for(c=5; c!=21; c++) {
  mvi a, 5
  sta main_c
l3:
  lda main_c
  cpi 21
  jz l4
  ; 30 gotoxy(10,c);
  mvi a, 10
  sta gotoxy_1
  lda main_c
  call gotoxy
  ; 31 putch('*');
  mvi a, 42
  call putch
  ; 32 gotoxy(55,c);
  mvi a, 55
  sta gotoxy_1
  lda main_c
  call gotoxy
  ; 33 putch('*');
  mvi a, 42
  call putch
l5:
  lxi h, main_c
  mov a, m
  inr m
  jmp l3
l4:
  ; 36 printValue("\r\nCURSOR: ", wherexy());
  lxi h, string2
  shld printValue_1
  call 63518
  call printValue
  ; 38 while(1) {
l6:
  ; 39 c=getch();
  call 63491
  sta main_c
  ; 40 switch(c) {
  cpi 82
  jnz l10
l9:
  ; 41 reboot();
  call 63488
l10:
  ; 42 putch(c);
  lda main_c
  call putch
l8:
  jmp l6
l7:
  ret
  ; --- putch -----------------------------------------------------------------
putch:
    mov c, a
    call 0F809h
  
  ret
  ; --- clrscr -----------------------------------------------------------------
clrscr:
    mvi c, 1Fh
    call 0F809h
  
  ret
  ; --- crcTape -----------------------------------------------------------------
crcTape:
    push b
    xchg
    lhld crcTape_1
    call 0F82Ah
    mov h, b
    mov l, c
    pop b
  
  ret
  ; --- gotoxy -----------------------------------------------------------------
gotoxy:
  sta gotoxy_2
  ; 2 putch(0x1B);
  mvi a, 27
  call putch
  ; 3 putch('Y');
  mvi a, 89
  call putch
  ; 4 putch(y+0x20);
  lda gotoxy_2
  adi 32
  call putch
  ; 5 putch(x+0x20);
  lda gotoxy_1
  adi 32
  jmp putch
printValue_1:
 .ds 2
printValue_2:
 .ds 2
main_c:
 .ds 1
putch_1:
 .ds 1
crcTape_1:
 .ds 2
crcTape_2:
 .ds 2
gotoxy_1:
 .ds 1
gotoxy_2:
 .ds 1
string2:
 .db 13,10,67,85,82,83,79,82,58,32,0
string1:
 .db 66,73,79,83,32,67,82,67,58,32,0
string0:
 .db 70,82,69,69,32,77,69,77,79,82,89,58,32,0
  .end

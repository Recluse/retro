#include <mem.h>
#include <apogey/bios.h>

void printValue(const char* text, int v) {
  puts(text);
  puthex(v>>8);
  puthex(v&0xFF);
  putch(13);
  putch(10);
}

void main() {
  char c;    

  clrscr();

  printValue("FREE MEMORY: ", getMemTop());
  setMemTop(0x8000);
  printValue("FREE MEMORY: ", getMemTop());

  printValue("BIOS CRC: ", crcTape((char*)0xF000, (char*)0xFFFF));
  
  for(c=10; c!=55; c++) {
    gotoxy(c,5);
    putch('*');
    gotoxy(c,20);
    putch('*');
  }
  for(c=5; c!=21; c++) {
    gotoxy(10,c);
    putch('*');
    gotoxy(55,c);
    putch('*');
  }

  printValue("\r\nCURSOR: ", wherexy());

  while(1) {
    c=getch();
    switch(c) {
      case 'R': reboot();
      default: putch(c);
    }
  }
}
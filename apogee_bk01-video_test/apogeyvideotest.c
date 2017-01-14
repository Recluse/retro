#include <mem.h>
#include <apogey/screen_constrcutor.h>
//#include <apogey/video.h>
#include <apogey/bios.h>
#include "gprint.h"
#include "giga.h"

void print2x(uchar* dest, char* text) {
  asm {
    xchg
    lhld print2x_1
print2x_loop:
    ldax d
    ora  a
    rz
    mov  m, a
    inx  h
    inx  d
    jmp  print2x_loop
  }
}

void printx(uchar x, uchar y, char* text) {
  print2x(charAddr(x, y), text);
}

void test(uchar apogeyVideoHeight) {
  uchar i;
  for(i=1; i<apogeyVideoHeight; i++) {
    printx(i,i,"\x81HELLO WORLD\x84");
    printx(64-16-i,i,"\x84HELLO WORLD\x81");
  }
  getch();
}

void gtest(uchar apogeyVideoHeight) {
  uchar i;
  for(i=3; i<apogeyVideoHeight; i++) {
    printx(i,i,"\x81\x44\x7B\x7F\x3F\x7F\x7B\x44\x84");
    printx(64-11-i,i,"\x84\x44\x7B\x7F\x3F\x7F\x7B\x44\x81");
  }
  getch();
}


void test16(uchar apogeyVideoHeight) {
  uchar i;
  for(i=2; i<apogeyVideoHeight; i++) {
    printx(0,i,"\x80HELL\x81O WO\x84RLD \x85!!! \x88THIS\x89 IS \x8CTEST\x8D:):)");
    printx(40,i,"\x90HELL\x91O WO\x94RLD \x95!!! \x98THIS\x99 IS \x9CTEST\x9D:):)");
    i++;
    if(i==apogeyVideoHeight) break;
    printx(0,i,"\x82HELL\x83O WO\x86RLD \x87!!! \x8ATHIS\x8B IS \x8ETEST\x8F:):)");
    printx(40,i,"\x92HELL\x93O WO\x96RLD \x97!!! \x9ATHIS\x9B IS \x9ETEST\x9F:):)");
  }
  getch();
}

void gtest16(uchar apogeyVideoHeight) {
  uchar i;
  for(i=3; i<apogeyVideoHeight; i++) {
    printx(0 ,i,"\x80\x3F\x7F\x7B\x44\x81\x3F\x7F\x7B\x44\x84\x3F\x7F\x7B\x44\x85\x3F\x7F\x7B\x44\x88\x3F\x7F\x7B\x44\x89\x3F\x7F\x7B\x44\x8C\x3F\x7F\x7B\x44\x8D\x3F\x7F\x7B\x44");
    printx(40,i,"\x90\x3F\x7F\x7B\x44\x91\x3F\x7F\x7B\x44\x94\x3F\x7F\x7B\x44\x95\x3F\x7F\x7B\x44\x98\x3F\x7F\x7B\x44\x99\x3F\x7F\x7B\x44\x9C\x3F\x7F\x7B\x44\x9D\x3F\x7F\x7B\x44");
  }
  getch();
}

void main() {   
  // Скрываем курсор       
  VG75[1] = 0x80;
  VG75[0] = 0xFF;
  VG75[0] = 0xFF;

  while(1) {
    apogeyScreen0(); 
    printx(0,0,"SCREEN 0 64X25 50HZ SPACE ATTR");
    test(25);

    apogeyScreen0B(); 
    printx(0,0,"SCREEN 0B 64X25 50HZ");
    test(25);

    apogeyScreen1();
    printx(0,0,"SCREEN 1 64X25 60HZ SPACE ATTR");
    test(25);    

    apogeyScreen1B();
    printx(0,0,"SCREEN 1B 64X25 60HZ");
    test(25);

    apogeyScreen2A();
    printx(0,0,"SCREEN 2A 64X30 0-2 COLORS PER LINE");
    test(31);    

    apogeyScreen2B();
    printx(0,0,"SCREEN 2B 64X30 0-5 COLORS PER LINE");
    test(31);

    apogeyScreen2C();
    printx(0,0,"SCREEN 2C 64X30 16 COLORS");
    printx(32,0,"\x8080\x8181\x8484\x8585\x8888\x8989\x8C8C\x8D8D\x8282\x8383\x8686\x8787\x8A8A\x8B8B\x8E8E\x8F8F");
    printx(32,1,"\x9080\x9181\x9484\x9585\x9888\x9989\x9C8C\x9D8D\x9282\x9383\x9686\x9787\x9A8A\x9B8B\x9E8E\x9F8F");
    test16(31);

    apogeyScreen3A();
    gprint(0, 0, "SCREEN 3A 192X104 SPC ATTR");
    gtest(51);    

    apogeyScreen3B();
    gprint(0, 0, "SCREEN 3B 192X104 0-5");
    gtest(51);

    apogeyScreen3C();
    printx(32,0,"\x80\x7B\x81\x7B\x84\x7B\x85\x7B\x88\x7B\x89\x7B\x8C\x7B\x8D\x7B\x82\x7B\x83\x7B\x86\x7B\x87\x7B\x8A\x7B\x8B\x7B\x8E\x7B\x80");
    printx(32,1,"\x90\x7B\x91\x7B\x94\x7B\x95\x7B\x98\x7B\x99\x7B\x9C\x7B\x9D\x7B\x92\x7B\x93\x7B\x96\x7B\x97\x7B\x9A\x7B\x9B\x7B\x9E\x7B\x80");
    printx(32,2,"\x80\x7B\x81\x7B\x84\x7B\x85\x7B\x88\x7B\x89\x7B\x8C\x7B\x8D\x7B\x82\x7B\x83\x7B\x86\x7B\x87\x7B\x8A\x7B\x8B\x7B\x8E\x7B\x80");
    gprint(0, 0, "3C 192X104 16");
    gtest16(51);

    gigaScreen();
  }
}
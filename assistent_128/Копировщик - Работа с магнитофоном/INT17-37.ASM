pr:    jmp      INIT          ;è‡Æ£‡†¨¨† Ø•Á†‚®.
PRINT: MOV      DX,85H
       PUSH     CX
       XOR      CX,CX
       OR       AH,AH
       JNZ      F1
       PUSH     BX
       LEA      BX,COI
       ADD      BX,AX
       MOV      AL,CS:[BX]
       POP      BX
       OUT      DX,AL
       INC      DX
       XOR      AL,AL
       OUT      DX,AL
BU1:   PUSH     CX
       MOV      CX,10H
BUZY1: IN       AL,DX
       TEST     AL,20H
       JZ       GOT
       LOOP     BUZY1
       POP      CX
       LOOP     BU1
       JMP      OSH
GOT:   POP      CX
       MOV      AL,1
       OUT      DX,AL
       XOR      CX,CX
BU2:   PUSH     CX
       MOV      CX,10H
BUZY2: IN       AL,DX
       TEST     AL,20H
       JNZ      BUZY
       LOOP     BUZY2
       POP      CX
       LOOP     BU2
       JMP      OSH
BUZY:  POP      CX
       XOR      AL,AL
       OUT      DX,AL
       XOR      CX,CX
BU3:   PUSH     CX
       MOV      CX,10H
NBUZY: IN       AL,DX
       TEST     AL,20H
       JZ       F1
       LOOP     NBUZY
       POP      CX
       LOOP     BU3
OSH:   MOV      AH,88H
       JMP      END
F1:    POP      CX
       MOV      AH,50H
END:   POP      CX
       IRET
COI    DB       0H,1H,2H,3H,4H,5H,6H,7H,8H,9H,0AH,0BH,0CH,0DH,0EH,0FH
       DB       10H,11H,12H,13H,14H,15H,16H,17H,18H,19H,1AH,1BH,1CH,1DH,1EH,1FH
       DB       ' !"#$%&',27H,'()*+,-./'
       DB       '0123456789:;<=>?'
       DB       '@ABCDEFGHIJKLMNO'
       DB       'PQRSTUVWXYZ[\]^_'
       DB       60H,'abcdefghijklmno'
       db       'pqrstuvwxyz',7bh,7ch,7dh,7eh,7fh
       DB       0B0H,0B1H,0B2H,0B3H,0B4H,0B5H,0B6H,0B7H,0B8H,0B9H,0BAH,0BBH,0BCH,0BDH,0BEH,0BFH
       DB       0C0H,0C1H,0C2H,0C3H,0C4H,0C5H,0C6H,0C7H,0C8H,0C9H,0CAH,0CBH,0CCH,0CDH,0CEH,0CFH
       DB       0D0H,0D1H,0D2H,0D3H,0D4H,0D5H,0D6H,0D7H,0D8H,0D9H,0DAH,0DBH,0DCH,0DDH,0DEH,0DFH
       DB       9BH,9CH,9DH,0A5H,0A7H,83H,84H,85H,86H,97H,95H,91H,92H,8BH,8CH,0A1H
       DB       0A3H,0A8H,0A6H,0A9H,0A4H,0AAH,8DH,8EH,93H,90H,98H,96H,99H,94H,9AH,80H
       DB       8BH,82H,81H,88H,89H,8AH,8FH,9EH,9FH,0A2H,0A0H,0ABH,0ACH,0ADH,0AEH,0AFH
       DB       0E0H,0E1H,0E2H,0E3H,0E4H,0E5H,0E6H,0E7H,0E8H,0E9H,0EAH,0EBH,0ECH,0EDH,0EEH,0EFH
       DB       0F0H,0F1H,0F2H,0F3H,0F4H,0F5H,0F6H,0F7H,0F8H,0F9H,0FAH,0FBH,0FCH,0FDH,0FEH,0FFH
       DB       0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
INIT:  PUSH     AX
       XOR      AX,AX
       MOV      DS,AX
       LEA      AX,CS:PRINT
       MOV      BX,5CH
       MOV      [BX],AX
       INC      BX
       INC      BX
       PUSH     CS
       POP      AX
       MOV      [BX],AX
       MOV      BX,408H
       MOV      [BX],84H
       MOV      DX,87H
       MOV      AL,88H
       OUT      DX,AL
       MOV      DX,84H
       MOV      AL,32H
       OUT      DX,AL
       PUSH     CS
       POP      DS
       LEA      DX,NAME
       INC      DX
       MOV      AX,0900H
       INT      21H
       LEA      DX,INIT
       MOV      CL,4H
       SHR      DX,CL
       POP      AX
       MOV      AH,31H
       INT      21H
NAME:  NOP
       DB       0DH,0AH,'êÄÑóÖçäé ã.à., INT17-37, 1991 £.',0DH,0AH,24H



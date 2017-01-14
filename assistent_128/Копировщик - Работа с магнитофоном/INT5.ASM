pr:    jmp      INIT          ;è‡Æ£‡†¨¨† Ø•Á†‚®.
PRINT: PUSH     AX
       PUSH     BX
       PUSH     CX
       PUSH     DX
       PUSH     DS
       MOV      AX,40H
       MOV      DS,AX
       MOV      AL,1
       XCHG     AL,[100H]
       CMP      AL,1
       JZ       FFD3
       STI
       MOV      AL,0AH
       XOR      AH,AH
       INT      17H
       AND      AH,50H
       JZ      FFCE
       MOV      AH,0FH
       INT      10H
       MOV      BL,AH
       MOV      AH,3H
       INT      10H
       PUSH     DX
       XOR      CX,CX
       MOV      DH,0FFH
FF87:  MOV      AL,0DH
       CALL     FFB8
       MOV      AL,0AH
       CALL     FFB8
       INC      DH
       CMP      DH,18H
       JBE      FF9D
       MOV      AL,0DH
       CALL     FFB8
       MOV      AL,0AH
       CALL     FFB8
       MOV      BL,00
       JMP      FFC9
FF9D:  XOR      DL,DL
FF9F:  MOV      AH,2H
       INT      10H
       mov      AH,8H
       INT      10H
       OR       AL,AL
       JNZ      FFAD
       MOV      AL,20H
FFAD:  CALL     FFB8
       INC      DL
       CMP      DL,BL
       JB       FF9F
       JMP      FF87
FFB8:  MOV      AH,0
       XCHG     CX,DX
       INT      17H
       XCHG     CX,DX
       TEST     AH,88H
       JNZ      FFC6
       RET
FFC6:  POP      DX
       MOV      BL,0FFH
FFC9:  POP      DX
       MOV      AH,2H
       INT      10H
FFCE:  CLI
       MOV      [100H],BL
FFD3:  POP      DS
       POP      DX
       POP      CX
       POP      BX
       POP      AX
       IRET
       DB       0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
INIT:  PUSH     AX
       XOR      AX,AX
       MOV      DS,AX
       LEA      AX,CS:PRINT
       MOV      BX,14H
       MOV      [BX],AX
       INC      BX
       INC      BX
       PUSH     CS
       POP      AX
       MOV      [BX],AX
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
       DB       0DH,0AH,'êÄÑóÖçäé ã.à., INT5, 1991 £.',0DH,0AH,24H



pr:    jmp      INIT          ;è‡Æ£‡†¨¨† INT14.
PRINT: STI
       PUSH     DX
       PUSH     BX
       PUSH     AX
       OR       AH,AH
       JZ       F0
       DEC      AH
       JZ       F1
       DEC      AH
       JZ       F2
       DEC      AH
       JZ       F3
       POP      AX
END:   POP      BX
       POP      DX
       IRET
F0:    MOV      DX,87H
       MOV      AL,88H
       OUT      DX,AL
       MOV      DX,84H
       MOV      AL,32H
       OUT      DX,AL
       MOV      DX,8BH
       MOV      AL,16H
       OUT      DX,AL
       MOV      AL,56H
       OUT      DX,AL
       MOV      DX,88H
       POP      AX
       OUT      DX,AL
       MOV      DX,89H
       OUT      DX,AL
       MOV      DX,8DH
       MOV      AL,8EH
       OUT      DX,AL
       MOV      AL,40H
       OUT      DX,AL
       MOV      AL,0CEH
       OUT      DX,AL
       JMP      END
F1:    MOV      BX,100H
F12:   MOV      DX,8DH
       IN       AL,DX
       TEST     AL,1H
       JNZ      F11
       INC      BX
       OR       BH,BH
       JNZ      F12
F14:   POP      AX
       MOV      AH,80H
       JMP      END
F11:   MOV      DX,8DH
       IN       AL,DX
       TEST     AL,02H
       JZ       F13
F15:   MOV      DX,8CH
       IN       AL,DX
       INC      BX
       OR       BH,BH
       JZ       F14
       CMP      AL,13H
       JZ       F15
F13:   POP      AX
       MOV      DX,8CH
       OUT      DX,AL
       XOR      AH,AH
       JMP      END
F2:    MOV      BX,100H
F22:   MOV      DX,8D
       IN       AL,DX
       TEST     AL,3H
       JNZ      F21
       INC      BX
       OR       BH,BH
       JNZ      F22
F21:   POP      AX
       MOV      DX,8CH
       IN       AL,DX
       XOR      AH,AH
       JMP      END
F3:    POP      AX
       XOR      AX,AX
       JMP      END
INIT:  PUSH     AX
       XOR      AX,AX
       MOV      DS,AX
       LEA      AX,CS:PRINT
       MOV      BX,50H
       MOV      [BX],AX
       INC      BX
       INC      BX
       PUSH     CS
       POP      AX
       MOV      [BX],AX
       MOV      BX,400H
       MOV      [BX],88H
       MOV      DX,87H
       MOV      AL,88H
       OUT      DX,AL
       MOV      DX,84H
       MOV      AL,32H
       OUT      DX,AL
       MOV      DX,8BH
       MOV      AX,16H
       OUT      DX,AL
       MOV      AL,56H
       OUT      DX,AL
       MOV      DX,88H
       MOV      AL,08H
       OUT      DX,AL
       MOV      DX,89H
       OUT      DX,AL
       MOV      DX,8DH
       MOV      AL,8EH
       OUT      DX,AL
       MOV      AL,40H
       OUT      DX,AL
       MOV      AL,0CEH
       OUT      DX,AL
       MOV      AL,15H
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
       INC      DX
       POP      AX
       MOV      AH,31H
       INT      21H
NAME:  NOP
       DB       0DH,0AH,'êÄÑóÖçäé ã.à., INT14, 1991 £.',0DH,0AH,24H



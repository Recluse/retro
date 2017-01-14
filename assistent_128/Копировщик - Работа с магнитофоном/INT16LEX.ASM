pr:    jmp      INIT          ;Программа клавиатуры.
PRINT: PUSH     BX
       LEA      BX,SMESN
       INC      BX
       PUSHF
       CALL     CS:[BX]
       POP      BX
       PUSHF
       CMP      AX,5495H
       JNZ      PR1
       MOV      AX,1A95H
       JMP      END
PR1:   CMP      AX,559AH
       JNZ      PR2
       MOV      AX,299AH
       JMP      END
PR2:   CMP      AX,5686H
       JNZ      PR3
       MOV      AX,2786H
       JMP      END
PR3:   CMP      AX,5799H
       JNZ      PR4
       MOV      AX,2899H
       JMP      END
PR4:   CMP      AX,589EH
       JNZ      PR5
       MOV      AX,349EH
       JMP      END
PR5:   CMP      AX,5981H
       JNZ      PR6
       MOV      AX,3381H
       JMP      END
PR6:   CMP      AX,5AF0H
       JNZ      PR7
       MOV      AX,1BF0H
       JMP      END
PR7:   CMP      AX,54E5H
       JNZ      PR8
       MOV      AX,1AE5H
       JMP      END
PR8:   CMP      AX,55EAH
       JNZ      PR9
       MOV      AX,29EAH
       JMP      END
PR9:   CMP      AX,56A6H
       JNZ      PR10
       MOV      AX,27A6H
       JMP      END
PR10:  CMP      AX,57EDH
       JNZ      PR11
       MOV      AX,28EDH
       JMP      END
PR11:  CMP      AX,58EEH
       JNZ      PR12
       MOV      AX,34EEH
       JMP      END
PR12:  CMP      AX,59A1H
       JNZ      PR13
       MOV      AX,33A1H
       JMP      END
PR13:  CMP      AX,5AF1H
       JNZ      END
       MOV      AX,1BF1H
END:   POPF
       RETF
	NOP
       NOP
       NOP
       NOP
SMESN: NOP
SMES   DW       0E82EH
SGM    DW       0F000H
       DB       0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
INIT:  PUSH     AX
       XOR      AX,AX
       MOV      DS,AX
       LEA      DX,PRINT
       MOV      BX,58H
       MOV      AX,[BX]
       MOV      CS:[SMES],AX
       CLI
       MOV      [BX],DX
       INC      BX
       INC      BX
       MOV      AX,[BX]
       MOV      CS:[SGM],AX
       PUSH     CS
       POP      AX
       MOV      [BX],AX
       STI
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
       DB       0DH,0AH,'РАДЧЕНКО Л.И., INT16lex, 1991 г.',0DH,0AH,24H


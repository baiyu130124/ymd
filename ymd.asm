DATAS SEGMENT
OUTPUT1 DB "WHAT IS THE DATE(MM(2)/DD(2)/YY(4))?",'$'
OUTPUT2 DB '-','$'
OUTPUTYEAR   DB 4 DUP(?),'$'
OUTPUTMONTH  DB 2 DUP(?),'$'
OUTPUTDATE   DB 2 DUP(?),'$'
BUF    DB  20				    ;预定义10字节的空间
       DB  ?				    ;待输入完成后，自动获得输入的字符个数
       DB  20  DUP(0)    
CRLF   DB  0AH, 0DH,'$'     ;换行符
    
DATAS ENDS
 
STACKS SEGMENT
    DB 20 DUP(0)
STACKS ENDS
 
CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    MOV AX,STACKS 
    MOV SS,AX
    MOV SP,19

    LEA DX,OUTPUT1                    ;接收字符串
    MOV AH, 09H
    INT 21H
   
    MOV DL,07H;输出响铃字符
    MOV AH,2
    INT 21H   
    LEA DX,CRLF                    ;接收字符串
    MOV AH, 09H
    INT 21H

    CALL GetNUM

    LEA DX,CRLF                    ;接收字符串
    MOV AH, 09H
    INT 21H
  
    CALL Disp
    CALL Dispp
    CALL Disppp
    JMP OK



GetNUM:
    LEA DX,BUF                    ;接收字符串
    MOV AH, 0AH
    INT 21H
    RET

Disp:
   MOV AL,BUF[8]
   MOV OUTPUTYEAR[0],AL
   MOV AL,BUF[9]
   MOV OUTPUTYEAR[1],AL
   MOV AL,BUF[10]
   MOV OUTPUTYEAR[2],AL
   MOV AL,BUF[11]
   MOV OUTPUTYEAR[3],AL
  
   LEA DX,OUTPUTYEAR                 ;输出输入的字符串
   MOV AH, 09H							 
   INT 21H
   LEA DX, OUTPUT2                 ;输出输入的字符串
   MOV AH, 09H							 
   INT 21H
   RET


Dispp:
   MOV AL,BUF[2]
   MOV OUTPUTMONTH[0],AL
   MOV AL,BUF[3]
   MOV OUTPUTMONTH[1],AL
   LEA DX,OUTPUTMONTH                ;输出输入的字符串
   MOV AH, 09H							 
   INT 21H
   LEA DX, OUTPUT2                 ;输出输入的字符串
   MOV AH, 09H							 
   INT 21H
   RET
Disppp:
   MOV AL,BUF[5]
   MOV OUTPUTDATE[0],AL
   MOV AL,BUF[6]
   MOV OUTPUTDATE[1],AL
   LEA DX,OUTPUTDATE                ;输出输入的字符串
   MOV AH, 09H							 
   INT 21H
   RET




    
OK: MOV AH,4CH
    INT 21H
CODES ENDS
    END START
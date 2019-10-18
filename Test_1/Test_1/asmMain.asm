.386
.model flat,stdcall
.stack 4096
option casemap: none

INCLUDELIB legacy_stdio_definitions.lib

printf PROTO C,
    format: PTR BYTE, args: VARARG
scanf PROTO C,
    format: PTR BYTE, args: VARARG
;isPrime PROTO C,			   ;because isPrime is written in .asm, so         
    ;n: DWORD				   ;we don't need this any more
asmIsPrime PROTO,
    nn: DWORD

.data
inputF BYTE "%d %d %d", 0
outputF BYTE "%d ", 0
outputFN BYTE "%d", 0dh, 0ah, 0
outP BYTE 0dh, 0ah, "Total prime num: %d",0
M DWORD ?					  ;lower bound
N DWORD ?					  ;upper bound
T DWORD ?					  ;change to new line while output T prime numbers
cnt DWORD ?					  ;counter for how many number should be check
cntP DWORD 0				  ;counter for new line
i DWORD 2					  ;variables to divise nn
tmp DWORD ?					  ;store srqt(n)

.code

asmIsPrime PROC, nn: DWORD    ;check whether nn is a prime number function

checkTwo:                     ;check whether nn is 2
    CMP nn, 2                 
    JNE calSqrt               ;if nn is not 2, jump to start check procedure
    JMP isP                   ;if nn is 2, jump to IsP
    
calSqrt:                      ;calculate sqrt(nn)
    fild DWORD PTR [nn]
    fsqrt
    fistp DWORD PTR [tmp]     ;store sqrt(nn) in tmp
    MOV i, 2                  ;innitialize i to 2
    
checkPrime:
    MOV EAX, tmp              ;eax = sqrt(nn)
    CMP i, EAX                ;if i > eax
    JA isP                    ;jump to isP
    
division:                     ;division start
    MOV EDX,0                 
    MOV EAX, nn
    MOV ECX, i            
    DIV ECX                   ;edx:eax divided by ecx
    ADD i, 1                  ;i++
    CMP EDX, 0                ;check if nn is divisible by i
    JE notP                   ;if nn is divisible by i, jump to NotP
    JMP checkPrime            ;continue to check
    
notP:
    MOV EAX, 0                ;nn is not prime
    RET
    
isP:
    MOV EAX, 1                ;nn is prime
    RET
asmIsPrime ENDP

.code
asmMain PROC C
    INVOKE scanf, ADDR inputF, ADDR M, ADDR N, ADDR T
    
compareMN:                    ;check whether M < N
    MOV EBX, M                ;one of the variable must be register in CMP instruction
    CMP EBX, N                
    JBE calCnt                ;if M <= N, jump to calculate cnt
    
changeMN:                     ;if M > N, change M and N
    MOV EAX, N                
    MOV N, EBX
    MOV M, EAX
    
calCnt:                       ;calculate how many number should be checked
    MOV EBX, N                
    SUB EBX, M
    ADD EBX, 1
    MOV cnt, EBX
    MOV EBX, T                ;innitialize ebx, used to check should I change to new line
    SUB M, 1                  ;innitialize M

whileStart:
    ADD M, 1

checkCnt:
    MOV EAX, cnt        
    CMP EAX, 0
    JE whileEnd               ;if all number has been checked, jump to end
    
checkP:
    INVOKE asmIsPrime, M
    SUB cnt, 1
    CMP EAX, 0
    JE whileStart             ;if not a prime num, jump to continue checking next num   
    
checkT:
    CMP EBX, 1
    JE newLine
    
simpleOutput:
    INVOKE printf, ADDR outputF, M
    ADD cntP, 1
    SUB EBX, 1
    JMP whileStart

newLine:                      ;output with \n
    INVOKE printf, ADDR outputFN, M
    ADD cntP, 1
    MOV EBX, T
    JMP whileStart

whileEnd:
    INVOKE printf, ADDR outP, cntP    ;print total prime number
    RET
asmMain ENDP

END
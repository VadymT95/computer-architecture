 .MODEL SMALL
 .STACK 512
 .DATA
;--------------------------

;-------------------------------------------------------------------------
 Array dw 1253h, 5739h ,1537h ,8674h, 3752h, 1964h ,2145h ,6831h, 2363h, 2988h ,5482h ,8762h, 1321h, 4895h ,2641h ,0913h  ;1
 dw 5437h, 5627h ,2894h ,3613h, 7865h, 3178h ,8937h ,2164h, 8970h, 5210h ,2615h ,1542h, 7847h, 8263h ,5895h ,4785h          ;2
 dw 4587h, 2361h ,1423h ,1485h, 1369h, 7855h ,1452h ,4685h, 1217h, 9868h ,5232h ,7874h, 5854h, 4578h ,5362h ,2585h          ;3
 dw 1454h, 1530h ,7454h ,8566h, 3226h, 4754h ,1563h ,2573h, 1984h, 8763h ,4129h ,6214h, 8742h, 8962h ,8753h ,8513h          ;4
 dw 2325h, 5784h ,1451h ,6986h, 5743h, 5842h ,8521h ,8969h, 3214h, 4789h ,5263h ,5478h, 5412h, 9534h ,7513h ,2196h          ;5
 dw 6587h, 6542h ,5236h ,5745h, 4523h, 9998h ,7812h ,9648h, 2684h, 3572h ,6255h ,3458h, 1452h, 1457h ,3256h ,8547h          ;6
 dw 1478h, 2486h ,1268h ,3589h, 2452h, 5896h ,6587h ,2359h, 1452h, 6556h ,2547h ,5221h, 2189h, 3278h ,9641h ,5438h          ;7
 dw 4785h, 5244h ,4787h ,5226h, 3247h, 1263h ,1593h ,6547h, 2581h, 3278h ,4258h ,9587h, 4257h, 4215h ,6521h ,9854h          ;8
 dw 2561h, 3274h ,3025h ,5846h, 5810h, 6309h ,8574h ,2653h, 1239h, 8956h ,8751h ,8563h, 8451h, 8712h ,2548h ,3024h
 dw 2781h, 8756h ,8965h ,5412h, 7845h, 3264h ,9856h ,2187h, 3201h, 4858h ,9526h ,6325h, 3478h, 3218h ,2056h ,3057h
 dw 0478h, 3205h ,9853h ,2103h, 2076h, 6254h ,7846h ,3558h, 2556h, 4851h ,3259h ,2563h, 1478h, 4512h ,3258h ,3259h
 dw 1542h, 0845h ,0256h ,2482h, 6842h, 3621h ,3259h ,2412h, 3698h, 4874h ,5721h ,5624h, 3552h, 2541h ,2984h ,2563h;
 dw 2565h, 4152h ,2585h ,3658h, 3256h, 1278h ,5326h ,3025h, 9856h, 2644h ,3265h ,2158h, 4856h, 5680h ,1475h ,0245h
 dw 5045h, 1588h ,3256h ,1856h, 6325h, 3256h ,0542h ,4521h, 6235h, 2845h ,5562h ,1205h, 3482h, 4784h ,1542h ,1252h
 dw 2586h, 6589h ,5523h ,4157h, 3584h, 2015h ,4785h ,2635h, 1451h, 4826h ,1243h ,1148h, 6825h, 4521h ,1536h ,5429h
 dw 4852h, 5374h ,3945h ,1542h, 2752h, 7635h ,2356h ,2784h, 4587h, 5642h ,6319h ,5493h, 4862h, 2255h ,3278h ,5476h; 01FEh 
 Len dw 100h
 string db 254 ;змінна для строки - string,
 
PORT_B EQU 61H
COMMAND_REG EQU 43H ; Адреса командного регістру 
CHANNEL_2 EQU 42H ; Адреса каналу 2
TOPROW EQU 08 ;Верхній рядок меню
BOTROW EQU 15 ;Нижній рядок меню
LEFCOL EQU 26 ;Лівий стовпчик меню
ATTRIB DB ? ; Атрибути екрану
ROW DB 00 ;Рядок екрану
SHADOW DB 19 DUP(0DBH);
MENU DB 0C9H, 17 DUP(0CDH), 0BBH
 DB 0BAH, ' print info      ',0BAH
 DB 0BAH, ' Count           ',0BAH
 DB 0BAH, ' Sound           ',0BAH
 DB 0BAH, ' Max value       ',0BAH
 DB 0BAH, ' Min value       ',0BAH
 DB 0BAH, ' Exit            ',0BAH
 DB 0C8H, 17 DUP(0CDH), 0BCH
PROMPT DB 'To select an item, use <Up/Down Arrow>'
 DB ' and press <Enter>.'
 DB 13, 10, 'Press <Esc> to exit.'
.386 ;-------------------------------------------------------------------
display_message_0 DB "------------programm for lab 3 is running !!!--------", 13, 10, '$'
display_message_1 DB "c - for count", 13, 10, '$'
display_message_2 DB "V - for beep", 13, 10, '$'
display_message_3 DB "b - for exit", 13, 10, '$' 
display_message_3_3 DB "d - for max ", 13, 10, '$' 
display_message_4 DB "----------programm for lab is END !!! --------------", 13, 10, '$'
display_message_5 DB "*****SOUND*****", 13, 10, '$'
display_message_6 DB "Result:                               ", 13, 10, '$'   
display_message_7 DB "max value:", 13, 10, '$'
display_message_7_7 DB "min value:", 13, 10, '$'
display_message_8 DB " ", 13, 10, '$'

team db "team 8:",10,13,'$'
stepanenko db "Stepanenko Anatolii",10,13,'$';Рядок символів для виводу на екран
salymonenko db "Salymonenko Vadym",10,13,'$';Рядок символів для виводу на екран
durdynets db "Durdynets Aleksandr",10,13,'$';Рядок символів для виводу на екран
;/////////////////////////////////////////////////////////////
 .CODE
A10MAIN PROC FAR
 MOV AX,@data 
 MOV DS,AX 
 MOV ES,AX 
 CALL Q10CLEAR ; Очистка екрану
 MOV ROW,BOTROW+4 
A20:
 CALL B10MENU ;Вивід меню
 MOV ROW,TOPROW+1 ;Вибір верхнього пункту меню 
 ; у якості початкового значення
 MOV ATTRIB,16H ;Переключення зображення в інв..
 CALL D10DISPLY
 CALL C10INPUT

; CALL D10DISPLY ;Відображення CALL C10INPUT ;Вибір з меню
 JMP A20 ;
A10MAIN ENDP
;-------------------------------------------------------------------------
; Вивід рамки, меню і запрошення…
;-------------------------------------------------------------------------
B10MENU PROC NEAR
 PUSHA ;
 MOV AX,1301H ;
 MOV BX,0060H ;
 LEA BP,SHADOW ;
 MOV CX,19 ;
 MOV DH,TOPROW+1 ;
 MOV DL,LEFCOL+1 ;
B20: INT 10H
 ;;;;;
 INC DH ;Наступний рядок
 CMP DH,BOTROW+2 ;
 JNE B20 ; 
 MOV ATTRIB,71H ;
 MOV AX,1300H ;
 MOVZX BX,ATTRIB ;
 LEA BP,MENU ;
 MOV CX,19 
 MOV DH,TOPROW ;Рядок 
 MOV DL,LEFCOL ;Стовпчик
B30:
 INT 10H
 ADD BP,19 ;
 INC DH ;
 CMP DH,BOTROW+1 ;
 JNE B30 ; 
 MOV AX,1301H ;
 MOVZX BX,ATTRIB ;
 LEA BP,PROMPT ;
 MOV CX,79 ;
 MOV DH,BOTROW+4 ;
 MOV DL,00 ; 
 INT 10H
 POPA ;‚
 RET
 B10MENU ENDP
;-------------------------------------------------------------------------
; Натискування клавиш, управління через клавиші і ENTER
; для вибору пункту меню і клавіші ESC для виходу
;-------------------------------------------------------------------------
C10INPUT PROC NEAR
 PUSHA ;
Main_cikle: 
MOV AH,10H ;Запитати один символ з кл.
 INT 16H ; 
 CMP AH,50H ;Стрілка до низу
 JE C30
 CMP AH,48H ;Стрілка до гори ?
 JE C40
 CMP AL,0DH ;Натистнено ENTER?
 JE C90 ; C90
 CMP AL,1BH ;Натиснено ESCAPE?
 JE C80 ; Вихід
 JMP Main_cikle ;Жодна не натиснена, повторення
C30:
 MOV ATTRIB,71H ;Кольор символів
 CALL D10DISPLY ;
 INC ROW ;
 CMP ROW,BOTROW-1 ;
 JBE C50 ; 
 MOV ROW,TOPROW+1 ; 
 JMP C50
C40:
 MOV ATTRIB,71H ;Кольор символів і екрану
 CALL D10DISPLY ;
 ; 
 DEC ROW
 CMP ROW,TOPROW+1 ;
 JAE C50 ; 
 MOV ROW,BOTROW-1 ; 
C50:
 MOV ATTRIB,17H ;Кольор символів
 CALL D10DISPLY ;
 JMP Main_cikle
C80:
jmp Exit
C90:
 POPA 
 lea si,ROW
 mov ax,[DS:si]
 XOR ah,ah
 mov bx, 8
 sub ax, bx ;
 
 
 cmp ax, 01h ; c ascii =63h ; Вибір відповідної функції
je  printTeam; На лекції 3!!!
cmp ax, 02h ; V ascii =56h
je Count
cmp ax, 03h ; d ascii =64h
je Beep
cmp ax, 04h ; b ascii =62h
je max
cmp ax, 05h ; b ascii =62h
je min
cmp ax, 06h ; b ascii =62h
je Exit
 RET
C10INPUT ENDP

printTeam:
	mov dx, offset display_message_8 ; Закоментовані повідомлення у ході налаштування
	call display_foo
	Push ds
Mov ah, 25h
Mov al, 58h
Lea dx, print
Mov bx, seg print
Mov ds, bx
Int 21h
Pop ds
Int 58h
	jmp Main_cikle
Count:
 mov dx, offset display_message_8 ; Закоментовані повідомлення у ході налаштування
  call display_foo
 mov dx, offset display_message_6 ; Закоментовані повідомлення у ході налаштування
  call display_foo
 call math
jmp Main_cikle

Beep:
 mov dx, offset display_message_8 
  call display_foo
 mov dx, offset display_message_5 
 call display_foo
 call zvukF1; виклик функції звуку
 jmp Main_cikle
max:
 mov dx, offset display_message_8 
  call display_foo
 mov dx, offset display_message_7 
 call display_foo
 call Bubblesort 
 mov ax, [DS:01FEh]
 call output 
 jmp Main_cikle
 
 min:
 mov dx, offset display_message_8 
  call display_foo
 mov dx, offset display_message_7_7
 call display_foo
 call Bubblesort 
 mov ax, [DS:0000h]
 call output 
 jmp Main_cikle
;---------------------------------------------------------
; Стандартний вихід з програми
 Exit:
  mov dx, offset display_message_8 
  call display_foo
 mov dx, offset display_message_4 
 call display_foo
 MOV AX,4C00H
 INT 21H
 ;-------------SUB-2 display_foo---------------------
 display_foo PROC
 mov ah,9
 int 21h
 xor dx, dx
 ret
 display_foo  ENDP
 ;---------------------------------------------------------
output PROC 
        ;ax - число
		mov [ES:0475h],' '
		mov [ES:0474h],' '
		mov [ES:0473h],' '
		mov [ES:0472h],' '
		mov [ES:0471h],' '
    mov di,0470h    ;es:di - адрес буфера приемника
    push cx ;сохраняем регистры
    push dx
    push bx
    mov bx,10   ;основание системы
    XOR CX,CX   ;в сх будет количество цифр в десятичном числе
m1:   XOR dx,dx
    DIV bx      ;делим число на степени 10
    PUSH DX     ;и сохраняем остаток от деления(коэффициенты при степенях) в стек
    INC CX
    TEST AX,AX
    JNZ m1
m2:   POP AX
    ADD AL,'0'  ;преобразовываем число в ASCII символ
    STOSb       ;сохраняем в буфер
    LOOP m2       ;все цифры
    pop bx      ;восстанавливаем регистры
    POP dx
    POP cx 
mov [ES:0475h],'$'
    mov dx, 0470h ;Пересилання адреси рядка символів message в регістр dx
  	mov ah,09h;Завантаження числа 09h до регістру ah
	int 21h;Переривання	
	
call pause1

call screenClear
ret 
 output ENDP

 zvukF1 PROC
lab2: 
;Встановлення частоти 440 гц
 ;--- дозвіл каналу 2 встановлення порту В мікросхеми 8255
 IN AL,PORT_B ;Читання
 OR AL,3 ;Встановлення двох молодших бітів
 OUT PORT_B,AL ;пересилка байта в порт B мікросхеми 8255
 ;--- встановлення регістрів порту вводу-виводу
 MOV AL,10110110B ;біти для каналу 2
 OUT COMMAND_REG,AL ;байт в порт командний регістр
 ;--- встановлення лічильника 
 MOV AX,2705 ;лічильник = 1190000/440
 OUT CHANNEL_2,AL ;відправка AL
 MOV AL,AH ;відправка старшого байту в AL
 OUT CHANNEL_2,AL ;відправка старшого байту 
 
 ;--- пауза 2 секунды
call pause1

 ;--- виключення звуку 
 IN AL,PORT_B ;отримуємо байт з порту В
 AND AL,11111100B ;скидання двох молодших бітів
 OUT PORT_B,AL ;пересилка байтів в зворотному напрямку
 call screenClear
 ret
  zvukF1 ENDP
 
  math PROC
  mov ax, -2
 mov bx, 3
 sub ax, bx ; -5
 
  mov bx, 1
 add ax,bx ; -4
 
 mov bl, 2
 idiv bl ;AL (приватне), Ah (залишок)
 
 mov dx,ax
 mov cl,3h
 imul cl
 mov dl,al
 mov al,dh
 imul cl
 mov ah,al
 mov al,dl
 
 call output
 ret
  math ENDP

 Bubblesort PROC
lea si, Array
mov cx, Len    
        push    bx
        push    cx
        push    dx
        push    si
        push    di
 
        mov     bx,     si
        mov     dx,     cx
        dec     dx
        shl     dx,     1               
        dec     cx                      
        mov     si,     0
ForI:
        mov     di,     dx             
ForJ:                                 
        mov     ax,     [bx+di-2]       
        cmp     ax,     [bx+di]
        jbe     NextJ                
        xchg    ax,     [bx+di]         
        xchg    ax,     [bx+di-2]       
        xchg    ax,     [bx+di]         
NextJ:
        sub     di,     2              
        cmp     di,     si             
        ja      ForJ
        add     si,     2              
        loop    ForI      
		pop     di
        pop     si
        pop     dx
        pop     cx
        pop     bx
        ret
 Bubblesort  ENDP
;-------------------------------------------------------------------------
; Забарвлення виділеного рядка
;-------------------------------------------------------------------------
D10DISPLY PROC NEAR
 PUSHA 
 MOVZX AX,ROW 
 SUB AX,TOPROW
 IMUL AX,19 
 LEA SI,MENU+1 
 ADD SI,AX
 MOV AX,1300H 
 MOVZX BX,ATTRIB 
 MOV BP,SI 
 MOV CX,17 
 MOV DH,ROW 
 MOV DL,LEFCOL+1 
 INT 10H
 POPA 
 RET
D10DISPLY ENDP
;------------------------------------------------------------------------
; Очищення екрану
;------------------------------------------------------------------------
Q10CLEAR PROC NEAR
 PUSHA 
 MOV AX,0600H
 MOV BH,61H 
 MOV CX,00 
 MOV DX,184FH
 INT 10H
 POPA 
 RET
Q10CLEAR ENDP

 print proc far
	mov dx, offset team
	mov ah,09h;Завантаження числа 09h до регістру ah
	int 21h
	mov dx, offset stepanenko;Пересилання адреси рядка символів message в регістр dx
	int 21h;Переривання	
	mov dx, offset salymonenko
	int 21h	
	mov dx, offset durdynets
	int 21h
	call pause1
	call screenClear
IRET
 print endp
 
 screenClear PROC
     CALL Q10CLEAR ; Очистка екрану
	CALL B10MENU ;Вивід меню
	MOV ATTRIB,16H ;Переключення зображення в інв..
	CALL D10DISPLY
	ret
 screenClear ENDP
 
 pause1 PROC
 	 ;--- пауза 2 секунды
 mov cx, 80 ;(40 - 1 сек)
classic_loop:
mov bx, cx
  mov  ah,86h
  xor cx, cx
  mov  dx,25000
  int  15h
 mov cx, bx 
 loop classic_loop
 ret
 pause1 ENDP
 END A10MAIN
;Програма під час початку роботи виводить повідомлення.
;В залежності від обраного повідомлення вона :
;1. Викликає функцію для видачі звуку.
;2. Викликає функцію для обчислення результату виразу 
;3. Забезпечує вихід з програми
; Під час реалізації функцій 
; Програма читає зі стандартного вводу (клавіатури) строку.
; Розроблено на кафедрі АУТС 3.10.2011 року.
;--------------------------------------------------------------- 
 IDEAL
 MODEL small 
 STACK 512
 
 DATASEG
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
 str_len db 0 ;
 db 254 dup ('*') ; Буфер заповнюється '*' для ;кращого налаштування
	;----- Змінні для виводу системних команд 
system_message_1 DB "Input command and press enter\ " ,'$'
system_message_2 DB "Program end" ,'$' 
	;----- Змінні для виводу команд під час управління програмою 
display_message_0 DB "------------programm for lab 3 is running !!!--------", 13, 10, '$'
display_message_1 DB "c - for count", 13, 10, '$'
display_message_2 DB "V - for beep", 13, 10, '$'
display_message_3 DB "b - for exit", 13, 10, '$' 
display_message_3_3 DB "d - for max ", 13, 10, '$' 
display_message_4 DB "----------programm for lab is END !!! --------------", 13, 10, '$'
display_message_5 DB "Press any key for beep --------------", 13, 10, '$'
display_message_6 DB "Result:", 13, 10, '$'
display_message_7 DB "max value:", 13, 10, '$'
	;--- Змінні що використовувалися під час налаштування програми 
message DB ?
	test_message_1 DB "!!! count DISPLAY", 13, 10, '$' 
	;------Константи для функції звуку
 NUMBER_CYCLES EQU 2000
 FREQUENCY EQU 600
 PORT_B EQU 61H
 COMMAND_REG EQU 43H ; Адреса командного регістру 
 CHANNEL_2 EQU 42H ; Адреса каналу 2
 simvol db ?
 
 value1 db -2
 value2 db 3
 value3 db 1
 value4 db 2
 value5 db 3 
 ;//////////////////////////////###############################\\\\\\\\\\\\\\\\\\\\\\\\\\\\/
 CODESEG
 
Start:
mov ax, @data ; ax <- @data
mov ds, ax ; ds <- ax
mov es, ax ; es <- ax



Main_cikle: ; Основний цикл програми для інтерфейсу користувача
;----------------------------------------------
call display_foo_main
;-----------------------------------------------
 mov ah, 0ah ; ah <- 0ah 
 mov dx, offset string ; пересилка в dx начала буфера
 int 21h 
 
xor ax, ax
 mov bx, offset string ;пересилка в bx начала буфера для 
 ;реалізації адресації зі зміщенням
 mov ax, [bx+1] ;занесення в ax чисельного значення
 ;символу ASCII, що відповідає
 ;знаку,
 ;який введено з клавіатури 
 shr ax, 8 ;зсув в регістрі ах для виконання
 ;cmp 
cmp ax, 063h ; c ascii =63h ; Вибір відповідної функції
je Count ; На лекції 3!!!
cmp ax, 056h ; V ascii =56h
je Beep
cmp ax, 064h ; d ascii =64h
je max
cmp ax, 062h ; b ascii =62h
je Exit
jmp Main_cikle
;---------------------------------------------------------
Count:
 mov dx, offset display_message_6 ; Закоментовані повідомлення у ході налаштування
  call display_foo
 call math
jmp Main_cikle
;---------------------------------------------------------
Beep:
 ; any foo for sound ; виклик функції звуку
 mov dx, offset display_message_5 
 call display_foo
 call zvukF1
 jmp Main_cikle
 
 ;---------------------------------------------------------
max:
 ; any foo for sound ; виклик функції звуку
 mov dx, offset display_message_7 
 call display_foo
 call Bubblesort 
 jmp Main_cikle
;---------------------------------------------------------
; Стандартний вихід з програми
 Exit:
 mov dx, offset display_message_4 
 call display_foo
 mov ah,04Ch ; 
 int 21h ; 
;------------SUB-1 display_foo_main------------------
PROC display_foo_main
 mov ah, 0 ;Функція відображає інтерфейс
 ;користувача 
 mov al, 3
 int 10h
 mov dx, offset display_message_0
 call display_foo
 mov dx, offset display_message_1
 call display_foo
 mov dx, offset display_message_2
 call display_foo
 mov dx, offset display_message_3
 call display_foo
  mov dx, offset display_message_3_3
 call display_foo
 mov dx, offset system_message_1
 call display_foo
 ret
ENDP display_foo_main
;-------------SUB-2 display_foo---------------------
PROC display_foo
 mov ah,9
 int 21h
 xor dx, dx
 ret
ENDP display_foo 
;-------------SUB-3 zvukF1---------------------
PROC zvukF1
lab2: 
 
 int 16h ; Зберігає отримане значення з клавіатури в змінній 
 mov [simvol],al ; simvol
 cmp [simvol],'e' ; Перевірка на відповідність і встановлення прапору ознаки 0
 jz Exit ; 
 ; Перехід на Exit: у випадку відповідності 
 
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
 mov cx, 80
classic_loop:
mov bx, cx
  mov  ah,86h
  xor cx, cx
  mov  dx,25000
  int  15h
 mov cx, bx 
 loop classic_loop

 ;--- виключення звуку 
 IN AL,PORT_B ;отримуємо байт з порту В
 AND AL,11111100B ;скидання двох молодших бітів
 OUT PORT_B,AL ;пересилка байтів в зворотному напрямку
 ret
 ENDP zvukF1
 
 PROC math
  mov ax, -2
 mov bx, 3
 sub ax, bx
  mov bx, 1
 add ax,bx
 mov bl, 2
 mov dx, 1h
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
 ENDP math
 
PROC output
        ;ax - число
		mov [ES:0234h],' '
		mov [ES:0233h],' '
		mov [ES:0232h],' '
		mov [ES:0231h],' '
    mov di,0230h    ;es:di - адрес буфера приемника
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
mov [ES:022Dh],'$'
mov [ES:0235h],'$'
    mov dx, 230h ;Пересилання адреси рядка символів message в регістр dx
  	mov ah,09h;Завантаження числа 09h до регістру ah
	int 21h;Переривання
	
 mov cx, 80
classic_loop2:
mov bx, cx
  mov  ah,86h
  xor cx, cx
  mov  dx,25000
  int  15h
 mov cx, bx 
 loop classic_loop2
 
ret 
ENDP output

PROC Bubblesort 
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
 mov ax, [DS:01FEh]
 call output       
		pop     di
        pop     si
        pop     dx
        pop     cx
        pop     bx
        ret
ENDP Bubblesort  

END Start
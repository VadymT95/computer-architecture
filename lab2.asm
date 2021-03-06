;------------------------------------------------------------------------------
;------------------------------------------------------------------------------
;ЛР  №2
;------------------------------------------------------------------------------
; Архітектура комп'ютера
; Завдання:     Основи розробки і налагодження
; ВУЗ:          КНУУ "КПІ"
; Факультет:    ФІОТ
; Курс:         1
; Група:        ІТ-01
;------------------------------------------------------------------------------
; Автор:        команда 8(Степаненко, Салимоненко, Дурдинець)
; Дата:         24/02/2021
;---------------------------------------------------------------
;---------------------------ЗАГОЛОВОК ПРОГРАМИ------------------
IDEAL
; Директива - тип Асемблера tasm 
MODEL small
; Директива - тип моделі пам'яті 
STACK 256
 
;	Директива	-	розмір	стеку	в	байтах
;---------------------------МАКРОСИ-----------------------------
; макрос для ініціалізації 
MACRO M_Init
; Початок макросу
mov ax, @data ; ax <- @data
 mov ds, ax ; ds <- ax
mov es, ax ; es <- ax 
ENDM M_Init
; Кінець макросу
;---------------------------ПОЧАТОК	СЕГМЕНТУ	ДАНИХ	
DATASEG
exCode db 0
; Одна Лінія прямокутника

           ; ---1---  ---2---  ---3---  ---4---  ---5---  ---6---  ---7---  ---8---  ---9---  ---10--- 
rect_line db 50h,0aeh,4Ch,0aeh,55h,0aeh,53h,0aeh,45h,0aeh,52h,0aeh,53h,0aeh,20h,0aeh,41h,0aeh,52h,0aeh  
          db 45h,0aeh,20h,0aeh,54h,0aeh,48h,0aeh,45h,0aeh,20h,0aeh,42h,0aeh,45h,0aeh,53h,0aeh,54h,0aeh 
rect_line_length=$-rect_line
;---------------------------ПОЧАТОК СЕГМЕНТУ КОДУ	
CODESEG
Start:
M_Init
;---------------------------------------------------------------
mov dx,860 ; Початок виводу прямокутника
mov cx, 10

loopStart:
mov bx, cx
mov ax,0B800h ; 1. Сегментна адреса відеопамяті
mov es,ax ; 2. До ES ; Налаштування SI,DI и СХ для movsb 

mov di,dx; di <- Початок виводу на екран
mov si,offset rect_line
mov cx,rect_line_length ; Число байтів на пересилання
cld ; DF - вперед
 
rep movsb ; Пересилання 
mov cx,bx
add dx, 160
LOOP loopStart

Exit:
mov ah,04Ch
mov al,[exCode] ; отримання коду виходу
int 21h ; виклик функції DOS 4ch
;---------------------------------------------------------------
END Start
;---------------------------------------------------------------

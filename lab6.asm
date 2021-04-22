 ;------------------------------------------------------------------------------
IDEAL
MODEL small
STACK 256
;------------------------------------------------------------------------------
MACRO M_Init ; Ініціалізація DS і ES
	mov ax, @data ; ax <- @data
	mov ds, ax ; ds <- ax
	mov es, ax ; es <- ax
ENDM

DATASEG

team db "team 8:",10,13,'$'
stepanenko db "Stepanenko Anatolii",10,13,'$';Рядок символів для виводу на екран
salymonenko db "Salymonenko Vadym",10,13,'$';Рядок символів для виводу на екран
durdynets db "Durdynets Aleksandr",10,13,'$';Рядок символів для виводу на екран

CODESEG
Start:
M_Init

Push ds
Mov ah, 25h
Mov al, 58h
Lea dx, Interrupt_proc
Mov bx, seg Interrupt_proc
Mov ds, bx
Int 21h
Pop ds

Int 58h

mov ah,4ch; Завантаження числа 4ch до регістру ah
mov al,0h	; отримання коду виходу 
int 21h	;виклик функції DOS 4ch(Функція DOS 4ch - виходу з програми)

proc Interrupt_proc far
	mov dx, offset team
	mov ah,09h;Завантаження числа 09h до регістру ah
	int 21h
	mov dx, offset stepanenko;Пересилання адреси рядка символів message в регістр dx
	int 21h;Переривання	
	mov dx, offset salymonenko
	int 21h	
	mov dx, offset durdynets
	int 21h
IRET
endp Interrupt_proc

end Start 
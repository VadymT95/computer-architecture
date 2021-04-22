.model small
.stack 256h
 ;макрос для виходу з програми

.data
Array dw 1253h, 5739h ,1537h ,8674h, 3752h, 1964h ,2145h ,6831h, 2363h, 2988h ,5482h ,8762h, 1321h, 4895h ,2641h ,0913h  ;1
 dw 5437h, 5627h ,2894h ,3613h, 7865h, 3178h ,8937h ,2164h, 8970h, 5210h ,2615h ,1542h, 7847h, 8263h ,5895h ,4785h          ;2
 dw 4587h, 2361h ,1423h ,1485h, 1369h, 7855h ,1452h ,4685h, 1217h, 9868h ,5232h ,7874h, 5854h, 4578h ,5362h ,2585h          ;3
 dw 1454h, 1530h ,7454h ,8566h, 3226h, 4754h ,1563h ,2573h, 1984h, 8763h ,4129h ,6214h, 8742h, 8962h ,8753h ,8513h          ;4
 dw 2325h, 5784h ,1451h ,6986h, 5743h, 5842h ,8521h ,8969h, 3214h, 4789h ,5263h ,5478h, 5412h, 9534h ,7513h ,2196h          ;5
 dw 6587h, 6542h ,5236h ,5745h, 4523h, 2341h ,7812h ,9648h, 2684h, 3572h ,6255h ,3458h, 1452h, 1457h ,3256h ,8547h          ;6
 dw 1478h, 2486h ,1268h ,3589h, 2452h, 5896h ,6587h ,2359h, 1452h, 6556h ,2547h ,5221h, 2189h, 3278h ,9641h ,5438h          ;7
 dw 4785h, 5244h ,4787h ,5226h, 3247h, 1263h ,1593h ,6547h, 2581h, 3278h ,4258h ,9587h, 4257h, 4215h ,6521h ,9854h          ;8
 dw 2561h, 3274h ,3025h ,5846h, 5810h, 6309h ,8574h ,2653h, 1239h, 8956h ,8751h ,8563h, 8451h, 8712h ,2548h ,3024h
 dw 2781h, 8756h ,8965h ,5412h, 7845h, 3264h ,9856h ,2187h, 3201h, 4858h ,9526h ,6325h, 3478h, 3218h ,2056h ,3057h
 dw 0478h, 3205h ,9853h ,2103h, 2076h, 6254h ,7846h ,3558h, 2556h, 4851h ,3259h ,2563h, 1478h, 4512h ,3258h ,3259h
 dw 1542h, 7845h ,0256h ,2482h, 6842h, 3621h ,3259h ,7412h, 3698h, 9874h ,5721h ,5624h, 3552h, 2541h ,2984h ,2563h
 dw 2565h, 4152h ,2585h ,3658h, 3256h, 1278h ,5326h ,3025h, 9856h, 2644h ,3265h ,2158h, 4856h, 5680h ,1475h ,0245h
 dw 7845h, 1588h ,3256h ,7856h, 6325h, 3256h ,8542h ,4521h, 6235h, 7845h ,8562h ,1205h, 3482h, 4784h ,1542h ,1239h
 dw 2586h, 6589h ,5523h ,4157h, 3584h, 2015h ,4785h ,2635h, 1451h, 4826h ,1243h ,1148h, 6825h, 4521h ,1536h ,5429h
 dw 9852h, 5374h ,8945h ,1542h, 8752h, 9635h ,2356h ,2784h, 4587h, 5642h ,7319h ,5493h, 4862h, 2255h ,3278h ,9542h; 1DA0h
Len dw 257 
CODESEG
;----------------------VI. ПОЧАТОК СЕГМЕНТУ КОДУ
Start:

main proc 
mov ax, @data ; ax <- @data
mov ds, ax ; ds <- ax
mov es, ax ; es <- ax
 
    mov cx, 5h
	mov si, 108h
        copy_loop:
            mov [ds:si], 3431h            ; get number from array_array stack & set it to bx as a temp variable
            add si, 2        ; set value from bx to ds with offset 
            mov [ds:si], 3131h
			add si, 2                    ; si value + 2
            mov [ds:si], 3032h
			add si, 2   
			mov [ds:si], 3230h 
			add si, 10   
			
            mov [ds:si], 3231h            ; get number from array_array stack & set it to bx as a temp variable
            add si, 2        ; set value from bx to ds with offset 
            mov [ds:si], 3131h
			add si, 2                    ; si value + 2
            mov [ds:si], 3032h
			add si, 2   
			mov [ds:si], 3230h 
			add si, 10  

            mov [ds:si], 3732h            ; get number from array_array stack & set it to bx as a temp variable
            add si, 2        ; set value from bx to ds with offset 
            mov [ds:si], 3031h
			add si, 2                    ; si value + 2
            mov [ds:si], 3032h
			add si, 2   
			mov [ds:si], 3330h 
			add si, 10  		
			loop copy_loop		
	
lea si, Array
mov cx, Len
call BubbleSort      
 			mov ax, 01h
			mov ax, 01h
			mov ax, 01h
			mov ax, 01h
 mov ah,04Ch ; 
 int 21h ; 
endp main

BubbleSort      proc       
        push    ax
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
        pop     ax
        ret
BubbleSort      endp 

end Start
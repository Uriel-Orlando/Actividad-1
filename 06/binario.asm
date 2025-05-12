 section .data
 msg_num db "Numero 123", 10, "Binario: "
 msg_len equ $ - msg_num
 buffer resb 9

 section .text
 global _start

 %macro show_binary 1
 mov eax, %1
 mov ecx, 8
 mov edi, buffer
 %%loop:
 rol al, 1
 mov bl, al
 and bl, 1
 add bl, '0'
 mov [edi], bl
 inc edi
 loop %%loop
 mov byte [edi], 0

 mov eax, 4
 mov ebx, 1
 mov ecx, buffer
 mov edx, 8
 int 0x80

 %endmacro

 _start:
 mov eax, 4
 mov ebx, 1
 mov ecx, msg_num
 mov edx, msg_len
 int 0x80

 show_binary 123

 mov eax, 1
xor ebx, ebx
 int 0x80


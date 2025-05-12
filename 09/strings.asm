 section .data
 str1 db 'hola',0
 str2 db 'mundo', 0 
 msg db "Similitud encontrada: ", 0
 msg2 db "No hay letras iguales ", 10, 0
 newline db 10, 0

 section .bss
 char_sim resb 1

 section .text
 global _start

 _start:
 mov esi, str1
 mov edi, str2

 .compare_loop:
 mov al, [esi]
 mov bl, [edi]
 test al, al
 jz .check_str2

 test bl, bl
 jz .next_char_str1

 cmp al, bl
 je .found_similitary

 inc edi
 jmp .compare_loop

 .next_char_str1:
 inc esi
 mov edi, str2
 jmp .compare_loop

 .check_str2:
 mov eax, msg2
 call print_string
 jmp .exit

 .found_similitary:
 mov [char_sim], al

 mov eax, msg
 call print_string

 mov eax, char_sim
 call print_string

 mov eax, newline
 call print_string

 .exit:
 mov eax, 1
 mov ebx, 0
 int 0x80

 print_string:
 push ecx
 push edx
 mov ecx, eax
 xor edx, edx
 
 .strlen:
 cmp byte [eax+edx], 0
 je .print
 inc edx
 jmp .strlen

 .print:
 mov eax, 4
 mov ebx, 1
 int 0x80
 pop edx
 pop ecx
 ret

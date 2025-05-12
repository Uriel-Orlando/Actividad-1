 section .data
 msg1 db "Ingrese una palabra: ", 0
 msg2 db "Palabra invertida: ", 0
 newline db 10 ,0

 section .bss
 buffer resb 100
 reversed resb 100

 section .text
 global _start

 _start:
 mov eax, msg1
 call print_string

 mov eax, 3
 mov ebx, 0
 mov ecx, buffer
 mov edx, 100
 int 0x80

 mov edi, buffer
 call strlen
 cmp byte [edi + eax - 1], 10
 jne .no_newline
 mov byte [edi + eax - 1], 0
 dec eax

 .no_newline:
 mov esi, buffer
 lea edi, [buffer + eax - 1]
 mov ecx, reversed

 .reverse_loop:
 cmp esi, edi
 ja .reverse_done
 mov al, [edi]
 mov [ecx], al
 dec edi
 inc ecx
 jmp .reverse_loop

 .reverse_done:
 mov byte [ecx], 0

 mov eax, msg2
 call print_string
 mov eax, reversed
 call print_string
 mov eax, newline
 call print_string

 mov eax, 1
 xor ebx, ebx
 int 0x80

 strlen:
 xor eax, eax
 .strlen_loop:
 cmp byte [edi + eax], 0
 je .strlen_done
 inc eax
 jmp .strlen_loop

 .strlen_done:
 ret

 print_string:
 pusha
 mov ecx, eax
 xor edx, edx

 .print_strlen:
 cmp byte [eax + edx], 0
 je .print
 inc edx
jmp .print_strlen

 .print:
 mov eax, 4
 mov ebx, 1
 int 0x80
 popa
 ret

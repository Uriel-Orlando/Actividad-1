 section .data
 msg_input db "Ingrese un numero (0-12): ", 0
 msg_result db "Factorial: ", 0
 newline db 10, 0

 section .bss
 buffer resb 12
 number resd 1

 section .text
 global _start

 %macro factorial 0
 push ecx
 mov ecx, eax
 cmp eax, 1
 jbe .done
 dec ecx
 .loop:
 mul ecx
 loop .loop
 .done:
 pop ecx
 %endmacro

 _start:
 mov eax, 4
 mov ebx, 1
 mov ecx, msg_input
 mov edx, 23
 int 0x80

 mov eax, 3
 factorial

 add eax, '0'
 mov [buffer], eax

 mov eax, 4
 mov ebx, 1
 mov ecx, msg_result
 mov edx, 11
 int 0x80

 mov eax, 4
 mov ebx, 1
 mov ecx, buffer
 mov edx, 1
 int 0x80

 mov eax, 4
 mov ebx, 1
 mov ecx, newline
 mov edx, 1
 int 0x80

 mov eax, 1
 xor ebx, ebx
 int 0x80

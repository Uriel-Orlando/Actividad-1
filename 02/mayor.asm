 section .data
 num1 dd 15
 num2 dd 27
 num3 dd 19
 msg db "El numero mayor es: "
 msg_len equ $ - msg
 newline db 10

 section .bss
 buffer resb 10 

 section .text
 global _start

 _start:
 mov eax, [num1]
 mov ebx, [num2]
 mov ecx, [num3]
 
 cmp eax, ebx
 jge .compare
 mov eax, ebx

 .compare:
 cmp eax, ecx
 jge .convert
 mov eax, ecx

 .convert:
 mov edi, buffer + 9
 mov byte [edi], 0
 mov ebx, 10
 
 .convert_loop:
 dec edi
 xor edx, edx
 div ebx
 add dl, '0'
 mov [edi], dl
 test eax, eax
 jnz .convert_loop

 mov eax, 4
 mov ebx, 1
 mov ecx, msg
 mov edx, msg_len
 int 0x80

 mov eax, 4
 mov ebx, 1
 mov ecx, edi
 mov edx, buffer + 10
 sub edx, edi
 int 0x80

 mov eax, 4
 mov ebx, 1
 mov ecx, newline
 mov edx, 1
 int 0x80

 mov eax, 1
 xor ebx, ebx
 int 0x80
 section .data
 msg1 db " Ingrese valor: ", 0
 msg_row db " Fila: ", 0
 newline db 10
 space db 32
 
 section .bss
 mat1 resd 9
 mat2 resd 9
 result resd 9
 buffer resb 12

 section .text
 global _start

 _start:
 mov esi, mat1
 call leer_matriz
 mov esi, mat2
 call leer_matriz

 call sumar
 mov esi, result
 call imprimir_matriz

 mov eax, 1
 xor ebx, ebx
 int 0x80

 leer_matriz:
 mov ecx, 9
 mov edi, 0
 .leer_loop:
 pusha
 mov eax, 4
 mov ebx, 1
 mov ecx, msg1
 mov edx, 15
 int 0x80
 popa

 pusha
 mov eax, 3
 mov ebx, 0
 mov ecx, buffer
 mov edx, 12
 int 0x80

 call atoi
 mov [esi + edi*4], eax
 popa

 inc edi
 loop .leer_loop
 ret

 sumar:
 mov ecx, 9
 xor edi, edi
 .suma_loop:
 mov eax, [mat1 + edi*4]
 add eax, [mat2 + edi*4]
 mov [result + edi*4], eax
 inc edi
 loop .suma_loop
 ret

 imprimir_matriz:
 mov ecx, 3
 xor edi, edi
 .fila_loop:
 pusha
 mov eax, 4
 mov ebx, 1
 mov ecx, msg_row
 mov edx, 7
 int 0x80
 popa

 mov edx, 3
 .col_loop:
 pusha
 mov eax, [esi + edi*4]
 call print_int

 mov eax, 4
 mov ebx, 1
 mov ecx, space
 mov edx, 1
 int 0x80
 popa

 inc edi
 dec edx
 jnz .col_loop

 pusha
 mov eax, 4
 mov ebx, 1
 mov ecx, newline
 mov edx, 1
 int 0x80
 popa

 loop .fila_loop
 ret

 atoi:
 xor eax, eax
 xor ebx, ebx
 mov ecx, buffer
 .convert:
 movzx edx, byte [ecx]
 cmp dl, 10
 je .done
 sub dl, '0'
 imul eax, 10
 add eax, edx
 inc ecx
 jmp .convert

 .done:
 ret

 print_int:
 mov edi, buffer + 11
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
 mov ecx, edi
 mov edx, buffer + 12
 sub edx, edi
 int 0x80
 ret

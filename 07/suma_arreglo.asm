 section .data
 arr1 dd 5, 12, 8
 arr2 dd 3, 7, 4
 msg1 db "Suma: ", 0
 msg2 db "Resta: ", 0
 espacio db '  ', 0
 newline db 10, 0

 section .bss
 suma resd 3
 resta resd 3
 buffer resb 12

 section .text
 global _start

 _start:
 mov ecx, 3
 xor esi, esi

 .calcular:
 mov eax, [arr1 + esi*4]
 mov ebx, [arr2 + esi*4]
 add eax, ebx
 mov [suma + esi*4], eax

 mov eax, [arr1 + esi*4]
 sub eax, ebx
 mov [resta + esi*4], eax

 inc esi
 loop .calcular

 mov eax, msg1
 call print_string

 mov ecx, 3
 xor esi, esi

 .mostrar_suma:
 mov eax, [suma + esi*4]
 call print_int
 mov eax, espacio
 call print_string
 inc esi
 loop .mostrar_suma

 call print_newline

 mov eax, msg2
 call print_string

 mov ecx, 3
 xor esi, esi
 
 .mostrar_resta:
 mov eax, [resta + esi*4]
 call print_int
 mov eax, espacio
 call print_string
 inc esi
 loop .mostrar_resta

 call print_newline

 mov eax, 1
 xor ebx, ebx
 int 0x80

 print_int:
 pusha
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
 popa 
 ret

 print_string:
 pusha
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
 popa
 ret

 print_newline:
 pusha
 mov eax, 4
 mov ebx, 1
 mov ecx, newline
 mov edx, 1
 int 0x80
 popa
 ret

 
 
 
 

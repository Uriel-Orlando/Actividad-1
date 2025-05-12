 section .data
 nums dd 15, 42, 27, 35
 msg db "La mediana es: "
 msg_len equ $ - msg
 newline db 10

 section .bss
 result resb 3

 section .text
 global _start

 _start:
 mov ecx, 3
 
 .sort_loop:
 mov esi, nums
 mov edx, 3
 
 .inner_loop:
 mov eax, [esi]
 mov ebx, [esi+4]
 cmp eax, ebx
 jle .no_swap
 mov [esi], ebx
 mov [esi+4], eax
 
 .no_swap:
 add esi, 4
 dec edx
 jnz .inner_loop
 loop .sort_loop

 mov eax, [nums+4]
 add eax, [nums+8]
 shr eax, 1

 mov ebx, 10
 xor edx, edx
 div ebx

 add al, '0'
 add dl, '0'

 mov [result], al
 mov [result+1], dl
 mov byte [result+2], 10

 mov eax, 4
 mov ebx, 1
 mov ecx, msg
 mov edx, msg_len
 int 0x80

 mov eax, 4
 mov ebx, 1
 mov ecx, result
 mov edx, 3
 int 0x80

 mov eax, 1
 xor ebx, ebx
 int 0x80

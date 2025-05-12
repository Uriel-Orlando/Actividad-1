 section .data
 line db '--------------------', 10
 len equ $ - line

 section .text
 global _start
 
 _start:
 mov eax, 4
 mov ebx, 1
 mov ecx, line
 mov edx, len
 int 0x80

 mov eax, 1
 xor ebx, ebx
 int 0x80

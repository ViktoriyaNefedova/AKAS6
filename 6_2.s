%include "syscall.mac"

%macro WRITE 3
    mov eax, 4         ; Системный вызов для записи
    mov ebx, %1        ; Файловый дескриптор STDOUT
    mov ecx, %2        ; Адрес буфера для записи
    mov edx, %3        ; Размер буфера
    int 0x80
%endmacro

%macro EXIT_PROGRAM 1
    mov eax, 1            ; Системный вызов для выхода
    mov ebx, %1           ; Код завершения
    int 0x80
%endmacro


section .data
    buffer equ 256    ; Размер буфера для строки

section .bss
    input resb buffer    ; Выделение памяти под входную строку

section .text
    global _start

_start:
    ; Чтение строки из stdin
    READ 0, input, buffer

    ; Вывод строки в stdout
    WRITE 1, input, buffer

    ; Выход из программы
    EXIT_PROGRAM 0


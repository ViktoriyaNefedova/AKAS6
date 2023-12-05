%include "syscall.mac"

%macro WRITE_FILE 2
    mov rax, 1             ; Системный вызов для записи
    mov rdi, 1             ; Файловый дескриптор STDOUT
    mov rsi, %1            ; Адрес буфера для записи
    mov rdx, %2            ; Размер буфера
    syscall
%endmacro

%macro EXIT_PROGRAM 1
    mov rax, 60            ; Системный вызов для выхода
    mov rdi, %1            ; Код завершения
    syscall
%endmacro

section .data
    buffer equ 256    ; Размер буфера для строки

section .bss
    input resb buffer    ; Выделение памяти под входную строку

section .text
    global _start

_start:
    ; Чтение строки из stdin
    READ_FILE input, buffer

    ; Вывод строки в stdout
    WRITE_FILE input, buffer

    ; Выход из программы
    EXIT_PROGRAM 0

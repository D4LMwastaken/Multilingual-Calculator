; Assembly translation of test.c
; Target architecture: x86-64

section .data
; Constants
NAME:       db "Hello World Testing", 0
DEV:        db "D4LM", 0
VERSION:    db "1.0", 0

    ; Format strings for printf
    fmt_greeting:       db "%s", 10, "Developer: %s", 10, "Version: %s", 10, 0
    fmt_hello:          db "Hello World", 10, 0
    fmt_prompt:         db "%s", 0
    fmt_add_result:     db "%.2f + %.2f = %.2f", 10, 0
    fmt_sub_result:     db "%.2f - %.2f = %.2f", 10, 0
    fmt_mul_result:     db "%.2f * %.2f = %.2f", 10, 0
    fmt_div_result:     db "%.2f / %.2f = %.2f", 10, 0
    fmt_exp_result:     db "%.2f ^ %.2f = %.2f", 10, 0
    fmt_sqrt_result:    db "Square root of %.2f = %.4f", 10, 0
    fmt_help_header:    db 10, "Available commands:", 10, 0
    fmt_help_entry:     db "%s - %s", 10, 0
    fmt_goodbye:        db "Goodbye!", 10, 0
    fmt_invalid:        db "Invalid command, check help", 10, 0
    fmt_newline:        db 10, 0
    fmt_debug:          db "Debug: %s", 10, 0
    
    ; String constants for commands
    str_greet:          db "greet", 0
    str_add:            db "add", 0
    str_subtract:       db "subtract", 0
    str_multiply:       db "multiply", 0
    str_divide:         db "divide", 0
    str_exponent:       db "exponent", 0
    str_square_root:    db "square_root", 0
    str_quit:           db "quit", 0
    str_help:           db "help", 0
    
    ; Prompt strings
    prompt_what_to_do:  db "What do you want to do? ", 0
    prompt_first_num:   db "Enter first number: ", 0
    prompt_second_num:  db "Enter second number: ", 0
    prompt_base:        db "Enter base: ", 0
    prompt_exponent:    db "Enter exponent: ", 0
    prompt_number:      db "Enter number: ", 0
    
    ; Command descriptions
    desc_greet:         db "Greet the user", 0
    desc_add:           db "Add two numbers", 0
    desc_subtract:      db "Subtract two numbers", 0
    desc_multiply:      db "Multiply two numbers", 0
    desc_divide:        db "Divide two numbers", 0
    desc_exponent:      db "Raise a number to a power", 0
    desc_square_root:   db "Calculate the square root of a number", 0
    desc_quit:          db "Quit the program", 0
    desc_help:          db "Display this help message", 0
    
    ; Command and description pairs
    command_pairs:
        dq str_greet, desc_greet
        dq str_add, desc_add
        dq str_subtract, desc_subtract
        dq str_multiply, desc_multiply
        dq str_divide, desc_divide
        dq str_exponent, desc_exponent
        dq str_square_root, desc_square_root
        dq str_quit, desc_quit
        dq str_help, desc_help
    
    command_count:      dd 9
    
section .bss
    input:      resb 100    ; Input buffer
    numInput:   resb 100    ; Number input buffer
    num1:       resq 1      ; Space to store first number
    num2:       resq 1      ; Space to store second number

section .text
    global main
    extern printf, scanf, fgets, stdin, strcmp, tolower, atof, pow, sqrt, strlen

main:
    push rbp
    mov rbp, rsp
    sub rsp, 32              ; Create stack frame with local variables
    and rsp, -16             ; Ensure 16-byte alignment

    ; Print greeting
    mov rdi, fmt_greeting
    mov rsi, NAME
    mov rdx, DEV
    mov rcx, VERSION
    xor rax, rax
    call printf
    
main_loop:
    ; Ask for command
    mov rdi, prompt_what_to_do
    lea rsi, [input]
    mov rdx, 100
    call get_input

    ; Convert input to lowercase
    mov rdi, input
    call make_lowercase
    
    ; Check commands
    mov rdi, input
    mov rsi, str_greet
    call strcmp
    test eax, eax
    jz do_greet
    
    mov rdi, input
    mov rsi, str_add
    call strcmp
    test eax, eax
    jz do_add
    
    mov rdi, input
    mov rsi, str_subtract
    call strcmp
    test eax, eax
    jz do_subtract
    
    mov rdi, input
    mov rsi, str_multiply
    call strcmp
    test eax, eax
    jz do_multiply
    
    mov rdi, input
    mov rsi, str_divide
    call strcmp
    test eax, eax
    jz do_divide
    
    mov rdi, input
    mov rsi, str_exponent
    call strcmp
    test eax, eax
    jz do_exponent
    
    mov rdi, input
    mov rsi, str_square_root
    call strcmp
    test eax, eax
    jz do_square_root
    
    mov rdi, input
    mov rsi, str_quit
    call strcmp
    test eax, eax
    jz do_quit
    
    mov rdi, input
    mov rsi, str_help
    call strcmp
    test eax, eax
    jz do_help
    
    ; Invalid command
    mov rdi, fmt_invalid
    xor rax, rax
    call printf
    jmp main_loop
    
do_greet:
    ; Call greet function
    call greet
    jmp main_loop

do_add:
    ; Get first number
    mov rdi, prompt_first_num
    lea rsi, [numInput]
    mov rdx, 100
    call get_input
    
    ; Convert to double
    mov rdi, numInput
    call atof
    movsd [num1], xmm0
    
    ; Get second number
    mov rdi, prompt_second_num
    lea rsi, [numInput]
    mov rdx, 100
    call get_input
    
    ; Convert to double
    mov rdi, numInput
    call atof
    movsd [num2], xmm0
    
    ; Add the numbers and print result
    movsd xmm0, [num1]
    movsd xmm1, [num2]
    movsd xmm2, xmm0
    addsd xmm2, xmm1
    
    mov rdi, fmt_add_result
    mov rax, 3
    call printf
    
    jmp main_loop
    
do_subtract:
    ; Get first number
    mov rdi, prompt_first_num
    lea rsi, [numInput]
    mov rdx, 100
    call get_input
    
    ; Convert to double
    mov rdi, numInput
    call atof
    movsd [num1], xmm0
    
    ; Get second number
    mov rdi, prompt_second_num
    lea rsi, [numInput]
    mov rdx, 100
    call get_input
    
    ; Convert to double
    mov rdi, numInput
    call atof
    movsd [num2], xmm0
    
    ; Subtract and print result
    movsd xmm0, [num1]
    movsd xmm1, [num2]
    movsd xmm2, xmm0
    subsd xmm2, xmm1
    
    mov rdi, fmt_sub_result
    mov rax, 3
    call printf
    
    jmp main_loop
    
do_multiply:
    ; Get first number
    mov rdi, prompt_first_num
    lea rsi, [numInput]
    mov rdx, 100
    call get_input
    
    ; Convert to double
    mov rdi, numInput
    call atof
    movsd [num1], xmm0
    
    ; Get second number
    mov rdi, prompt_second_num
    lea rsi, [numInput]
    mov rdx, 100
    call get_input
    
    ; Convert to double
    mov rdi, numInput
    call atof
    movsd [num2], xmm0
    
    ; Multiply and print result
    movsd xmm0, [num1]
    movsd xmm1, [num2]
    movsd xmm2, xmm0
    mulsd xmm2, xmm1
    
    mov rdi, fmt_mul_result
    mov rax, 3
    call printf
    
    jmp main_loop
    
do_divide:
    ; Get first number
    mov rdi, prompt_first_num
    lea rsi, [numInput]
    mov rdx, 100
    call get_input
    
    ; Convert to double
    mov rdi, numInput
    call atof
    movsd [num1], xmm0
    
    ; Get second number
    mov rdi, prompt_second_num
    lea rsi, [numInput]
    mov rdx, 100
    call get_input
    
    ; Convert to double
    mov rdi, numInput
    call atof
    movsd [num2], xmm0
    
    ; Divide and print result
    movsd xmm0, [num1]
    movsd xmm1, [num2]
    movsd xmm2, xmm0
    divsd xmm2, xmm1
    
    mov rdi, fmt_div_result
    mov rax, 3
    call printf
    
    jmp main_loop
    
do_exponent:
    ; Get base
    mov rdi, prompt_base
    lea rsi, [numInput]
    mov rdx, 100
    call get_input
    
    ; Convert to double
    mov rdi, numInput
    call atof
    movsd [num1], xmm0
    
    ; Get exponent
    mov rdi, prompt_exponent
    lea rsi, [numInput]
    mov rdx, 100
    call get_input
    
    ; Convert to double
    mov rdi, numInput
    call atof
    movsd [num2], xmm0
    
    ; Calculate power
    movsd xmm0, [num1]
    movsd xmm1, [num2]
    call pow
    movsd xmm2, xmm0
    
    ; Print result
    movsd xmm0, [num1]
    movsd xmm1, [num2]
    mov rdi, fmt_exp_result
    mov rax, 3
    call printf
    
    jmp main_loop
    
do_square_root:
    ; Get number
    mov rdi, prompt_number
    lea rsi, [numInput]
    mov rdx, 100
    call get_input
    
    ; Convert to double
    mov rdi, numInput
    call atof
    movsd [num1], xmm0
    
    ; Calculate square root
    call sqrt
    movsd xmm1, xmm0
    
    ; Print result
    movsd xmm0, [num1]
    mov rdi, fmt_sqrt_result
    mov rax, 2
    call printf
    
    jmp main_loop
    
do_quit:
    ; Print goodbye message
    mov rdi, fmt_goodbye
    xor rax, rax
    call printf
    
    ; Return from main
    xor eax, eax
    leave
    ret
    
do_help:
    ; Display help
    call display_help
    jmp main_loop

; Function implementations
greet:
    push rbp
    mov rbp, rsp
    
    ; Print "Hello World"
    mov rdi, fmt_hello
    xor rax, rax
    call printf
    
    leave
    ret
    
; COMPLETELY REWRITTEN display_help function to avoid segfaults
display_help:
    push rbp
    mov rbp, rsp
    sub rsp, 32
    
    ; Print help header
    mov rdi, fmt_help_header
    xor rax, rax
    call printf
    
    ; Print each command and description
    mov DWORD [rbp-4], 0      ; Counter i = 0
    
help_loop:
    mov eax, DWORD [rbp-4]
    cmp eax, DWORD [command_count]
    jge help_done
    
    ; Calculate offset in command_pairs array
    mov eax, DWORD [rbp-4]
    shl eax, 4                ; i * 16 (each entry is 16 bytes)
    
    ; Get command string and description
    mov rsi, [command_pairs + rax]     ; Command
    mov rdx, [command_pairs + rax + 8] ; Description
    
    ; Print the command and description
    mov rdi, fmt_help_entry
    xor rax, rax
    call printf
    
    ; Increment counter
    inc DWORD [rbp-4]
    jmp help_loop
    
help_done:
    ; Print a newline
    mov rdi, fmt_newline
    xor rax, rax
    call printf
    
    leave
    ret
    
; Helper function to get user input
get_input:
    push rbp
    mov rbp, rsp
    sub rsp, 32
    
    ; Save parameters
    mov [rbp-8], rdi         ; Prompt
    mov [rbp-16], rsi        ; Buffer
    mov [rbp-24], rdx        ; Size
    
    ; Print prompt
    mov rdi, fmt_prompt
    mov rsi, [rbp-8]
    xor rax, rax
    call printf
    
    ; Get input using fgets
    mov rdi, [rbp-16]
    mov rsi, [rbp-24]
    mov rdx, [stdin]
    call fgets
    
    ; Remove trailing newline if present
    mov rdi, [rbp-16]
    call strlen
    
    cmp rax, 0
    je get_input_done
    
    mov rcx, [rbp-16]
    add rcx, rax
    dec rcx         ; Point to last character
    
    cmp byte [rcx], 10  ; Check for newline
    jne get_input_done
    
    mov byte [rcx], 0   ; Replace with null
    
get_input_done:
    mov rax, [rbp-16]  ; Return buffer address
    leave
    ret
    
; Function to convert string to lowercase
make_lowercase:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    
    ; Save string pointer
    mov [rbp-8], rdi
    
    ; Set up counter
    mov QWORD [rbp-16], 0
    
make_lowercase_loop:
    ; Get current character pointer
    mov rax, [rbp-8]
    add rax, [rbp-16]
    
    ; Check if we're at the end of the string
    cmp byte [rax], 0
    je make_lowercase_done
    
    ; Call tolower on the character
    movzx edi, byte [rax]
    call tolower
    
    ; Store lowercase character back
    mov rcx, [rbp-8]
    add rcx, [rbp-16]
    mov byte [rcx], al
    
    ; Move to next character
    inc QWORD [rbp-16]
    jmp make_lowercase_loop
    
make_lowercase_done:
    mov rax, [rbp-8]  ; Return string pointer
    leave
    ret
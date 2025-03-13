; Multilingual Calculator in x86-64 Assembly for Linux
; Uses direct system calls for I/O

section .data
    ; Constants
    LF equ 10                    ; Line feed character
    NULL equ 0                   ; Null terminator
    
    ; Program information
    title db "Multilingual Calculator", LF
    title_len equ $ - title
    dev db "Developer: D4LM", LF
    dev_len equ $ - dev
    codev db "CoDeveloper: AidanB446", LF
    codev_len equ $ - codev
    version db "Version: 1.1", LF, LF
    version_len equ $ - version
    
    ; Prompts
    prompt_cmd db "What do you want to do? "
    prompt_cmd_len equ $ - prompt_cmd
    prompt_num1 db "Enter first number: "
    prompt_num1_len equ $ - prompt_num1
    prompt_num2 db "Enter second number: "
    prompt_num2_len equ $ - prompt_num2
    
    ; Messages
    msg_hello db "Hello World!", LF
    msg_hello_len equ $ - msg_hello
    msg_goodbye db "Goodbye!", LF
    msg_goodbye_len equ $ - msg_goodbye
    msg_help db LF, "Available commands:", LF
              db "greet       - Greet the user", LF
              db "add         - Add two numbers", LF
              db "subtract    - Subtract two numbers", LF
              db "multiply    - Multiply two numbers", LF
              db "divide      - Divide two numbers", LF
              db "exponent    - Raise a number to a power", LF
              db "square_root - Calculate the square root of a number", LF
              db "quit        - Quit the program", LF
              db "help        - Display this help message", LF, LF
    msg_help_len equ $ - msg_help
    msg_invalid db "Invalid command, type 'help' for available commands", LF
    msg_invalid_len equ $ - msg_invalid
    msg_second_required db "Second number is required for this operation", LF
    msg_second_required_len equ $ - msg_second_required
    msg_invalid_number db "Please enter valid numbers", LF
    msg_invalid_number_len equ $ - msg_invalid_number
    msg_divide_zero db "Error: Division by zero", LF
    msg_divide_zero_len equ $ - msg_divide_zero
    
    ; Commands
    cmd_greet db "greet", NULL
    cmd_add db "add", NULL
    cmd_subtract db "subtract", NULL
    cmd_multiply db "multiply", NULL
    cmd_divide db "divide", NULL
    cmd_exponent db "exponent", NULL
    cmd_square_root db "square_root", NULL
    cmd_quit db "quit", NULL
    cmd_help db "help", NULL
    
    ; Result templates
    result_add db " + ", NULL
    result_subtract db " - ", NULL
    result_multiply db " * ", NULL
    result_divide db " / ", NULL
    result_exponent db " ^ ", NULL
    result_root db "√", NULL
    result_equals db " = ", NULL
    
    ; Numeric conversion buffers
    ten dq 10                    ; For numeric conversion

section .bss
    input_buffer resb 100        ; Input buffer
    command_buffer resb 20       ; Command buffer
    num_buffer1 resb 20          ; Number buffer 1
    num_buffer2 resb 20          ; Number buffer 2
    result_buffer resb 100       ; Result buffer
    num1 resq 1                  ; First number
    num2 resq 1                  ; Second number
    result resq 1                ; Result

section .text
    global _start

_start:
    ; Display header
    mov rdi, title
    mov rsi, title_len
    call print_string
    
    mov rdi, dev
    mov rsi, dev_len
    call print_string
    
    mov rdi, codev
    mov rsi, codev_len
    call print_string
    
    mov rdi, version
    mov rsi, version_len
    call print_string
    
main_loop:
    ; Prompt for command
    mov rdi, prompt_cmd
    mov rsi, prompt_cmd_len
    call print_string
    
    ; Read command
    mov rdi, input_buffer
    mov rsi, 100
    call read_line
    
    ; Copy command to a separate buffer
    mov rsi, input_buffer
    mov rdi, command_buffer
    call copy_string
    
    ; Convert command to lowercase
    mov rdi, command_buffer
    call to_lowercase
    
    ; Check commands
    mov rdi, command_buffer
    mov rsi, cmd_quit
    call compare_string
    cmp rax, 0
    je exit_program
    
    mov rdi, command_buffer
    mov rsi, cmd_help
    call compare_string
    cmp rax, 0
    je display_help
    
    mov rdi, command_buffer
    mov rsi, cmd_greet
    call compare_string
    cmp rax, 0
    je do_greet
    
    ; For other commands, we need numbers
    mov rdi, prompt_num1
    mov rsi, prompt_num1_len
    call print_string
    
    ; Read first number
    mov rdi, input_buffer
    mov rsi, 100
    call read_line
    
    ; Copy to number buffer
    mov rsi, input_buffer
    mov rdi, num_buffer1
    call copy_string
    
    ; Convert to integer
    mov rdi, num_buffer1
    call string_to_int
    cmp rdx, 0          ; Check if conversion was successful
    jne invalid_number
    mov [num1], rax     ; Store the number
    
    ; Check for square_root command
    mov rdi, command_buffer
    mov rsi, cmd_square_root
    call compare_string
    cmp rax, 0
    je do_square_root
    
    ; Get second number for binary operations
    mov rdi, prompt_num2
    mov rsi, prompt_num2_len
    call print_string
    
    ; Read second number
    mov rdi, input_buffer
    mov rsi, 100
    call read_line
    
    ; Check if empty
    mov rdi, input_buffer
    call string_length
    cmp rax, 0
    je second_required
    
    ; Copy to number buffer
    mov rsi, input_buffer
    mov rdi, num_buffer2
    call copy_string
    
    ; Convert to integer
    mov rdi, num_buffer2
    call string_to_int
    cmp rdx, 0          ; Check if conversion was successful
    jne invalid_number
    mov [num2], rax     ; Store the number
    
    ; Check which operation to perform
    mov rdi, command_buffer
    mov rsi, cmd_add
    call compare_string
    cmp rax, 0
    je do_add
    
    mov rdi, command_buffer
    mov rsi, cmd_subtract
    call compare_string
    cmp rax, 0
    je do_subtract
    
    mov rdi, command_buffer
    mov rsi, cmd_multiply
    call compare_string
    cmp rax, 0
    je do_multiply
    
    mov rdi, command_buffer
    mov rsi, cmd_divide
    call compare_string
    cmp rax, 0
    je do_divide
    
    mov rdi, command_buffer
    mov rsi, cmd_exponent
    call compare_string
    cmp rax, 0
    je do_exponent
    
    ; Invalid command
    mov rdi, msg_invalid
    mov rsi, msg_invalid_len
    call print_string
    jmp main_loop

;----- Command Handlers -----

exit_program:
    mov rdi, msg_goodbye
    mov rsi, msg_goodbye_len
    call print_string
    
    ; Exit program
    mov rax, 60         ; syscall: exit
    xor rdi, rdi        ; status: 0
    syscall

display_help:
    mov rdi, msg_help
    mov rsi, msg_help_len
    call print_string
    jmp main_loop

do_greet:
    mov rdi, msg_hello
    mov rsi, msg_hello_len
    call print_string
    jmp main_loop

invalid_number:
    mov rdi, msg_invalid_number
    mov rsi, msg_invalid_number_len
    call print_string
    jmp main_loop

second_required:
    mov rdi, msg_second_required
    mov rsi, msg_second_required_len
    call print_string
    jmp main_loop

do_add:
    ; Clear result buffer
    mov rdi, result_buffer
    call clear_buffer
    
    ; First number
    mov rdi, num_buffer1
    mov rsi, result_buffer
    call append_string
    
    ; + symbol
    mov rdi, result_add
    mov rsi, result_buffer
    call append_string
    
    ; Second number
    mov rdi, num_buffer2
    mov rsi, result_buffer
    call append_string
    
    ; = symbol
    mov rdi, result_equals
    mov rsi, result_buffer
    call append_string
    
    ; Calculate result
    mov rax, [num1]
    add rax, [num2]
    mov [result], rax
    
    ; Convert result to string and append
    mov rdi, result
    mov rsi, result_buffer
    call append_int
    
    ; Add line feed
    mov rdi, result_buffer
    call string_length
    mov byte [result_buffer + rax], LF
    inc rax
    mov byte [result_buffer + rax], NULL
    
    ; Print result
    mov rdi, result_buffer
    mov rsi, 100   ; Maximum length
    call print_string
    
    jmp main_loop

do_subtract:
    ; Clear result buffer
    mov rdi, result_buffer
    call clear_buffer
    
    ; First number
    mov rdi, num_buffer1
    mov rsi, result_buffer
    call append_string
    
    ; - symbol
    mov rdi, result_subtract
    mov rsi, result_buffer
    call append_string
    
    ; Second number
    mov rdi, num_buffer2
    mov rsi, result_buffer
    call append_string
    
    ; = symbol
    mov rdi, result_equals
    mov rsi, result_buffer
    call append_string
    
    ; Calculate result
    mov rax, [num1]
    sub rax, [num2]
    mov [result], rax
    
    ; Convert result to string and append
    mov rdi, result
    mov rsi, result_buffer
    call append_int
    
    ; Add line feed
    mov rdi, result_buffer
    call string_length
    mov byte [result_buffer + rax], LF
    inc rax
    mov byte [result_buffer + rax], NULL
    
    ; Print result
    mov rdi, result_buffer
    mov rsi, 100   ; Maximum length
    call print_string
    
    jmp main_loop

do_multiply:
    ; Clear result buffer
    mov rdi, result_buffer
    call clear_buffer
    
    ; First number
    mov rdi, num_buffer1
    mov rsi, result_buffer
    call append_string
    
    ; * symbol
    mov rdi, result_multiply
    mov rsi, result_buffer
    call append_string
    
    ; Second number
    mov rdi, num_buffer2
    mov rsi, result_buffer
    call append_string
    
    ; = symbol
    mov rdi, result_equals
    mov rsi, result_buffer
    call append_string
    
    ; Calculate result
    mov rax, [num1]
    imul rax, [num2]
    mov [result], rax
    
    ; Convert result to string and append
    mov rdi, result
    mov rsi, result_buffer
    call append_int
    
    ; Add line feed
    mov rdi, result_buffer
    call string_length
    mov byte [result_buffer + rax], LF
    inc rax
    mov byte [result_buffer + rax], NULL
    
    ; Print result
    mov rdi, result_buffer
    mov rsi, 100   ; Maximum length
    call print_string
    
    jmp main_loop

do_divide:
    ; Check for division by zero
    cmp qword [num2], 0
    je divide_by_zero
    
    ; Clear result buffer
    mov rdi, result_buffer
    call clear_buffer
    
    ; First number
    mov rdi, num_buffer1
    mov rsi, result_buffer
    call append_string
    
    ; / symbol
    mov rdi, result_divide
    mov rsi, result_buffer
    call append_string
    
    ; Second number
    mov rdi, num_buffer2
    mov rsi, result_buffer
    call append_string
    
    ; = symbol
    mov rdi, result_equals
    mov rsi, result_buffer
    call append_string
    
    ; Calculate result
    mov rax, [num1]
    cqo                 ; Sign extend rax into rdx:rax
    idiv qword [num2]
    mov [result], rax
    
    ; Convert result to string and append
    mov rdi, result
    mov rsi, result_buffer
    call append_int
    
    ; Add line feed
    mov rdi, result_buffer
    call string_length
    mov byte [result_buffer + rax], LF
    inc rax
    mov byte [result_buffer + rax], NULL
    
    ; Print result
    mov rdi, result_buffer
    mov rsi, 100   ; Maximum length
    call print_string
    
    jmp main_loop

divide_by_zero:
    mov rdi, msg_divide_zero
    mov rsi, msg_divide_zero_len
    call print_string
    jmp main_loop

do_exponent:
    ; For simplicity, we'll implement exponentiation for positive integers
    mov rcx, [num2]     ; Power
    mov rax, 1          ; Start with 1
    
    cmp rcx, 0          ; Check if power is 0
    je exponent_done
    
exponent_loop:
    imul rax, [num1]    ; Multiply by base
    dec rcx
    jnz exponent_loop
    
exponent_done:
    mov [result], rax
    
    ; Clear result buffer
    mov rdi, result_buffer
    call clear_buffer
    
    ; First number
    mov rdi, num_buffer1
    mov rsi, result_buffer
    call append_string
    
    ; ^ symbol
    mov rdi, result_exponent
    mov rsi, result_buffer
    call append_string
    
    ; Second number
    mov rdi, num_buffer2
    mov rsi, result_buffer
    call append_string
    
    ; = symbol
    mov rdi, result_equals
    mov rsi, result_buffer
    call append_string
    
    ; Convert result to string and append
    mov rdi, result
    mov rsi, result_buffer
    call append_int
    
    ; Add line feed
    mov rdi, result_buffer
    call string_length
    mov byte [result_buffer + rax], LF
    inc rax
    mov byte [result_buffer + rax], NULL
    
    ; Print result
    mov rdi, result_buffer
    mov rsi, 100   ; Maximum length
    call print_string
    
    jmp main_loop

do_square_root:
    ; Simple integer square root implementation for positive integers
    ; This is a rough approximation using an iterative method
    mov rcx, [num1]     ; Number to find sqrt of
    mov rax, 0          ; Current guess
    
sqrt_loop:
    mov rdx, rax        ; Save current guess
    inc rax             ; Try next value
    imul rax, rax       ; Square it
    cmp rax, rcx        ; Compare with target
    jle sqrt_loop       ; If <= target, continue
    
    mov [result], rdx   ; Store result (previous value)
    
    ; Clear result buffer
    mov rdi, result_buffer
    call clear_buffer
    
    ; Square root symbol
    mov rdi, result_root
    mov rsi, result_buffer
    call append_string
    
    ; Number
    mov rdi, num_buffer1
    mov rsi, result_buffer
    call append_string
    
    ; = symbol
    mov rdi, result_equals
    mov rsi, result_buffer
    call append_string
    
    ; Convert result to string and append
    mov rdi, result
    mov rsi, result_buffer
    call append_int
    
    ; Add line feed
    mov rdi, result_buffer
    call string_length
    mov byte [result_buffer + rax], LF
    inc rax
    mov byte [result_buffer + rax], NULL
    
    ; Print result
    mov rdi, result_buffer
    mov rsi, 100   ; Maximum length
    call print_string
    
    jmp main_loop

;----- String Utility Functions -----

; Print a string to stdout
; rdi = string address, rsi = length
print_string:
    push rax
    push rdi
    push rsi
    push rdx
    
    mov rdx, rsi        ; length
    mov rsi, rdi        ; buffer
    mov rdi, 1          ; fd (stdout)
    mov rax, 1          ; syscall: write
    syscall
    
    pop rdx
    pop rsi
    pop rdi
    pop rax
    ret

; Read a line from stdin
; rdi = buffer, rsi = max length
; Returns length in rax
read_line:
    push rdi
    push rsi
    push rdx
    
    mov rdx, rsi        ; max length
    mov rsi, rdi        ; buffer
    mov rdi, 0          ; fd (stdin)
    mov rax, 0          ; syscall: read
    syscall
    
    ; Remove newline if present
    mov rcx, rax        ; length read
    dec rcx             ; index of last character
    cmp byte [rsi + rcx], LF
    jne read_done
    mov byte [rsi + rcx], NULL
    dec rax
    
read_done:
    ; Ensure null termination
    mov rcx, rax
    mov byte [rsi + rcx], NULL
    
    pop rdx
    pop rsi
    pop rdi
    ret

; Convert a string to lowercase
; rdi = string
to_lowercase:
    push rax
    push rcx
    push rdi
    
    mov rcx, rdi
    
lowercase_loop:
    movzx eax, byte [rcx]   ; Get character
    test al, al          ; Check for null
    jz lowercase_done
    
    cmp al, 'A'          ; Check if uppercase
    jl lowercase_next
    cmp al, 'Z'
    jg lowercase_next
    
    add al, 32           ; Convert to lowercase
    mov [rcx], al
    
lowercase_next:
    inc rcx              ; Next character
    jmp lowercase_loop
    
lowercase_done:
    pop rdi
    pop rcx
    pop rax
    ret

; Compare two null-terminated strings
; rdi = first string, rsi = second string
; Returns 0 in rax if equal, non-zero if different
compare_string:
    push rbx
    push rcx
    push rdx
    
    mov rcx, rdi
    mov rdx, rsi
    
compare_loop:
    movzx eax, byte [rcx]   ; Get character from first string
    movzx ebx, byte [rdx]   ; Get character from second string
    
    test al, al          ; Check for end of first string
    jz compare_end
    
    cmp al, bl           ; Compare characters
    jne compare_end
    
    inc rcx              ; Next character
    inc rdx
    jmp compare_loop
    
compare_end:
    cmp al, bl           ; Final comparison
    pop rdx
    pop rcx
    pop rbx
    ret

; Copy a null-terminated string
; rsi = source, rdi = destination
copy_string:
    push rax
    push rsi
    push rdi
    
copy_loop:
    mov al, [rsi]        ; Get character
    mov [rdi], al        ; Copy character
    test al, al          ; Check for null
    jz copy_done
    
    inc rsi              ; Next source character
    inc rdi              ; Next destination character
    jmp copy_loop
    
copy_done:
    pop rdi
    pop rsi
    pop rax
    ret

; Append a null-terminated string to another
; rdi = source to append, rsi = destination
append_string:
    push rax
    push rcx
    push rdi
    push rsi
    
    ; Find end of destination
    mov rcx, rsi
    
find_end:
    cmp byte [rcx], NULL
    je found_end
    inc rcx
    jmp find_end
    
found_end:
    ; Now copy source to end of destination
    mov rsi, rdi        ; Source
    mov rdi, rcx        ; Destination (end of string)
    
append_loop:
    mov al, [rsi]        ; Get character
    mov [rdi], al        ; Copy character
    test al, al          ; Check for null
    jz append_done
    
    inc rsi              ; Next source character
    inc rdi              ; Next destination character
    jmp append_loop
    
append_done:
    pop rsi
    pop rdi
    pop rcx
    pop rax
    ret

; Get length of a null-terminated string
; rdi = string
; Returns length in rax
string_length:
    push rdi
    
    mov rax, 0          ; Initialize counter
    
length_loop:
    cmp byte [rdi], NULL
    je length_done
    inc rax              ; Increment counter
    inc rdi              ; Next character
    jmp length_loop
    
length_done:
    pop rdi
    ret

; Clear a buffer (fill with nulls)
; rdi = buffer
clear_buffer:
    push rax
    push rdi
    
    mov rax, 0          ; Null character
    
clear_loop:
    cmp byte [rdi], NULL
    je clear_done
    mov byte [rdi], NULL
    inc rdi
    jmp clear_loop
    
clear_done:
    pop rdi
    pop rax
    ret

; Convert a string to an integer
; rdi = string
; Returns integer in rax, status in rdx (0 = success, 1 = error)
string_to_int:
    push rbx
    push rcx
    push rsi
    
    mov rax, 0          ; Result
    mov rdx, 0          ; Status (0 = success)
    mov rcx, rdi        ; String pointer
    
    ; Check for sign
    mov bl, [rcx]
    cmp bl, '-'
    jne not_negative
    
    ; Negative number
    inc rcx              ; Skip sign
    mov rsi, 1          ; Remember it's negative
    jmp convert_loop
    
not_negative:
    mov rsi, 0          ; Not negative
    
convert_loop:
    movzx rbx, byte [rcx]   ; Get digit
    test bl, bl         ; Check for null
    jz convert_done
    
    cmp bl, '0'         ; Check if digit
    jl convert_error
    cmp bl, '9'
    jg convert_error
    
    ; Valid digit, convert
    sub bl, '0'         ; Convert to value
    imul rax, 10        ; Multiply by 10
    add rax, rbx        ; Add digit
    
    inc rcx              ; Next character
    jmp convert_loop
    
convert_error:
    mov rdx, 1          ; Set error status
    jmp convert_exit
    
convert_done:
    ; Apply sign if needed
    cmp rsi, 1
    jne convert_exit
    neg rax
    
convert_exit:
    pop rsi
    pop rcx
    pop rbx
    ret

; Append an integer to a string
; rdi = integer address, rsi = string buffer
append_int:
    push rax
    push rbx
    push rcx
    push rdx
    push rdi
    push rsi
    
    ; Find end of destination string
    mov rcx, rsi
    
find_end_int:
    cmp byte [rcx], NULL
    je found_end_int
    inc rcx
    jmp find_end_int
    
found_end_int:
    mov rsi, rcx        ; End of string
    
    ; Convert number to string (reversed)
    mov rax, [rdi]      ; Number to convert
    
    ; Check for negative
    cmp rax, 0
    jge append_int_positive
    
    ; Handle negative
    neg rax
    mov byte [rsi], '-'  ; Add minus sign
    inc rsi
    
append_int_positive:
    mov rcx, rsi        ; Save start of number
    
    ; Special case for 0
    cmp rax, 0
    jne append_int_loop
    
    mov byte [rsi], '0'
    inc rsi
    jmp append_int_done
    
append_int_loop:
    cmp rax, 0
    je append_int_reverse
    
    ; Divide by 10
    mov rdx, 0          ; Clear high part
    div qword [ten]     ; rax = quotient, rdx = remainder
    
    ; Convert remainder to digit
    add dl, '0'
    mov [rsi], dl       ; Store digit
    inc rsi
    
    jmp append_int_loop
    
append_int_reverse:
    ; Now reverse the digits
    mov byte [rsi], NULL ; Add null terminator
    dec rsi             ; Last digit
    
reverse_loop:
    cmp rcx, rsi
    jge reverse_done
    
    ; Swap characters
    mov al, [rcx]
    mov bl, [rsi]
    mov [rcx], bl
    mov [rsi], al
    
    inc rcx
    dec rsi
    jmp reverse_loop
    
reverse_done:
    ; Nothing to do
    
append_int_done:
    pop rsi
    pop rdi
    pop rdx
    pop rcx
    pop rbx
    pop rax
    ret

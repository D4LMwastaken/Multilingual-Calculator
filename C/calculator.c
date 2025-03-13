#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <math.h>

// Constants
#define MAX_INPUT 100
#define NUM_FUNCTIONS 9

// Variables
const char* Name = "Multilingual Calculator";
const char* Dev = "D4LM";
const char* CoDev = "AidanB446";
const char* Version = "1.1";

// Function prototypes
void greet(void);
char* add(double a, double b);
char* subtract(double a, double b);
char* multiply(double a, double b);
char* divide(double a, double b);
char* exponent(double a, double b);
char* square_root(double a);
void display_help(void);
char* read_input(const char* prompt, char* buffer, size_t size);
void to_lower(char* str);
int is_number(const char* str);
void trim(char* str);

// Buffer for function outputs
char output_buffer[MAX_INPUT];

// Function list
const char* function_names[NUM_FUNCTIONS] = {
    "greet", "add", "subtract", "multiply", "divide", 
    "exponent", "square_root", "quit", "help"
};

const char* function_descriptions[NUM_FUNCTIONS] = {
    "Greet the user",
    "Add two numbers",
    "Subtract two numbers",
    "Multiply two numbers",
    "Divide two numbers",
    "Raise a number to a power",
    "Calculate the square root of a number",
    "Quit the program",
    "Display this help message"
};

int main() {
    char command_buffer[MAX_INPUT];
    char a_buffer[MAX_INPUT];
    char b_buffer[MAX_INPUT];
    double a, b;
    int running = 1;
    
    // Print header
    printf("%s\nDeveloper: %s\nCoDeveloper: %s\nVersion: %s\n", 
           Name, Dev, CoDev, Version);
    
    while (running) {
        // Get command
        read_input("What do you want to do? ", command_buffer, MAX_INPUT);
        to_lower(command_buffer);
        trim(command_buffer);  // Trim whitespace from input
        
        // Handle basic commands
        if (strcmp(command_buffer, "quit") == 0) {
            printf("Goodbye!\n");
            running = 0;
            continue;
        } else if (strcmp(command_buffer, "help") == 0) {
            display_help();
            continue;
        } else if (strcmp(command_buffer, "greet") == 0) {
            greet();
            continue;
        }
        
        // Get first number
        read_input("Enter first number: ", a_buffer, MAX_INPUT);
        trim(a_buffer);  // Trim whitespace
        if (!is_number(a_buffer)) {
            printf("Please enter valid numbers\n");
            continue;
        }
        a = atof(a_buffer);
        
        // Handle square root (single parameter)
        if (strcmp(command_buffer, "square_root") == 0) {
            printf("%s\n", square_root(a));
            continue;
        }
        
        // Get second number
        read_input("Enter second number: ", b_buffer, MAX_INPUT);
        trim(b_buffer);  // Trim whitespace
        if (strlen(b_buffer) == 0) {
            printf("Second number is required for this operation\n");
            continue;
        }
        if (!is_number(b_buffer)) {
            printf("Please enter valid numbers\n");
            continue;
        }
        b = atof(b_buffer);
        
        // Execute the appropriate operation        
        if (strcmp(command_buffer, "add") == 0) {
            printf("%s\n", add(a, b));
        } else if (strcmp(command_buffer, "subtract") == 0) {
            printf("%s\n", subtract(a, b));
        } else if (strcmp(command_buffer, "multiply") == 0) {
            printf("%s\n", multiply(a, b));
        } else if (strcmp(command_buffer, "divide") == 0) {
            printf("%s\n", divide(a, b));
        } else if (strcmp(command_buffer, "exponent") == 0) {
            printf("%s\n", exponent(a, b));
        } else {
            printf("Invalid command, type 'help' for available commands\n");
        }
    }
    
    return 0;
}

// Helper function to trim whitespace from a string
void trim(char* str) {
    if (!str) return;
    
    // Trim leading spaces
    char* start = str;
    while (isspace((unsigned char)*start)) start++;
    
    if (start != str) {
        memmove(str, start, strlen(start) + 1);
    }
    
    // Trim trailing spaces
    char* end = str + strlen(str) - 1;
    while (end > str && isspace((unsigned char)*end)) end--;
    *(end + 1) = '\0';
}

// Helper function to read input - now takes a buffer to write to
char* read_input(const char* prompt, char* buffer, size_t size) {
    printf("%s", prompt);
    fflush(stdout);
    
    if (fgets(buffer, size, stdin) != NULL) {
        // Remove newline if present
        size_t len = strlen(buffer);
        if (len > 0 && buffer[len-1] == '\n') {
            buffer[len-1] = '\0';
        }
    } else {
        // Handle EOF or error
        buffer[0] = '\0';
    }
    
    return buffer;
}

// Convert string to lowercase
void to_lower(char* str) {
    for (int i = 0; str[i]; i++) {
        str[i] = tolower((unsigned char)str[i]);
    }
}

// Check if string is a valid number
int is_number(const char* str) {
    if (str == NULL || *str == '\0') {
        return 0;
    }
    
    char* endptr;
    strtod(str, &endptr);
    
    // If endptr points to the end of the string, the entire string was a valid number
    return *endptr == '\0';
}

// Display help menu
void display_help(void) {
    printf("\nAvailable commands:\n");
    for (int i = 0; i < NUM_FUNCTIONS; i++) {
        // Pad function name to 12 characters
        printf("%-12s- %s\n", function_names[i], function_descriptions[i]);
    }
    printf("\n");
}

// Calculator Functions
void greet(void) {
    printf("Hello World!\n");
}

char* add(double a, double b) {
    sprintf(output_buffer, "%.6g + %.6g = %.6g", a, b, a + b);
    return output_buffer;
}

char* subtract(double a, double b) {
    sprintf(output_buffer, "%.6g - %.6g = %.6g", a, b, a - b);
    return output_buffer;
}

char* multiply(double a, double b) {
    sprintf(output_buffer, "%.6g * %.6g = %.6g", a, b, a * b);
    return output_buffer;
}

char* divide(double a, double b) {
    if (b == 0) {
        return "Error: Division by zero";
    }
    sprintf(output_buffer, "%.6g / %.6g = %.6g", a, b, a / b);
    return output_buffer;
}

char* exponent(double a, double b) {
    sprintf(output_buffer, "%.6g ** %.6g = %.6g", a, b, pow(a, b));
    return output_buffer;
}

char* square_root(double a) {
    sprintf(output_buffer, "√%.6g = %.6g", a, sqrt(a));
    return output_buffer;
}
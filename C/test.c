// test.c - translated from test.java

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <ctype.h>

// Constants
#define NAME "Hello World Testing"
#define DEV "D4LM"
#define VERSION "1.0"
#define MAX_INPUT 100
#define MAX_FUNCTIONS 9

// Function descriptions structure
typedef struct {
    char command[20];
    char description[50];
} Function;

// Global variables
Function functions[MAX_FUNCTIONS];
int functionCount = 0;

// Function prototypes
void initFunctions();
void greet();
char* add(double a, double b);
char* subtract(double a, double b);
char* multiply(double a, double b);
char* divide(double a, double b);
char* exponent(double a, double b);
double squareRoot(double a);
void displayHelp();
char* question(const char* query, char* buffer, size_t size);
int compareStrings(const void* a, const void* b);
void toLowerCase(char* str);

// Functions
void initFunctions() {
    strcpy(functions[0].command, "greet");
    strcpy(functions[0].description, "Greet the user");
    
    strcpy(functions[1].command, "add");
    strcpy(functions[1].description, "Add two numbers");
    
    strcpy(functions[2].command, "subtract");
    strcpy(functions[2].description, "Subtract two numbers");
    
    strcpy(functions[3].command, "multiply");
    strcpy(functions[3].description, "Multiply two numbers");
    
    strcpy(functions[4].command, "divide");
    strcpy(functions[4].description, "Divide two numbers");
    
    strcpy(functions[5].command, "exponent");
    strcpy(functions[5].description, "Raise a number to a power");
    
    strcpy(functions[6].command, "square_root");
    strcpy(functions[6].description, "Calculate the square root of a number");
    
    strcpy(functions[7].command, "quit");
    strcpy(functions[7].description, "Quit the program");
    
    strcpy(functions[8].command, "help");
    strcpy(functions[8].description, "Display this help message");
    
    functionCount = 9;
}

void greet() {
    printf("Hello World\n");
}

char* add(double a, double b) {
    static char result[100];
    sprintf(result, "%.2f + %.2f = %.2f", a, b, (a + b));
    return result;
}

char* subtract(double a, double b) {
    static char result[100];
    sprintf(result, "%.2f - %.2f = %.2f", a, b, (a - b));
    return result;
}

char* multiply(double a, double b) {
    static char result[100];
    sprintf(result, "%.2f * %.2f = %.2f", a, b, (a * b));
    return result;
}

char* divide(double a, double b) {
    static char result[100];
    sprintf(result, "%.2f / %.2f = %.2f", a, b, (a / b));
    return result;
}

char* exponent(double a, double b) {
    static char result[100];
    sprintf(result, "%.2f ^ %.2f = %.2f", a, b, pow(a, b));
    return result;
}

double squareRoot(double a) {
    return sqrt(a);
}

void displayHelp() {
    printf("\nAvailable commands:\n");
    
    // Create a sorted copy of functions for consistent display
    Function sortedFunctions[MAX_FUNCTIONS];
    memcpy(sortedFunctions, functions, sizeof(functions));
    qsort(sortedFunctions, functionCount, sizeof(Function), compareStrings);
    
    for (int i = 0; i < functionCount; i++) {
        // Calculate padding for alignment
        int padding = 12 - strlen(sortedFunctions[i].command);
        printf("%s", sortedFunctions[i].command);
        for (int j = 0; j < padding; j++) {
            printf(" ");
        }
        printf("- %s\n", sortedFunctions[i].description);
    }
    printf("\n");
}

// Helper function to get user input
char* question(const char* query, char* buffer, size_t size) {
    printf("%s", query);
    fgets(buffer, size, stdin);
    
    // Remove trailing newline
    size_t len = strlen(buffer);
    if (len > 0 && buffer[len-1] == '\n') {
        buffer[len-1] = '\0';
    }
    
    return buffer;
}

// Compare function for qsort
int compareStrings(const void* a, const void* b) {
    Function* fa = (Function*)a;
    Function* fb = (Function*)b;
    return strcmp(fa->command, fb->command);
}

// Convert string to lowercase
void toLowerCase(char* str) {
    for (int i = 0; str[i]; i++) {
        str[i] = tolower(str[i]);
    }
}

int main() {
    char input[MAX_INPUT];
    char numberInput[MAX_INPUT];
    double a, b;
    
    // Initialize functions
    initFunctions();
    
    printf("%s\nDeveloper: %s\nVersion: %s\n", NAME, DEV, VERSION);
    
    while (1) {
        question("What do you want to do? ", input, sizeof(input));
        toLowerCase(input);
        
        if (strcmp(input, "greet") == 0) {
            greet();
        }
        else if (strcmp(input, "add") == 0) {
            question("Enter first number: ", numberInput, sizeof(numberInput));
            a = atof(numberInput);
            
            question("Enter second number: ", numberInput, sizeof(numberInput));
            b = atof(numberInput);
            
            printf("%s\n", add(a, b));
        }
        else if (strcmp(input, "subtract") == 0) {
            question("Enter first number: ", numberInput, sizeof(numberInput));
            a = atof(numberInput);
            
            question("Enter second number: ", numberInput, sizeof(numberInput));
            b = atof(numberInput);
            
            printf("%s\n", subtract(a, b));
        }
        else if (strcmp(input, "multiply") == 0) {
            question("Enter first number: ", numberInput, sizeof(numberInput));
            a = atof(numberInput);
            
            question("Enter second number: ", numberInput, sizeof(numberInput));
            b = atof(numberInput);
            
            printf("%s\n", multiply(a, b));
        }
        else if (strcmp(input, "divide") == 0) {
            question("Enter first number: ", numberInput, sizeof(numberInput));
            a = atof(numberInput);
            
            question("Enter second number: ", numberInput, sizeof(numberInput));
            b = atof(numberInput);
            
            printf("%s\n", divide(a, b));
        }
        else if (strcmp(input, "exponent") == 0) {
            question("Enter base: ", numberInput, sizeof(numberInput));
            a = atof(numberInput);
            
            question("Enter exponent: ", numberInput, sizeof(numberInput));
            b = atof(numberInput);
            
            printf("%s\n", exponent(a, b));
        }
        else if (strcmp(input, "square_root") == 0) {
            question("Enter number: ", numberInput, sizeof(numberInput));
            a = atof(numberInput);
            
            printf("Square root of %.2f = %.4f\n", a, squareRoot(a));
        }
        else if (strcmp(input, "quit") == 0) {
            printf("Goodbye!\n");
            return 0;
        }
        else if (strcmp(input, "help") == 0) {
            displayHelp();
        }
        else {
            printf("Invalid command, check help\n");
        }
    }
    
    return 0;
}
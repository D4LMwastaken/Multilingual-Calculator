#include <iostream>
#include <string>
#include <map>
#include <functional>
#include <cmath>
#include <algorithm>
#include <sstream>
#include <iomanip>

// Constants
const std::string Name = "Multilingual Calculator";
const std::string Dev = "D4LM";
const std::string CoDev = "AidanB446";
const std::string Version = "1.1";

// Function prototypes
void greet();
std::string add(double a, double b);
std::string subtract(double a, double b);
std::string multiply(double a, double b);
std::string divide(double a, double b);
std::string exponent(double a, double b);
std::string square_root(double a);
std::string read_input(const std::string& prompt);
bool is_number(const std::string& s);
std::string pad_right(const std::string& str, int width);
std::string format_number(double num);

int main() {
    // Function descriptions
    std::map<std::string, std::string> Functions = {
        {"greet", "Greet the user"},
        {"add", "Add two numbers"},
        {"subtract", "Subtract two numbers"},
        {"multiply", "Multiply two numbers"},
        {"divide", "Divide two numbers"},
        {"exponent", "Raise a number to a power"},
        {"square_root", "Calculate the square root of a number"},
        {"quit", "Quit the program"},
        {"help", "Display this help message"}
    };

    // Function handlers for binary operations
    std::map<std::string, std::function<std::string(double, double)>> handler = {
        {"add", add},
        {"subtract", subtract},
        {"divide", divide},
        {"multiply", multiply},
        {"exponent", exponent}
    };

    std::cout << Name << "\nDeveloper: " << Dev << "\nCoDeveloper: " << CoDev << "\nVersion: " << Version << std::endl;

    while (true) {
        std::string answer = read_input("What do you want to do? ");
        std::transform(answer.begin(), answer.end(), answer.begin(),
                      [](unsigned char c){ return std::tolower(c); });

        if (answer == "quit") {
            std::cout << "Goodbye!" << std::endl;
            break;
        } else if (answer == "help") {
            std::cout << "\nAvailable commands:" << std::endl;
            for (const auto& pair : Functions) {
                std::cout << pad_right(pair.first, 12) << "- " << pair.second << std::endl;
            }
            std::cout << std::endl;
            continue;
        } else if (answer == "greet") {
            greet();
            continue;
        }

        // Get first number
        std::string a_str = read_input("Enter first number: ");
        if (!is_number(a_str)) {
            std::cout << "Please enter valid numbers" << std::endl;
            continue;
        }
        double a = std::stod(a_str);

        // Handle square root (single argument operation)
        if (answer == "square_root") {
            std::cout << square_root(a) << std::endl;
            continue;
        }

        // Get second number
        std::string b_str = read_input("Enter second number: ");
        if (b_str.empty()) {
            std::cout << "Second number is required for this operation" << std::endl;
            continue;
        }

        if (!is_number(b_str)) {
            std::cout << "Please enter valid numbers" << std::endl;
            continue;
        }
        double b = std::stod(b_str);

        // Execute the operation
        if (handler.find(answer) != handler.end()) {
            std::cout << handler[answer](a, b) << std::endl;
        } else {
            std::cout << "Invalid command, type 'help' for available commands" << std::endl;
        }
    }

    return 0;
}

// Helper function to format numbers nicely
std::string format_number(double num) {
    std::ostringstream ss;
    ss << std::fixed << std::setprecision(6) << num;
    std::string numStr = ss.str();
    
    // Remove trailing zeros
    size_t pos = numStr.find_last_not_of('0');
    if (pos != std::string::npos && numStr[pos] == '.') {
        numStr.erase(pos);
    } else if (pos != std::string::npos) {
        numStr.erase(pos + 1);
    }
    
    // Remove trailing dot
    if (numStr.back() == '.') {
        numStr.pop_back();
    }
    
    return numStr;
}

// Helper function to read input
std::string read_input(const std::string& prompt) {
    std::string input;
    std::cout << prompt;
    std::getline(std::cin, input);
    return input;
}

// Helper function to check if a string is a valid number
bool is_number(const std::string& s) {
    std::string trimmed = s;
    trimmed.erase(0, trimmed.find_first_not_of(" \t\n\r\f\v"));
    trimmed.erase(trimmed.find_last_not_of(" \t\n\r\f\v") + 1);
    
    if (trimmed.empty()) return false;
    
    char* end = nullptr;
    std::strtod(trimmed.c_str(), &end);
    return end != trimmed.c_str() && *end == '\0';
}

// Helper function to pad strings
std::string pad_right(const std::string& str, int width) {
    if (str.length() >= width) {
        return str;
    }
    return str + std::string(width - str.length(), ' ');
}

// Calculator functions
void greet() {
    std::cout << "Hello World!" << std::endl;
}

std::string add(double a, double b) {
    return format_number(a) + " + " + format_number(b) + " = " + format_number(a + b);
}

std::string subtract(double a, double b) {
    return format_number(a) + " - " + format_number(b) + " = " + format_number(a - b);
}

std::string multiply(double a, double b) {
    return format_number(a) + " * " + format_number(b) + " = " + format_number(a * b);
}

std::string divide(double a, double b) {
    if (b == 0) {
        return "Error: Division by zero";
    }
    return format_number(a) + " / " + format_number(b) + " = " + format_number(a / b);
}

std::string exponent(double a, double b) {
    return format_number(a) + " ** " + format_number(b) + " = " + format_number(pow(a, b));
}

std::string square_root(double a) {
    return "√" + format_number(a) + " = " + format_number(sqrt(a));
}
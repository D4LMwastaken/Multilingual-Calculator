// test.cpp - translated from test.c which was originally from test.java

#include <iostream>
#include <string>
#include <map>
#include <cmath>
#include <algorithm>
#include <iomanip>
#include <sstream>

// Constants
const std::string NAME = "Hello World Testing";
const std::string DEV = "D4LM";
const std::string VERSION = "1.0";

// Class definition
class Calculator {
private:
    // Map to store functions and their descriptions
    std::map<std::string, std::string> functions;

public:
    // Constructor
    Calculator() {
        // Initialize function descriptions
        functions["greet"] = "Greet the user";
        functions["add"] = "Add two numbers";
        functions["subtract"] = "Subtract two numbers";
        functions["multiply"] = "Multiply two numbers";
        functions["divide"] = "Divide two numbers";
        functions["exponent"] = "Raise a number to a power";
        functions["square_root"] = "Calculate the square root of a number";
        functions["quit"] = "Quit the program";
        functions["help"] = "Display this help message";
    }

    // Functions
    void greet() {
        std::cout << "Hello World" << std::endl;
    }

    std::string add(double a, double b) {
        std::ostringstream result;
        result << std::fixed << std::setprecision(2) << a << " + " << b << " = " << (a + b);
        return result.str();
    }

    std::string subtract(double a, double b) {
        std::ostringstream result;
        result << std::fixed << std::setprecision(2) << a << " - " << b << " = " << (a - b);
        return result.str();
    }

    std::string multiply(double a, double b) {
        std::ostringstream result;
        result << std::fixed << std::setprecision(2) << a << " * " << b << " = " << (a * b);
        return result.str();
    }

    std::string divide(double a, double b) {
        std::ostringstream result;
        result << std::fixed << std::setprecision(2) << a << " / " << b << " = " << (a / b);
        return result.str();
    }

    std::string exponent(double a, double b) {
        std::ostringstream result;
        result << std::fixed << std::setprecision(2) << a << " ^ " << b << " = " << pow(a, b);
        return result.str();
    }

    double squareRoot(double a) {
        return sqrt(a);
    }

    void displayHelp() {
        std::cout << "\nAvailable commands:" << std::endl;
        
        // Use the natural order of map for sorting
        for (const auto& func : functions) {
            // Calculate padding for alignment
            int padding = 12 - func.first.length();
            std::cout << func.first;
            for (int i = 0; i < padding; i++) {
                std::cout << " ";
            }
            std::cout << "- " << func.second << std::endl;
        }
        std::cout << std::endl;
    }

    // Helper function to get user input
    std::string question(const std::string& query) {
        std::string input;
        std::cout << query;
        std::getline(std::cin, input);
        return input;
    }

    // Main loop
    void run() {
        std::cout << NAME << "\nDeveloper: " << DEV << "\nVersion: " << VERSION << std::endl;
        
        while (true) {
            std::string input = question("What do you want to do? ");
            // Convert to lowercase
            std::transform(input.begin(), input.end(), input.begin(), 
                           [](unsigned char c){ return std::tolower(c); });
            
            if (input == "greet") {
                greet();
            }
            else if (input == "add") {
                double a = std::stod(question("Enter first number: "));
                double b = std::stod(question("Enter second number: "));
                std::cout << add(a, b) << std::endl;
            }
            else if (input == "subtract") {
                double a = std::stod(question("Enter first number: "));
                double b = std::stod(question("Enter second number: "));
                std::cout << subtract(a, b) << std::endl;
            }
            else if (input == "multiply") {
                double a = std::stod(question("Enter first number: "));
                double b = std::stod(question("Enter second number: "));
                std::cout << multiply(a, b) << std::endl;
            }
            else if (input == "divide") {
                double a = std::stod(question("Enter first number: "));
                double b = std::stod(question("Enter second number: "));
                std::cout << divide(a, b) << std::endl;
            }
            else if (input == "exponent") {
                double a = std::stod(question("Enter base: "));
                double b = std::stod(question("Enter exponent: "));
                std::cout << exponent(a, b) << std::endl;
            }
            else if (input == "square_root") {
                double a = std::stod(question("Enter number: "));
                std::cout << "Square root of " << std::fixed << std::setprecision(2) << a 
                          << " = " << std::setprecision(4) << squareRoot(a) << std::endl;
            }
            else if (input == "quit") {
                std::cout << "Goodbye!" << std::endl;
                return;
            }
            else if (input == "help") {
                displayHelp();
            }
            else {
                std::cout << "Invalid command, check help" << std::endl;
            }
        }
    }
};

int main() {
    // Create calculator object and run it
    Calculator calc;
    
    try {
        calc.run();
    } catch (const std::exception& e) {
        std::cerr << "Error: " << e.what() << std::endl;
        return 1;
    }
    
    return 0;
}
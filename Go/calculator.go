package main

import (
	"fmt"
	"math"
	"strconv"
	"strings"
)

// Variables
var Name = "Multilingual Calculator"
var Dev = "D4LM"
var CoDev = "AidanB446"
var Version = "1.1"

// Function list
var Functions = map[string]string{
	"greet":       "Greet the user",
	"add":         "Add two numbers",
	"subtract":    "Subtract two numbers",
	"multiply":    "Multiply two numbers",
	"divide":      "Divide two numbers",
	"exponent":    "Raise a number to a power",
	"square_root": "Calculate the square root of a number",
	"quit":        "Quit the program",
	"help":        "Display this help message",
}

// Functions
func greet() {
	fmt.Println("Hello World!")
}

func add(a, b float64) string {
	return fmt.Sprintf("%g + %g = %g", a, b, a+b)
}

func subtract(a, b float64) string {
	return fmt.Sprintf("%g - %g = %g", a, b, a-b)
}

func multiply(a, b float64) string {
	return fmt.Sprintf("%g * %g = %g", a, b, a*b)
}

func divide(a, b float64) string {
	if b == 0 {
		return "Error: Division by zero"
	}
	return fmt.Sprintf("%g / %g = %g", a, b, a/b)
}

func exponent(a, b float64) string {
	return fmt.Sprintf("%g ** %g = %g", a, b, math.Pow(a, b))
}

func squareRoot(a float64) string {
	return fmt.Sprintf("√%g = %g", a, math.Sqrt(a))
}

// Helper function to read input
func readInput(prompt string) string {
	var input string
	fmt.Print(prompt)
	fmt.Scanln(&input)
	return input
}

// Helper function to pad strings
func padRight(s string, width int) string {
	if len(s) >= width {
		return s
	}
	return s + strings.Repeat(" ", width-len(s))
}

func main() {
	fmt.Printf("%s\nDeveloper: %s\nCoDeveloper: %s\nVersion: %s\n", 
		Name, Dev, CoDev, Version)

	// Define a handler type for binary operations
	type binOpFunc func(float64, float64) string
	
	// Map of command names to handler functions
	handler := map[string]binOpFunc{
		"add":      add,
		"subtract": subtract,
		"divide":   divide,
		"multiply": multiply,
		"exponent": exponent,
	}

	for {
		answer := strings.ToLower(readInput("What do you want to do? "))

		if answer == "quit" {
			break
		} else if answer == "help" {
			fmt.Println("\nAvailable commands:")
			for cmd, desc := range Functions {
				fmt.Printf("%s- %s\n", padRight(cmd, 12), desc)
			}
			fmt.Println()
			continue
		} else if answer == "greet" {
			greet()
			continue
		}

		// Get first number
		aStr := readInput("Enter first number: ")
		a, err := strconv.ParseFloat(aStr, 64)
		if err != nil {
			fmt.Println("Please enter valid numbers")
			continue
		}

		// Handle square root (single argument operation)
		if answer == "square_root" {
			fmt.Println(squareRoot(a))
			continue
		}

		// Get second number
		bStr := readInput("Enter second number: ")
		if bStr == "" {
			fmt.Println("Second number is required for this operation")
			continue
		}

		b, err := strconv.ParseFloat(bStr, 64)
		if err != nil {
			fmt.Println("Please enter valid numbers")
			continue
		}

		// Execute the appropriate operation if it exists
		if op, exists := handler[answer]; exists {
			fmt.Println(op(a, b))
		} else {
			fmt.Println("Invalid command, type 'help' for available commands")
		}
	}

	fmt.Println("Goodbye!")
}

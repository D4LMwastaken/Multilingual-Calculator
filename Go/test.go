// Hello World/Go/calculator.go
// Translated from C# which was originally from C++ which was originally from Java

package main

import (
	"bufio"
	"fmt"
	"math"
	"os"
	"sort"
	"strings"
	"strconv"
)

// Constants
const (
	NAME    = "Hello World Testing"
	DEV     = "D4LM"
	VERSION = "1.0"
)

// Calculator struct definition
type Calculator struct {
	// Map to store functions and their descriptions
	functions map[string]string
}

// Constructor
func NewCalculator() *Calculator {
	c := &Calculator{
		// Initialize function descriptions
		functions: map[string]string{
			"greet":       "Greet the user",
			"add":         "Add two numbers",
			"subtract":    "Subtract two numbers",
			"multiply":    "Multiply two numbers",
			"divide":      "Divide two numbers",
			"exponent":    "Raise a number to a power",
			"square_root": "Calculate the square root of a number",
			"quit":        "Quit the program",
			"help":        "Display this help message",
		},
	}
	return c
}

// Functions
func (c *Calculator) Greet() {
	fmt.Println("Hello World")
}

func (c *Calculator) Add(a, b float64) string {
	return fmt.Sprintf("%.2f + %.2f = %.2f", a, b, a+b)
}

func (c *Calculator) Subtract(a, b float64) string {
	return fmt.Sprintf("%.2f - %.2f = %.2f", a, b, a-b)
}

func (c *Calculator) Multiply(a, b float64) string {
	return fmt.Sprintf("%.2f * %.2f = %.2f", a, b, a*b)
}

func (c *Calculator) Divide(a, b float64) string {
	return fmt.Sprintf("%.2f / %.2f = %.2f", a, b, a/b)
}

func (c *Calculator) Exponent(a, b float64) string {
	return fmt.Sprintf("%.2f ^ %.2f = %.2f", a, b, math.Pow(a, b))
}

func (c *Calculator) SquareRoot(a float64) float64 {
	return math.Sqrt(a)
}

func (c *Calculator) DisplayHelp() {
	fmt.Println("\nAvailable commands:")

	// Get sorted keys
	var keys []string
	for k := range c.functions {
		keys = append(keys, k)
	}
	sort.Strings(keys)

	// Display commands in sorted order
	for _, key := range keys {
		// Calculate padding for alignment
		padding := 12 - len(key)
		fmt.Print(key)
		for i := 0; i < padding; i++ {
			fmt.Print(" ")
		}
		fmt.Printf("- %s\n", c.functions[key])
	}
	fmt.Println()
}

// Helper function to get user input
func (c *Calculator) Question(query string) string {
	reader := bufio.NewReader(os.Stdin)
	fmt.Print(query)
	input, _ := reader.ReadString('\n')
	// Trim newline characters for cross-platform compatibility
	return strings.TrimSpace(input)
}

// Helper function to parse float with error handling
func (c *Calculator) ParseFloat(input string) (float64, error) {
	return strconv.ParseFloat(input, 64)
}

// Main loop
func (c *Calculator) Run() {
	fmt.Printf("%s\nDeveloper: %s\nVersion: %s\n", NAME, DEV, VERSION)

	for {
		input := c.Question("What do you want to do? ")
		// Convert to lowercase
		input = strings.ToLower(input)

		switch input {
		case "greet":
			c.Greet()
		case "add":
			a, err1 := c.ParseFloat(c.Question("Enter first number: "))
			if err1 != nil {
				fmt.Println("Invalid number format.")
				continue
			}
			b, err2 := c.ParseFloat(c.Question("Enter second number: "))
			if err2 != nil {
				fmt.Println("Invalid number format.")
				continue
			}
			fmt.Println(c.Add(a, b))
		case "subtract":
			a, err1 := c.ParseFloat(c.Question("Enter first number: "))
			if err1 != nil {
				fmt.Println("Invalid number format.")
				continue
			}
			b, err2 := c.ParseFloat(c.Question("Enter second number: "))
			if err2 != nil {
				fmt.Println("Invalid number format.")
				continue
			}
			fmt.Println(c.Subtract(a, b))
		case "multiply":
			a, err1 := c.ParseFloat(c.Question("Enter first number: "))
			if err1 != nil {
				fmt.Println("Invalid number format.")
				continue
			}
			b, err2 := c.ParseFloat(c.Question("Enter second number: "))
			if err2 != nil {
				fmt.Println("Invalid number format.")
				continue
			}
			fmt.Println(c.Multiply(a, b))
		case "divide":
			a, err1 := c.ParseFloat(c.Question("Enter first number: "))
			if err1 != nil {
				fmt.Println("Invalid number format.")
				continue
			}
			b, err2 := c.ParseFloat(c.Question("Enter second number: "))
			if err2 != nil {
				fmt.Println("Invalid number format.")
				continue
			}
			if b == 0 {
				fmt.Println("Division by zero is not allowed.")
				continue
			}
			fmt.Println(c.Divide(a, b))
		case "exponent":
			a, err1 := c.ParseFloat(c.Question("Enter base: "))
			if err1 != nil {
				fmt.Println("Invalid number format.")
				continue
			}
			b, err2 := c.ParseFloat(c.Question("Enter exponent: "))
			if err2 != nil {
				fmt.Println("Invalid number format.")
				continue
			}
			fmt.Println(c.Exponent(a, b))
		case "square_root":
			a, err := c.ParseFloat(c.Question("Enter number: "))
			if err != nil {
				fmt.Println("Invalid number format.")
				continue
			}
			if a < 0 {
				fmt.Println("Cannot calculate square root of a negative number.")
				continue
			}
			fmt.Printf("Square root of %.2f = %.4f\n", a, c.SquareRoot(a))
		case "quit":
			fmt.Println("Goodbye!")
			return
		case "help":
			c.DisplayHelp()
		default:
			fmt.Println("Invalid command, check help")
		}
	}
}

func main() {
	// Create calculator object and run it
	calc := NewCalculator()

	defer func() {
		if r := recover(); r != nil {
			fmt.Fprintf(os.Stderr, "Error: %v\n", r)
			os.Exit(1)
		}
	}()

	calc.Run()
}

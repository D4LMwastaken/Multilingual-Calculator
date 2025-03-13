# Variables
Name = "Hello World Testing"
Dev = "D4LM"
Version = "1.0"

# Function list
Functions = {
    "greet": "Greet the user",
    "add": "Add two numbers",
    "subtract": "Subtract two numbers",
    "multiply": "Multiply two numbers",
    "divide": "Divide two numbers",
    "exponent": "Raise a number to a power",
    "square_root": "Calculate the square root of a number",
    "quit": "Quit the program",
    "help": "Display this help message"
}

# Functions
def greet():
    print("Hello World")
    
def add(a, b):
    return f"{a} + {b} = {a + b}"
    
def subtract(a, b):
    return f"{a} - {b} = {a - b}"
    
def multiply(a, b):
    return f"{a} * {b} = {a * b}"
    
def divide(a, b):
    if b == 0:
        return "Error: Division by zero"
    return f"{a} / {b} = {a / b}"
    
def exponent(a, b):
    return f"{a} ** {b} = {a ** b}"
    
def square_root(a):
    return f"√{a} = {a ** 0.5}"

def main():
    print(Name + "\nDeveloper: " + Dev + "\nVersion: " + Version)

    handler = {
        "add": add,
        "subtract": subtract,
        "divide": divide,
        "multiply": multiply,
        "exponent": exponent,
        "square_root": square_root,  # Fixed key name to match Functions dictionary
    } 

    while True:
        answer = input("What do you want to do? ").lower()
        
        if answer == "quit":
            break
        elif answer == "help":
            print("\nAvailable commands:")
            for cmd, desc in Functions.items():
                print(f"{cmd:<12}- {desc}")
            print()
            continue
        elif answer == "greet":
            greet()
            continue
            
        try:
            a = int(input("Enter first number: "))
            
            if answer == "square_root":
                print(square_root(a))
                continue
                
            b = input("Enter second number: ")
            if not b:
                print("Second number is required for this operation")
                continue
                
            b = int(b)
            
            if answer in handler:
                print(handler[answer](a, b))
            else:
                print("Invalid command, type 'help' for available commands")
                
        except ValueError:
            print("Please enter valid numbers")
        
main()
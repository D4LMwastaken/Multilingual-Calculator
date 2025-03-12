
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
    return f"{a} / {b} = {a / b}"
    
def exponent(a, b):
    return f"{a} ** {b} = {a ** b}"
    
def square_root(a, b):
    return a ** 0.5

def main():
    print(Name + "\nDeveloper: " + Dev + "\nVersion: " + Version)

    handler = {
        "add": add,
        "subtract": subtract,
        "divide": divide,
        "multiply": multiply,
        "exponent": exponent,
        "square root": square_root, 
        } 

    while True:
        answer = input("What do you want to do? ").lower()
        a = int(input("Enter first number: "))
        b = input("Enter second number (If Applicable, else leave empty): ")
        
        if not b == "" :
            b = int(b) 

        if answer == "greet":
            greet()
        elif answer == "quit":
            break
        elif answer == "help":
            print("\nAvailable commands:")
            for cmd, desc in Functions.items():
                print(f"{cmd:<12}- {desc}")
            print()
        
        if answer in handler :
            print(handler[answer](a, b))

        else:
            print("Invalid command, check help")
    
main()

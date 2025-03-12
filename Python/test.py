
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
    
def square_root(a):
    return a ** 0.5



def main():
    print(Name + "\nDeveloper: " + Dev + "\nVersion: " + Version)
    while True:
        answer = input("What do you want to do? ").lower()
        if answer == "greet":
            greet()
        elif answer == "add":
            a = int(input("Enter first number: "))
            b = int(input("Enter second number: "))
            print(add(a, b))
        elif answer == "subtract":
            a = int(input("Enter first number: "))
            b = int(input("Enter second number: "))
            print(subtract(a, b))
        elif answer == "multiply":
            a = int(input("Enter first number: "))
            b = int(input("Enter second number: "))
            print(multiply(a, b))
        elif answer == "divide":
            a = int(input("Enter first number: "))
            b = int(input("Enter second number: "))
            print(divide(a, b))
        elif answer == "exponent":
            a = int(input("Enter base: "))
            b = int(input("Enter exponent: "))
            print(exponent(a, b))
        elif answer == "square_root":
            a = int(input("Enter number: "))
            print(square_root(a))
        elif answer == "quit":
            break
        elif answer == "help":
            print("\nAvailable commands:")
            for cmd, desc in Functions.items():
                print(f"{cmd:<12}- {desc}")
            print()
        else:
            print("Invalid command, check help")
    
main()

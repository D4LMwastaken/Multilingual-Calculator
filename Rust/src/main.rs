use std::collections::HashMap;
use std::io::{self, Write};

// Define structs to hold our function types
type BinaryOperation = fn(f64, f64) -> String;
type UnaryOperation = fn(f64) -> String;

fn main() {
    // Variables
    let name = "Multilingual Calculator";
    let dev = "D4LM";
    let co_dev = "AidanB446";
    let version = "1.1";

    // Create function descriptions
    let mut functions = HashMap::new();
    functions.insert("greet", "Greet the user");
    functions.insert("add", "Add two numbers");
    functions.insert("subtract", "Subtract two numbers");
    functions.insert("multiply", "Multiply two numbers");
    functions.insert("divide", "Divide two numbers");
    functions.insert("exponent", "Raise a number to a power");
    functions.insert("square_root", "Calculate the square root of a number");
    functions.insert("quit", "Quit the program");
    functions.insert("help", "Display this help message");

    // Create operation handlers
    let mut binary_handlers: HashMap<String, BinaryOperation> = HashMap::new();
    binary_handlers.insert(String::from("add"), add);
    binary_handlers.insert(String::from("subtract"), subtract);
    binary_handlers.insert(String::from("divide"), divide);
    binary_handlers.insert(String::from("multiply"), multiply);
    binary_handlers.insert(String::from("exponent"), exponent);

    let mut unary_handlers: HashMap<String, UnaryOperation> = HashMap::new();
    unary_handlers.insert(String::from("square_root"), square_root);

    println!("{}\nDeveloper: {}\nCoDeveloper: {}\nVersion: {}", 
             name, dev, co_dev, version);

    loop {
        let answer = read_input("What do you want to do? ").to_lowercase();

        if answer == "quit" {
            println!("Goodbye!");
            break;
        } else if answer == "help" {
            println!("\nAvailable commands:");
            for (cmd, desc) in &functions {
                println!("{:<12}- {}", cmd, desc);
            }
            println!();
            continue;
        } else if answer == "greet" {
            greet();
            continue;
        }

        // Get first number
        let a: f64 = match read_input("Enter first number: ").parse() {
            Ok(num) => num,
            Err(_) => {
                println!("Please enter valid numbers");
                continue;
            }
        };

        // Handle unary operations
        if answer == "square_root" {
            if let Some(handler) = unary_handlers.get(&answer) {
                println!("{}", handler(a));
            }
            continue;
        }

        // Handle binary operations
        let b_str = read_input("Enter second number: ");
        if b_str.is_empty() {
            println!("Second number is required for this operation");
            continue;
        }

        let b: f64 = match b_str.parse() {
            Ok(num) => num,
            Err(_) => {
                println!("Please enter valid numbers");
                continue;
            }
        };

        if let Some(handler) = binary_handlers.get(&answer) {
            println!("{}", handler(a, b));
        } else {
            println!("Invalid command, type 'help' for available commands");
        }
    }
}

// Helper function to read input
fn read_input(prompt: &str) -> String {
    print!("{}", prompt);
    io::stdout().flush().unwrap(); // Ensure the prompt is displayed before reading input
    let mut input = String::new();
    io::stdin().read_line(&mut input).expect("Failed to read input");
    input.trim().to_string()
}

// Calculator Functions
fn greet() {
    println!("Hello World!");
}

fn add(a: f64, b: f64) -> String {
    format!("{} + {} = {}", a, b, a + b)
}

fn subtract(a: f64, b: f64) -> String {
    format!("{} - {} = {}", a, b, a - b)
}

fn multiply(a: f64, b: f64) -> String {
    format!("{} * {} = {}", a, b, a * b)
}

fn divide(a: f64, b: f64) -> String {
    if b == 0.0 {
        String::from("Error: Division by zero")
    } else {
        format!("{} / {} = {}", a, b, a / b)
    }
}

fn exponent(a: f64, b: f64) -> String {
    format!("{} ** {} = {}", a, b, a.powf(b))
}

fn square_root(a: f64) -> String {
    format!("√{} = {}", a, a.sqrt())
}

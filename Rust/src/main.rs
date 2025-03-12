// test.rs - translated from test.cpp

use std::collections::HashMap;
use std::io::{self, Write};
use std::process;

// Constants
const NAME: &str = "Hello World Testing";
const DEV: &str = "D4LM";
const VERSION: &str = "1.0";

// Calculator struct definition
struct Calculator {
    // Map to store functions and their descriptions
    functions: HashMap<String, String>,
}

impl Calculator {
    // Constructor
    fn new() -> Self {
        let mut functions = HashMap::new();
        
        // Initialize function descriptions
        functions.insert("greet".to_string(), "Greet the user".to_string());
        functions.insert("add".to_string(), "Add two numbers".to_string());
        functions.insert("subtract".to_string(), "Subtract two numbers".to_string());
        functions.insert("multiply".to_string(), "Multiply two numbers".to_string());
        functions.insert("divide".to_string(), "Divide two numbers".to_string());
        functions.insert("exponent".to_string(), "Raise a number to a power".to_string());
        functions.insert("square_root".to_string(), "Calculate the square root of a number".to_string());
        functions.insert("quit".to_string(), "Quit the program".to_string());
        functions.insert("help".to_string(), "Display this help message".to_string());
        
        Calculator { functions }
    }

    // Functions
    fn greet(&self) {
        println!("Hello World");
    }

    fn add(&self, a: f64, b: f64) -> String {
        format!("{:.2} + {:.2} = {:.2}", a, b, a + b)
    }

    fn subtract(&self, a: f64, b: f64) -> String {
        format!("{:.2} - {:.2} = {:.2}", a, b, a - b)
    }

    fn multiply(&self, a: f64, b: f64) -> String {
        format!("{:.2} * {:.2} = {:.2}", a, b, a * b)
    }

    fn divide(&self, a: f64, b: f64) -> String {
        format!("{:.2} / {:.2} = {:.2}", a, b, a / b)
    }

    fn exponent(&self, a: f64, b: f64) -> String {
        format!("{:.2} ^ {:.2} = {:.2}", a, b, a.powf(b))
    }

    fn square_root(&self, a: f64) -> f64 {
        a.sqrt()
    }

    fn display_help(&self) {
        println!("\nAvailable commands:");
        
        // Create a sorted list of commands for display
        let mut commands: Vec<(&String, &String)> = self.functions.iter().collect();
        commands.sort_by(|a, b| a.0.cmp(b.0));
        
        for (command, description) in commands {
            // Calculate padding for alignment
            let padding = 12 - command.len();
            let padding_spaces = " ".repeat(padding);
            println!("{}{}- {}", command, padding_spaces, description);
        }
        println!();
    }

    // Helper function to get user input
    fn question(&self, query: &str) -> String {
        print!("{}", query);
        io::stdout().flush().unwrap();
        
        let mut input = String::new();
        io::stdin().read_line(&mut input).expect("Failed to read input");
        input.trim().to_string()
    }

    // Parse string to f64 with error handling
    fn parse_number(&self, input: &str) -> Result<f64, String> {
        match input.parse::<f64>() {
            Ok(num) => Ok(num),
            Err(_) => Err(format!("Could not parse '{}' as a number", input))
        }
    }

    // Main loop
    fn run(&self) {
        println!("{}\nDeveloper: {}\nVersion: {}", NAME, DEV, VERSION);
        
        loop {
            let input = self.question("What do you want to do? ").to_lowercase();
            
            match input.as_str() {
                "greet" => self.greet(),
                
                "add" => {
                    match self.get_two_numbers() {
                        Ok((a, b)) => println!("{}", self.add(a, b)),
                        Err(e) => println!("Error: {}", e)
                    }
                },
                
                "subtract" => {
                    match self.get_two_numbers() {
                        Ok((a, b)) => println!("{}", self.subtract(a, b)),
                        Err(e) => println!("Error: {}", e)
                    }
                },
                
                "multiply" => {
                    match self.get_two_numbers() {
                        Ok((a, b)) => println!("{}", self.multiply(a, b)),
                        Err(e) => println!("Error: {}", e)
                    }
                },
                
                "divide" => {
                    match self.get_two_numbers() {
                        Ok((a, b)) => {
                            if b == 0.0 {
                                println!("Error: Cannot divide by zero");
                            } else {
                                println!("{}", self.divide(a, b));
                            }
                        },
                        Err(e) => println!("Error: {}", e)
                    }
                },
                
                "exponent" => {
                    let base_str = self.question("Enter base: ");
                    let exp_str = self.question("Enter exponent: ");
                    
                    match (self.parse_number(&base_str), self.parse_number(&exp_str)) {
                        (Ok(a), Ok(b)) => println!("{}", self.exponent(a, b)),
                        (Err(e), _) | (_, Err(e)) => println!("Error: {}", e)
                    }
                },
                
                "square_root" => {
                    let num_str = self.question("Enter number: ");
                    
                    match self.parse_number(&num_str) {
                        Ok(a) => {
                            if a < 0.0 {
                                println!("Error: Cannot calculate square root of negative number");
                            } else {
                                println!("Square root of {:.2} = {:.4}", a, self.square_root(a));
                            }
                        },
                        Err(e) => println!("Error: {}", e)
                    }
                },
                
                "quit" => {
                    println!("Goodbye!");
                    return;
                },
                
                "help" => self.display_help(),
                
                _ => println!("Invalid command, check help")
            }
        }
    }
    
    // Helper to get two numbers for operations
    fn get_two_numbers(&self) -> Result<(f64, f64), String> {
        let first_str = self.question("Enter first number: ");
        let second_str = self.question("Enter second number: ");
        
        let a = self.parse_number(&first_str)?;
        let b = self.parse_number(&second_str)?;
        
        Ok((a, b))
    }
}

fn main() {
    // Create calculator object and run it
    let calc = Calculator::new();
    
    match std::panic::catch_unwind(|| {
        calc.run();
    }) {
        Ok(_) => {},
        Err(_) => {
            eprintln!("An unexpected error occurred");
            process::exit(1);
        }
    }
}
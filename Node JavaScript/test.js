// Hello World/test.js

// Variables
const Name = "Hello World Testing";
const Dev = "D4LM";
const Version = "1.0";

// Function list with descriptions
const Functions = {
    greet: "Greet the user",
    add: "Add two numbers",
    subtract: "Subtract two numbers",
    multiply: "Multiply two numbers",
    divide: "Divide two numbers",
    exponent: "Raise a number to a power",
    square_root: "Calculate the square root of a number",
    quit: "Quit the program",
    help: "Display this help message"
};

// Import readline module for user input
const readline = require('readline');
const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

// Functions
function greet() {
    console.log("Hello World");
}

function add(a, b) {
    return `${a} + ${b} = ${a + b}`;
}

function subtract(a, b) {
    return `${a} - ${b} = ${a - b}`;
}

function multiply(a, b) {
    return `${a} * ${b} = ${a * b}`;
}

function divide(a, b) {
    return `${a} / ${b} = ${(a / b).toFixed(2)}`;
}

function exponent(a, b) {
    return `${a} ^ ${b} = ${Math.pow(a, b).toFixed(2)}`;
}

function square_root(a) {
    return Math.pow(a, 0.5);
}

// Helper function to get user input with a promise
function question(query) {
    return new Promise((resolve) => {
        rl.question(query, resolve);
    });
}

// Main function
async function main() {
    console.log(`${Name}\nDeveloper: ${Dev}\nVersion: ${Version}`);

    while (true) {
        const answer = (await question("What do you want to do? ")).toLowerCase();

        if (answer === "greet") {
            greet();
        } else if (answer === "add") {
            const a = parseFloat(await question("Enter first number: "));
            const b = parseFloat(await question("Enter second number: "));
            console.log(add(a, b));
        } else if (answer === "subtract") {
            const a = parseFloat(await question("Enter first number: "));
            const b = parseFloat(await question("Enter second number: "));
            console.log(subtract(a, b));
        } else if (answer === "multiply") {
            const a = parseFloat(await question("Enter first number: "));
            const b = parseFloat(await question("Enter second number: "));
            console.log(multiply(a, b));
        } else if (answer === "divide") {
            const a = parseFloat(await question("Enter first number: "));
            const b = parseFloat(await question("Enter second number: "));
            console.log(divide(a, b));
        } else if (answer === "exponent") {
            const a = parseFloat(await question("Enter base: "));
            const b = parseFloat(await question("Enter exponent: "));
            console.log(exponent(a, b));
        } else if (answer === "square_root") {
            const a = parseFloat(await question("Enter number: "));
            console.log(`Square root of ${a} = ${square_root(a).toFixed(4)}`);
        } else if (answer === "quit") {
            rl.close();
            break;
        } else if (answer === "help") {
            console.log("\nAvailable commands:");
            // Create a sorted list of keys for consistent display order
            const keys = Object.keys(Functions).sort();
            
            for (const cmd of keys) {
                // Format to align descriptions
                const padding = " ".repeat(12 - cmd.length);
                console.log(`${cmd}${padding}- ${Functions[cmd]}`);
            }
            console.log("");
        } else {
            console.log("Invalid command, check help");
        }
    }
}

// Execute main function
main().catch(err => {
    console.error("An error occurred:", err);
    rl.close();
});

// Handle process exit
rl.on('close', () => {
    console.log("Goodbye!");
    process.exit(0);
});
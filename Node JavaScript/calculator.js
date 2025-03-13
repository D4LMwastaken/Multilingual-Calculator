// Variables
const Name = "Mutlilingual Calculator";
const Dev = "D4LM";
const CoDev = "AidanB446";
const Version = "1.1";

// Function list
const Functions = {
    "greet": "Greet the user",
    "add": "Add two numbers",
    "subtract": "Subtract two numbers",
    "multiply": "Multiply two numbers",
    "divide": "Divide two numbers",
    "exponent": "Raise a number to a power",
    "square_root": "Calculate the square root of a number",
    "quit": "Quit the program",
    "help": "Display this help message"
};

// Functions
function greet() {
    console.log("Hello World!");
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
    if (b === 0) {
        return "Error: Division by zero";
    }
    return `${a} / ${b} = ${a / b}`;
}

function exponent(a, b) {
    return `${a} ** ${b} = ${Math.pow(a, b)}`;
}

function squareRoot(a) {
    return `√${a} = ${Math.sqrt(a)}`;
}

// Node.js input handling
const readline = require('readline');
const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

function main() {
    console.log(`${Name}\nDeveloper: ${Dev}\nCoDeveloper: ${CoDev}\nVersion: ${Version}`);

    const handler = {
        "add": add,
        "subtract": subtract,
        "divide": divide,
        "multiply": multiply,
        "exponent": exponent,
        "square_root": squareRoot,
    };

    function askCommand() {
        rl.question("What do you want to do? ", (answer) => {
            answer = answer.toLowerCase();

            if (answer === "quit") {
                rl.close();
                return;
            } else if (answer === "help") {
                console.log("\nAvailable commands:");
                for (const [cmd, desc] of Object.entries(Functions)) {
                    console.log(`${cmd.padEnd(12)}- ${desc}`);
                }
                console.log();
                askCommand();
                return;
            } else if (answer === "greet") {
                greet();
                askCommand();
                return;
            }

            rl.question("Enter first number: ", (firstInput) => {
                const a = Number(firstInput);

                if (isNaN(a)) {
                    console.log("Please enter valid numbers");
                    askCommand();
                    return;
                }

                if (answer === "square_root") {
                    console.log(squareRoot(a));
                    askCommand();
                    return;
                }

                rl.question("Enter second number: ", (secondInput) => {
                    if (!secondInput) {
                        console.log("Second number is required for this operation");
                        askCommand();
                        return;
                    }

                    const b = Number(secondInput);

                    if (isNaN(b)) {
                        console.log("Please enter valid numbers");
                        askCommand();
                        return;
                    }

                    if (answer in handler) {
                        console.log(handler[answer](a, b));
                    } else {
                        console.log("Invalid command, type 'help' for available commands");
                    }
                    
                    askCommand();
                });
            });
        });
    }

    askCommand();
}

main();
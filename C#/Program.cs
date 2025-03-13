// No namespace or class declaration needed for top-level statements

// Variables
string Name = "Multilingual Calculator";
string Dev = "D4LM";
string CoDev = "AidanB446";
string Version = "1.1";

// Function list
var Functions = new Dictionary<string, string>
{
    {"greet", "Greet the user"},
    {"add", "Add two numbers"},
    {"subtract", "Subtract two numbers"},
    {"multiply", "Multiply two numbers"},
    {"divide", "Divide two numbers"},
    {"exponent", "Raise a number to a power"},
    {"square_root", "Calculate the square root of a number"},
    {"quit", "Quit the program"},
    {"help", "Display this help message"}
};

// Main program
Console.WriteLine($"{Name}\nDeveloper: {Dev}\nCoDeveloper: {CoDev}\nVersion: {Version}");

// Create dictionary of operations
var handlers = new Dictionary<string, Func<double, double, string>>
{
    {"add", (a, b) => $"{a} + {b} = {a + b}"},
    {"subtract", (a, b) => $"{a} - {b} = {a - b}"},
    {"multiply", (a, b) => $"{a} * {b} = {a * b}"},
    {"divide", (a, b) => b == 0 ? "Error: Division by zero" : $"{a} / {b} = {a / b}"},
    {"exponent", (a, b) => $"{a} ** {b} = {Math.Pow(a, b)}"}
};

var unaryHandlers = new Dictionary<string, Func<double, string>>
{
    {"square_root", a => $"√{a} = {Math.Sqrt(a)}"}
};

bool running = true;
while (running)
{
    Console.Write("What do you want to do? ");
    string answer = (Console.ReadLine() ?? "").ToLower();

    if (answer == "quit")
    {
        running = false;
        Console.WriteLine("Goodbye!");
        continue;
    }
    else if (answer == "help")
    {
        Console.WriteLine("\nAvailable commands:");
        foreach (var pair in Functions)
        {
            Console.WriteLine($"{pair.Key.PadRight(12)}- {pair.Value}");
        }
        Console.WriteLine();
        continue;
    }
    else if (answer == "greet")
    {
        Console.WriteLine("Hello World!");
        continue;
    }

    try
    {
        Console.Write("Enter first number: ");
        string aInput = Console.ReadLine() ?? "";
        if (!double.TryParse(aInput, out double a))
        {
            Console.WriteLine("Please enter valid numbers");
            continue;
        }

        if (answer == "square_root")
        {
            if (unaryHandlers.TryGetValue(answer, out var handler))
            {
                Console.WriteLine(handler(a));
            }
            continue;
        }

        Console.Write("Enter second number: ");
        string bInput = Console.ReadLine() ?? "";
        
        if (string.IsNullOrEmpty(bInput))
        {
            Console.WriteLine("Second number is required for this operation");
            continue;
        }

        if (!double.TryParse(bInput, out double b))
        {
            Console.WriteLine("Please enter valid numbers");
            continue;
        }

        if (handlers.TryGetValue(answer, out var operation))
        {
            Console.WriteLine(operation(a, b));
        }
        else
        {
            Console.WriteLine("Invalid command, type 'help' for available commands");
        }
    }
    catch (Exception ex)
    {
        Console.WriteLine($"An error occurred: {ex.Message}");
    }
}
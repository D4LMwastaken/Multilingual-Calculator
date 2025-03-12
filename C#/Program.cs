// Hello World/C#/test.cs
// Translated from test.cpp which was originally from test.java

using System;
using System.Collections.Generic;
using System.Linq;
using System.Globalization;

namespace HelloWorldTesting
{
    // Class definition
    public class Calculator
    {
        // Constants
        private const string NAME = "Hello World Testing";
        private const string DEV = "D4LM";
        private const string VERSION = "1.0";

        // Dictionary to store functions and their descriptions
        private Dictionary<string, string> functions;

        // Constructor
        public Calculator()
        {
            // Initialize function descriptions
            functions = new Dictionary<string, string>
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
        }

        // Functions
        public void Greet()
        {
            Console.WriteLine("Hello World");
        }

        public string Add(double a, double b)
        {
            return $"{a:F2} + {b:F2} = {(a + b):F2}";
        }

        public string Subtract(double a, double b)
        {
            return $"{a:F2} - {b:F2} = {(a - b):F2}";
        }

        public string Multiply(double a, double b)
        {
            return $"{a:F2} * {b:F2} = {(a * b):F2}";
        }

        public string Divide(double a, double b)
        {
            return $"{a:F2} / {b:F2} = {(a / b):F2}";
        }

        public string Exponent(double a, double b)
        {
            return $"{a:F2} ^ {b:F2} = {Math.Pow(a, b):F2}";
        }

        public double SquareRoot(double a)
        {
            return Math.Sqrt(a);
        }

        public void DisplayHelp()
        {
            Console.WriteLine("\nAvailable commands:");
            
            // Sort the functions by name
            foreach (var func in functions.OrderBy(f => f.Key))
            {
                // Calculate padding for alignment
                int padding = 12 - func.Key.Length;
                Console.Write(func.Key);
                for (int i = 0; i < padding; i++)
                {
                    Console.Write(" ");
                }
                Console.WriteLine("- " + func.Value);
            }
            Console.WriteLine();
        }

        // Helper function to get user input
        private string Question(string query)
        {
            Console.Write(query);
            return Console.ReadLine();
        }

        // Main loop
        public void Run()
        {
            Console.WriteLine($"{NAME}\nDeveloper: {DEV}\nVersion: {VERSION}");
            
            while (true)
            {
                string input = Question("What do you want to do? ");
                // Convert to lowercase
                input = input.ToLower();
                
                switch (input)
                {
                    case "greet":
                        Greet();
                        break;
                    case "add":
                        try
                        {
                            double a = Convert.ToDouble(Question("Enter first number: "), CultureInfo.InvariantCulture);
                            double b = Convert.ToDouble(Question("Enter second number: "), CultureInfo.InvariantCulture);
                            Console.WriteLine(Add(a, b));
                        }
                        catch (FormatException)
                        {
                            Console.WriteLine("Invalid number format.");
                        }
                        break;
                    case "subtract":
                        try
                        {
                            double a = Convert.ToDouble(Question("Enter first number: "), CultureInfo.InvariantCulture);
                            double b = Convert.ToDouble(Question("Enter second number: "), CultureInfo.InvariantCulture);
                            Console.WriteLine(Subtract(a, b));
                        }
                        catch (FormatException)
                        {
                            Console.WriteLine("Invalid number format.");
                        }
                        break;
                    case "multiply":
                        try
                        {
                            double a = Convert.ToDouble(Question("Enter first number: "), CultureInfo.InvariantCulture);
                            double b = Convert.ToDouble(Question("Enter second number: "), CultureInfo.InvariantCulture);
                            Console.WriteLine(Multiply(a, b));
                        }
                        catch (FormatException)
                        {
                            Console.WriteLine("Invalid number format.");
                        }
                        break;
                    case "divide":
                        try
                        {
                            double a = Convert.ToDouble(Question("Enter first number: "), CultureInfo.InvariantCulture);
                            double b = Convert.ToDouble(Question("Enter second number: "), CultureInfo.InvariantCulture);
                            Console.WriteLine(Divide(a, b));
                        }
                        catch (FormatException)
                        {
                            Console.WriteLine("Invalid number format.");
                        }
                        break;
                    case "exponent":
                        try
                        {
                            double a = Convert.ToDouble(Question("Enter base: "), CultureInfo.InvariantCulture);
                            double b = Convert.ToDouble(Question("Enter exponent: "), CultureInfo.InvariantCulture);
                            Console.WriteLine(Exponent(a, b));
                        }
                        catch (FormatException)
                        {
                            Console.WriteLine("Invalid number format.");
                        }
                        break;
                    case "square_root":
                        try
                        {
                            double a = Convert.ToDouble(Question("Enter number: "), CultureInfo.InvariantCulture);
                            Console.WriteLine($"Square root of {a:F2} = {SquareRoot(a):F4}");
                        }
                        catch (FormatException)
                        {
                            Console.WriteLine("Invalid number format.");
                        }
                        break;
                    case "quit":
                        Console.WriteLine("Goodbye!");
                        return;
                    case "help":
                        DisplayHelp();
                        break;
                    default:
                        Console.WriteLine("Invalid command, check help");
                        break;
                }
            }
        }
    }

    class Program
    {
        static void Main(string[] args)
        {
            // Create calculator object and run it
            Calculator calc = new Calculator();
            
            try
            {
                calc.Run();
            }
            catch (Exception e)
            {
                Console.Error.WriteLine($"Error: {e.Message}");
                Environment.Exit(1);
            }
        }
    }
}
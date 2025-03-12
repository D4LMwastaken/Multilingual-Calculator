// HelloWorld/test.java

import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;
import java.util.TreeMap;

class test {
    // Variables
    private static final String NAME = "Hello World Testing";
    private static final String DEV = "D4LM";
    private static final String VERSION = "1.0";

    // Function list with descriptions
    private static final Map<String, String> FUNCTIONS = new HashMap<>();
    static {
        FUNCTIONS.put("greet", "Greet the user");
        FUNCTIONS.put("add", "Add two numbers");
        FUNCTIONS.put("subtract", "Subtract two numbers");
        FUNCTIONS.put("multiply", "Multiply two numbers");
        FUNCTIONS.put("divide", "Divide two numbers");
        FUNCTIONS.put("exponent", "Raise a number to a power");
        FUNCTIONS.put("square_root", "Calculate the square root of a number");
        FUNCTIONS.put("quit", "Quit the program");
        FUNCTIONS.put("help", "Display this help message");
    }

    private static Scanner scanner = new Scanner(System.in);

    // Functions
    private static void greet() {
        System.out.println("Hello World");
    }

    private static String add(double a, double b) {
        return a + " + " + b + " = " + (a + b);
    }

    private static String subtract(double a, double b) {
        return a + " - " + b + " = " + (a - b);
    }

    private static String multiply(double a, double b) {
        return a + " * " + b + " = " + (a * b);
    }

    private static String divide(double a, double b) {
        return String.format("%s / %s = %.2f", a, b, (a / b));
    }

    private static String exponent(double a, double b) {
        return String.format("%s ^ %s = %.2f", a, b, Math.pow(a, b));
    }

    private static double squareRoot(double a) {
        return Math.pow(a, 0.5);
    }

    // Helper function to get user input
    private static String question(String query) {
        System.out.print(query);
        return scanner.nextLine();
    }

    // Main function
    public static void main(String[] args) {
        System.out.printf("%s\nDeveloper: %s\nVersion: %s\n", NAME, DEV, VERSION);

        while (true) {
            String answer = question("What do you want to do? ").toLowerCase();

            switch (answer) {
                case "greet":
                    greet();
                    break;
                case "add":
                    double addA = Double.parseDouble(question("Enter first number: "));
                    double addB = Double.parseDouble(question("Enter second number: "));
                    System.out.println(add(addA, addB));
                    break;
                case "subtract":
                    double subA = Double.parseDouble(question("Enter first number: "));
                    double subB = Double.parseDouble(question("Enter second number: "));
                    System.out.println(subtract(subA, subB));
                    break;
                case "multiply":
                    double mulA = Double.parseDouble(question("Enter first number: "));
                    double mulB = Double.parseDouble(question("Enter second number: "));
                    System.out.println(multiply(mulA, mulB));
                    break;
                case "divide":
                    double divA = Double.parseDouble(question("Enter first number: "));
                    double divB = Double.parseDouble(question("Enter second number: "));
                    System.out.println(divide(divA, divB));
                    break;
                case "exponent":
                    double expA = Double.parseDouble(question("Enter base: "));
                    double expB = Double.parseDouble(question("Enter exponent: "));
                    System.out.println(exponent(expA, expB));
                    break;
                case "square_root":
                    double sqrtA = Double.parseDouble(question("Enter number: "));
                    System.out.printf("Square root of %s = %.4f\n", sqrtA, squareRoot(sqrtA));
                    break;
                case "quit":
                    scanner.close();
                    System.out.println("Goodbye!");
                    return;
                case "help":
                    System.out.println("\nAvailable commands:");
                    // Create a sorted map for consistent display order
                    Map<String, String> sortedFunctions = new TreeMap<>(FUNCTIONS);
                    
                    for (Map.Entry<String, String> entry : sortedFunctions.entrySet()) {
                        String cmd = entry.getKey();
                        // Format to align descriptions
                        String padding = " ".repeat(12 - cmd.length());
                        System.out.printf("%s%s- %s\n", cmd, padding, entry.getValue());
                    }
                    System.out.println();
                    break;
                default:
                    System.out.println("Invalid command, check help");
                    break;
            }
        }
    }
}
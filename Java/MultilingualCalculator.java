import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;

public class MultilingualCalculator {
    // Variables
    private static final String Name = "Multilingual Calculator";
    private static final String Dev = "D4LM";
    private static final String CoDev = "AidanB446";
    private static final String Version = "1.1";

    // Function list
    private static final Map<String, String> Functions = new HashMap<String, String>() {{
        put("greet", "Greet the user");
        put("add", "Add two numbers");
        put("subtract", "Subtract two numbers");
        put("multiply", "Multiply two numbers");
        put("divide", "Divide two numbers");
        put("exponent", "Raise a number to a power");
        put("square_root", "Calculate the square root of a number");
        put("quit", "Quit the program");
        put("help", "Display this help message");
    }};

    // Interface for calculator operations
    private interface CalculatorOperation {
        String execute(double a, double b);
    }

    // Interface for single parameter operations
    private interface SingleParamOperation {
        String execute(double a);
    }

    public static void main(String[] args) {
        System.out.println(Name + "\nDeveloper: " + Dev + "\nCoDeveloper: " + CoDev + "\nVersion: " + Version);

        // Function handlers
        Map<String, CalculatorOperation> handler = new HashMap<>();
        handler.put("add", MultilingualCalculator::add);
        handler.put("subtract", MultilingualCalculator::subtract);
        handler.put("divide", MultilingualCalculator::divide);
        handler.put("multiply", MultilingualCalculator::multiply);
        handler.put("exponent", MultilingualCalculator::exponent);

        // Single param operations
        Map<String, SingleParamOperation> singleParamHandler = new HashMap<>();
        singleParamHandler.put("square_root", MultilingualCalculator::squareRoot);

        Scanner scanner = new Scanner(System.in);
        boolean running = true;

        while (running) {
            System.out.print("What do you want to do? ");
            String answer = scanner.nextLine().toLowerCase();

            if (answer.equals("quit")) {
                running = false;
                continue;
            } else if (answer.equals("help")) {
                System.out.println("\nAvailable commands:");
                for (Map.Entry<String, String> entry : Functions.entrySet()) {
                    System.out.println(padRight(entry.getKey(), 12) + "- " + entry.getValue());
                }
                System.out.println();
                continue;
            } else if (answer.equals("greet")) {
                greet();
                continue;
            }

            try {
                System.out.print("Enter first number: ");
                String firstInput = scanner.nextLine();
                double a;
                
                try {
                    a = Double.parseDouble(firstInput);
                } catch (NumberFormatException e) {
                    System.out.println("Please enter valid numbers");
                    continue;
                }

                if (answer.equals("square_root")) {
                    System.out.println(squareRoot(a));
                    continue;
                }

                System.out.print("Enter second number: ");
                String secondInput = scanner.nextLine();
                
                if (secondInput.isEmpty()) {
                    System.out.println("Second number is required for this operation");
                    continue;
                }
                
                double b;
                try {
                    b = Double.parseDouble(secondInput);
                } catch (NumberFormatException e) {
                    System.out.println("Please enter valid numbers");
                    continue;
                }

                if (handler.containsKey(answer)) {
                    System.out.println(handler.get(answer).execute(a, b));
                } else {
                    System.out.println("Invalid command, type 'help' for available commands");
                }
                
            } catch (Exception e) {
                System.out.println("An error occurred: " + e.getMessage());
            }
        }
        
        scanner.close();
        System.out.println("Goodbye!");
    }

    // Helper function to pad strings
    private static String padRight(String s, int n) {
        return String.format("%-" + n + "s", s);
    }

    // Calculator Functions
    private static void greet() {
        System.out.println("Hello World!");
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
        if (b == 0) {
            return "Error: Division by zero";
        }
        return a + " / " + b + " = " + (a / b);
    }

    private static String exponent(double a, double b) {
        return a + " ^ " + b + " = " + Math.pow(a, b);
    }

    private static String squareRoot(double a) {
        return "√" + a + " = " + Math.sqrt(a);
    }
}
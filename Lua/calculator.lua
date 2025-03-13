-- Variables
local Name = "Mutlilingual Calculator"
local Dev = "D4LM"
local CoDev = "AidanB446"
local Version = "1.1"

-- Function list
local Functions = {
    ["greet"] = "Greet the user",
    ["add"] = "Add two numbers",
    ["subtract"] = "Subtract two numbers",
    ["multiply"] = "Multiply two numbers",
    ["divide"] = "Divide two numbers",
    ["exponent"] = "Raise a number to a power",
    ["square_root"] = "Calculate the square root of a number",
    ["quit"] = "Quit the program",
    ["help"] = "Display this help message"
}

-- Functions
local function greet()
    print("Hello World!")
end

local function add(a, b)
    return string.format("%s + %s = %s", a, b, a + b)
end

local function subtract(a, b)
    return string.format("%s - %s = %s", a, b, a - b)
end

local function multiply(a, b)
    return string.format("%s * %s = %s", a, b, a * b)
end

local function divide(a, b)
    if b == 0 then
        return "Error: Division by zero"
    end
    return string.format("%s / %s = %s", a, b, a / b)
end

local function exponent(a, b)
    return string.format("%s ^ %s = %s", a, b, a ^ b)
end

local function squareRoot(a)
    return string.format("√%s = %s", a, math.sqrt(a))
end

-- String padding helper function (since Lua doesn't have string.padEnd)
local function padEnd(str, length)
    if string.len(str) >= length then
        return str
    end
    return str .. string.rep(" ", length - string.len(str))
end

-- Main function
local function main()
    print(string.format("%s\nDeveloper: %s\nCoDeveloper: %s\nVersion: %s", 
          Name, Dev, CoDev, Version))

    local handler = {
        ["add"] = add,
        ["subtract"] = subtract,
        ["divide"] = divide,
        ["multiply"] = multiply,
        ["exponent"] = exponent,
        ["square_root"] = squareRoot,
    }

    local function askCommand()
        io.write("What do you want to do? ")
        local answer = string.lower(io.read())

        if answer == "quit" then
            return -- Exit the recursive function
        elseif answer == "help" then
            print("\nAvailable commands:")
            for cmd, desc in pairs(Functions) do
                print(padEnd(cmd, 12) .. "- " .. desc)
            end
            print("")
            return askCommand() -- Recursive call
        elseif answer == "greet" then
            greet()
            return askCommand() -- Recursive call
        end

        io.write("Enter first number: ")
        local firstInput = io.read()
        local a = tonumber(firstInput)

        if a == nil then
            print("Please enter valid numbers")
            return askCommand() -- Recursive call
        end

        if answer == "square_root" then
            print(squareRoot(a))
            return askCommand() -- Recursive call
        end

        io.write("Enter second number: ")
        local secondInput = io.read()
        
        if secondInput == "" then
            print("Second number is required for this operation")
            return askCommand() -- Recursive call
        end

        local b = tonumber(secondInput)

        if b == nil then
            print("Please enter valid numbers")
            return askCommand() -- Recursive call
        end

        if handler[answer] then
            print(handler[answer](a, b))
        else
            print("Invalid command, type 'help' for available commands")
        end
        
        return askCommand() -- Recursive call
    end

    askCommand()
end

main()
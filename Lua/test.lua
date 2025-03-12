-- Variables
Name = "Hello World Testing"
Dev = "D4LM"
Version = "1.0"

-- Function list with descriptions
Functions = {
    greet = "Greet the user",
    add = "Add two numbers",
    subtract = "Subtract two numbers",
    multiply = "Multiply two numbers",
    divide = "Divide two numbers",
    exponent = "Raise a number to a power",
    square_root = "Calculate the square root of a number",
    quit = "Quit the program",
    help = "Display this help message"
}

-- Functions
local function greet()
    print("Hello World")
end

local function add(a, b)
    return string.format("%d + %d = %d", a, b, a + b)
end

local function subtract(a, b)
    return string.format("%d - %d = %d", a, b, a - b)
end

local function multiply(a, b)
    return string.format("%d * %d = %d", a, b, a * b)
end

local function divide(a, b)
    return string.format("%d / %d = %.2f", a, b, a / b)
end

local function exponent(a, b)
    return string.format("%d ^ %d = %.2f", a, b, a ^ b)
end

local function square_root(a)
    return a ^ 0.5
end

local function main()
    print(Name .. "\nDeveloper: " .. Dev .. "\nVersion: " .. Version)

    while true do
        io.write("What do you want to do? ")
        local answer = string.lower(io.read())

        if answer == "greet" then
            greet()
        elseif answer == "add" then
            io.write("Enter first number: ")
            local a = tonumber(io.read())
            io.write("Enter second number: ")
            local b = tonumber(io.read())
            print(add(a, b))
        elseif answer == "subtract" then
            io.write("Enter first number: ")
            local a = tonumber(io.read())
            io.write("Enter second number: ")
            local b = tonumber(io.read())
            print(subtract(a, b))
        elseif answer == "multiply" then
            io.write("Enter first number: ")
            local a = tonumber(io.read())
            io.write("Enter second number: ")
            local b = tonumber(io.read())
            print(multiply(a, b))
        elseif answer == "divide" then
            io.write("Enter first number: ")
            local a = tonumber(io.read())
            io.write("Enter second number: ")
            local b = tonumber(io.read())
            print(divide(a, b))
        elseif answer == "exponent" then
            io.write("Enter base: ")
            local a = tonumber(io.read())
            io.write("Enter exponent: ")
            local b = tonumber(io.read())
            print(exponent(a, b))
        elseif answer == "square_root" then
            io.write("Enter number: ")
            local a = tonumber(io.read())
            print(string.format("Square root of %d = %.4f", a, square_root(a)))
        elseif answer == "quit" then
            break
        elseif answer == "help" then
            print("\nAvailable commands:")
            -- Create a sorted list of keys for consistent display order
            local keys = {}
            for k in pairs(Functions) do
                table.insert(keys, k)
            end
            table.sort(keys)

            for _, cmd in ipairs(keys) do
                -- Format to align descriptions (Lua doesn't have f-strings)
                local padding = string.rep(" ", 12 - string.len(cmd))
                print(cmd .. padding .. "- " .. Functions[cmd])
            end
            print("")
        else
            print("Invalid command, check help")
        end
    end
end

main()
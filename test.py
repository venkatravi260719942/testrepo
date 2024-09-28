# Basic Python Script

# Define a function to greet the user
def greet(name):
    print(f"Hello, {name}! Welcome to Python programming.")

# Define a function to add two numbers
def add_numbers(a, b):
    return a + b

# Main code execution
if __name__ == "__main__":
    # Variables
    name = "Alice"
    number1 = 5
    number2 = 10
    
    # Call the greet function
    greet(name)
    
    # Add two numbers and print the result
    result = add_numbers(number1, number2)
    print(f"The sum of {number1} and {number2} is: {result}")

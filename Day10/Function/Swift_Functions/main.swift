//
//  main.swift
//  Swift_Functions
//
//  Created by Leo_Lei on 5/19/17.
//  Copyright © 2017 LibertyLeo. All rights reserved.
//

import Foundation

//  MARK: Functions
/*
 Functions are self-contained chunks of code that perform a specific task.
 You give a function a name that identifies what it does, and this name is used
 to "call" the function to perform its task when needed.
 
 Prameters can provide default values to simplify function calls and can be 
 passed as in-out parameters, which modify a passed variable once the function
 has completed its execution.
 */



//  MARK: - Defining and Calling Functions
/*
 When you define a function, you can optionally define one or more named, typed
 values that the function takes as input, known as paraters.
 You can also optionally define a type of value that the function will pass back
 as output when it is done, known as its return type.
 Every function has a function name, which describes the task that the function
 performs.
 */
func greet(person: String) -> String {
    let greeting = "Hello, " + person + "!"
    return greeting
}
/*
 All of this information is rolled up into the function's definition, which is 
 prefixed with the 'func' keyword.
 You indivate the function's return type with the return arrow '->' (a hyphen
 followed by a right angle bracket), which is followed by the name of the type
 to return.
 */

/*
 The definition describes what the function does, what it expects to receive,
 and what it returns when it is done. The definition makes it easy for the 
 function to be called unambiguously from everywhere in your code.
 */
print(greet(person: "Anna"))
//  Prints "Hello, Anna!"
print(greet(person: "Brian"))
//  Prints "Hello, Brian!"

/*
 NOTE:
 The 'print(_:separator:terminator:)' function doesn't have a label for its first
 argument, and its other arguments are optional because they have a default value.
 */

/*
 To make the body of this function shorter, you can combine the message creation
 and the return statement into one line
 */
func greetAgain(person: String) -> String {
    return "Hello again, " + person + "!"
}
print(greetAgain(person: "Anna"))
//  Prints "Hello again, Anna!"



//  MARK: - Function Parameters and Return Values
//  MARK: Functions Without Parameters
//  Functions are not required to define input parameters.
func sayHelloWorld() -> String {
    return "hello world"
}
print(sayHelloWorld())
//  Prints "Hello World"
/*
 The function definition still need parentheses after the function's name, even 
 though it does not take any paramters.
*/

//  MARK: Function With multiple Parameters
/*
 Functions can have multips input parameters, which are written within the 
 function's parentheses, separated by commas.
 */
func greet(person: String, alreadyGreeted: Bool) -> String {
    if alreadyGreeted {
        return greetAgain(person: person)
    } else {
        return greet(person: person)
    }
}
print(greet(person: "Tim", alreadyGreeted: true))
// Prints "Hello again, Tim!"
/*
 Note that this function is distinct from the 'greet(person:)' function shown 
 above. Although both function have names that begin with 'greet', the
 'greet(person:alreadyGreeted:)' function takes two arguments but the 
 'greet(person:)' function takes only one.
 */



//  MARK: Functions Without Return Values
//  Functions are not required to define a return type.
func greetWithNoReturn(person: String) {
    print("Hello, \(person)!")
}
greetWithNoReturn(person: "Dave")
//  Prints "Hello, Dave!"
/*
 Because it does not need to return a value, the function's definition does not
 include the return arrow (->) or a return type.
 
 NOTE:
 Strictly speaking, this version of the 'greet(person:)' function does still 
 return a value, even through no return value is defined.
 Functions without a defined return type return a special value of type 'Void'.
 This is simply an empty tuple, which is written as ().
 */

//  The return value of a function can be ignored when it is called:
func printAndCount(string: String) -> Int {
    print(string)
    return string.characters.count
}
func printWithoutCounting(string: String) {
    let _ = printAndCount(string: string)
}
printAndCount(string: "hello, world")
//  Prints "hello, world" and return a value of 12
printWithoutCounting(string: "hello, world")
//  Prints "hello, world" but does not return a value.

/*
 NOTE:
 Return values can be ignored, but a function that says it will return a value 
 must always do so.
 A function with a defined return type cannot allow control to fall out of the 
 bottom of the function without returning a value, and attempting to do so will
 result in a compile-time error.
 */



//  MARK: Functions with Multiple Return Values
/*
 You can use a tuple type as the return type for a function to return multiple
 values as part of one compound return value.
 */
func minMax(array: [Int]) -> (min: Int, max: Int) {
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMin, currentMax)
}

/*
 Because the tuple's member values are named as part of the function's return
 type, they can be accessed with dot syntax to retrieve the minimum and maximum
 found values.
 */
let bounds = minMax(array: [8, -6, 2, 109, 3, 71])
print("min is \(bounds.min) and max is \(bounds.max)")
//  Print "min is -6 and max is 109"
/*
 Note that the tuple's members do not need to be named at the point that the
 tuple is returned from the function, because their names are already specified
 as part of the function's return type.
 */



//  MARK: Optional Tuple Return Types
/*
 If the tuple type to be returned from a function has the potential to have "no
 value" for the entire tuple, you can use an optional tuple return type to 
 reflect the fact that the entire tuple can be 'nil'.
 You write an optional tuple return type by placing a question mark after the
 tuple type's closing parenthesis, such as (Int, Int)? or (String, Int, Bool)?.
 
 NOTE:
 An optional tuple type such as (Int, Int)? is different from a tuple that 
 contains optional types such as (Int?, Int?). With an optional tuple type, the 
 entire tuple is optional, not just each individual value within the tuple.
 
 However, the function does not perform any safety checks on the array it is 
 passed. If the 'array' argument contains an empty array, the 'mixMax(array:)'
 function, as defined above, will trigger a runtime error when attempting to
 access 'array[0]'.
 */
func minMaxSafety(array: [Int]) -> (min: Int, max: Int)? {
    if array.isEmpty { return nil }
    var currentMin = array[0]
    var curretMax = array[0]
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        } else if value > curretMax {
            curretMax = value
        }
    }
    return (currentMin, curretMax)
}

/*
 You can use optional binding to check whether this version of 'minMax(array:)'
 function return an actual tuple value or 'nil'
 */
if let bounds = minMaxSafety(array: [8, -6, 2, 109, 3, 71]) {
    print("min is \(bounds.min) and max is \(bounds.max)")
}
//  Print "min is -6 and max is 109"



//  MARK: - Function Argument Labels and Parameter Names
/*
 Each function parameter has both an argument label and a parameter name.
 Each argument is written in the function call with its arguments label befor it.
 By default, paremeters use their parameter name as their argument label.
 */
func someFunction(firstParameterName: Int, secondParameterName: Int) {
    //  In the function body, firstParameterName and secondParameterName
    //  refer to the argument values for the first and second parameters
}
someFunction(firstParameterName: 1, secondParameterName: 2)
/*
 All parameters must have unique names.
 Although it's possible for multiple parameters to have the same argument label,
 unique argument labels help make your code more readable.
 */



//  MARK: Specifying Argument Labels
//  You write an argument label before the parameter name, separated by a space
func someFunction(argumentLabel parameterName: Int) {
    //  In the function body, parameterName refers to the argument value
    //  for that parameter
}

/*
 Here's a variation of the 'greet(person:)' function that takes a person's name
 and hometown and returns a greeting:
 */
func greet(person: String, from hometown: String) -> String {
    return "Hello \(person)! Glad you could visit from \(hometown)."
}
print(greet(person: "Bill", from: "Cupertino"))
//  Prints "Hello Bill! Glad you could visit from Cupertino."
/*
 The use of argument labels can allow a function to be called in an expressive,
 sentence-like manner, while still providing a function body that is readable
 and clear in intent.
 */



//  MARK: Omitting Argument Labels
/*
 If you don't want an argument label for a parameter, write an underscore (_)
 instead of an explict argument label for that parameter.
 */
func someFunction(_ firstParameterName: Int, secondParameterName: Int) {
    //  In the function body, firstParameterName and secondParameterName
    //  refer to the argument values for the first and second parameters.
}
someFunction(1, secondParameterName: 2)



//  MARK: Default Parameter Values
/*
 You can define a default value for any parameter in a function by assigning a
 value to the parameter after the parameter's type. If a default value is
 defined, you can omit that parameter when calling the function.
 */
func someFunction(parameterWithoutDefault: Int, parameterWithDefault: Int = 12) {
    //  If you omit the second argument when calling this function, then
    //  the value of parameterWithDefault is 12 inside the function body
}
someFunction(parameterWithoutDefault: 3, parameterWithDefault: 6)
//  parameterWithDefault is 6
someFunction(parameterWithoutDefault: 4)
//  parameterWithDefault is 12
/*
 Place parameters that don't have default values at the beginning of a 
 function's parameter list, before the parameters that have default values.
 Parameters that don't have default values are usually more important to the 
 function's meaning--writing them first makes it easier to recongnize that the
 same function is being called, regardless of whether any default parameters are 
 ommitted.
 */



//  MARK: Variadic Parameter
/*
 A variadic parameter accepts zero or more values of a specified type.
 You use a variadic parameter to specify that the parameter can be passed a 
 varying number of input values when the function is called.
 Write variadic parameters by inserting three period characters (...) after the
 paramter's type name.
 */
func arithmeticMean(_ numbers: Double...) -> Double {
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}
arithmeticMean(1, 2, 3, 4, 5)
//  returns 3.0, which is the arithmetic mean of these five numbers
arithmeticMean(3, 8.25, 18.75)
//  returns 10.0, which is the arithmetic mean of these three numbers
//  NOTE:   A function may have at most one variadic parameter.



//  MARK: In-Out parameters
/*
 Function parameters are constants by default.
 Trying to change the value of a function parameter from within the body of that
 function results in a compile-time error. This means that you can't change the
 value of a parameter by mistake.
 If you want a function to modify a parameter's value, and you want those 
 changes to persist after the function call has ended, define that parameter
 as an in-out parameter instead.
 
 You write an in-out parameter by placing the 'inout' keyword right before a 
 parameter's type. An in-out parameter has value that is passed in to the
 function, is modified by the function, and is passed back out of the function
 to replace the original value.
 You can only pass a variable as the argument for an in-out parameter.
 You place an ampersand (&) directly before a variable's name when you pass it
 as an argument to an in-out parameter, to indicate that it can be modified by 
 the function.
 
 NOTE:
 In-out parameters cannot have defaults values, and variadic parameters cannot
 be marked as inout.
 */
func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}

/*
 You can call the 'swapTwoInts(_:_:)' function with two variables of type 'Int'
 to swap their values. Note that the names of 'someInt' and 'anotherInt' are
 prefixed with an ampersand when they are passed to the 'swapTwoInts(_:_:)' 
 function
 */
var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)
print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")
//  someInt is now 107, and anotherInt is now 3
/*
 In-out parameters are not the same as returning a value from a function.
 The 'swapTwoInts' example above does not define a return type or return a value,
 but it still modifies the values of 'someInt' and 'anotherInt'.
 In-out parameters are an alternative way for a function to have an effect outside
 of the scope of its function body.
 */



//  MARK: - Function Types
/*
 Every function has a specific funtion type, made up of the parameter types and 
 the return type of the function.
 */
func addTwoInts(_ a: Int, _ b: Int) -> Int{
    return a + b
}
func multiplyTwoInts(_ a: Int, _ b: Int) -> Int {
    return a * b
}
/*
 The type of both of these function is '(Int, Int) -> (Int)'. This can be read as
    "A function that has two parameters, both of type 'Int', and that returns a
 value of type 'Int.'"
 */

//  Here's another example, for a function with no parameters or return value
func printHelloWorld() {
    print("hello, world")
}
/*
 The type of this function is '() -> Void', or "a function that has no paramters,
 and returns 'Void'".
 */



//  MARK: Using Function Types
/*
 You use function types just like any other types in Swift.
 For example, you can define a constant or variable to be of a function type and
 assign an appropriate function to that value
 */
var mathFunction: (Int, Int) -> Int = addTwoInts
/*
 This can be read as
 "Define a variable called 'mathFunction', which has a type of 'a function that
 takes two 'Int' values, and returns an 'Int' vlaue.' Set this new variable to
 refer to the function called 'addTwoInts."
 
 The 'addTwoInts(_:_:)' function has the same type as the 'mathFunction'
 variable, and so this assignment is allowed by Swift's type-checker.
 
 You can now call the assigned function with the name 'mathFunction':
 */
print("Result: \(mathFunction(2, 3))")
//  Prints "Result: 5"

/*
 A different function with the same matching type can be assigned to the same
 variable, in the same way as fou non-function types.
 */
mathFunction = multiplyTwoInts
print("Result: \(mathFunction(2, 3))")
//  Prints "Result: 6"

/*
 As with any other type, you can leave it to Swift to infer the function type
 when you assign a function to a constant or variable
 */
let anotherMathFunction = addTwoInts
//  anotherMathFunction is inferred to be of type (Int, Int) -> Int



//  MARK: Function Types as Parameter Types
/*
 You can use a function type such as '(Int, Int) -> Int' as a parameter type
 for another function. This enables you to leave some aspects of a function's
 implementation for the funciton's caller to provide when the function is called.
 */
func printMathResult(_ mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {
    print("Result: \(mathFunction(a, b))")
}
printMathResult(addTwoInts, 3, 5)
//  Prints "Result: 8"
/*
 The role of 'printMathResult(_:_:_:)' is to print the result of a call to a 
 math function of an appropriate type.
 It doesn't matters what that function's implementation actually does--it matters
 only that the function is of the correct type.
 This enables 'printMathResult(_:_:_:)' to hand off its functionality to the
 caller of the function in a type-safe way,
 */



//  MARK: Function Types as Return Types
//  You can use a function type as the return type of another function.
func stepForward(_ input: Int) -> Int {
    return input + 1
}
func stepBackward(_ input: Int) -> Int {
    return input - 1
}

func chooseStepFunction(backward: Bool) -> (Int) -> Int {
    return backward ? stepBackward : stepForward
}

/*
 You can now use 'chooseStepFunction(backward:)' to obtain a function that will
 step in one direction or the other
 */
var currentValue = 3
let moveNearerToZero = chooseStepFunction(backward: currentValue > 0)
//  moveNearerToZero now refers to the stepBackward() function

/*
 Now that 'moveNearerToZero' refers to the correct function, it can be used to 
 count to zero.
 */
print("Counting to zero")
//  Counting to zero"
while currentValue != 0 {
    print("\(currentValue)... ")
    currentValue = moveNearerToZero(currentValue)
}
print("zero!")
//  3...
//  2...
//  1...
//  zero!



//  MARK: Nested Function
/*
 You can define functions inside the bodies of other function, known as nested
 function.
 Nested functions are hidden from the outside world by default, but can still be 
 called and used by their enclosing function.
 */
func chooseStepFunctionNested(backward: Bool) -> (Int) -> Int {
    func stepForward(input: Int) -> Int { return input + 1 }
    func stepBackward(input: Int) -> Int { return input - 1 }
    return backward ? stepBackward : stepForward
}
var currentValueNested = -4
let moveNearerToZeroNested = chooseStepFunctionNested(backward: currentValueNested > 0)
/// moveNearerToZeroNested now refers to the nested stepForward() function
while currentValueNested != 0 {
    print("\(currentValueNested)... ")
    currentValueNested = moveNearerToZeroNested(currentValueNested)
}
print("zero!")
//  -4...
//  -3...
//  -2...
//  -1...
//  zero!

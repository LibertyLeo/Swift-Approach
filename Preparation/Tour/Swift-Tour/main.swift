//
//  main.swift
//  Swift-Tour
//
//  Created by Leo_Lei on 5/8/17.
//  Copyright © 2017 LibertyLeo. All rights reserved.
//

import Foundation

//  MARK: Simple Value and Print
/*
 Use let to make a constant and var to make a variable, the value must 
 assign exactly once.
 */
var myVariable = 42
myVariable = 50
let myContant = 42

//  Specify the type by writing it after the variable, sepated by a colon.
let implicitInteger = 70
let impllicitDouble = 70.0
let explicitDouble: Double = 70

//  Creating a constant with an explicit type of Float and a value of 4.   (Exp)
let explicitFloat: Float = 4
print("The explicit value is \(explicitFloat).")

/*
 If you need to convert a value to a different type, explicitly make an instance 
 of the desired type.
 */
let label = "The width is "
let width = 100
let widthLabel = label + String(width)

/*
 Try removing the conversion to String from the last line.
 What error do you get? (Exp)
 A: Binary operator + cannot be applied to different type.
 */

//  \() usage for combine.
let apples = 3
let oranges = 5
let appleSummary = "I have \(apples) apples."
let fruitSummary = "I have \(apples + oranges) pieces of fruits."
print(appleSummary)
print(fruitSummary)

/*
 Use \() to include a floating-point calculation in a string and to include
 someones name in a greeting.  (Exp)
 */
let heightA = 110.4
let heightB = 64.2
let name = "Leo"
let nameGreeting = "Hi, \(name)! Are you \(String(heightA + heightB)) centimeters tall?"
print(nameGreeting)



//  MARK: Array and Dictionary
/* 
 Create arrays and dictionaries using brackets([]).
 , is allowed after last element.
 */
var shoppingList = ["catfish", "water", "tulips", "blue paint"]
shoppingList[1] = "bottle of water"
print("Shopping List: \(shoppingList)")

var occupations = [
    "Malcolm": "Captain",
    "Kaylee": "Mechanic",
]
occupations["Jayne"] = "Public Relations"
print("Occupations: \(occupations)")

//  Use the initializer syntax to create an empty array or dictionary.
let emptyArray = [String]()
let emptyDictionary = [String: Float]()

/*
 Or if the array or dicionary's type can be inferred.
 You can write it as [] and [:]
 */
shoppingList = []
occupations = [:]



//  MARK: Control Flow
/*
 Use if and switch to make contidionals, and use for-in, for, while,
 and repeat-while to make loops.
 In a if statement, the conditional must be a Boolean expression, which means 
 the code such as if score { ... } is an error.
 */
let individualScores = [75, 43, 103, 87, 12]
var teamScore =  0
for score in individualScores {
    if score > 50 {
        teamScore += 3
    } else {
        teamScore += 1
    }
}
print(teamScore)

/*
 Write a question mark (?) after the type of a value to mark the value as optional.
 */
var optionalString: String? = "Hello"
print(optionalString == nil)

/*
 Use if and let together to work, when the constant is nil, the code in 
 braces is skipped.
 */
var optionalName: String? = "John Appleseed"
var greeting = "Hello!"
if let name = optionalName {
    greeting = "Hello, \(name)"
}
print("Greeting official: \(greeting)")

/*
 Change optionalName to nil. What greeting do you get? Add an else clasue
 that sets a different greeting if optionalName is nil.   (Exp)
 A: I got "Hello!".
 */
var optionName: String? = nil
var greetingCustom = "Hello!"
if let name = optionName {
    greetingCustom = "Hello, \(name)"
} else {
    greetingCustom = "Hello with no one!"
}
print("Greeting custom: \(greetingCustom)")

/*
 One way to handler optional values is to provide a default value using the ?? 
 operator.
 */
let nickName: String? = nil;
let fullName: String = "John Appleseed"
let informalGreeting = "Hi \(nickName ?? fullName)"
print("Since I do not know whether i have a nickname: \(informalGreeting).")

/*  
 Switches support any kind of data and a wide variatey of comparision
 operations.
 Try removing the default case. What error do you get?  (Exp)
 A: Switches must be exhaustive, consider adding a default clause.
 */
let vegetable = "red pepper"

switch vegetable {
case "celery" :
    print("Add some raisins and make ants on a log.")
case "cucumber", "watercress" :
    print("That would make a good tea sandwich.")
case let x where x.hasSuffix("pepper"):
    print("It is a spicy \(x)?")
default:
    print("Everything tasts good in soup.")
}

/*
 You use for-in to iterate over items in a dictionary by providing a pair of
 names to use for each key-value pair.
 Add variable to keep track of which kind of number was the largest (Exp)
 */
let interestingNumbers = [
    "Prime": [2, 3, 5, 7, 11, 13],
    "Fibonacci": [1, 1, 2, 3, 5, 8],
    "Square": [1, 4, 9, 16, 25],
]
var largest = 0
for (kind, numbers) in interestingNumbers {
    for number in numbers {
        if number > largest {
            largest = number
        }
    }
}
print(largest)

/*
 Add another variable to keep track of which kind of number was the largest, as
 well as what the largest number was.    (Exp)
 */
largest = 0
var largestKind: String = "Prime"
for (kind, numbers) in interestingNumbers {
    for number in numbers {
        if number > largest {
            largest = number
            largestKind = kind
        }
    }
}
print("\(largestKind) has largest number \(largest)")

/*
 Use while to repeat a block of code until a condition changes.
 The condition of loop can be at the end instead, ensuring that the loop is run
 at least once.
 */
var n = 2
while n < 100 {
    n *= 2
}
print(n)

var m = 2
repeat {
    m *= 2
} while m < 100
print(m)

/*
 Keep an index in a loop by using ..< to make a range of indexes that omits
 its upper value, and use ... to make a range that incldes both values.
 */
var total = 0
for i in 0..<4 {
    total += i
}
print(total)

total = 0
for i in 0...4 {
    total += i
}
print(total)

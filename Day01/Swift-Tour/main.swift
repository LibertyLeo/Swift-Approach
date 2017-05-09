//
//  main.swift
//  Swift-Tour
//
//  Created by Leo_Lei on 5/8/17.
//  Copyright © 2017 LibertyLeo. All rights reserved.
//

import Foundation

//  MARK: Simple Value and Print
//  Explicit constant   (Exp)
let explicitFloat: Float = 4
print(explicitFloat)

//  Conversion type of combine  (Exp)
let label = "The width is "
let width = 100
let widthLabel = label + String(width)
print(widthLabel)

//  '\()' usage for combine
let apples = 3
let oranges = 5
let appleSummary = "I have \(apples) apples."
let fruitSummary = "I have \(apples + oranges) pieces of fruits"
print(appleSummary)
print(fruitSummary)
    
//  Different type of combine   (Exp)
let long = 2.12
let longer = 3.24
let name = "Leo"
let summary = "Hi, Are you \(String(long + longer)) \(name)?"
print(summary)

//  MARK: Array and Dictionary
//  Array and dictionary (',' is allowed after last element
var shoppingList = ["catfish", "water", "tulips", "blue paint"]
shoppingList[1] = "bottle of water"
print(shoppingList)

var occupations = [
    "Malcolm": "Captain",
    "Kaylee": "Mechanic",
]
occupations["Jayne"] = "Public Relations"
print(occupations)

//  Explict type of array or dictionary
let emptyArray = [String]()
let emptyDictionary = [String: Float]()

//  or if the array or dicionary's type can be inferred
shoppingList = []
occupations = [:]


//  MARK: Control Flow
/*
 In a if statement, the conditional must be a Boolean expression,
 which means the code such as if score { ... } is an error
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

var optionalString: String? = "Hello"
print(optionalString == nil)

/*
 Use 'if' and 'let' together to work, when the constant is nil, 
 the code in braces is skipped  (Exp)
 */
var optionName: String? = "John Appleseed"
//var optionName: String? = nil
var greeting = "Hello!"
if let name = optionName {
    greeting = "Hello, \(name)"
} else {
    greeting = "Hello with no one!"
}
print(greeting)

/*
 One way to handler optional values is to provide a default value using
 the ?? operator
 */
let nickName: String? = nil;
let fullName: String = "John Appleseed"
let informalGreeting = "Hi \(nickName ?? fullName)"
print(informalGreeting)

/*  
 Switches support any kind of data and a wide variatey of comparision
 operations. Switches must be exhaustive, so to add default clause
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
 When use for-in to iterate over items in a dictionary by providing a pair
 of names to use for each key-value pair.
 Add variable to keep track of which kind of number was the largest (Exp)
 */
let interestingNumbers = [
    "Prime": [2, 3, 5, 7, 11, 13],
    "Fibonacci": [1, 1, 2, 3, 5, 8],
    "Square": [1, 4, 9, 16, 25],
]
var largest = 0
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
 Use while to repeat a block of code until a condition changes. The condition of
 loop can be at the end instead, ensuring that the loop is run at least once.
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
 Keep an index in a loop by using ..< to make a range of indexes, use ... to 
 make a range that incldes both values
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

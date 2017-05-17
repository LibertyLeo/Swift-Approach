//
//  main.swift
//  Swift_Function_and_Closures
//
//  Created by Leo_Lei on 5/9/17.
//  Copyright © 2017 LibertyLeo. All rights reserved.
//

import Foundation

//  MARK: Function and Closures
/*
 Use 'func' to declare a function. 
 Use '->' to separate the parameter names and types from the function's return 
 type.
 */
func greet(person: String, day: String) -> String {
    return "Hello \(person), today is \(day)."
}

print(greet(person: "Bob", day: "Tuesday"))

/*
 Remove the 'day' parameter. Add a parameter to include today's lunch special
 in the greeting.   (Exp)
 */
func greetWithLunch(person: String, lunch: String) -> String {
    return "Hello \(person), today you're going to have \(lunch) for lunch."
}

print(greetWithLunch(person: "Leo", lunch: "pork"))

/*
 By default, functions use their parameter names as labels for their arguments. 
 Write custom argument label before the parameter name, or write _ to use no 
 argument label.
 */
func greetOnce(_ person: String, on day: String) -> String {
    return "Hello \(person), today is \(day)."
}

print(greetOnce("John", on: "Wednesday"))

/*
 Use a tuple to make a compound value.
 The elements of a tuple can be referred to either by name or by number.
 */
func calculateStatistics(scores: [Int]) -> (min: Int, max: Int, sum: Int) {
    var min = scores[0]
    var max = scores[0]
    var sum = 0
    
    for score in scores {
        if score > max {
            max = score
        } else if score < min {
            min = score
        }
        sum += score
    }
    return (min, max, sum)
}

let statistics = calculateStatistics(scores: [5, 3, 100, 3, 9])
print(statistics.sum)
print(statistics.2)

/*
 Functions can also take a variable number of arguments, collecting them into 
 array.
 */
func sumOf(numbers: Int...) -> Int {
    var sum = 0
    for number in numbers {
        sum += number
    }
    return sum
}

print(sumOf())
print(sumOf(numbers: 42, 597, 12))

/*
 Write a function that calculates the average of its arguments. (Exp)
 */
func averageOf(numbers: Int...) -> Int {
    let sum = numbers.reduce(0, +)
    return (numbers.count == 0 ? 0 : sum / numbers.count)
}

print("The average value of no number is \(averageOf()).")
print("The average value of the array is \(averageOf(numbers: 4, 12, 85)).")

//  Functions can be nested.
func returnFifteen() -> Int {
    var y = 10
    func add() {
        y += 5
    }
    add()
    return y
}

print("This value must be 15, actually it is \(returnFifteen()).")

/*
 Functions are a first-class type, so it can return another function as its value.
 */
func makeIncrement() -> ((Int) -> Int) {
    func addOne(number: Int) -> Int {
        return number + 1
    }
    return addOne
}

var increment = makeIncrement()
print("Nested function value is \(increment(7)).")

//  A function can take another function as one of its arguments.
func hasAnyMatches(list: [Int], condition: (Int) -> Bool) -> Bool {
    for item in list {
        if condition(item) {
            return true
        }
    }
    return false
}

func lessThanTen(number: Int) -> Bool {
    return number < 10
}

var numbers = [20, 19, 7, 12]
print(hasAnyMatches(list: numbers, condition: lessThanTen))



//  MARK: Closures
/*
 Functions are actually a special case of closures: blocks of code that can be 
 called later.
 You can write a closure without a name by surrounding code with braces ({}).
 Use 'in' to separate the argument and return type from the body.
 */
let multipliedNumber = numbers.map({ (number: Int) -> Int in
    let result = 3 * number
    return result
})

print("All number are multiply by 3, then it becomes \(multipliedNumber).")

//  Rewrite the closure to return zero for all odd numbers    (Exp)
let oddNumbers = numbers.map({ (number: Int) -> Int in
    let result = number % 2 == 0 ? number : 0
    return result
})

print("All even numbers are \(oddNumbers).")

/*
 When a closure's type is already known, such as the callback for a delegate, 
 you can omit the type of its parameter, its return type, or both.
 */
let mappedNumbers = numbers.map({ number in 3 * number})
print(mappedNumbers)

/*
 You can refer to parameters by number instead of by name.
 When a closure is the only argument to a function, you can omit the parenthese
 entirely.
 */
let sortedNumbers = numbers.sorted { $0 > $1 }
print(sortedNumbers)

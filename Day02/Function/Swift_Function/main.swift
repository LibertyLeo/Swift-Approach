//
//  main.swift
//  Swift_Function
//
//  Created by Leo_Lei on 5/9/17.
//  Copyright © 2017 LibertyLeo. All rights reserved.
//

import Foundation

//  MARK: - Function and Closures
/*
 Use func to declare a function. Use -> to separate the parameter names and
 types from the function's return type.
 
 */
func greet(person: String, day: String) -> String {
    return "Hello \(person), today is \(day)."
}
print(greet(person: "Bob", day: "Tuesday"))

//  Change parameter to include lunch special in the greeting   (Exp)
func lunch(person: String, meal: String) -> String {
    return "Hello \(person), today you're going to have \(meal) for lunch."
}
print(lunch(person: "Leo", meal: "fish"))

/*
 By default, functions use their parameter names as labels for their
 arguments. Write custom argument label before the parameter name,
 or write _ to use no argument label.
 */
func greetOnce(_ person: String, on day: String) -> String {
    return "Hello \(person), today is \(day)."
}
print(greetOnce("John", on: "Wednesday"))


//  Use a tuple to make a compound value
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
/*
 Functions can also take a variable number of arguments, collecting them
 into array
 */
print(statistics.2)

func sumOf(numbers: Int...) -> Int {
    var sum = 0
    for number in numbers {
        sum += number
    }
    return sum
}
print(sumOf())
print(sumOf(numbers: 42, 597, 12))

//  Functions for calculating average   (Exp)
func averageOf(numbers: Int...) -> Int {
    var sum = 0
    var average = 0
    for number in numbers {
        sum += number
    }
    average = sum / numbers.count
    return average
}
print("The average value of the array is \(averageOf(numbers: 4, 12, 85))")

//  Functions can be nested.
func returnFifteen() -> Int {
    var y = 10
    func add() {
        y += 5
    }
    add()
    return y
}
print(returnFifteen())

//  Functions are a first-class type
func makeIncrement() -> ((Int) -> Int) {
    func addOne(number: Int) -> Int {
        return number + 1
    }
    return addOne
}
var increment = makeIncrement()
print(increment(7))

//  A function can take another function as one of its arguments
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

/*
 Functions are actuall a special case o f closures: blocks of code
 that can be called later
 */
let mappedNumber = numbers.map({ (number: Int) -> Int in
//    let result = 3 * number
    //  Rewrite the close to return zero for all odd numbers    (Exp)
    let result = (number % 2 == 0 ? number : 0)
    return result
})
print(mappedNumber)

/*
 When a closure's type is already known, such as the callback for a
 delegate, you can omit the type of its parameter, its return type, or both
 */
let mappedNumbers = numbers.map({ number in 3 * number})
print(mappedNumbers)

/*
 You can refer to parameters by number instead of by name
 */
let sortedNumbers = numbers.sorted { $0 > $1 }
print(sortedNumbers)

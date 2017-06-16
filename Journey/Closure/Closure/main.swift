//
//  main.swift
//  Closure
//
//  Created by Leo_Lei on 5/22/17.
//  Copyright © 2017 LibertyLeo. All rights reserved.
//

import Foundation

/*
 Closures are self-contained blocks of functionality that can be passed around
 and used in your code.
 Closures can capture and store references to any constants and variables from
 the context in which they are defined. This is known as closing over those
 constants and variables. Swift handles all of the memory management of
 capturing for you.

 Closures take one of three forms:
 - Global functions are closures that have a name and do not capture any
 values.
 - Nested functions are closures that have a name and can cpature values
 from their enclosing function.
 - Closures expressions are unnamed closures written in a lightweight syntax
 that can capture values from their surrounding context.

 Swift's closure expressions have optimizations include:
 - Inferring parameter and return value types from context
 - Implicit returns from single-expression closures.
 - Shorthand argument names
 - Trailing closure syntax
 */



//  MARK: - Closure Expressions
/*
 Closure expressions are a way to write inline closures in a brief, focused
 syntax.
 */



//  MARK: The Sorted Method
/*
 Swift's standard library provides a method called sorted(by:), which sorts
 an array of values of a known type, based on the output of a storing closure
 that you provide.
 Once it completes the sorting process, the sorted(by:) method return a new
 array of the same type and size as the old one, with its elements in the
 correct sorted order.
 The original array is not modified bby the sorted(by:) method.
 */
let names = ["Chris", "Alex", "Ewa", "Barry", "Dainella"]

func backward(_ s1: String, _ s2: String) -> Bool {
    return s1 > s2
}
var reversedNames = names.sorted(by: backward)
//  reversedNames is equal to ["Ewa", "Donielaa", "Chris", "Barry", "Alex"]

/*
 However, this is a rather long-winded way to write what it essentially a
 single-expression function (a > b). In this example, it would be preferable
 to write the sorting closure inline, using closure expression syntax.
 */



//  MARK: Closure Expression Syntax
/*
 Closure expression syntax has the following general form:
 ///{ (<#parameters#>) -> <#return type #> in
 ///    <#statements#>
 ///}
 */
reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in
    return s1 > s2
})

/*
 The start of the closure's body is introduced by the in keyword.
 This keyword indicates that the difinition of the closure's parameters and
 return type has finished, and the body of the closure is about to begin.

 Because the body of the closure is so short, it can even be written on a sinle
 line:
 */
reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in return s1 > s2 } )



//  MARK: Inferring Type From Context
/*
 Because the sorting closure is passed as an arguments to a method, Swift can
 infer the types of its parameters and the type of the value it returns.

 The sorted(by:) method is being called on an array of strings, so its
 argument must be a function of type (String, String) -> Bool. This means
 that the (String, String)) and Bool types do not need to be written as
 part of the closure expression's definition.
 Because all of the types can be inferred, the return arrow (->) and the
 parenthese around the names of the parameters can also be omitted.
 */
reversedNames = names.sorted(by: { s1, s2 in return s1 > s2})



//  MARK: Implict Returns from Single-Expression Closures
/*
 Single-expression closures can implicitly return the result of their single
 expression by omitting the return keyword from their declaration.
 */
reversedNames = names.sorted(by: { s1, s2 in s1 > s2 } )
/*
 Because the closures' body contains a single expression (s1 > s2) that returns
 a Bool value, there is no ambiguity, and the return keyword can be omitted.
 */



//  MARK: Shorthand Argument Names
/*
 Swift automatically provides shorthand argument names to inline closures,
 which can be used to refer to the values of the closure's arguments by the
 name $0, $1, $2. and so on.

 If you use these shorthand argument name within your closure expression, you
 can omit the closure's argument list from its definition, and the number and
 type of the shorthand argument names will be inferred from the expected
 function type.
 */
reversedNames = names.sorted(by: { $0 > $1 })



//  MARK: Operator Methods
/*
 Swift's String type defines its string-specific implementaion of the
 greater-than operator (>) as a method that has two parameters of type
 String, and returns a value of type Bool.
 */
reversedNames = names.sorted(by: >)



//  MARK: Trailing Closures
/*
 If you need to pass a closure expression to a function as the function's final
 argument and the closure expression is long, it can be useful to write it as a
 trailing closure instead.
 When you use the trailiing closure syntax, you don't write the argument label
 for the closure as part of the function call.
 */
func someFunctionThatTakesAClosure(closure: () -> Void) {
    //  function body goes here
}

//  Here's how you call this function without ussing a trailing closure:

someFunctionThatTakesAClosure(closure: {
    //  closure's body goes here
})

//  Here's how you call this function with a trailing closure instead

someFunctionThatTakesAClosure() {
    //  trailing closure's body goes here
}

/*
 The string-sorting closure above can be written outside of the sorted(by:)
 method's parentheese as  a trailing closure.
 */
reversedNames = names.sorted() { $0 > $1 }

/*
 If a closure expression is provided as the function or method's only argument
 and you provide that expression as a trailing closure, you do not need to
 write a paire of parenthese () after the function or method's name.
 */
reversedNames = names.sorted { $0 > $1 }

/*
 Trailing closures are most useful when the closure is sufficiently long that
 it is not possible to write it inline on a single line.
 As an example, Swift's Array type has a map(_:)method which takes a
 closure expression as its single argument.
 The nature of the mapping and the type of the returned value is left up to the
 closure to specify.

 After applying the provided closure to each array element, the map(_:)
 method returns a new array containing all of the new mapped values, in the
 same order as their corresponding values in the original array.
 */
let digitName = [
    0: "Zero", 1: "One", 2: "Two", 3: "Three", 4: "Four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]
let numbers = [16, 58, 510]
/*
 The code above creates a dictionary of mappings between the integer digits and
 English-language versions of their names. It also defines an array of integers,
 ready to be converted into string.
 */
let strings = numbers.map { (number) -> String in
    var number = number
    var output = ""
    repeat {
        output = digitName[number % 10]! + output
        number /= 10
    } while number > 0
    return output
}
//  string is inferred to be of type [String]
//  its value is ["OneSix", "FiveEight", "FiveOneZero"]

/*
 The closure expression builds a string called output each time it is called.

 NOTE:
 The call to the digitalNames dictionary's subscript is followed by an
 exclamation mark(!), because dictionary subscripts return an optional value to
 indicate that the dictionary lookup can fail if the key does not exist.
 */



//  MARK: - Capturing Values
/*
 A closure can capture constants and variables from the surrounding context in
 which it is defined.
 The closure can then refer to and modify the values of those constants and
 variables from within its body, even if the original scope that defined the
 constants and variables no longer exists.
 */
func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}

/*
 When considered in isolation, the nested incrementer() function might seem
 unusual.

 The incrementer() function doesn't have any parameters, and yet it refers to
 runningTotal and amount from within its function body.

 It does this by capturing a reference to runningTotal and amount from the
 surrounding function and using them within its own function body.

 Capturing by reference ensures that runningTotal and amount do not
 disappear when the call to makeIncrementer ends, and also ensures that
 runningTotal is available the next time the incrementer function is called.

 NOTE:
 As an optimization, Swift may instead capture and store a copy of a value if
 that values is not mutated by a closure, and if the values is not mutated
 after closure is created.
 Swift also handles all memory management involved in disposing of variables
 when they are no longer needed.
 */
let incrementByTen = makeIncrementer(forIncrement: 10)

/*
 An incrementer function that adds 10 to its runningTotal variable each
 time it is called. Calling the function multiple times shows this behavior
 in action.
 */
incrementByTen()
//  returns a value of 10
incrementByTen()
//  returns a value of 20
incrementByTen()
//  returns a value of 30

/*
 If you create a second incrementer, it will have its own stored reference to a
 new, separate runningTotal variable.
 */
let incrementBySeven = makeIncrementer(forIncrement: 7)
incrementBySeven()
//  returns a value of 7

/*
 Calling hte original incrementer (incrementByTen) agagin continues to
 increment its own runningTotal variable, and does not affect the variable
 captured by incrementBySeven
 */
incrementByTen()
//  returns a value of 40

/*
 NOTE:
 If you assign a closure to a property of a class instance, and the closure
 captures that instance by referring to the instance or its members, you will
 create a strong reference cycle between the closures and the instance.
 Swift uses capture lists to break these strong reference cycles.
 */



//  MARK: Closures Are Reference Types
/*
 In the example above, incrementBySeven and incrementByTen are constants,
 but the closure these constants refer to are still able to increment the
 runningTotal variables that they have captures.
 This is because functions and closures are reference types.
 It is the choice of closure that incrementByTen refers to that is constant,
 and not the contens of the closure itself. This also means that if you assign
 a closure to two different constants or variable, both of those constants or
 variables will refer to the same closure
 */
let alsoIncrementByTen = incrementByTen
alsoIncrementByTen()
//  returns a value of 50



//  MARK: - Escaping Closures
/*
 A closure is said to escape a function when the closure is passed as an
 argument to the function, but is called after the function returns.
 When you declare a function that takes a closure as one of its parameters, you
 can write @escaping before the parameter's type to indicate that the closure
 is allowed to escape.
 */
var completionHandlers: [() -> Void] = []
func someFunctionWithEscapingClosure(completionHandler: @escaping() -> Void) {
    completionHandlers.append(completionHandler)
}
/*
 If you didn't mark the parameter of this function with @escaping, you would
 get a compile-time error.
 Marking a closure with @escaping means you have to refer to self
 explicitly within the closure.

 The closure passed to someFunctionWithEscapingClosure(_:) is an escaping
 closure, which means it need to refer to self explicitly.
 In contrast, the closure passed to someFunctionWithNonescapingClosure(_:) is
 a nonescaping closure, which means it can refer to self implicitly.
 */
func someFunctionWithNonescapingClosure(closure: () -> Void) {
    closure()
}

class someClass {
    var x = 10
    func doSomething() {
        someFunctionWithEscapingClosure { self.x = 100 }
        someFunctionWithNonescapingClosure { x = 200 }
    }
}

let instance = someClass()
instance.doSomething()
print(instance.x)
//  Prints "200"

completionHandlers.first?()
print(instance.x)
//  Prints "100"



//  MARK: - Autoclosures
/*
 An autoclosure is a closure that is automatically created to wrap an
 expression that's being passed as an argument to a function. It doesn't take
 any arguments, and when it's called, it returns the value of the expression
 that's wrapped inside of it.
 This syntactic convenience lets you omit braces around a function's parameter
 by writing a normal expression instead of an explict closure.

 An autoclosure lets you delay evaluation, because the code inside isn't run
 until you call the closure.
 */
var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
print(customersInLine.count)
//  Prints "5"

let customerProvider = { customersInLine.remove(at: 0) }
print(customersInLine.count)
//  Prints "5"

print("Now serving \(customerProvider())!")
//  Prints "Now serving Chris!"
print(customersInLine.count)
//  Prints "4"

/*
 Even though the first element of the customersInLine array is removed by the
 code inside the closure, the array element isn't removed until the closure is
 actually called.

 You get the same behavior of delayed evaluation when you pass a closure as an
 arugment to a function.
 */
//  customersInLIne is ["Alex", "Ewa", "Barry", "Daniella"]
func serve(customer customerProvider: () -> String) {
    print("Now serving \(customerProvider())!")
}
serve(customer: { customersInLine.remove(at: 0) })
//  Prints "Now serving Alex!"

/*
 The serve(customer:) function in the listing above takes an explicit closure
 that returns a customer's name.
 The version of serve(customer:) below performs the same operation but,
 instead of taking an explicit closure, it takes an autoclosure by marking its
 parameters type with the @autoclosure attribute.
 */
//  customersInLIne is ["Ewa", "Barry", "Daniella"]
func serve(customer customerProvider: @autoclosure () -> String) {
    print("Now serving \(customerProvider())!")
}
serve(customer: customersInLine.remove(at: 0))
//  Prints "Now serving Ewa!"
/*
 NOTE:
 Overusing autoclosure can make your code hard to understand.
 The context and function name should make it clear that evaluation is being
 deferred.
 */

/*
 If you want an autoclosure that is allowed to escape, use both the
 @autoclosure and @escaping attributed.
 */
//  customersInLIne is ["Barry", "Daniella"]
var customerProviders: [() -> String] = []
func collectCustomerProviders(_ customerProvider: @autoclosure @escaping () -> String ) {
    customerProviders.append(customerProvider)
}

collectCustomerProviders(customersInLine.remove(at: 0))
collectCustomerProviders(customersInLine.remove(at: 0))

print("Collected \(customerProviders.count) closures.")
//  Prints "Collected 2 closures."

for customerProvider in customerProviders {
    print("Now serving \(customerProvider())!")
}
//  Prints "Now serving Barry!"
//  Prints "Now serving Daniella!"

/*
 The collectCustomerProviders(_:) function appends the closure to the
 customerProviders array.
 The array is declared outside the scope of the function, which means the
 closures in the array can be executed after the function returns.
 As a result, the value of the customerProvider argument must be allowed to
 escape the function's scope.
 */

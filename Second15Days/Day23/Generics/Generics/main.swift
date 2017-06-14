//
//  main.swift
//  Generics
//
//  Created by Leo_Lei on 6/14/17.
//  Copyright © 2017 LibertyLeo. All rights reserved.
//

import Foundation

/*
 Generic code enables you to write flexible, reusable functions and types that
 can work with any type, subject to requirements that you define. You can write 
 code that avoids duplication and expresses its intent in a clear, abstracted 
 manner.
 */



//  MARK: The Problem That Generics Solve
/*
 Here’s a standard, nongeneric function called swapTwoInts(_:_:), which swaps 
 two Int values:
 */
func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}

var someInt = 3
var anotherInt = 107
swap(&someInt, &anotherInt)
print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")
// Prints "someInt is now 107, and anotherInt is now 3"

/*
 The swapTwoInts(_:_:) function is useful, but it can only be used with Int 
 values. If you want to swap two String values, or two Double values, you have
 to write more functions, such as the swapTwoStrings(_:_:) and 
 swapTwoDoubles(_:_:) functions shown below:
 */
func swapTwoStrings(_ a: inout String, _ b: inout String) {
    let temporaryA = a
    a = b
    b = temporaryA
}

func swapTwoDoubles(_ a: inout Double, _ b: inout Double) {
    let temporaryA = a
    a = b
    b = temporaryA
}
/*
 It’s more useful, and considerably more flexible, to write a single function 
 that swaps two values of any type. Generic code enables you to write such a 
 function.
 
 NOTE:
 In all three functions, the types of a and b must be the same. If a and b 
 aren’t of the same type, it isn’t possible to swap their values. Swift is a 
 type-safe language, and doesn’t allow (for example) a variable of type String
 and a variable of type Double to swap values with each other. Attempting to do 
 so results in a compile-time error.
 */



//  MARK: Generic Functions
/*
 Generic functions can work with any type. Here’s a generic version of the 
 swapTwoInts(_:_:) function from above, called swapTwoValues(_:_:):
 */
func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
    let temporaryA = a
    a = b
    b = temporaryA
}

/*
 The generic version of the function uses a placeholder type name instead of an
 actual type name. It does say that both a and b must be of the same type T, 
 whatever T represents.

 The swapTwoValues(_:_:) function can now be called in the same way as 
 swapTwoInts, except that it can be passed two values of any type, as long as 
 both of those values are of the same type as each other. Each time 
 swapTwoValues(_:_:) is called, the type to use for T is inferred from the 
 types of values passed to the function.

 In the two examples below, T is inferred to be Int and String respectively:
 */
var newInt = 3
var newAnotherInt = 107
swapTwoValues(&newInt, &newAnotherInt)
// newInt is now 107, and newAnotherInt is now

var someString = "hello"
var anotherString = "world"
// someString is now 'world', and anotherString is now 'hello'
/*
 NOTE:
 If you need the behavior of the swapTwoValues(_:_:) function in your own code,
 you can use Swift’s existing swap(_:_:) function rather than providing your 
 own implementation.
 */



//  MARK: Type Parameters
/*
 Type parameters specify and name a placeholder type, and are written 
 immediately after the function’s name, between a pair of matching angle 
 brackets (such as <T>).
 
 Once you specify a type parameter, you can use it to define the type of a 
 function’s parameters (such as the a and b parameters of the 
 swapTwoValues(_:_:) function), or as the function’s return type, or as a type
 annotation within the body of the function. In each case, the type parameter
 is replaced with an actual type whenever the function is called.
 
 You can provide more than one type parameter by writing multiple type
 parameter names within the angle brackets, separated by commas.
 */



//  MARK: Naming Type Parameters
/*
 In most cases, type parameters have descriptive names, such as Key and Value 
 in Dictionary<Key, Value> and Element in Array<Element>, which tells the 
 reader about the relationship between the type parameter and the generic type 
 or function it’s used in. However, when there isn’t a meaningful relationship 
 between them, it’s traditional to name them using single letters such as T, U, 
 and V, such as T in the swapTwoValues(_:_:) function above.

 NOTE:
 Always give type parameters upper camel case names (such as T and
 MyTypeParameter) to indicate that they are a placeholder for a type, not a 
 value.
 */



//  MARK: - Generic Types
/*
 In addition to generic functions, Swift enables you to define your own generic
 types. These are custom classes, structures, and enumerations that can work
 with any type, in a similar way to Array and Dictionary.
 
 The illustration below shows the push and pop behavior for a stack:

              |                   ↑
         |  __↓__  |         |  __|__  |         |
         | |_____| |  _____  | |_____| |         |
  _____  |  _____  | |_____| |  _____  |  _____  |
 |_____| | |_____| | |_____| | |_____| | |_____| |
 |_____| | |_____| | |_____| | |_____| | |_____| |
 |_____| | |_____| | |_____| | |_____| | |_____| |
 --------|---------|---------|---------|---------|
 
 There are currently three values on the stack.
 A fourth value is pushed onto the top of the stack.
 The stack now holds four values, with the most recent one at the top.
 The top item in the stack is popped.
 After popping a value, the stack once again holds three values.
 */
struct IntStack {
    var items = [Int]()
    mutating func push(_ item: Int) {
        items.append(item)
    }

    mutating func pop() -> Int {
        return items.removeLast()
    }
}

/*
 The IntStack type shown above can only be used with Int values, however. It 
 would be much more useful to define a generic Stack class, that can manage a
 stack of any type of value.

 Here’s a generic version of the same code:
 */
struct Stack<Element> {
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }

    mutating func pop() -> Element {
        return items.removeLast()
    }
}

/*
 Element defines a placeholder name for a type to be provided later. This 
 future type can be referred to as Element anywhere within the structure’s 
 definition. In this case, Element is used as a placeholder in three places:

    - To create a property called items, which is initialized with an empty 
 array of values of type Element
    - To specify that the push(_:) method has a single parameter called item, 
 which must be of type Element
    - To specify that the value returned by the pop() method will be a value of 
 type Element
 
 You create a new Stack instance by writing the type to be stored in the stack 
 within angle brackets. For example, to create a new stack of strings, you 
 write Stack<String>():
 */
var stackOfStrings = Stack<String>()
stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")
stackOfStrings.push("cuatro")
// the stack now contains 4 strings.

/*
 Here’s how stackOfStrings looks after pushing these four values on to the stack:

                                         |
           |           |     |     |  ___↓___  |           |
           |     |     |  ___↓___  | |_cuatro| |  _______  |
           |  ___↓___  | |__tres_| |  _______  | |_cuatro| |
     |     | |__dos__| |  _______  | |__tres_| | |__tres_| |
  ___↓___  |  _______  | |__dos__| | |__dos__| | |__dos__| |
 |__uno__| | |__uno__| | |__uno__| | |__uno__| | |__uno__| |
 ----------|-----------|-----------|-----------|-----------|
 */

// Popping a value from the stack removes and returns the top value, "cuatro":
let fromTheTop = stackOfStrings.pop()
// fromTheTop is equal to "cuatro", and the stack now contains 3 strings.

/*
 Here’s how the stack looks after popping its top value:

                 ↑
           |  ___|___  |           |
  _______  | |_cuatro| |           |
 |_cuatro| |  _______  |  _______  |
 |__tres_| | |__tres_| | |__tres_| |
 |__dos__| | |__dos__| | |__dos__| |
 |__uno__| | |__uno__| | |__uno__| |
 ----------|-----------|-----------|
 */

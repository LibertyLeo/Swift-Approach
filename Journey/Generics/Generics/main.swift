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
 Here’s how stackOfStrings looks after pushing these four values on to the 
 stack:

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



//  MARK: Extending a Generic Type
/*
 When you extend a generic type, you do not provide a type parameter list as 
 part of the extension’s definition. Instead, the type parameter list from the
 original type definition is available within the body of the extension, and 
 the original type parameter names are used to refer to the type parameters 
 from the original definition.
 */
extension Stack {
    var topItem: Element? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}

/*
 Note that this extension doesn’t define a type parameter list. Instead, the
 Stack type’s existing type parameter name, Element, is used within the 
 extension to indicate the optional type of the topItem computed property.
 
 The topItem computed property can now be used with any Stack instance to
 access and query its top item without removing it.
 */
if let topItem = stackOfStrings.topItem {
    print("The top item on the stack is \(topItem).")
}
// Prints "The top item on the stack is tres."
/*
 Extensions of a generic type can also include requirements that instances of 
 the extended type must satisfy in order to gain the new functionality.
 */



//  MARK: - Type Constraints
/*
 Type constraints specify that a type parameter must inherit from a specific
 class, or conform to a particular protocol or protocol composition.

 The requirement is enforced by a type constraint on the key type for 
 Dictionary, which specifies that the key type must conform to the Hashable 
 protocol, a special protocol defined in the Swift standard library. All of
 Swift’s basic types (such as String, Int, Double, and Bool) are hashable by 
 default.

 You can define your own type constraints when creating custom generic types, 
 and these constraints provide much of the power of generic programming. 
 Abstract concepts like Hashable characterize types in terms of their
 conceptual characteristics, rather than their concrete type.
 */



//  MARK: Type Constraint Syntax
/*
 You write type constraints by placing a single class or protocol constraint
 after a type parameter’s name, separated by a colon, as part of the type 
 parameter list.

 The basic syntax for type constraints on a generic function is shown below 
 (although the syntax is the same for generic types):
 ///    func someFunction<T: SomeClass, U: SomeProtocol>(someT: T, someU: U) {
 ///        // function body goes here
 ///    }
 */



//  MARK: Type Constraints in Action
/*
 Here’s a nongeneric function called findIndex(ofString:in:), which is given
 a String value to find and an array of String values within which to find it.
 The findIndex(ofString:in:) function returns an optional Int value, which will
 be the index of the first matching string in the array if it is found, or nil
 if the string cannot be found:
 */
func findIndex(ofString valueToFind: String, in array: [String]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

/*
 The findIndex(ofString:in:) function can be used to find a string value in 
 an array of strings:
 */
let strings = ["cat", "dog", "llama", "parakeet", "terrapin"]
if let foundIndex = findIndex(ofString: "llama", in: strings) {
    print("The index of llama is \(foundIndex)")
}
// Prints "The index of llama is 2"

/*
 Note that the return type of this function is still Int?, because the function
 returns an optional index number, not an optional value from the array.
 Be warned, though—this function doesn’t compile, for reasons explained after 
 the example:
 */
//func findIndex<T>(of valueToFind: T, in array:[T]) -> Int? {
//    for (index, value) in array.enumerated() {
//        if value == valueToFind {
//            return index
//        }
//    }
//    return nil
//}

/*
 This function doesn’t compile as written above. The problem lies with the
 equality check, if value == valueToFind”. Not every type in Swift can be
 compared with the equal to operator (==). If you create your own class or
 structure to represent a complex data model, for example, then the meaning of
 equal to” for that class or structure isn’t something that Swift can guess for
 you. Because of this, it isn’t possible to guarantee that this code will work 
 for every possible type T, and an appropriate error is reported when you try 
 to compile the code.
 
 The Swift standard library defines a protocol called Equatable, which requires 
 any conforming type to implement the equal to operator (==) and the not equal
 to operator (!=) to compare any two values of that type. All of Swift’s 
 standard types automatically support the Equatable protocol.
 
 Any type that is Equatable can be used safely with the findIndex(of:in:)
 function, because it is guaranteed to support the equal to operator. To 
 express this fact, you write a type constraint of Equatable as part of the
 type parameter’s definition when you define the function:
 */
func findIndex<T: Equatable>(of valueToFind: T, in array:[T]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

/*
 The findIndex(of:in:) function now compiles successfully and can be used with
 any type that is Equatable, such as Double or String:
 */
let doubleIndex = findIndex(of: 9.3, in: [3.14159, 0.1, 0.25])
// doubleIndex is an optional Int with no value, because 9.3 isn't in the array
let stringIndex = findIndex(of: "Andrea", in: ["Mike", "Malcolm", "Andrea"])
// stringIndex is an optional Int containing a value of 2



//  MARK: - Associated Types
/*
 An associated type gives a placeholder name to a type that is used as part of
 the protocol. The actual type to use for that associated type isn’t specified 
 until the protocol is adopted.
 Associated types are specified with the associatedtype keyword.
 */



//  MARK: Associated Types in Action
/*
 Here’s an example of a protocol called Container, which declares an associated
 type called Item:
 */
protocol Container {
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}

/*
 The Container protocol defines three required capabilities that any container 
 must provide:

 - It must be possible to add a new item to the container with an append(_:)
 method.
 - It must be possible to access a count of the items in the container through
 a count property that returns an Int value.
 - It must be possible to retrieve each item in the container with a subscript 
 that takes an Int index value.
 
 Any type that conforms to the Container protocol must be able to specify the 
 type of values it stores. Specifically, it must ensure that only items of the 
 right type are added to the container, and it must be clear about the type of
 the items returned by its subscript.
 
 The Item alias provides a way to refer to the type of the items in a
 Container, and to define a type for use with the append(_:) method and
 subscript, to ensure that the expected behavior of any Container is enforced.

 Here’s a version of the nongeneric IntStack type from earlier, adapted to
 conform to the Container protocol:
 */
struct IntStackContainter: Container {
    // original IntStack implementation
    var items = [Int]()
    mutating func push(_ item: Int) {
        items.append(item)
    }

    mutating func pop() -> Int {
        return items.removeLast()
    }

    // conformance to the Container protocol
    typealias Item = Int
    mutating func append(_ item: Int) {
        self.push(item)
    }

    var count: Int {
        return items.count
    }

    subscript(i: Int) -> Int {
        return items[i]
    }
}

/*
 You can also make the generic Stack type conform to the Container protocol:
 */
struct StackContainer<Element>: Container {
    // original Stack<Element> implementation
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }

    mutating func pop() -> Element {
        return items.removeLast()
    }

    // conformance to the Container protocol
    mutating func append(_ item: Element) {
        self.push(item)
    }

    var count: Int {
        return items.count
    }

    subscript(i: Int) -> Element {
        return items[i]
    }
}

//  MARK: Extending an Existing Type to Specify an Associated Type
/*
 You can extend an existing type to add conformance to a protocol, this
 includes a protocol with an associated type.
 
 Swift’s Array type already provides an append(_:) method, a count property,
 and a subscript with an Int index to retrieve its elements. These three 
 capabilities match the requirements of the Container protocol. This means 
 that you can extend Array to conform to the Container protocol simply by
 declaring that Array adopts the protocol.
 */
extension Array: Container {}
/*
 Array’s existing append(_:) method and subscript enable Swift to infer the 
 appropriate type to use for Item, just as for the generic Stack type above.
 After defining this extension, you can use any Array as a Container.
 */



//  MARK: - Generic Where Clauses
/*
 Type constraints enable you to define requirements on the type parameters 
 associated with a generic function or type.

 It can also be useful to define requirements for associated types. You do this
 by defining a generic where clause. A generic where clause enables you to 
 require that an associated type must conform to a certain protocol, or that 
 certain type parameters and associated types must be the same. A generic where
 clause starts with the where keyword, followed by constraints for associated
 types or equality relationships between types and associated types. You write
 a generic where clause right before the opening curly brace of a type or
 function’s body.
 
 The example below defines a generic function called allItemsMatch, which 
 checks to see if two Container instances contain the same items in the same
 order.
 */
func allItemsMatch<C1: Container, C2: Container>(_ someContainer: C1, _ anotherContainer: C2) -> Bool
    where C1.Item == C2.Item, C1.Item: Equatable {
        // Check that both containers contain the same number of items
        if someContainer.count != anotherContainer.count {
            return false
        }

        // Check each pair of items to see if they are equivalent
        for i in 0..<someContainer.count {
            if someContainer[i] != anotherContainer[i] {
                return false
            }
        }

        // All items match, so return true
        return true
}

/*
 The following requirements are placed on the function’s two type parameters:

    - C1 must conform to the Container protocol (written as C1: Container).
    - C2 must also conform to the Container protocol (written as C2: Container).
    - The Item for C1 must be the same as the Item 
 for C2 (written as C1.Item == C2.Item).
    - The Item for C1 must conform to the Equatable 
 protocol (written as C1.Item: Equatable).

 The first and second requirements are defined in the function’s type
 parameter list, and the third and fourth requirements are defined in the
 function’s generic where clause.

 These requirements mean:

    - someContainer is a container of type C1.
    - anotherContainer is a container of type C2.
    - someContainer and anotherContainer contain the same type of items.
    - The items in someContainer can be checked with the not equal
 operator (!=) to see if they are different from each other.
 
 The third and fourth requirements combine to mean that the items in 
 anotherContainer can also be checked with the != operator, because they
 are exactly the same type as the items in someContainer.

 These requirements enable the allItemsMatch(_:_:) function to compare thtwo
 containers, even if they are of a different container type.
 
 Here’s how the allItemsMatch(_:_:) function looks in action:
 */
var stackOfStringsForWhere = StackContainer<String>()
stackOfStringsForWhere.push("uno")
stackOfStringsForWhere.push("dos")
stackOfStringsForWhere.push("tres")

var arrayOfStrings = ["uno", "dos", "tres"]

if allItemsMatch(stackOfStringsForWhere, arrayOfStrings) {
    print("All items match.")
} else {
    print("Not all items match.")
}
// Prints "All items match."



//  MARK: Extensions with a Generic Where Clause
/*
 You can also use a generic where clause as part of an extension. 
 The example below extends the generic Stack structure from the previous
 examples to add an isTop(_:) method.
 */
extension StackContainer where Element: Equatable {
    func isTop(_ item: Element) -> Bool {
        guard let topItem = items.last else {
            return false
        }
        return topItem == item
    }
}

/*
 The implementation of isTop(_:) uses the == operator, but the definition of
 Stack doesn’t require its items to be equatable, so using the == operator 
 results in a compile-time error. Using a generic where clause lets you add 
 a new requirement to the extension, so that the extension adds the isTop(_:)
 method only when the items in the stack are equatable.

 Here’s how the isTop(_:) method looks in action:
 */
if stackOfStringsForWhere.isTop("tres") {
    print("Top element is tres.")
} else {
    print("Top element is something else")
}
// Prints "Top element is tres."

/*
 If you try to call the isTop(_:) method on a stack whose elements aren’t
 equatable, you’ll get a compile-time error.
 */
struct NotEquatable { }
var notEquatableStack = StackContainer<NotEquatable>()
let notEquatableValue = NotEquatable()
notEquatableStack.push(notEquatableValue)
notEquatableStack.isTop(notEquatableValue)  // Error

/*
 You can use a generic where clause with extensions to a protocol. The example 
 below extends the Container protocol from the previous examples to add a 
 startsWith(_:) method.
 */
extension Container where Item: Equatable {
    func startsWith(_ item: Item) -> Bool {
        return count >= 1 && self[0] == item;
    }
}

/*
 The startsWith(_:) method first makes sure that the container has at least one 
 item, and then it checks whether the first item in the container matches the 
 given item.
 */
if [9, 9, 9].startsWith(42) {
    print("Starts with 42.")
} else {
    print("Starts with something else.")
}
// Prints "Starts with something else."

/*
 The generic where clause in the example above requires Item to conform to a 
 protocol, but you can also write a generic where clauses that require Item to
 be a specific type. For example:
 */
extension Container where Item == Double {
    func average() -> Double {
        var sum = 0.0
        for index in 0..<count {
            sum += self[index]
        }
        return sum /  Double(count)
    }
}
print([1260.0, 1200.0, 98.6, 37.0].average)
// Prints "648.9"

/*
 It explicitly converts the count from Int to Double to be able to do
 floating-point division.

 You can include multiple requirements in a generic where clause that is part
 of an extension, just like you can for a generic where clause that you write 
 elsewhere. Separate each requirement in the list with a comma.
 */

//
//  main.swift
//  Error_Handling
//
//  Created by Leo_Lei on 6/2/17.
//  Copyright © 2017 LibertyLeo. All rights reserved.
//

import Foundation

/*
 Error handling is the process of responding to and recovering from error 
 conditions in your program. Swift provides first-class support for throwing,
 catching, propagating, and manipulating recoverable errors at runtime.
 Some operations aren’t guaranteed to always complete execution or produce a 
 useful output. Optionals are used to represent the absence of a value, but
 when an operation fails, it’s often useful to understand what caused the 
 failure, so that your code can respond accordingly.
 */



//  MARK: Representing and Throwing Errors
/*
 In Swift, errors are represented by values of types that conform to the Error 
 protocol. This empty protocol indicates that a type can be used for error 
 handling.
 Swift enumerations are particularly well suited to modeling a group of related
 error conditions, with associated values allowing for additional information
 about the nature of an error to be communicated.
 For example, here’s how you might represent the error conditions of operating
 a vending machine inside a game:
 */
enum VendingMachineError: Error {
    case invalidSelection
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
}

/*
 Throwing an error lets you indicate that something unexpected happened and 
 the normal flow of execution can’t continue. You use a throw statement to 
 throw an error.
 */
//throw VendingMachineError.insufficientFunds(coinsNeeded: 5)



//  MARK: - Handling Errors
/*
 When an error is thrown, some surrounding piece of code must be responsible 
 for handling the error—for example, by correcting the problem, trying an
 alternative approach, or informing the user of the failure.
 There are four ways to handle errors in Swift. 
 You can:
    - Propagate the error from a function to the code that calls that function.
    - Handle the error using a do-catch statement.
    - Handle the error as an optional value.
    - Assert that the error will not occur.
 When a function throws an error, it changes the flow of your program, so it’s
 important that you can quickly identify places in your code that can throw 
 errors. To identify these places in your code, write the try keyword—or the 
 try? or try! variation—before a piece of code that calls a function, method, 
 or initializer that can throw an error.
 
 NOTE:
 Error handling in Swift resembles exception handling in other languages, with
 the use of the try, catch and throw keywords.
 */



//  MARK: Propagating Errors Using Throwing Functions
/*
 To indicate that a function, method, or initializer can throw an error, you
 write the throws keyword in the function’s declaration after its parameters. 
 If the function specifies a return type, you write the throws keyword before
 the return arrow (->).
 func canThrowErrors() throws -> String
 func cannotThrowErrors() -> String
 
 A throwing function propagates errors that are thrown inside of it to the 
 scope from which it’s called.
 
 NOTE:
 Only throwing functions can propagate errors. Any errors thrown inside a 
 nonthrowing function must be handled inside the function.
 */
struct Item {
    var price: Int
    var count: Int
}

class VendingMachine {
    var inventory = [
        "Candy Bar" : Item(price: 12, count: 7),
        "Chips": Item(price: 10, count: 4),
        "Pretzels": Item(price: 7, count: 11)
    ]
    var coinsDeposited = 0

    func vend(itemNamed name: String) throws {
        guard let item = inventory[name] else {
            throw VendingMachineError.invalidSelection
        }

        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }

        guard item.price <= coinsDeposited else {
            throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
        }

        coinsDeposited -= item.price

        var newItem = item
        newItem.count -= 1
        inventory[name] = newItem

        print("Dispensing \(name)")
    }
}
/*
 The implementation of the vend(itemNamed:) method uses guard statements to 
 exit the method early and throw appropriate errors if any of the requirements 
 for purchasing a snack aren’t met. Because a throw statement immediately
 transfers program control, an item will be vended only if all of these
 requirements are met.
 
 Because the vend(itemNamed:) method propagates any errors it throws, any code
 that calls this method must either handle the errors—using a do-catch 
 statement, try?, or try!—or continue to propagate them.
 */
let favoriteSnacks = [
    "Alice": "Chips",
    "Bob": "Licorice",
    "Eve": "Pretzels"
]
func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    try vendingMachine.vend(itemNamed: snackName)
}

/*
 Throwing initializers can propagate errors in the same way as throwing
 functions.
 */
struct PurchasedSnack {
    let name: String
    init(name: String, vendingMachine: VendingMachine) throws {
        try vendingMachine.vend(itemNamed: name)
        self.name = name
    }
}



//  MARK: Handling Errors Using Do-Catch
/*
 You use a do-catch statement to handle errors by running a block of code. 
 If an error is thrown by the code in the do clause, it is matched against the
 catch clauses to determine which one of them can handle the error.
 Here is the general form of a do-catch statement:
 do {
    try expression
    statements
 } catch pattern 1 {
    statements
 } catch pattern 2 where condition {
    statments
 }
 
 The catch clauses don’t have to handle every possible error that the code in 
 its do clause can throw. If none of the catch clauses handle the error, the
 error propagates to the surrounding scope.
 */
var vendingMachine = VendingMachine()
vendingMachine.coinsDeposited = 8
do {
    try buyFavoriteSnack(person: "Alice", vendingMachine: vendingMachine)
} catch VendingMachineError.invalidSelection {
    print("Invalid Selection")
} catch VendingMachineError.outOfStock {
    print("Out of Stock.")
} catch VendingMachineError.insufficientFunds(let coinsNeeded) {
    print("Insufficient funds. Please insert an additional \(coinsNeeded) ocins.")
}
// Prints "Insufficient funds. Please insert an additional 2 ocins."
/*
 If an error is thrown, execution immediately transfers to the catch clauses,
 which decide whether to allow propagation to continue. If no error is thrown, 
 the remaining statements in the do statement are executed.
 */



//  MARK: Converting Errors to Optional Values
/*
 You use try? to handle an error by converting it to an optional value. If an
 error is thrown while evaluating the try? expression, the value of the 
 expression is nil. For example, in the following code x and y have the same 
 value and behavior:
 func someThrowingFunction() throws -> Int {
    // ...
 }

 let x = try? someThrowingFunction()

 let y: Int?
 do {
    y = try someThrowingFunction()
 } catch {
    y = nil
 }
 */

/*
 If someThrowingFunction() throws an error, the value of x and y is nil. 
 Otherwise, the value of x and y is the value that the function returned.
 
 Using try? lets you write concise error handling code when you want to handle
 all errors in the same way. For example, the following code uses several 
 approaches to fetch data, or returns nil if all of the approaches fail.
 func fetchData() -> Data? {
    if let data = try? fetchDataFromDisk() { return data }
    if let data = try? fetchDataFromServer() { return data }
    return nil
 }
 */



//  MARK: Disabling Error Propagation
/*
 You can write try! before the expression to disable error propagation and wrap 
 the call in a runtime assertion that no error will be thrown. If an error
 actually is thrown, you’ll get a runtime error.
 let photo = try! loadImage(atPath: "./Resources/John Appleseed.jpg")
 */



//  MARK: Specifying Cleanup Actions
/*
 You use a defer statement to execute a set of statements just before code
 execution leaves the current block of code.
 A defer statement defers execution until the current scope is exited. This 
 statement consists of the defer keyword and the statements to be executed 
 later.
 func processFiled(filename: String) throws {
    if exists(filename) {
        let file = open(filename)
        defer {
            close(file)
        }
        while let line = try file.readLine() {
            // Work with the file
        }
        // cloase(file) is called here, at the end of the scope.
    }
 }
 
 NOTE:
 You can use a defer statement even when no error handling code is involved.
 */

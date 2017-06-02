//
//  main.swift
//  Error_Handling
//
//  Created by Leo_Lei on 6/2/17.
//  Copyright © 2017 LibertyLeo. All rights reserved.
//

import Foundation

/*
 “Error handling is the process of responding to and recovering from error conditions in your program. Swift provides first-class support for throwing, catching, propagating, and manipulating recoverable errors at runtime.”

 摘录来自: Apple Inc. “The Swift Programming Language (Swift 3.1)”。 iBooks.
 “Some operations aren’t guaranteed to always complete execution or produce a useful output. Optionals are used to represent the absence of a value, but when an operation fails, it’s often useful to understand what caused the failure, so that your code can respond accordingly.”

 摘录来自: Apple Inc. “The Swift Programming Language (Swift 3.1)”。 iBooks.
 */



//  MARK: Representing and Throwing Errors
/*
 “In Swift, errors are represented by values of types that conform to the Error protocol. This empty protocol indicates that a type can be used for error handling.”

 摘录来自: Apple Inc. “The Swift Programming Language (Swift 3.1)”。 iBooks.
 “Swift enumerations are particularly well suited to modeling a group of related error conditions, with associated values allowing for additional information about the nature of an error to be communicated.”

 摘录来自: Apple Inc. “The Swift Programming Language (Swift 3.1)”。 iBooks.
 “For example, here’s how you might represent the error conditions of operating a vending machine inside a game:”

 摘录来自: Apple Inc. “The Swift Programming Language (Swift 3.1)”。 iBooks.
 */
enum VendingMachineError: Error {
    case invalidSelection
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
}

/*
 “Throwing an error lets you indicate that something unexpected happened and the normal flow of execution can’t continue. You use a throw statement to throw an error.”

 摘录来自: Apple Inc. “The Swift Programming Language (Swift 3.1)”。 iBooks.
 */
//throw VendingMachineError.insufficientFunds(coinsNeeded: 5)



//  MARK: - Handling Errors
/*
 “When an error is thrown, some surrounding piece of code must be responsible for handling the error—for example, by correcting the problem, trying an alternative approach, or informing the user of the failure.”

 摘录来自: Apple Inc. “The Swift Programming Language (Swift 3.1)”。 iBooks.
 “There are four ways to handle errors in Swift. 
 You can:
    - Propagate the error from a function to the code that calls that function.
    - Handle the error using a do-catch statement.
    - Handle the error as an optional value.
    - Assert that the error will not occur.”

 摘录来自: Apple Inc. “The Swift Programming Language (Swift 3.1)”。 iBooks.
 “When a function throws an error, it changes the flow of your program, so it’s important that you can quickly identify places in your code that can throw errors. To identify these places in your code, write the try keyword—or the try? or try! variation—before a piece of code that calls a function, method, or initializer that can throw an error.”

 摘录来自: Apple Inc. “The Swift Programming Language (Swift 3.1)”。 iBooks.
 
 NOTE:
 “Error handling in Swift resembles exception handling in other languages, with the use of the try, catch and throw keywords.”

 摘录来自: Apple Inc. “The Swift Programming Language (Swift 3.1)”。 iBooks.
 */



//  MARK: Propagating Errors Using Throwing Functions
/*
 “To indicate that a function, method, or initializer can throw an error, you write the throws keyword in the function’s declaration after its parameters. If the function specifies a return type, you write the throws keyword before the return arrow (->).”

 摘录来自: Apple Inc. “The Swift Programming Language (Swift 3.1)”。 iBooks.
 ///    func canThrowErrors() throws -> String
 ///    func cannotThrowErrors() -> String
 
 “A throwing function propagates errors that are thrown inside of it to the scope from which it’s called.”

 摘录来自: Apple Inc. “The Swift Programming Language (Swift 3.1)”。 iBooks.
 
 NOTE:
 “Only throwing functions can propagate errors. Any errors thrown inside a nonthrowing function must be handled inside the function.”

 摘录来自: Apple Inc. “The Swift Programming Language (Swift 3.1)”。 iBooks.
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
 “The implementation of the vend(itemNamed:) method uses guard statements to exit the method early and throw appropriate errors if any of the requirements for purchasing a snack aren’t met. Because a throw statement immediately transfers program control, an item will be vended only if all of these requirements are met.”

 摘录来自: Apple Inc. “The Swift Programming Language (Swift 3.1)”。 iBooks.
 
 “Because the vend(itemNamed:) method propagates any errors it throws, any code that calls this method must either handle the errors—using a do-catch statement, try?, or try!—or continue to propagate them.”

 摘录来自: Apple Inc. “The Swift Programming Language (Swift 3.1)”。 iBooks.
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
 “Throwing initializers can propagate errors in the same way as throwing functions.”

 摘录来自: Apple Inc. “The Swift Programming Language (Swift 3.1)”。 iBooks.
 */
struct PurchasedSnack {
    let name: String
    init(name: String, vendingMachine: VendingMachine) throws {
        try vendingMachine.vend(itemNamed: name)
        self.name = name
    }
}

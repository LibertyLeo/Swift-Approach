//
//  main.swift
//  Swift_Error_Handling
//
//  Created by Leo_Lei on 5/10/17.
//  Copyright © 2017 LibertyLeo. All rights reserved.
//

import Foundation

//  You represent errors using any type that adopts the Error protocol
enum PrinterError: Error {
    case outOfPaper
    case noToner
    case onFire
}

/* 
 Use throw to throw an error and throws to mark a function that can throw an 
 error. If you throw an error in a function, the function returns immediately
 and the code that called the function hadnles the error.
 */

func send(job: Int, toPrinter printerName: String) throws -> String {
    if printerName == "Never Has Toner" {
        throw PrinterError.noToner
    }
    return "Job sent"
}

/*
 There are several ways to handle errors. One way is to use do-catch. Inside the
 do block, you mark code that can thro an error by writing try in front of it.
 Inside the catch block, the error is automatically given the name error unless
 you give it a different name.
 */
do {
    let printerResponse = try send(job: 1040, toPrinter: "Bi Sheng")
    /*
     Change the printer name to "Never Has Toner", so that the
     send(job:toPrinter:)function throws an error.  (Exp)
     */
//    let printerResponse = try send(job: 1000, toPrinter: "Never Has Toner")
    print(printerResponse)
} catch {
    print(error)
}

/*
 You can provide multiple catch blocks that handle specific errors. You write
 a pattern after catch just as you do after case in a switch.
 */
do {
    let printerResponse = try send(job: 1440, toPrinter: "Gutenberg")
    /*
     Add code to trow an error inside the do block. What kind of error do you need
     to throws so that the error is handled by the first catch block? What about
     the second and third block?    (Exp)
     By throw specified error to let the catch block catch it.
     */
    print(printerResponse)
//    throw PrinterError.onFire
//    throw PrinterError.noToner
    enum noError: Error {
        case otherError
    }
    throw noError.otherError
} catch PrinterError.onFire {
    print("I'll just put this over here, with the rest of the fire.")
} catch let printerError as PrinterError {
    print("Printer error: \(printerError)")
} catch {
    print(error)
}

/*
 Another way to handle errors is to use try? to convert the result to an optional.
 If the function throws an error, the specific error is discarded and the result
 is nil. Otherwise, the result is an optional containg the value that the 
 function returned.
 */
let printerSuccess = try? send(job: 1884, toPrinter: "Mergenthaler")
let printerFailure = try? send(job: 1885, toPrinter: "Never Has Toner")
print(printerSuccess ?? "Error of success")
print(printerFailure ?? "Error of failure")


/*
 Use defer to write a block of code that is executed after all other code in the 
 function, just before the function returns. The code is executed regardless of 
 whether the function throws an error.
 */
var fridgeIsOpen = false
let fridgeContent = ["milk", "eggs", "leftovers"]

func fridgeContains(_ food: String) -> Bool {
    fridgeIsOpen = true
    defer {
        /*
         Since you put the food into fridge, the fridge should be open,
         after you finish placing, you should close the fridge, defer is
         just the action that you did after putting the food.
         */
        fridgeIsOpen = false
    }
    
    let result = fridgeContent.contains(food)
    return result
}

print(fridgeContains("banana"))
print(fridgeIsOpen)

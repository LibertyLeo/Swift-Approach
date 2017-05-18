//
//  main.swift
//  Swift_Control_Transfer_Statements
//
//  Created by Leo_Lei on 5/18/17.
//  Copyright © 2017 LibertyLeo. All rights reserved.
//

import Foundation

//  MARK: Control Transfer Statement
/*
 Control transfer statements change the order in which your code is executed,
 by transferring control from one piece of code to another.
 Swift has five control transfer statements:
    - continue
    - break
    - fallthrough
    - return
    - throw

 The continue, break and fallthrough statements are described below.
 The return statement is described in Function, and the throw statement is 
 described in Propagating Errors Using Throwing Functions.
 */



//  MARK: - Continue
/*
 The 'continue' statement tells a loop to stop what it is doing and start again
 at the beginning of the next iteration through the loop.
 It says "I am done with the current loop iteration" without leaving the loop
 together.
 */
let puzzleInput = "great minds think alike"
var puzzleOutput = ""
let charactersToRemove: [Character] = ["a", "e", "i", "o", "u", " "]
for character in puzzleInput.characters {
    if charactersToRemove.contains(character) {
        continue
    } else {
        puzzleOutput.append(character)
    }
}
print(puzzleOutput)
//  Prints "grtmndsthnklk"
/*
 The code above calls the 'continue' keyword whenever it matches a vowel or a 
 space, causing the current iteration of the llop to end immediately and to jump
 straight to the start of the next iteration.
 */



//  MARK: Break
/*
 The 'break' statement ends execution of an entire control flow statement
 immediately.
 
    Break in a Loop Statement:
    When used inside a loop statement, 'break' ends the loop's execution
 immediately and transfers control to the code after the loop's closing brace(}).
    No further code from the current iteration of the loop is executed, and no
 further iterations of the loop are started.
 
    Break in a Switch statement:
    When used inside a switch statement, 'break' casuse the 'switch' statement
 to ends its execution immediately and to transfer control to the code
 after 'switch' statement's closing brace (}).
    You do this by writting the 'break' statement as the entire body of the case
 you want to ignore.

 NOTE:
 A 'switch' case that contains only a comment is reported as compile-time error.
 Comments are not statement and do not cause a 'switch' case to be ignored.
 Always use a 'break' statemtn to ignore a 'switch' case.
 */
let numberSymbol: Character = "三"   //  Chinese symbol for the number 3
var possibleIntegerValue: Int?
switch numberSymbol {
case "1", "١", "一", "๑":
    possibleIntegerValue = 1
case "2", "٢", "二", "๒":
    possibleIntegerValue = 2
case "3", "٣", "三", "๓":
    possibleIntegerValue = 3
case "4", "٤", "四", "๔":
    possibleIntegerValue = 4
default:
    break
}
if let integerValue = possibleIntegerValue {
    print("The integer value of \(numberSymbol) is \(integerValue).")
} else {
    print("An integer value could not found for \(numberSymbol).")
}
// Prints "The integer value of 三 is 3."
/*
 This example checks 'numberSymbol' to determine whether it is a Latin, Arabic,
 Chinese, or Thai symbol for the numbers 1 to 4.
 */



//  MARK: Fallthrough
/*
 In Swift, 'switch' statements don't fall through the bottom of each case and
 into the next one.
 Avoiding default fallthrough means that Swift 'switch' statements are much more
 concise and predictable than their counterparts in C, and thus they avoid 
 executing multiple 'switch' cases by mistak.
 If you need C-style fallthrough behavior, you can opt in to this behavior on 
 a case-by-case basis with the 'fallthrough' keyword.
 */
let integerToDescribe = 5
var description = "The number \(integerToDescribe) is"
switch integerToDescribe {
case 2, 3, 5, 7, 11, 13, 17, 19:
    description += " a prime number, and also"
    fallthrough
default:
    description += " an integer."
}
print(description)
// Prints "The number 5 is a prime number, and also an integer."
/*
 NOTE:
 The 'fallthrough' keyword does not check the case conditions for the 'switch'
 case that it causes execution to fall into. The 'fallthrough' keyword simply
 causes code execution to move directly to the statements inside the next case
 (or 'default' case) block, as in C's standard 'switch' statement behavior.
 */



//  MARK: Labeled Statements
/*
 In Swift, you can nest loops and conditional statements inside other loops and
 conditional statements to create complex control flow structures. However, loops 
 and conditional statements can both use the 'break' statement to end their 
 execution prematurely.
 To achieve these aims, you can mark a loop statement or conditional statement 
 with a statement label.
 
 A labeled statement is indicated by placing a label on the same line as the 
 statement's introducer keyword, followed by a colon.
 ///    <#label name#>: while <#condition#> {
 ///    <#statements#>
 ///    }
 
 The following example uses the 'break' and 'continue' statements with a labels
 'while' loop for an adapted version of the Snakes and Ladders game. This time
 around, the game has an extra rule:
    To win, you must land exactly on square 25.

 If a particular dice roll would take you beyond square 25, you must roll again
 until you roll the exact number needed to land on square 25.
 */
let finalSquare = 25
var board = [Int](repeating: 0, count: finalSquare + 1)
board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
var square = 0
var diceRoll = 0

/*
 The 'while' loop has a statement label called 'gameLoop' to indicate that it is
 the main game loop for the Snakes and Ladders game.
 */
gameLoop: while square != finalSquare {
    diceRoll += 1
    if diceRoll == 7 { diceRoll = 1 }
    switch square + diceRoll {
    case finalSquare:
        //  diceRoll will move us to the final square, so the game is over
        break gameLoop
    case let newSquare where newSquare > finalSquare:
        // diceRoll will move us beyond the final square, so roll again
        continue gameLoop
    default:
        // this is a valid move, so find out its effect
        square += diceRoll
        square += board[square]
    }
}
print("Game over!")
/*
 If the dice roll will move the player onto the final square, the game is over.
 The 'break gameLoop' statement transfers control to the first line of code
 outside of the 'while' loop, which ends the game.
 
 If the dice roll will move the player beyond the final square, the move is 
 invalid and the player need to roll again. The continue gameLoop statement ends
 the current 'while' loop iteration and begins the next iteration of the loop.
 
 In all other cases, the dice roll is a valid move. The player moves forward by
 'diceRoll' squares, and the game logic checks for any snakes and ladders. The
 loop the ends, and control return to the 'while' condition to decide whether
 another turn is required.
 
 NOTE:
 If the 'break' statement above did not use the 'gameLoop' label, it would break
 out of the 'switch' statement, not the 'while' statement. Using the 'gameLoop' 
 label makes it clear which control statement should be terminated.
 */



//  MARK: Early Exit
/*
 A 'guard' statement, like an 'if' statement, executes statements depending on 
 the Boolean value of an expression.
 You use a 'guard' statement to require that a condition must be true in order
 for the code after the 'guard' statement to be executed.
 Unlike an 'if' statement, a 'guard' statement always has an 'else' clauses--the
 code inside the 'else' clauses is executed if the condition is not true.
 */
func greet(person: [String: String]) {
    guard let name = person["name"] else {
        return
    }

    print("Hello \(name)!")

    guard let location = person["location"] else {
        print("I hope the weather is nice near you.")
        return
    }

    print("I hope the weather is nice in \(location).")
}

greet(person: ["name": "John"])
//  Prints "Hello John!"
//  Prints "I hope the weather is nice near you."
greet(person: ["name": "Jane", "location": "Cupertino"])
//  Prints "Hello Jane!"
//  Prints "I hope the weather is nice in Cupertino."

/*
 If the 'guard' statement's condition is met, code execution continues after the
 'guard' statement's closing brace.

 If that condition is not met, the code inside the 'else' branch is executed.
 That branch must transfer control to exit the code block in which the 'guard'
 statement appears. It can do this with a control transfer statement such as
 'return', 'break', 'continue', or 'throw', or it can call a function or method
 that doesn't return, such as 'fatalError(_:file:line:)'.
 
 Using a 'guard' statement for requirements improves the readability of your
 code, compared to doing the same check with an 'if' statement.
 It lets you write the code that's typically executed without wrapping it in an
 'else' block, and it lets you keep the code that handles a violated requirement
 next to the requirement.
 */


//  MARK: Checking API Availability
/*
 Swift has built-in support for checking API availability, which ensures that you
 don't accidentally use APIs that are unavailable on a give deployment targer.
 Swift reports an error at compile time if you try to use an API that isn't
 available.
 
 You use an availability conditon in an 'if' or 'guard' statement to conditionally
 execute a block of code, depending on whether the APIs you want to use are 
 available at runtime.
 */
if #available(iOS 10, macOS 10.12, *) {
    //  Use iOS 10 APIs on iOS, and use macOS 10.12 APIs on macOS
} else {
    //  Fall back to earlier iOS and macOS APIs
}

/*
 The availability condition above specifies that in iOS, the body of the 'if'
 statement executes only in iOS 10 and later; in macOS, only in macOS 10.12 and
 later.
 The last argument '*', is required and specifies that on any other platform, the
 body of the if executes on the minimum deployment target specified by your target.
 
 In its general form, the availability condition takes a list of platform names
 and version.
 In addition to specifying major version numbers like iOS 8 or macOS 10.10, you 
 can specifiy minor versions numbers like iOS 8.3 and macOS 10.10.3.

 ///    if #available(<#platform name#> <#version#>, <#...#>, *) {
 ///    <#statements to execute if the APIs are available#>
 ///    } else {
 ///    <#fallback statements to execute if the APIs are unavailable#>
 ///    }
 */

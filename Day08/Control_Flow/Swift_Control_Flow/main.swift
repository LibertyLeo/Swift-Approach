//
//  main.swift
//  Swift_Control_Flow
//
//  Created by Leo_Lei on 5/17/17.
//  Copyright © 2017 LibertyLeo. All rights reserved.
//

import Foundation

//  MARK: For-In Loops
/*
 You use the for-in loop to iterate over a sequence, such as items in an array,
 ranges of numbers, or characters in a string.
 */
let names = ["Anna", "Alex", "Brian", "Jack"]
for name in names {
    print("Hello, \(name)!")
}
//  Hello, Anna!
//  Hello, Alex!
//  Hello, Brian!
//  Hello, Jack!

/*
 You can also literate over a dictionary to access its key-value pairs.
 Each item in the dictionary is returned as a (key, value) tuple when the 
 dictionary is iterated, and you can decompose the (key, value) tuple's members
 as explicitly named constants for use within the body of the for-in loop.
 */
let numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
for (animalName, legCount) in numberOfLegs {
    print("\(animalName)s have \(legCount) legs")
}
//  ants have 6 legs
//  spiders have 8 legs
//  cats have 4 legs

/*
 The contents of a Dictionary are inherently unordered, and iterating over them
 does not guarantee the order in which they will be retrieved. In particular,
 the order you insert items into a Dictionary doesn't define the order they are
 iterated.
 */

/*
 for-in loops also wok with numeric ranges.
 */
for index in 1...5 {
    print("\(index) times 5 is \(index * 5)")
}
//  1 times 5 is 5
//  2 times 5 is 10
//  3 times 5 is 15
//  4 times 5 is 20
//  5 times 5 is 25

/*
 If you don't need each value from a sequence, you can ignore the values by
 using an underscore in place of a variable name.
 */
let base = 3
let power = 10
var answer = 1
for _ in 1...power {
    answer *= base
}
print("\(base) to the power of \(power) is \(answer)")
//  Prints "3 to the power of 10 is 59049"

/*
 In some situations, you might not want to use closed ranges, which include both
 endpoints.
 Use the half-open range operator (..<) to include the lower bound but not the
 upper bound.
 */
let minutes = 60
for tickMark in 0..<minutes {
    //  render the tick mark each minute (60 times)
}

/*
 Some users might want fewer tick marks in their UI.
 They could prefer one mark ever 5 minutes instead. Use the 'stride(from:to:by:)'
 function to skip the unwanted marks.
 */
let minuteInterval = 5
for tickMark in stride(from: 0, to: minutes, by: minuteInterval) {
    //  render the tick mark every 5 minutes (0, 5, 10, 15 ... 45, 50, 55)
}

/*
 Closed ranges are also available, by using 'stride(from:through:by:)' instead
 */
let hours = 12
let hourInterval = 3
for tickMark in stride(from: 3, through: hours, by: hourInterval) {
    //  render the tick mark every 3 hours (3, 6, 9, 12)
}



//  MARK: - While Loops
/*
 A 'while' loop performs a set of statements until a conditon becomes false.
 These kinds of loops are best used when the number of iteration is not known 
 before the first iteration begins.
 Swift provides two kind of while loops:
    'while' evaluates its condition at the start of each pass through the loop.
    'repeat-while' evaluates its condition at the end of each pass through the loop.
 */

//  MARK: While
/*
 A 'while' loop starts by evaluating a single condition. If the condition is 
 true, a set of statement is repeated until the condition become false.

 Take a simple games of Snakes and Ladders as a example.
 The rules of the game are as follows:
    The board has 25 squares, and the aim is to land on or beyond square 25.
    The player's starting square is "square zero", which is just off the 
 bottom-left corner of the board.
    Each turn, you roll a six-sided dice and move by that number of squares,
 following the horizontal path indicated by the dotted arrow above.
    If you turn ends at the bottom of a ladder, you move up that ladder.
    If you turn ends at the head of snake, you move down that snake.
 
 The game board is represented by an array of Int values.
 Because the player start off the board, on "square zero", the board is 
 intialized with 26 zero Int values, not 25
 */
let finalSquare = 25
var board = [Int](repeating: 0, count: finalSquare + 1)

/*
 Some squares are then set to have more specific values for the snakes and 
 ladders.
 Squares with a ladder base have a positive number to move you up the board,
 whereas squares with a snake head have a negative number to move you back down
 the road.
 */
board[03] = +08; board[06] = +11; board[09] = +9; board[10] = +02
board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08

var square = 0
var diceRoll = 0
while square < finalSquare {
    //  roll the dice
    diceRoll += 1
    if diceRoll == 7 { diceRoll = 1 }
    //  move by the rolled amount
    square += diceRoll
    if square < board.count {
        //  if we're still on the board, move up or down for a snake or a ladder
        square += board[square]
    }
}
print("Game over!")

/*
 The example above uses a very simple approach to dice rolling. Instead of 
 generating a random number, it starts with a 'diceRoll' value of 0.
 Each time through the while loop, 'diceRoll' is incremented by one and is then
 checked to see whether it has become too large.
 Whenever this return value equals 7, the dice roll has become too large and is 
 reset to a value of 1. 
 The result is a sequence of 'diceRoll' values that is always 1, 2, 3, 4, 5, 6,
 1, 2 and so on.
 After rolling the dice, the player moves forward by 'diceRoll' squares. 
 It's possible that the dice roll may have moved the player beyond square 25, 
 in which case the game is over. To cope with this scenario, the codee checks 
 that 'square' is less than the 'board' array's count property.
 If 'square' is valid, the value stored in 'board[square]' is added to the 
 current 'square' value to move the player up or down any ladders or snakes.
 */

/*
 NOTE:
 If this check is not performed, 'board[square]' might try to access a value
 outside the bounds of the 'board' array, which would trigger a runtime error.
 */



//  MARK: Repeat-While
/*
 The other variation of the 'while' loop, known as the repeat-while loop, 
 performs a single pass through the loop block first, before considering the
 loop's condition.
 
 Here's the Snakes and Ladders example again.
 In this version of the game, the first action in the loop is to check for a
 ladder or a snake.
 No ladder on the board takes the player straight to square 25, and so it isn't
 possible to win the game by moving up a ladder. Therefore, it's safe to check
 for a snake or a ladder as the first action in the loop.
 */
let finalSquareRepeat = 25
var boardRepeat = [Int](repeating: 0, count: finalSquareRepeat + 1)
board[03] = +08; board[06] = +11; board[09] = +9; board[10] = +02
board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
var squareRepeat = 0
var diceRollRepeat = 0

repeat {
    //  move up or down for a snake or ladder
    squareRepeat += boardRepeat[squareRepeat]
    //  roll the dice
    diceRollRepeat += 1
    if diceRollRepeat == 7 { diceRollRepeat = 1 }
    //  move by the rolled amount
    squareRepeat += diceRollRepeat
} while squareRepeat < finalSquareRepeat
print("Game over!")

/*
 In the 'repeat-while' loop above, 'square += board[square]' is always executed
 immediately after the loop's 'while' condition confirms that 'square' is still
 on the board.
 This behavior removes the need for the array bounds check seen in the 'while'
 loop version of the game described earlier.
 */

//
//  main.swift
//  Deinitialization
//
//  Created by Leo_Lei on 6/1/17.
//  Copyright © 2017 LibertyLeo. All rights reserved.
//

import Foundation

/*
 A deinitializer is called immediately before a class instance is deallocated.
 You write deinitializers with the deinit keyword, similar to how initializers 
 are written with the init keyword. Deinitializers are only available on class
 types.
 */



//  MARK: How Deinitialization Works
/*
 Swift automatically deallocates your instances when they are no longer needed, 
 to free up resources.
 For example, if you create a custom class to open a file and write some data 
 to it, you might need to close the file before the class instance is 
 deallocated.
 Class definitions can have at most one deinitializer per class. The 
 deinitializer does not take any parameters and is written without parentheses:
 ///    deinit {
 ///    // perform the deinitialization
 ///    }
 
 You are not allowed to call a deinitializer yourself. Superclass 
 deinitializers are inherited by their subclasses, and the superclass 
 deinitializer is called automatically at the end of a subclass deinitializer
 implementation. Superclass deinitializers are always called, even if a
 subclass does not provide its own deinitializer.
 */



//  MARK: Deinitializers in Action
/*
 This example defines two new types, Bank and Player, for a simple game. The
 Bank class manages a made-up currency, which can never have more than 10,000 
 coins in circulation. There can only ever be one Bank in the game, and so the
 Bank is implemented as a class with type properties and methods to store and
 manage its current state:
 */
class Bank {
    static var coinsInBank = 10_000
    static func distribute(coins numberOfCoinsRequested: Int) -> Int {
        let numberOfCoinsToVend = min(numberOfCoinsRequested, coinsInBank)
        coinsInBank -= numberOfCoinsToVend
        return numberOfCoinsToVend
    }

    static func receive(coins: Int) {
        coinsInBank += coins
    }
}

/*
 The Player class describes a player in the game. Each player has a certain 
 number of coins stored in their purse at any time. This is represented by the 
 player’s coinsInPurse property:
 */
class Player {
    var coinsInPurse: Int
    init(coins: Int) {
        coinsInPurse = Bank.distribute(coins: coins)
    }

    func win(coins: Int) {
        coinsInPurse += Bank.distribute(coins: coins)
    }

    deinit {
        Bank.receive(coins: coinsInPurse)
    }
}

/*
 Here, the deinitializer simply returns all of the player's coins to the bank
 */
var playerOne: Player? = Player(coins: 100)
print("A new player has joined the game with \(playerOne!.coinsInPurse) coins")
// Prints "A new player has joined the game with 100 coins"
print("There are now \(Bank.coinsInBank) coins left in the bank")
// Prints "There are now 9900 coins left in the bank"

/*
 Because playerOne is an optional, it is qualified with an exclamation mark (!)
 when its coinsInPurse property is accessed to print its default number of 
 coins, and whenever its win(coins:) method is called:
 */
playerOne!.win(coins: 2_000)
print("Player won 2000 coins & now has \(playerOne!.coinsInPurse) coins")
// Prints "Player won 2000 coins & now has 2100 coins"
print("The bank now only has \(Bank.coinsInBank) coins left")
// Prints "The bank now only has 7900 coins left"

/*
 The player has now left the game. This is indicated by setting the optional
 playerOne variable to nil, meaning no Player instance. No other properties or 
 variables are still referring to the Player instance, and so it is deallocated
 in order to free up its memory. Just before this happens, its deinitializer is 
 called automatically, and its coins are returned to the bank.
 */
playerOne = nil
print("PlayerOne has left the game")
// Prints "PlayerOne has left the game"
print("The bank now has \(Bank.coinsInBank) coins")
// Prints "The bank now has 10000 coins"

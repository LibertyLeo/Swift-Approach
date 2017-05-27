//
//  main.swift
//  Swift_Enumeration_and_Structure
//
//  Created by Leo_Lei on 5/9/17.
//  Copyright © 2017 LibertyLeo. All rights reserved.
//

import Foundation

//  MARK: Enumeration
/*
 Use enum to create an enumeration. Like classes and all other named types,
 enumertaions can have methods associated with them.
 */
enum Rank: Int {
    case ace = 1
    case two, three, four, five, six, seven, eight, nine, ten
    case jack, queen, king
    func simpleDescription() -> String {
        switch self {
        case .ace:
            return "ace"
        case .jack:
            return "jack"
        case .queen:
            return "queen"
        case .king:
            return "king"
        default:
            return String(self.rawValue)
        }
    }
}

let ace = Rank.ace
let aceRawValue = ace.rawValue;
print("The first rank is \(ace), and its raw value is \(aceRawValue).")

/*
 Write a function that compares two Rank values by comparing their raw 
 values.  (Exp)
 */
enum RankExp: Int {
    case ace = 1
    case two, three, four, five, six, seven, eight, nine, ten
    case jack, queen, king
    func simpleDescription() -> String {
        switch self {
        case .ace:
            return "ace"
        case .jack:
            return "jack"
        case .queen:
            return "queen"
        case .king:
            return "king"
        default:
            return String(self.rawValue)
        }
    }
    
    func compare(param: RankExp) -> String {
        if self.rawValue > param.rawValue {
            return "\(self)'s rank is lower than \(param)."
        } else if self.rawValue == param.rawValue {
            return "\(self)'s rank is equal to \(param)."
        } else {
            return "\(self)'s rank is higher than \(param)."
        }
    }
}

let paramA = RankExp.ace
let paramB = RankExp.queen
print(paramA.compare(param: paramB))

/*
 Use the init?(rawValue:) intializer to make an instance of an enumeration
 from a raw value. It returns either the enumeration case matching the raw
 value or nil if there is no matching Rank.
 */
if let convertedRank = Rank(rawValue: 3) {
    let threeDescription = convertedRank.simpleDescription()
    print("Raw value begins at \(threeDescription).")
}

//  In case where there isn't a meaningful raw value, you don't have to provide one.
enum Suit {
    case spades, hearts, diamonds, clubs
    func simpleDescription() -> String {
        switch self {
        case .spades:
            return "spades"
        case .hearts:
            return "hearts"
        case .diamonds:
            return "diamonds"
        case .clubs:
            return "clubs"
        }
    }
}

let hearts = Suit.hearts
let heartsDescription = hearts.simpleDescription()

/*
 Add a color() method to Suit that returns "black" for spades and clubs, and
 returns "red" for hearts and diamonds. (Exp)
 */
enum SuitExp {
    case spades, hearts, diamonds, clubs
    func simpleDescription() -> String {
        switch self {
        case .spades:
            return "spades"
        case .hearts:
            return "hearts"
        case .diamonds:
            return "diamonds"
        case .clubs:
            return "clubs"
        }
    }
    
    func color() -> String {
        switch self {
        case .spades, .clubs:
            return "black"
        case .hearts, .diamonds:
            return "red"
        }
    }
}

let heartsExp = SuitExp.hearts
let heartsExpDescription = heartsExp.simpleDescription()
let heartsColor = heartsExp.color()
print("Hearts description is \(heartsExpDescription) and its color is \(heartsColor).")

/*
 Consider the case of requesting the sunrise and sunset times from a server.
 The server either responds with the requested information, or it responds with
 a description of what went wrong.
 */
enum ServerResponse {
    case result(String, String)
    case failure(String)
}

let success = ServerResponse.result("6:00 am", "8:09 pm")
let failure = ServerResponse.failure("Out of cheese.")

switch success {
case let .result(sunrise, sunset):
    print("Sunrise is at \(sunrise) and sunset is at \(sunset).")
case let .failure(message):
    print("Failure... \(message)")
}

//  Add a third case to ServerResponse and to the switch.   (Exp)
enum ServerResponseExp {
    case result(String, String)
    case failure(String)
    case noresponse(String)
}

let successExp = ServerResponseExp.result("6:00 am", "8:09 pm")
let failureExp = ServerResponseExp.failure("Out of cheese.")
let noresponseExp = ServerResponseExp.noresponse("Server is dead.")

switch successExp {
case let .result(sunrise, sunset):
    print("Sunrise is at \(sunrise) and sunset is at \(sunset).")
case let .failure(message):
    print("Failure... \(message)")
case let .noresponse(message):
    print("Oops, \(message)")
}



//  MARK: Structure
/*
 Use struct to create a structure. Structures support many of the same
 behavior as classes, including methods and initalizers. One of the most
 important differences between structures and classes is that structures
 are always copied when they are passed around in your code, but classes
 are passed by reference.
 */
struct Card {
    var rank: Rank
    var suit: Suit
    func simpleDescription() -> String {
        return "The \(rank.simpleDescription()) of \(suit.simpleDescription())"
    }
}

let threeOfSpades = Card(rank: .three, suit: .spades)
let threeOfSpadesDescription = threeOfSpades.simpleDescription()
print("The three of spades describes as \(threeOfSpadesDescription).")

/*
 Add a method to Card that creates a full deck of cards, with one card of each 
 combination of rank and suit. (Exp)
 */
struct CardExp {
    var rank: Rank
    var suit: Suit
    
    func simpleDescription() -> String {
        return "The \(rank.simpleDescription()) of \(suit.simpleDescription())"
    }
    
    func wholeDeckDescription() -> [String] {
        var allSuits = [Suit.spades, Suit.hearts, Suit.diamonds, Suit.clubs]
        var cards = [String]()
        for suitIndex in 0..<4 {
            let suit = allSuits[suitIndex]
            for rankIndex in 1...13 {
                let rank = Rank(rawValue: rankIndex)
                let card = "The \(rank!.simpleDescription()) of \(suit.simpleDescription())"
                cards.append(card)
            }
        }
        return cards
    }
}

let testCard = CardExp(rank: .ace, suit: .spades)
print(testCard.wholeDeckDescription())

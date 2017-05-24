//
//  main.swift
//  Swift_Methods
//
//  Created by Leo_Lei on 5/24/17.
//  Copyright © 2017 LibertyLeo. All rights reserved.
//

import Foundation

//  MARK: Methods
/*
 Methods are functions that are associated with a particular type. Classes,
 structures, and enumerations can all define instance methods, which 
 encapsulate specific tasks and functionality for working with an instance of 
 a given type.

 The fact that structures and enumerations can define methods in Swift is a 
 major difference from C and Objective-C.
 */



//  MARK: - Instance Methods
/*
 Instance methods are functions that belong to instances of a particular class,
 structure, or enumeration.
 An instance method has implicit access to all other instance methods and 
 properties of that type. 
 An instance method can be called only on a specific instance of the type it 
 belongs to. 
 It cannot be called in isolation without an existing instance.
 */
class Counter {
    var count = 0
    func increment() {
        count += 1
    }
    func increment(by amount: Int) {
        count += amount
    }
    func reset() {
        count = 0
    }
}

/*
 The Counter class defines three instance methods:

    - increment() increments the counter by 1.
    - increment(by: Int) increments the counter by a specified integer amount.
    - reset() resets the counter to zero.
 */
let counter = Counter()
//  the initial counter value is 0
counter.increment()
//  the counter's value is now 1
counter.increment(by: 5)
//  the counter's value is now 6
counter.reset()
//  the counter's value is now 0

/*
 Function parameters can have both a name and an argument label.
 The same is true for method parameters, because methods are just functions 
 that are associated with a type.
 */



//  MARK: The self Property
/*
 Every instance of a type has an implicit property called self, which is 
 exactly equivalent to the instance itself.

 In practice, you don’t need to write self in your code very often.
 If you don’t explicitly write self, Swift assumes that you are referring to a 
 property or method of the current instance whenever you use a known property 
 or method name within a method.
 
 The main exception to this rule occurs when a parameter name for an instance 
 method has the same name as a property of that instance.
 */
struct Point {
    var x = 0.0, y = 0.0
    func isToTheRightOf(x: Double) -> Bool {
        return self.x > x
    }
}
let somePoint = Point(x: 4.0, y: 5.0)
if somePoint.isToTheRightOf(x: 1.0) {
    print("This point is to the right of the line where x == 1.0")
}
//  Prints "This point is to the right of the line where x == 1.0"
/*
 Without the self prefix, Swift would assume that both uses of x referred to
 the method parameter called x.
 */



//  MARK: Modifying Value Types from Within Instance Methods
/*
 Structures and enumerations are value types. By default, the properties of a 
 value type cannot be modified from within its instance methods.
 However, if you need to modify the properties of your structure or enumeration
 within a particular method, you can opt in to mutating behavior for that 
 method.
 You can opt in to this behavior by placing the mutating keyword before the 
 func keyword for that method.
 */
struct PointMutate {
    var x = 0.0, y = 0.0
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
}
var somePointMutate = PointMutate(x: 1.0, y: 1.0)
somePointMutate.moveBy(x: 2.0, y: 3.0)
print("The point is now at (\(somePointMutate.x), \(somePointMutate.y))")
//  Prints "The point is now at (3.0, 4.0)

/*
 Note that you cannot call a mutating method on a constant of structure type,
 because its properties cannot be changed, even if they are variable properties.
 */
let fixedPoint = PointMutate(x: 3.0, y: 3.0)
//fixedPoint.moveBy(x: 2.0, y: 3.0)  
//  this will report an error



//  MARK: Assigning to self Within a Mutating Method
/*
 Mutating methods can assign an entirely new instance to the implicit self 
 property.
 */
struct PointMutateSelf {
    var x = 0.0, y = 0.0
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        self = PointMutateSelf(x: x + deltaX, y: y + deltaY)
    }
}

/*
 Mutating methods for enumerations can set the implicit self parameter to be a 
 different case from the same enumeration.
 */
enum TriStateSwitch {
    case off, low, high
    mutating func next() {
        switch self {
        case .off:
            self = .low
        case .low:
            self = .high
        case .high:
            self = .off
        }
    }
}
var ovenLight = TriStateSwitch.low
ovenLight.next()
//  ovenLight is now equal to .high
ovenLight.next()
//  ovenLight is now equal to .off



//  MARK: - Type Methods
/*
 You can also define methods that are called on the type itself. These kinds of
 methods are called type methods. You indicate type methods by writing the 
 static keyword before the method’s func keyword.
 Classes may also use the class keyword to allow subclasses to override the 
 superclass’s implementation of that method.
 
 NOTE:
 In Objective-C, you can define type-level methods only for Objective-C classes.
 In Swift, you can define type-level methods for all classes, structures, and
 enumerations. Each type method is explicitly scoped to the type it supports.
 */

//  Type methods are called with dot syntax, like instance methods.
class SomeClass {
    class func someTypeMethod() {
        //  type method implementation goes here
    }
}
SomeClass.someTypeMethod()

/*
 Within the body of a type method, the implicit self property refers to the 
 type itself, rather than an instance of that type.
 A type method can call another type method with the other method’s name,
 without needing to prefix it with the type name.
 
 The example below defines a structure called LevelTracker, which tracks a
 player’s progress through the different levels or stages of a game.
 The LevelTracker structure uses type properties and methods to keep track of
 which levels of the game have been unlocked. It also tracks the current level 
 for an individual player.
 */
struct LevelTracker {
    static var highestUnlockedLevel = 1
    var currentLevel = 1

    static func unlock(_ level: Int) {
        if level > highestUnlockedLevel {
            highestUnlockedLevel = level
        }
    }

    static func isUnlocked(_ level: Int) -> Bool {
        return level <= highestUnlockedLevel
    }

    @discardableResult
    mutating func advance(to level: Int) -> Bool {
        if LevelTracker.isUnlocked(level) {
            currentLevel = level
            return true
        } else {
            return false
        }
    }
}

/*
 To help manage the currentLevel property, LevelTracker defines an instance 
 method called advance(to:). Before updating currentLevel, this method checks 
 whether the requested new level is already unlocked.
 Because it’s not necessarily a mistake for code that calls the advance(to:) 
 method to ignore the return value, this function is marked with the 
 @discardableResult attribute.

 The LevelTracker structure is used with the Player class, shown below, to 
 track and update the progress of an individual player.
 */
class Player {
    var tracker = LevelTracker()
    let playerName: String
    func complete(level: Int) {
        LevelTracker.unlock(level + 1)
        tracker.advance(to: level + 1)
    }

    init(name: String) {
        playerName = name
    }
}

/*
 You can create an instance of the Player class for a new player, and see what
 happens when the player completes level one.
 */
var player = Player(name: "Argrios")
player.complete(level: 1)
print("Highest unlocked level is now \(LevelTracker.highestUnlockedLevel)")
//  Prints "Highest unlocked level is now 2"

/*
 If you create a second player, whom you try to move to a level that is not yet 
 unlocked by any player in the game, the attempt to set the player’s current 
 level fails:
 */
player = Player(name: "Beto")
if player.tracker.advance(to: 6) {
    print("player is now on level 6")
} else {
    print("level 6 has not yet been unlocked")
}
//  Prints "level 6 has not yet been unlocked"

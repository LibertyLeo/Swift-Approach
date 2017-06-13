//
//  main.swift
//  Protocols
//
//  Created by Leo_Lei on 6/12/17.
//  Copyright © 2017 LibertyLeo. All rights reserved.
//

import Foundation

/*
 A protocol defines a blueprint of methods, properties, and other requirements 
 that suit a particular task or piece of functionality. The protocol can then
 be adopted by a class, structure, or enumeration to provide an actual 
 implementation of those requirements. Any type that satisfies the requirements 
 of a protocol is said to conform to that protocol.
 */



//  MARK: Protocol Syntax
/*
 You define protocols in a very similar way to classes, structures, and 
 enumerations:

 ///    protocol SomeProtocol {
 ///        // protocol definition goes here
 ///    }
 
 Custom types state that they adopt a particular protocol by placing the
 protocol’s name after the type’s name, separated by a colon, as part of their
 definition. Multiple protocols can be listed, and are separated by commas:

 ///    struct SomeStructure: FirstProtocol, AnotherProtocol {
 ///        // structure goes here
 ///    }
 
 If a class has a superclass, list the superclass name before any protocols it 
 adopts, followed by a comma:

 ///    class SomeClass: SomeSuperClass, FirstProtocol, AnotherProtocol {
 ///        // class definition goes here
 ///    }
 */



//  MARK: - Property Requirements
/*
 A protocol can require any conforming type to provide an instance property or
 type property with a particular name and type. It only specifies the required
 property name and type. The protocol also specifies whether each property must 
 be gettable or gettable and settable.

 If a protocol requires a property to be gettable and settable, that property
 requirement cannot be fulfilled by a constant stored property or a read-only 
 computed property. If the protocol only requires a property to be gettable, 
 the requirement can be satisfied by any kind of property, and it is valid for 
 the property to be also settable if this is useful for your own code.
 
 Property requirements are always declared as variable properties, prefixed
 with the var keyword. Gettable and settable properties are indicated by 
 writing { get set } after their type declaration, and gettable properties are
 indicated by writing { get }.
 */
protocol SomeProtocol {
    var mustBeSettable: Int { get set }
    var doesNotNeedToBeSettable: Int { get }
}

/*
 Always prefix type property requirements with the static keyword when you
 define them in a protocol. This rule pertains even though type property 
 requirements can be prefixed with the class or static keyword when implemented 
 by a class:
 */
protocol AnotherProtocol {
    static var someTypeProperty: Int { get set }
}

/*
 Here’s an example of a protocol with a single instance property requirement:
 */
protocol FullyNamed {
    var fullName: String { get }
}

/*
 The FullyNamed protocol requires a conforming type to provide a 
 fully-qualified name. It only specifies that the type must be able to provide
 a full name for itself. The protocol states that any FullyNamed type must
 have a gettable instance property called fullName, which is of type String.
 Here’s an example of a simple structure that adopts and conforms to the 
 FullyNamed protocol:
 */
struct Person: FullyNamed {
    var fullName: String
}
let john = Person(fullName: "John Applesed")
// john.fullName is "John Applesed"

/*
 Here’s a more complex class, which also adopts and conforms to the FullyNamed
 protocol:
 */
class Starship: FullyNamed {
    var prefix: String?
    var name: String
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }

    var fullName: String {
        return (prefix != nil ? prefix! + " " : "") + name
    }
}
var ncc1701 = Starship(name: "Enterprise", prefix: "USS")
// ncc1701.fullName is "Uss EnterPrise"



//  MARK: Method Requirements
/*
 Protocols can require specific instance methods and type methods to be 
 implemented by conforming types. These methods are written as part of the 
 protocol’s definition in exactly the same way as for normal instance and type 
 methods, but without curly braces or a method body. Variadic parameters are 
 allowed, subject to the same rules as for normal methods. Default values, 
 however, cannot be specified for method parameters within a protocol’s
 
 As with type property requirements, you always prefix type method requirements
 with the static keyword when they are defined in a protocol.
 
 ///    protocol SomeProtocol {
 ///        static func someTypeMethod()
 ///    }
 
 The following example defines a protocol with a single instance method 
 requirement:
 */
protocol RandomNumberGenerator {
    func random() -> Double
}

/*
 The RandomNumberGenerator protocol simply requires the generator to provide a
 standard way to generate a new random number.
 Here’s an implementation of a class that adopts and conforms to the 
 RandomNumberGenerator protocol.
 */
class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = (lastRandom * a + c).truncatingRemainder(dividingBy: m)
        return lastRandom / m
    }
}
let generator = LinearCongruentialGenerator()
print("Here's a random number: \(generator.random())")
// Prints "Here's a random number: 0.37464991998171"
print("And another one: \(generator.random())")
// Prints "And another one: 0.729023776863283"



//  MARK: Mutating Method Requirements
/*
 It is sometimes necessary for a method to modify (or mutate) the instance it 
 belongs to. For instance methods on value types (that is, structures and 
 enumerations) you place the mutating keyword before a method’s func keyword to 
 indicate that the method is allowed to modify the instance it belongs to and
 any properties of that instance.

 If you define a protocol instance method requirement that is intended to 
 mutate instances of any type that adopts the protocol, mark the method with 
 the mutating keyword as part of the protocol’s definition. This enables
 structures and enumerations to adopt the protocol and satisfy that method
 requirement.

 NOTE:
 If you mark a protocol instance method requirement as mutating, you do not 
 need to write the mutating keyword when writing an implementation of that 
 method for a class. The mutating keyword is only used by structures and 
 enumerations.
 */

/*
 The toggle() method is marked with the mutating keyword as part of the 
 Togglable protocol definition, to indicate that the method is expected to 
 mutate the state of a conforming instance when it is called:
 */
protocol Togglable {
    mutating func toggle()
}

/*
 The example below defines an enumeration called OnOffSwitch. This enumeration 
 toggles between two states, indicated by the enumeration cases on and off. The 
 enumeration’s toggle implementation is marked as mutating, to match the
 Togglable protocol’s requirements:
 */
enum OnOffSwitch: Togglable {
    case off, on
    mutating func toggle() {
        switch  self {
        case .off:
            self = .on
        case .on:
            self = .off
        }
    }
}
var lightSwitch = OnOffSwitch.off
lightSwitch.toggle()
// lightSwitch is now equal to .on



//  MARK: Intializer Requirements
/*
 Protocols can require specific initializers to be implemented by conforming 
 types. You write these initializers as part of the protocol’s definition in
 exactly the same way as for normal initializers, but without curly braces or
 an initializer body:
 
 ///    protocol SomeProtocol {
 ///        init(someParameter: Int)
 ///    }
 */



//  MARK: Class Implementation of Protocol Initializer Requirements
/*
 You can implement a protocol initializer requirement on a conforming class as 
 either a designated initializer or a convenience initializer. In both cases, 
 you must mark the initializer implementation with the required modifier:
 ///    class someClass: SomeProtocol {
 ///        required init(someParameters: Int) {
 ///        // initializer implementation goes here
 ///        }
 ///    }
 
 The use of the required modifier ensures that you provide an explicit or 
 inherited implementation of the initializer requirement on all subclasses of 
 the conforming class, such that they also conform to the protocol.
 
 NOTE:
 You do not need to mark protocol initializer implementations with the required
 modifier on classes that are marked with the final modifier, because final 
 classes cannot be subclassed.
 */

/*
 If a subclass overrides a designated initializer from a superclass, and also 
 implements a matching initializer requirement from a protocol, mark the 
 initializer implementation with both the required and override modifiers:
 */
protocol SomeProtocolCopy {
    init()
}

class SomeSuperClass {
    init() {
        // initializer implementation goes here
    }
}

class SomeSubClass: SomeSuperClass, SomeProtocolCopy {
    // "required" from SomeProtocol conformance; "override" from SomeSuperClass
    required override init() {
        // initializer implementation goes here
    }
}



//  MARK: Failable Initializer Requirements
/*
 A failable initializer requirement can be satisfied by a failable or 
 nonfailable initializer on a conforming type.
 A nonfailable initializer requirement can be satisfied by a nonfailable 
 initializer or an implicitly unwrapped failable initializer.
 */



//  MARK: - Protocols as Types
/*
 Protocols do not actually implement any functionality themselves. Nonetheless, 
 any protocol you create will become a fully-fledged type for use in your code.

 Because it is a type, you can use a protocol in many places where other types 
 are allowed, including:

    - As a parameter type or return type in a function, method, or initializer
    - As the type of a constant, variable, or property
    - As the type of items in an array, dictionary, or other container
 
 NOTE:
 Because protocols are types, begin their names with a capital letter (such as 
 FullyNamed and RandomNumberGenerator) to match the names of other types in
 Swift (such as Int, String, and Double).
 */

// Here’s an example of a protocol used as a type:
class Dice {
    let sides: Int
    let generator: RandomNumberGenerator
    init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }

    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}

/*
 Here’s how the Dice class can be used to create a six-sided dice with a 
 LinearCongruentialGenerator instance as its random number generator: 
 */
var d6 = Dice(sides: 6, generator: LinearCongruentialGenerator())
for _ in 1...5 {
    print("Random dice roll is \(d6.roll())")
}
// Random dice roll is 3
// Random dice roll is 5
// Random dice roll is 4
// Random dice roll is 5
// Random dice roll is 4



//  MARK: - Delegation
/*
 Delegation is a design pattern that enables a class or structure to hand off 
 (or delegate) some of its responsibilities to an instance of another type. 
 This design pattern is implemented by defining a protocol that encapsulates 
 the delegated responsibilities, such that a conforming type (known as a 
 delegate) is guaranteed to provide the functionality that has been delegated. 
 Delegation can be used to respond to a particular action, or to retrieve data
 from an external source without needing to know the underlying type of that
 source.

 The example below defines two protocols for use with dice-based board games:
 */
protocol DiceGame {
    var dice: Dice { get }
    func play()
}

protocol DiceGameDelegate {
    func gameDidStart(_ game: DiceGame)
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
    func gameDidEnd(_ game: DiceGame)
}

/*
 The DiceGame protocol is a protocol that can be adopted by any game that 
 involves dice. The DiceGameDelegate protocol can be adopted by any type to
 track the progress of a DiceGame. Take a example of the Snakes and Ladders 
 game, and make a version which is adapted to use a Dice instance for its 
 dice-rolls; to adopt the DiceGame Protocol; and to notify a DiceGameDelegate
 about its progress:
 */
class SnakesAndLadders: DiceGame {
    let finalSquare = 25
    let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
    var square = 0
    var board: [Int]
    init() {
        board = Array(repeating: 0, count: finalSquare + 1)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
    }

    var delegate: DiceGameDelegate?
    func play() {
        square = 0
        delegate?.gameDidStart(self)
        gameLoop: while square != finalSquare {
            let diceRoll = dice.roll()
            delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll)
            switch square + diceRoll {
            case finalSquare:
                break gameLoop
            case let newSquare where newSquare > finalSquare:
                continue gameLoop
            default:
                square += diceRoll
                square += board[square]
            }
        }
        delegate?.gameDidEnd(self)
    }
}

/*
 Because the delegate property is an optional DiceGameDelegate, the play()
 method uses optional chaining each time it calls a method on the delegate. 
 If the delegate property is nil, these delegate calls fail gracefully and 
 without error. If the delegate property is non-nil, the delegate methods are 
 called, and are passed the SnakesAndLadders instance as a parameter. 
 */

/*
 This next example shows a class called DiceGameTracker, which adopts the 
 DiceGameDelegate protocol:
 */
class DiceGameTracker: DiceGameDelegate {
    var numberOfTurns = 0
    func gameDidStart(_ game: DiceGame) {
        numberOfTurns = 0
        if game is SnakesAndLadders {
            print("Start a new game of Snakes and Ladders")
        }
        print("The game is using a \(game.dice.sides)-sided dice")
    }

    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) {
        numberOfTurns += 1
        print("Rolled a \(diceRoll)")
    }

    func gameDidEnd(_ game: DiceGame) {
        print("The lastst tester For \(numberOfTurns) turns")
    }
}

/*
 The gameDidStart(_:) method also accesses the dice property of the passed game 
 parameter. Because game is known to conform to the DiceGame protocol, it is 
 guaranteed to have a dice property, and so the gameDidStart(_:) method is able
 to access and print the dice’s sides property, regardless of what kind of game
 is being played.

 Here’s how DiceGameTracker looks in action: 
 */
let tracker = DiceGameTracker()
let game = SnakesAndLadders()
game.delegate = tracker
game.play()
// Start a new game of Snakes and Ladders
// The game is using a 6-sided dice
// Rolled a 3
// Rolled a 5
// Rolled a 4
// Rolled a 5
// The lastst tester For 4 turns



//  MARK: - Adding Protocol Conformance with an Extension
/*
 You can extend an existing type to adopt and conform to a new protocol, even
 if you do not have access to the source code for the existing type. Extensions 
 can add new properties, methods, and subscripts to an existing type, and are 
 therefore able to add any requirements that a protocol may demand
 NOTE:
 Existing instances of a type automatically adopt and conform to a protocol 
 when that conformance is added to the instance’s type in an extension. 
 */

/*
 For example, this protocol, called TextRepresentable, can be implemented by
 any type that has a way to be represented as text. This might be a description
 of itself, or a text version of its current state: 
 */
protocol TextRepresentable {
    var textualDescription: String { get }
}

/*
 The Dice class from earlier can be extended to adopt and conform to
 TextRepresentable:
 */
extension Dice: TextRepresentable {
    var textualDescription: String {
        return "A \(sides)-sided dice"
    }
}

// Any Dice instance can now be treated as TextRepresentable:
let d12 = Dice(sides: 12, generator: LinearCongruentialGenerator())
print(d12.textualDescription)
// Prints "A 12-sided dice"

/*
 Similarly, the SnakesAndLadders game class can be extended to adopt and
 conform to the TextRepresentable protocol:
 */
extension SnakesAndLadders: TextRepresentable {
    var textualDescription: String {
        return "A game of Snakes and Ladders with \(finalSquare) squares"
    }
}
print(game.textualDescription)
// Prints "A game of Snakes and Ladders with 25 squares"



//  MARK: Declaring Protocol Adoption with an Extension
/*
 If a type already conforms to all of the requirements of a protocol, but has
 not yet stated that it adopts that protocol, you can make it adopt the protocol 
 with an empty extension:
 */
struct Hamster {
    var name: String
    var textualDescription: String {
        return "A hamster named \(name)"
    }
}
extension Hamster: TextRepresentable {}

/*
 Instances of Hamster can now be used wherever TextRepresentable is the required
 type:
 */
let simonTheHamster = Hamster(name: "Simon")
let somethingTextRepresentable: TextRepresentable = simonTheHamster
print(somethingTextRepresentable.textualDescription)
// Prints "A hamster named Simon"

/*
 Types do not automatically adopt a protocol just by satisfying its 
 requirements. They must always explicitly declare their adoption of the 
 protocol.
 */



//  MARK: Collections of Protocol Types
/*
 A protocol can be used as the type to be stored in a collection such as an
 array or a dictionary. This example creates an array of TextRepresentable
 things:
 */
let things: [TextRepresentable] = [game, d12, simonTheHamster]

/*
 It is now possible to iterate over the items in the array, and print each 
 item’s textual description:
 */
for thing in things {
    print(thing.textualDescription)
}
// A game of Snakes and Ladders with 25 squares
// A 12-sided dice
// A hamster named Simon

/*
 Note that the thing constant is of type TextRepresentable. It is not of type
 Dice, or DiceGame, or Hamster, even if the actual instance behind the scenes 
 is of one of those types. Nonetheless, because it is of type TextRepresentable,
 and anything that is TextRepresentable is known to have a textualDescription 
 property, it is safe to access thing.textualDescription each time through the 
 loop.
 */



//  MARK: Protocol Inheritance
/*
 A protocol can inherit one or more other protocols and can add further 
 requirements on top of the requirements it inherits. The syntax for protocol 
 inheritance is similar to the syntax for class inheritance, but with the 
 option to list multiple inherited protocols, separated by commas: 
 */
protocol InheritingProtocol: SomeProtocol, AnotherProtocol {
    // protocol definition goes here
}

/*
 Here's an example of a protocol that inherits the TextRepresentable protocol 
 from above
 */
protocol PrettyTextRepresentable: TextRepresentable {
    var prettyTextualDescription: String { get }
}

/*
 Anything that adopts PrettyTextRepresentable must satisfy all of the
 requirements enforced by TextRepresentable, plus the additional requirements
 enforced by PrettyTextRepresentable. In this example, PrettyTextRepresentable
 adds a single requirement to provide a gettable property called 
 prettyTextualDescription that returns a String.

 The SnakesAndLadders class can be extended to adopt and conform to
 PrettyTextRepresentable:
 */
extension SnakesAndLadders: PrettyTextRepresentable {
    var prettyTextualDescription: String {
        var output = textualDescription + ":\n"
        for index in 1...finalSquare {
            switch board[index] {
            case let ladder where ladder > 0:
                output += "▲ "
            case let snake where snake < 0:
                output += "▼ "
            default:
                output += "○ "
            }
        }
        return output
    }
}

/*
 Anything that is PrettyTextRepresentable must also be TextRepresentable, and 
 so the implementation of prettyTextualDescription starts by accessing the 
 textualDescription property from the TextRepresentable protocol to begin an
 output string. It then iterates through the array of board squares, and 
 appends a geometric shape to represent the contents of each square:

    - If the square’s value is greater than 0, it is the base of a ladder, and 
 is represented by ▲.
    - If the square’s value is less than 0, it is the head of a snake, and is
 represented by ▼.
    - Otherwise, the square’s value is 0, and it is a free” square, represented
 by ○.
 The prettyTextualDescription property can now be used to print a pretty text
 description of any SnakesAndLadders instance:
*/
print(game.prettyTextualDescription)
// A game of Snakes and Ladders with 25 squares:
// ○ ○ ▲ ○ ○ ▲ ○ ○ ▲ ▲ ○ ○ ○ ▼ ○ ○ ○ ○ ▼ ○ ○ ▼ ○ ▼ ○



//  MARK: Class-Only Protocols
/*
 You can limit protocol adoption to class types (and not structures or
 enumerations) by adding the class keyword to a protocol’s inheritance list.
 The class keyword must always appear first in a protocol’s inheritance list,
 before any inherited protocols:

 ///    protocol SomeClassOnlyProtocol: class, SomeInheritedProtocol {
 ///    // class-only protocol definition goes here
 ///    }

 In the example above, SomeClassOnlyProtocol can only be adopted by class types.
 It is a compile-time error to write a structure or enumeration definition that
 tries to adopt SomeClassOnlyProtocol.

 NOTE:
 Use a class-only protocol when the behavior defined by that protocol’s
 requirements assumes or requires that a conforming type has reference
 semantics rather than value semantics.
 */



//  MARK: Protocol Composition
/*
 It can be useful to require a type to conform to multiple protocols at once.
 You can combine multiple protocols into a single requirement with a protocol
 composition. Protocol compositions have the form
 SomeProtocol & AnotherProtocol. You can list as many protocols as you need
 to, separating them by ampersands (&).
 */
protocol Named {
    var name: String { get }
}

protocol Aged {
    var age: Int { get }
}

struct CompletePerson: Named, Aged {
    var name: String
    var age: Int
}

func wishHappyBirthday(to celebrator: Named & Aged) {
    print("Happy birthday, \(celebrator.name), you're \(celebrator.age)!")
}

let birthdayPerson = CompletePerson(name: "Malcolm", age: 21)
wishHappyBirthday(to: birthdayPerson)
// Prints "Happy birthday, Malcolm, you're 21!"
/*
 The example also defines a wishHappyBirthday(to:) function, The type of the
 celebrator parameter is Named & Aged, which means 'any type that conforms to
 both the Named and Aged protocols.'

 NOTE:
 Protocol compositions do not define a new, permanent protocol type. Rather,
 they define a temporary local protocol that has the combined requirements of
 all protocols in the composition.
 */



//  MARK: - Checking for Protocol Conformance
/*
 You can use the is and as operators to check for protocol conformance, and to
 cast to a specific protocol. Checking for and casting to a protocol follows
 exactly the same syntax as checking for and casting to a type:

 - The is operator returns true if an instance conforms to a protocol and
 returns false if it does not.
 - The as? version of the downcast operator returns an optional value of the
 protocol’s type, and this value is nil if the instance does not conform to
 that protocol.
 - The as! version of the downcast operator forces the downcast to the
 protocol type and triggers a runtime error if the downcast does not succeed.
 */
protocol HasArea {
    var area: Double { get }
}

class Circle: HasArea {
    let pi = 3.1415926
    var radius: Double
    var area: Double { return pi * radius * radius }
    init(radius: Double) { self.radius = radius }
}

class Country: HasArea {
    var area: Double
    init(area: Double) { self.area = area }
}

/*
 Both classes correctly conform to the HasArea protocol.
 Here’s a class called Animal, which does not conform to the HasArea protocol:
 */
class Animal {
    var legs: Int
    init(legs: Int) { self.legs = legs }
}

/*
 The Circle, Country and Animal classes do not have a shared base class.
 Nonetheless, they are all classes, and so instances of all three types can
 be used to initialize an array that stores values of type AnyObject:
 */
let objects: [AnyObject] = [
    Circle(radius: 2.0),
    Country(area: 243_610),
    Animal(legs: 4)
]

/*
 The objects array can now be iterated, and each object in the array can be
 checked to see if it conforms to the HasArea protocol:
 */
for object in objects {
    if let objectWithArea = object as? HasArea {
        print("Area is \(objectWithArea.area)")
    } else {
        print("Something that doesn't have an area")
    }
}
// Area is 12.5663704
// Area is 243610.0
// Something that doesn't have an area

/*
 The objectWithArea constant is known to be of type HasArea, and so its area
 property can be accessed and printed in a type-safe way.
 Note that the underlying objects are not changed by the casting process.
 However, at the point that they are stored in the objectWithArea constant,
 they are only known to be of type HasArea, and so only their area property
 can be accessed.
 */



//  MARK: Optional Protocol Requirements
/*
 Optional requirements are prefixed by the optional modifier as part of the
 protocol’s definition. Optional requirements are available so that you can
 write code that interoperates with Objective-C. Both the protocol and the
 optional requirement must be marked with the @objc attribute. Note that @objc
 protocols can be adopted only by classes that inherit from Objective-C classes
 or other @objc classes. They can’t be adopted by structures or enumerations.

 When you use a method or property in an optional requirement, its type
 automatically becomes an optional.

 You check for an implementation of an optional method by writing a question
 mark after the name of the method when it is called, such as
 someOptionalMethod?(someArgument).
 */
@objc protocol CounterDataSource {
    @objc optional func increment(forCount count: Int) -> Int
    @objc optional var fixedIncrement: Int { get }
}

/*
 NOTE:
 Strictly speaking, you can write a custom class that conforms to
 CounterDataSource without implementing either protocol requirement. They are
 both optional, after all. Although technically allowed, this wouldn’t make
 for a very good data source.
 */

/*
 The Counter class, defined below, has an optional dataSource property of type
 CounterDataSource?:
 */
class Counter {
    var count = 0
    var dataSource: CounterDataSource?
    func increment() {
        if let amount = dataSource?.increment?(forCount: count) {
            count += amount
        } else if let amount = dataSource?.fixedIncrement {
            count += amount
        }
    }
}

/*
 Here’s a simple CounterDataSource implementation where the data source returns
 a constant value of 3 every time it is queried. It does this by implementing
 the optional fixedIncrement property requirement:
 */
class ThreeSource: NSObject, CounterDataSource {
    let fixedIncrement = 3
}

/*
 You can use an instance of ThreeSource as the data source for a new Counter
 instance:
 */
var counter = Counter()
counter.dataSource = ThreeSource()
for _ in 1...4 {
    counter.increment()
    print(counter.count)
}
// 3
// 6
// 9
// 12

/*
 The code above creates a new Counter instance; sets its data source to be a
 new ThreeSource instance; and calls the counter’s increment() method four
 times. As expected, the counter’s count property increases by three each time
 increment() is called.

 Here’s a more complex data source called TowardsZeroSource, which makes a
 Counter instance count up or down towards zero from its current count value:
 */
@objc class TowardsZeroSource: NSObject, CounterDataSource {
    func increment(forCount count: Int) -> Int {
        if count == 0 {
            return 0
        } else if count < 0 {
            return 1
        } else {
            return -1
        }
    }
}

/*
 You can use an instance of TowardsZeroSource with the existing Counter
 instance to count from -4 to zero. Once the counter reaches zero, no more
 counting takes place:
 */
counter.count = -4
counter.dataSource = TowardsZeroSource()
for _ in 1...5 {
    counter.increment()
    print(counter.count)
}
// -3
// -2
// -1
// 0
// 0



//  MARK: - Protocol Extensions
/*
 Protocols can be extended to provide method and property implementations to
 conforming types. This allows you to define behavior on protocols themselves,
 rather than in each type’s individual conformance or in a global function.
 */
extension RandomNumberGenerator {
    func randomBool() -> Bool {
        return random() > 0.5
    }
}

/*
 By creating an extension on the protocol, all conforming types automatically
 gain this method implementation without any additional modification.
 */
let commonGenerator = LinearCongruentialGenerator()
print("Here's a random number: \(commonGenerator.random())")
// Prints "Here's a random number: 0.37464991998171"
print("And here's a random Boolean: \(commonGenerator.randomBool())")
// Prints "And here's a random Boolean: true"



//  MARK: Providing Default Implementations
/*
 You can use protocol extensions to provide a default implementation to any
 method or computed property requirement of that protocol. If a conforming type
 provides its own implementation of a required method or property, that
 implementation will be used instead of the one provided by the extension.

 For example, the PrettyTextRepresentable protocol, which inherits the
 TextRepresentable protocol can provide a default implementation of its required
 prettyTextualDescription property to simply return the result of accessing
 the textualDescription property:
 */
extension PrettyTextRepresentable {
    var prettyTextualDescription: String {
        return textualDescription
    }
}



//  MARK: Adding Constraints to Protocol Extension
/*
 When you define a protocol extension, you can specify constraints that
 conforming types must satisfy before the methods and properties of the
 extension are available. You write these constraints after the name of the
 protocol you’re extending using a generic where clause.
 */
extension Collection where Iterator.Element: TextRepresentable {
    var textualDescription: String {
        let itemsAsText = self.map { $0.textualDescription }
        return "[" + itemsAsText.joined(separator: ", ") + "]"
    }
}

/*
 Consider the Hamster structure from before, which conforms to the
 TextRepresentable protocol, and an array of Hamster values:
 */
let murrayTheHamster = Hamster(name: "Murray")
let morganTheHamster = Hamster(name: "Morgan")
let mauriceTheHamster = Hamster(name: "Maurice")
let hamsters = [murrayTheHamster, morganTheHamster, mauriceTheHamster]

/*
 Because Array conforms to Collection and the array’s elements conform to the
 TextRepresentable protocol, the array can use the textualDescription property
 to get a textual representation of its contents:
 */
print(hamsters.textualDescription)
// Prints "[A hamster named Murray, A hamster named Morgan, A hamster named Maurice]"
/*
 NOTE:
 If a conforming type satisfies the requirements for multiple constrained
 extensions that provide implementations for the same method or property, Swift
 will use the implementation corresponding to the most specialized constraints.
 */

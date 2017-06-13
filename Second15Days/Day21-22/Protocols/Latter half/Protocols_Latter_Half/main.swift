//
//  main.swift
//  Protocols_Latter_Half
//
//  Created by Leo_Lei on 6/13/17.
//  Copyright © 2017 LibertyLeo. All rights reserved.
//

import Foundation

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

struct Person: Named, Aged {
    var name: String
    var age: Int
}

func wishHappyBirthday(to celebrator: Named & Aged) {
    print("Happy birthday, \(celebrator.name), you're \(celebrator.age)!")
}

let birthdayPerson = Person(name: "Malcolm", age: 21)
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
 rotocols can be extended to provide method and property implementations to 
 conforming types. This allows you to define behavior on protocols themselves, 
 rather than in each type’s individual conformance or in a global function.
 */
protocol RandomNumberGenerator {
    func random() -> Double
}

extension RandomNumberGenerator {
    func randomBool() -> Bool {
        return random() > 0.5
    }
}

/*
 By creating an extension on the protocol, all conforming types automatically 
 gain this method implementation without any additional modification.
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
print("And here's a random Boolean: \(generator.randomBool())")
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
protocol TextRepresentable {
    var textualDescription: String { get }
}

protocol PrettyTextRepresentable: TextRepresentable {
    var prettyTextualDescription: String { get }
}

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
struct Hamster {
    var name: String
    var textualDescription: String {
        return "A hamster named \(name)"
    }
}
extension Hamster: TextRepresentable {}
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

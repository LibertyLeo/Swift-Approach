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

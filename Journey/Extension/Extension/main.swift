//
//  main.swift
//  Extension
//
//  Created by Leo_Lei on 6/7/17.
//  Copyright © 2017 LibertyLeo. All rights reserved.
//

import Foundation

/*
 Extensions add new functionality to an existing class, structure, enumeration,
 or protocol type. This includes the ability to extend types for which you do
 not have access to the original source code (known as retroactive modeling).

 Extensions in Swift can:

 - Add computed instance properties and computed type properties
 - Define instance methods and type methods
 - Provide new initializers
 - Define subscripts
 - Define and use new nested types
 - Make an existing type conform to a protocol
 In Swift, you can even extend a protocol to provide implementations of its
 requirements or add additional functionality that conforming types can take
 advantage of.

 NOTE:
 Extensions can add new functionality to a type, but they cannot override
 existing functionality.
 */



//  MARK: Extension Syntax
/*
 Declare extensions with the extension keyword:
 ///    extension SomeType {
 ///        // new functionality to add to Sometype goes here
 ///    }

 An extension can extend an existing type to make it adopt one or more
 protocols. To add protocol conformance, you write the protocol names the same
 way as you write them for a class or structure:
 ///    extension Sometype: SomeProtocol, AnotherProtocol {
 ///        // implementation of protocol requirements goes here
 ///    }

 An extension can be used to extend an existing generic type, and can also
 extend a generic type to conditionally add functionality.
 NOTE:
 If you define an extension to add new functionality to an existing type, the
 new functionality will be available on all existing instances of that type,
 even if they were created before the extension was defined.
 */



//  MARK: - Computed Properties
/*
 Extensions can add computed instance properties and computed type properties
 to existing types.
 */
extension Double {
    var km: Double { return self * 1_000.0 }
    var m: Double { return self }
    var cm: Double { return self / 1_00.0 }
    var mm: Double { return self / 1_000.0 }
    var ft: Double { return self / 3.28084 }
}
let oneInch = 25.4.mm
print("One inch is \(oneInch) meters")
// Prints "One inch is 0.0254 meters"
let threeFeet = 3.ft
print("There feet is \(threeFeet) meters")
// Prints "There feet is 0.914399970739201 meters"
/*
 Although they are implemented as computed properties, the names of these
 properties can be appended to a floating-point literal value with dot syntax,
 as a way to use that literal value to perform distance conversions.

 These properties are read-only computed properties, and so they are expressed
 without the get keyword, for brevity. Their return value is of type Double,
 and can be used within mathematical calculations wherever a Double is accepted:
 */
let aMarathon = 42.km + 195.m
print("A marathon is \(aMarathon) meters long")
// Prints "A marathon is 42195.0 meters long"
/*
 NOTE:
 Extensions can add new computed properties, but they cannot add stored
 properties, or add property observers to existing properties.
 */



//  MARK: Initializers
/*
 Extensions can add new initializers to existing types. This enables you to
 extend other types to accept your own custom types as initializer parameters,
 or to provide additional initialization options that were not included as
 part of the type’s original implementation.
 Extensions can add new convenience initializers to a class, but they cannot
 add new designated initializers or deinitializers to a class. Designated
 initializers and deinitializers must always be provided by the original class
 implementation.

 NOTE:
 If you use an extension to add an initializer to a value type that provides
 default values for all of its stored properties and does not define any custom
 initializers, you can call the default initializer and memberwise initializer
 for that value type from within your extension’s initializer.
 */
struct Size {
    var width = 0.0, height = 0.0
}

struct Point {
    var x = 0.0, y = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
}

/*
 Because the Rect structure provides default values for all of its properties,
 it receives a default initializer and a memberwise initializer automatically.
 */
let defaultRect = Rect()
let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0),
                          size: Size(width: 5.0, height: 5.0))

/*
 You can extend the Rect structure to provide an additional initializer that
 takes a specific center point and size:
 */
extension Rect {
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

/*
 The initializer then calls the structure’s automatic memberwise initializer
 init(origin:size:), which stores the new origin and size values in the
 appropriate properties:
 */
let centerRect = Rect(center: Point(x: 4.0, y: 4.0),
                      size: Size(width: 3.0, height: 3.0))
// centerRect's a origin is (2.5, 2.5) and its size is (3.0, 3.0)

/*
 NOTE:
 If you provide a new initializer with an extension, you are still responsible
 for making sure that each instance is fully initialized once the initializer
 completes.
 */



//  MARK: Methods
/*
 Extensions can add new instance methods and type methods to existing types.
 The following example adds a new instance method called repetitions to the
 Int type:
 */
extension Int {
    func repetition(task: () -> Void) {
        for _ in 0..<self {
            task()
        }
    }
}

/*
 After defining this extension, you can call the repetitions(task:) method on
 any integer to perform a task that many number of times:
 */
3.repetition {
    print("Hello!")
}
// Hello!
// Hello!
// Hello!



//  MARK: Mutating Instance Methods
/*
 Instance methods added with an extension can also modify (or mutate) the
 instance itself. Structure and enumeration methods that modify self or its
 properties must mark the instance method as mutating, just like mutating
 methods from an original implementation.
 */
extension Int {
    mutating func square() {
        self = self * self
    }
}
var someInt = 3
someInt.square()
// someInt is now 9



//  MARK: Subscripts
/*
 Extensions can add new subscripts to an existing type. This example adds an
 integer subscript to Swift’s built-in Int type. This subscript [n] returns the
 decimal digit n places in from the right of the number:

 - 123456789[0] returns 9
 - 123456789[1] returns 8
 …and so on:
 */
extension Int {
    subscript(digitIndex: Int) -> Int {
        var decimalBase = 1
        for _ in 0..<digitIndex {
            decimalBase *= 10
        }
        return (self / decimalBase) % 10
    }
}
746381295[0]
// return 5
746381295[1]
// return 9
746381295[2]
// return 2
746381295[8]
// return 7

/*
 If the Int value does not have enough digits for the requested index, the
 subscript implementation returns 0, as if the number had been padded with
 zeros to the left:
 */
746381295[9]
// returns 0, as if you had requested:
0746381295[9]



//  MARK: Nested Types
/*
 Extensions can add new nested types to existing classes, structures, and
 enumerations:
 */
extension Int {
    enum Kind {
        case negative, zero, positive
    }
    var kind: Kind {
        switch self {
        case 0:
            return .zero
        case let x where x > 0:
            return .positive
        default:
            return .negative
        }
    }
}

/*
 This example adds a new nested enumeration to Int. This enumeration, called
 Kind, expresses the kind of number that a particular integer represents.
 Specifically, it expresses whether the number is negative, zero, or positive.

 This example also adds a new computed instance property to Int, called kind,
 which returns the appropriate Kind enumeration case for that integer.

 The nested enumeration can now be used with any Int value:
 */
func printIntegerKinds(_ numbers: [Int]) {
    for number in numbers {
        switch number.kind {
        case .negative:
            print("- ", terminator: "")
        case .zero:
            print("0 ", terminator: "")
        case .positive:
            print("+ ", terminator: "")
        }
    }
    print("")
}
printIntegerKinds([3, 19, -27, 0, -6, 0, 7])
// Prints "+ + - 0 - 0 + "

/*
 For each integer in the array, the function considers the kind computed
 property for that integer, and prints an appropriate description.

 NOTE:
 number.kind is already known to be of type Int.Kind. Because of this, all
 of the Int.Kind case values can be written in shorthand form inside the switch
 statement, such as .negative rather than Int.Kind.negative.
 */

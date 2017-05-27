//
//  main.swift
//  Swift_Enumerations
//
//  Created by Leo_Lei on 5/23/17.
//  Copyright © 2017 LibertyLeo. All rights reserved.
//

import Foundation

//  MARK: Enumeration
/*
 An enumeration defines a common type for a group of related values and enables
 you to work with those values in a type-safe way within your code.
 Enumerations can define initializers to provide an initial case value; can be
 extended to expand their functionality beyond their original implementation;
 and can confrom to protocols to provide standard functionality.
 */



//  MARK: - Enumeration Syntax
/*
 You introduce enumerations with the enum keyword and place their entire 
 definition with a pair of braces.
 */
enum someEnumeration {
    //  enumeration definition goes here
}

//  You use the case keyword to introduce new enumeration cases.
enum CompassPoint {
    case north
    case south
    case east
    case west
}

/*
 NOTE:
 Unlike C and Objective-C, Swift enumeration cases are not assigned a default
 integer value when they are created.
 Instead, the different enumeration cases are fully-fledged values in their own
 right, with an explicitly-defined type of CompassPoint.
 */

//  Multiple cases can appear on a single line, separated by commas
enum Planet {
    case mercury, venus, earth, mars, jupiter, saturn, uranus, neptune
}

/*
 Each enumeration definition defines a brand new type.
 Like other types in Swift, their names should start with a capital letter.
 Give enumeration types singular rather than plural names, so that they read as
 self-evident.
 */
var directionToHead = CompassPoint.west

/*
 Once directionToHead is declared as a CompassPoint, you can set it to a 
 different CompassPoint value using a short dot syntax.
 */
directionToHead = .east



//  MARK: Matching Enumeration Values with a Switch Statement
//  You can math individual enumeration values with a switch statement
directionToHead = .south
switch directionToHead {
case .north:
    print("Lots of planets have a north")
case .south:
    print("Watch out for penguins")
case .east:
    print("Where the sun rises")
case .west:
    print("Where the skies are blue")
}
//  Prints "Watch out for penguins

/*
 Requiring exhaustiveness ensures that enumeration cases are not accidently 
 omiited.
 When it is not appropriate to provide a case for every enumeration case, you
 can provide a default case to cover any cases that are not addressed 
 explicitly.
 */
let somePlanet = Planet.earth
switch somePlanet {
case .earth:
    print("Mostly harmless")
default:
    print("Not a safe place for humans")
}
//  Prints "Mostly harmless"



//  MARK: - Associated Values
/*
 It is sometimes useful to be able to store associated values of other types
 alongside these case values. This enables you to store additional custom
 information along with the case value, and permits this information to vary
 each time you use that case in your code.

 For example, suppose an inventory tracking system need to track products by
 two different types of barcode. 
 Some products are labeled with 1D barcodes in UPC format, which uses the 
 numbers 0 to 9.
 Other products are labeled with 2D barcodes in QR code format, which can use
 any ISO 8859-1 character and can encode a string up to 2,953 characters long
 */
enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}

/*
 This definition does not provide any actual Int or String values - it just
 defines the type of associated values that Barcode constants and variables
 can store when they are equal to Barcode.upc or Barcode.qrCode
 */
var productBarcode = Barcode.upc(8, 85909, 51226, 3)
productBarcode = .qrCode("ABCDEFGHIJKLMNOP")

/*
 The different barcode types can be checked using a switch statement, as before.
 This time, however, the associated values can be extracted as part of the 
 switch statement.
 You extract each associated values as a constant (with the let prefix) or a
 variable (with the var prefix) for use within the switch cases body.
 */
switch productBarcode {
case .upc(let numberSystem, let manufacturer, let product, let check):
    print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
case .qrCode(let productCode):
    print("QR code: \(productCode).")
}
//  Prints "QR code: ABCDEFGHIJKLMNOP."

/*
 If all of the associated values for an enumeration case are extracted as 
 constants, or if all are extracted as variables, you can place a single var
 or let annotation before the case name, for brevity
 */
switch productBarcode {
case let .upc(numberSystem, manufacturer, product, check):
    print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
case let .qrCode(productCode):
    print("QR code: \(productCode).")
}
//  Prints "QR code: ABCDEFGHIJKLMNOP."



//  MARK: Raw Values
/*
 As an alternative to associated values, enumeration cases can come prepopulated
 with default values (called raw values), which are of the same type.
 */
enum ASCIIControlCharacter: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriageRerutn = "\r"
}

/*
 Raw values can be strings, characters, or any of the integer or floating-point
 number types.
 Each raw value must be unique within its enumeration declaration.

 NOTE:
 Raw values are not the same as associated values.
 Raw values are set to prepopulated values when you first define the enumeration
 in your code, like the three ASCII codes above.
 The raw value for a particular enumeration case is always the same.
 Associated values are set when you create a new constant or variable based on
 one of the emumeration's cases, and can be different each times you do so.
 */



//  MARK: Implicitly Assigned Raw Values
/*
 When you're working with enumerations that store integer or string raw values,
 you don't have to explicitly assign a raw value for each case. When you don't,
 Swift will automatically assign the values for you.
 
 For instance, when integers are used for raw values, the implicit value for
 each case is one more than the previous case. If the first case doesn't have a
 value set, its value is 0.
 When strings are used for raw values, the implicit value for each case is the 
 text of the case's name.
 */
enum PlanetImplicitly: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}

enum CompassPointImplicitly: String {
    case north, south, east, west
}

//  You access the raw value of an enumeration case with its rawValue property
let earthsOrder = PlanetImplicitly.earth.rawValue
//  earthsOrder is 3
let sunsetDirection = CompassPointImplicitly.west.rawValue
//  sunsetDirection is "west"



//  MARK: Initializing from a Raw Value
/*
 If you define an enumeration with a raw-value type, the enumeration 
 automatically receives an intializer that takes a value of the raw value's type
 (as a parameter called rawValue) and returns either an enumeration case or
 nil.
 */
let possiblePlanet = PlanetImplicitly(rawValue: 7)
/*  
 possiblePlanet is of type PlanetImplicitly? and equals
 PlanetImplicityly.uranus.
 Not all possible Int values will find a matching planet, however. Because of 
 this, the raw value initializer always returns an optional enumeration case.
 In the example above, possiblePlanet is of type PlanetImplicitly?, or
 "optional PlanetImplicitly."
 
 NOTE:
 The raw value initializer is a failable intializer, because not every raw 
 value will return an enumeration case.
 */

/*
 If you try to find a planet with a position of 11, the optional 
 PlanetImplicitly value returned by the raw value initializer will be nil.
 */
let positionToFind = 11
if let somePlanet = PlanetImplicitly(rawValue: positionToFind) {
    switch somePlanet {
    case .earth:
        print("Mostly harmless")
    default:
        print("Not a safe place for humans")
    }
} else {
    print("There isn't a planet at position \(positionToFind)")
}
//  Prints "There isn't a planet at position 11"



//  MARK: - Recursive Enumerations
/*
 A recursive enumeration is an enumeration that has another instance of the
 enumeration as the associated value for one or more of the enumeration cases.
 You indicate that an enumeration case is recursive by writing indirect before
 it, which tells the compiler to insert the necessary layer of indirection.
 */
enum ArithmeticExpression {
    case number(Int)
    indirect case addition(ArithmeticExpression, ArithmeticExpression)
    indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
}

/*
 You can also write indirect before the beginning of the enumeration, to 
 enable indirection for all of the enumeration's cases that need it.
 
 This enumeration can store three kinds of arithmetic expressions:
 a plain number, the addition of two expressions, and the multiplication of two
 expression.
 */
indirect enum ArithmeticExpressions {
    case number(Int)
    case additoon(ArithmeticExpressions, ArithmeticExpressions)
    case multiplication(ArithmeticExpressions, ArithmeticExpressions)
}

/*
 For example, the expression (5 + 4) * 2 has number on the right hand side of
 the multiplication and another expression on the left hand side of the
 multiplication.
 Because the data is nested, the enumeration used to store the data also need to
 support nesting.
 The code below shows the ArithmeticExpression recursive enumeration being
 created for (5 + 4) * 2
 */
let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let sum = ArithmeticExpression.addition(five, four)
let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))

/*
 A recursive function is a straightforward way to work with data that has a
 recursive structure.
 */
func evaluate(_ expression: ArithmeticExpression) -> Int {
    switch expression {
    case let .number(value):
        return value
    case let .addition(left, right):
        return evaluate(left) + evaluate(right)
    case let .multiplication(left, right):
        return evaluate(left) * evaluate(right)
    }
}

print(evaluate(product))
//  Prints "18"

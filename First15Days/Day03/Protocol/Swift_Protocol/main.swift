//
//  main.swift
//  Swift_Protocol
//
//  Created by Leo_Lei on 5/10/17.
//  Copyright © 2017 LibertyLeo. All rights reserved.
//

import Foundation

//  Use protocol to declare a protocol.
protocol ExamlpleProtocol {
    var simpleDescription: String { get }
    mutating func adjust()
}

//  Classes, enumeraions, and structs can all adopt protocols.
class SimpleClass: ExamlpleProtocol {
    var simpleDescription: String = "A very simple class"
    var anotherProperty: Int = 69105
    func adjust() {
        simpleDescription += " is now 100% adjusted."
    }
}

var testClass = SimpleClass()
testClass.adjust()
let classDescription = testClass.simpleDescription
print(classDescription)

/*
 The use of the mutating keyword in the declaration of SimpleStructure to
 mark a method that modifies the structure.
 The declaration of SimpleClass doesn't need any of its methods marked as 
 mutating because methods on a class can always modify the class.
 */
struct SimpleStructure: ExamlpleProtocol {
    var simpleDescription: String = "A simple structure"
    mutating func adjust() {
        simpleDescription += "(adjusted)"
    }
}

var testStruct = SimpleStructure()
testStruct.adjust()
let structDescription = testStruct.simpleDescription
print(structDescription)

//  Write an enumeration that conforms to this protocol.    (Exp)
enum SimpleEnumeration: ExamlpleProtocol {
    case original, adjusted
    var simpleDescription: String {
        switch self {
        case .original:
            return "A original value."
        case .adjusted:
            return "Original value has been adjusted."
        }
    }
    
     mutating func adjust() {
        self = .adjusted
    }
}

var testEnum = SimpleEnumeration.original
testEnum.adjust()
let enumDescription = testEnum.simpleDescription
print(enumDescription)

/*
 Use extension to add functionality to an existing type, such as new methods
 and computed properties. You can use an extension to add protocol conformance
 to a type that is declared elsewhere, or even to a type that you imported from
 a library or framework.
 */
extension Int: ExamlpleProtocol {
    var simpleDescription: String {
        return "The number \(self)."
    }
    mutating func adjust() {
        self += 42
    }
}

print(7.simpleDescription)

var testInt = 7
testInt.adjust()
print(testInt.simpleDescription)

/*  
 Write an extension for the Double type that adds an absoluteValue
 property.  (Exp)
 */
extension Double: ExamlpleProtocol {
    var absoluteValue: Double {
        return (self >= 0 ? self : self * (-1))
    }
    
    var simpleDescription: String {
        return "The number of Double is \(self)."
    }
    
    mutating func adjust() {
        self = self.absoluteValue
    }
}

var testNumber: Double = -30.2
print(testNumber.simpleDescription)
testNumber.adjust()
print(testNumber.simpleDescription)

/*
 You can use a protocol name just like any other named type--for example, to
 create a colletion of objects that have different types but that all conform
 to a single protocl. When you work with values whose type is a protocol type,
 methods outside the protocol definition are not available.
 */

let protocolValue: ExamlpleProtocol = SimpleClass()
print(protocolValue.simpleDescription)
//print(protocolValue.anotherProperty)  //  Uncomment to see the error.

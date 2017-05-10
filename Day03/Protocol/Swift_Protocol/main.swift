//
//  main.swift
//  Swift_Protocol
//
//  Created by Leo_Lei on 5/10/17.
//  Copyright © 2017 LibertyLeo. All rights reserved.
//

import Foundation

//  Use protocol to declare a protocol
protocol ExamlpleProtocol {
    var simpleDescription: String { get }
    mutating func adjust()
}

//  Classes, enumeraions, and structs can all adopt protocols
class SimpleClass: ExamlpleProtocol {
    var simpleDescription: String = "A very simple class"
    var anotherProperty: Int = 69105
    func adjust() {
        simpleDescription += " Now 100% adjusted."
    }
}
var classA = SimpleClass()
classA.adjust()
let aDescription = classA.simpleDescription
print(aDescription)

struct SimpleStructure: ExamlpleProtocol {
    var simpleDescription: String = "A simple structure"
    /*  
     The use of the mutating keyword in the declaration of SimpleStructure to 
     mark a method that modifies the structure.
     */
    mutating func adjust() {
        simpleDescription += "(adjusted)"
    }
}

var structB = SimpleStructure()
structB.adjust()
let bDescription = structB.simpleDescription
print(bDescription)

//  FIXME: This enumeration gets problem
//  Write an enumeration that conforms to this protocol
enum SimpleEnumeration: String, ExamlpleProtocol {
    case enumA, enumB, enumC
    var simpleDescription: String {
        switch self {
        case .enumA:
            return "enumA"
        case .enumB:
            return "enumB"
        case .enumC:
            return "enumC"
        }
    }
    
     func adjust() {
        var description = simpleDescription
        switch self {
        case .enumA:
            description += "simpleA"
        case .enumB:
            description += "simpleB"
        case .enumC:
            description += "simpleC"
        }
    }
}

var enumC = SimpleEnumeration.enumA
enumC.adjust()
let cDescription = enumC.simpleDescription
print(cDescription)

/*
 Use extension to add functionally to an existing type, such as new methods
 and computed properties. You can use an extension to add protocol conformance
 to a type that is declared elsewhere, or even to a type that you imported from
 a library or framework.
 */
extension Int: ExamlpleProtocol {
    var simpleDescription: String {
        return "The number \(self)"
    }
    mutating func adjust() {
        self += 42
    }
}

print(7.simpleDescription)

/*  
 Write an Extension for the Double type that adds an absoluteValue 
 property.  (Exp)
 */
extension Double: ExamlpleProtocol {
    var absoluteValue: Double {
        return 20.0
    }
    
    var simpleDescription: String {
        return "The number \(self)"
    }
    
    mutating func adjust() {
        self += absoluteValue
    }
}

print(30.2.simpleDescription)

/*
 You can use a protocol name just like any other named type--for example, to
 create a colletion of objects that have different types but that all conform
 to a single protocl. When you work with values whose type is a protocol type,
 methods outside the protocol definition are not available.
 */
var valueA = SimpleClass()
let protocolValue: ExamlpleProtocol = valueA
print(protocolValue.simpleDescription)
//print(protocolValue.anotherProperty)  //  Uncomment to see the error

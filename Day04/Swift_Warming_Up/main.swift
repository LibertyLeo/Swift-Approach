//
//  main.swift
//  Swift_Warming_Up
//
//  Created by Leo_Lei on 5/11/17.
//  Copyright © 2017 LibertyLeo. All rights reserved.
//

import Foundation

/*
 Constant and variable names can contain almost anycharacter, including
 Unicode character.
 Constant and variable names cannot contain whitespace characters, mathmatical
 symbols, arrows, private-use(or invalid) Unicode code points, or line- and
 box-drawing charaters.
 */
let π = 3.14159265359
let 你好 = "你好世界"
let 🐶🐮 = "dogcow"



/*
 Swift does not require you to write a semicolon(';') after each statement in
 your code, although you can do so if you wish. However, semicolons are required 
 if you want to write multiple separate statements on a single line.
 */
let cat = "🐱"; print(cat)  //  Prints "🐱"



/*
 You can access the minimum and maximum values of each integer type with its
 'min' and 'max' properties.
 In most cases, you don't need to pick a specific size of integer to use in your
 code. Swift provides an additional integer type, 'Int', which has the same size
 as the current platform's native word size:
 On a 32-bit platform, 'Int' is the same size as Int32.
 On a 64-bit platform, 'Int' is the same size as Int64.
 */
let minValue = UInt8.min    //  minValue is equal to 0, and is of type UInt8
let maxValue = UInt8.max    //  maxValue is equal to 255, and is of type UInt8



/*
 Integer literals can be written as:
    A decimal number, with no prefix
    A binary number, with a '0b' prefix
    An octal number, with a '0o' prefix
    A hexadecimal number, with a 0x prefix
 */
let decimalInteger = 17
let binaryInteger = 0b10001     //  17 in binary notation
let octalInteger = 0o21         //  17 in octal notation
let hexadecimalInteger = 0x11   //  17 in hexadeciamlInteger notation

/*
 /*
 For decimal numbers with an exponent of 'exp', the base number is multiplied 
 by 10^exp.
    1.25e2 means 1.25 x 10^2, or 125.0.
    1.25e-2 means 1.25 x 10^(-2), or 0.0125.
 */

 /*
 For hexadecimal numbers with an exponent of 'exp', the base number is multiplied
 by 2^exp.
    0xFp2 means 15 x 2^2, or 60.0.
    0xFp-2 means 15 x 2^(-2), or 3.75
 */
 
 All of these floating-point literals have a decimal value of 12.1875:
*/
let decimalDouble = 12.1875
let exponentDouble = 1.21875e1
let hexadecimalDouble = 0xC.3p0

/*
 Numeric literals can contain extra formatting to make them easier to read.
 Both integers and floats can be padded with extra zeros and can contain
 underscores to help with readability. Neither type of formatting affects the
 underlying value of the literal
 */
let paddedDouble = 000123.456
let oneMillion = 1_000_000
let justOverOneMillion = 1_000_000.000_000_1



/*
 A number that will not fit into a constant or variable of a sized integer type
 is reported as an error when your code is complied.
 */
//let cannotBeNegative: UInt8 = -1
//  UInt 8 can not store negative numbers, and so this will report an error.
//let tooBig: Int8 = Int8.max + 1
//  Int8 cannot store a number larger than its maximum value,
//  and so this will also report an error.
let twoThousand: UInt16 = 2_000
let one: UInt8 = 1
let twoThousandAndOne = twoThousand + UInt16(one)

/*
 Conversion between integer and floating-point numeric types must be made
 explicit
 */
let three = 3
let pointOneFourOneFiveNine = 0.14159
let pi = Double(three) + pointOneFourOneFiveNine
//  pi equals 3.14159, and is inferred to be of type Double

//  An integer type can be initialized with a 'Double' or 'Float' value
let intergerPi = Int(pi)
//  integerPi equals 3, and is inferred to be of type Int



/*
 Type aliases define alternative name for an exiting type.
 You define type aliases with the typealias keyword.
 */
typealias AudioSample = UInt16
var maxAmplitudeFound = AudioSample.min    //  maxAmplitude is now 0



/*
 Boolean values are referred to as logical, because they can only ever be true
 or false.Swift provides two Boolean constant values, 'true' adn 'false'.
 */
let orangeAreOrange = true
let turnipsAreDelicious = false

/*
 Boolean values are particularly useful when you work with conditional 
 statements such as the 'if' statement
 */
if turnipsAreDelicious {
    print("Mmm, tasty turnips!")
} else {
    print("Eww, turnips are horrible.")
}
//  Prints "Eww, turnips are horrible."

/*
 Swift's type safety prevents non-Boolean values from being substitued for
 'Bool'.
 */
//let i = 1
//if i {
    //  this example will not compile, and will report an error
//}

let ii = 1
if ii == 1 {
    // this example will compile successfully
}



/*
 Tuples group multiple values into a single compound value. The values within
 a tuple can be of any type and do not have to be of the same type as each other.
 Take "404 Not Found" error as example
 */
let http404Error = (404, "Not Found")
//  http404Error is of type (Int, String), and equals (404, "Not Found")

/*
 You can decompose a tuple's content into separate constants or variables,
 which you then access as usual.
 */
let (statusCode, statusMessage) = http404Error
print("The status code is \(statusCode)")
//  Prints "The status code is 404"
print("The status message is \(statusMessage)")
//  Prints "The status message is Not Found"

/*
 If you only need some of the tuple's values, ignore parts of the tuple with an
 underscore (_) when you decompose the tuple:
 */
let (justTheStatusCode, _) = http404Error
print("The status code is \(justTheStatusCode)")
//  Prints "The status code is 404"

/*
 Alternatively, access the individual element values in a tuple using index 
 numbers starting at zero.
 */
print("The status code is \(http404Error.0)")
//  Prints "The status code is 404"
print("The status message is \(http404Error.1)")
//  Prints "The status message is Not Found"

/*
 You can name the individual elements in a tuple when the tuple is defined.
 If you name the elements in a tuple, you can use the element names to access
 the values of those elements.
 */
let http200Status = (statusCode: 200, description: "OK")
print("The status code is \(http200Status.statusCode)")
//  Prints "The status code is 200"
print("The status message is \(http200Status.description)")
//  Prints "The status message is OK"



/*
 Because the initializer might fail, it returns an optional 'Int', rather than
 an 'Int'.
 An optional 'Int' is written as 'Int?', not 'Int'. The question mark indicates
 it might constains some 'Int' value, or it might contain no value at all.
 */
let possibleNumber = "123"
let convertedNumber = Int(possibleNumber)
//  convertedNumber is inferred to be of type "Int?", or "optional Int"

/*
 You set an optional variable to a valueless state by assigning it the special
 value 'nil'.
 */
var serverResponseCode: Int? = 404
//  serverResponseCode contains an actual Int value of 404
serverResponseCode = nil
//  serverresponseCode now contains no value

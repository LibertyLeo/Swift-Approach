//
//  main.swift
//  Swift_Strings_and_Characters
//
//  Created by Leo_Lei on 5/12/17.
//  Copyright © 2017 LibertyLeo. All rights reserved.
//

import Foundation

/*
 NOTE:  Swift's 'String' tyoe is bridge with Foundation's 'NSString' class.
 If you import Foundation, you can access those 'NSString' methods on 'String'
 without casting.
 */



//  MARK: String Literals
/*
 You can include predefined 'String' values within your code as string literals.
 Use a string literal as an initial value for a constant or variable
 */
let someString = "Some string literal value"



//  MARK: Initializing an Empty String
/*
 To create an empty 'String' value as the starting point for building a longer
 string, either assign an empty string literal to a variable, or initialize a 
 new 'String' instance with initializer syntax.
 */
var emptyString = ""    //  empty string literal
var anotherEmptyString = String()   //  initializer syntax
//  These two strings are both empty, and are equivalent to each other

/*
 Find out whether a 'String' value is empty by checking its Boolean 'isEmpty'
 property.
 */
if emptyString.isEmpty {
    print("Nothing to see here")
}
//  Prints "Nothing to see here"



//  MARK: String Mutability
/*
 You indicate whether a particular 'String' can be modified(or mutated) by 
 assigning it to a variable(in which case it can be modified), or to a constant
 (in which case it cannot be modified)
 */
var variableString = "Horse"
variableString += " and carriage"
//  variableString is now "Horse and carriage"

let constantString = "Highlander"
//constantString += " and another Highlander"
//  This reports a compile-time error - a constant string cannot be modified



//  MARK: String Are Value Types
/*
 Swift's 'String' type is a value type.
 Swift's copy-by-default 'String' behavior ensures that when a funciton or 
 method passes you a 'String' value, it is clear that you own that exact 
 'String' value, regardless of where it came from.
 Behind the scenes, Swift's compiler optimizes string usage so that actual
 copying takes place only when absolutely necessary.
 */



//  MARK: Working with Characters
/*
 You can access the individual 'Character' values for a 'String' by iterating
 over its 'characters' property with a 'for-in' loop.
 */
for character in "Dog!🐶".characters {
    print(character)
}

//  D
//  o
//  g
//  !
//  🐶

/*
 Alternatively, you can create a stand-alone 'Charcter' constant or variable
 from a single-character string literal by providing a 'Charcter' type 
 annotation.
 */
let exclamationMark: Character = "!"

/*
 'String' values can be constructed by passing an array of 'Character' values
 as an argument to its initializer
 */
let catCharacter: [Character] = ["C", "a", "t", "!", "🐱"]
let catString = String(catCharacter)
print(catString)
//  Prints "Cat!🐱"



//  MARK: Concatenating Strings and Characters
/*
 'String' value can be added together (or concatenated) in three ways:
    With the addition operator (+) to create a new 'String' value.
    With the addition assignment operator (+=).
    With the 'String' type's 'append()' method.
 */
let string1 = "hello"
let string2 = " there"
var welcome = string1 + string2
//  welcome now equals "hello there"

var instruction = "look over"
instruction += string2
//  instruction now equals "look over there"

let exclamaMark: Character = "!"
welcome.append(exclamaMark)
//  welcome now equals "hello there!"

/*
 NOTE:  You can't append a 'String' or 'Character' to an existing 'Character'
 variable, because a 'Character' value must contain a single character only.
 */



//  MARK: String Interpolation
/*
 String interpolation is a way to construct a new 'String' value from a mix
 of constants, variables, literals, and expressions by including their values
 inside a string literal.
 Each item that you insert into the string literal is wrapped in a pair of 
 parentheses, prefixed by a backslash (\)
 */
let multiplier = 3
let message = "\(multiplier) times 2.5 is \(Double(multiplier) * 2.5)"
//  message is "3 times 2.5 is 7.5

/*
 NOTE:  The expressions you write inside parentheses within an interpolated 
 string cannot contain an unescaped backslash (\), a carriage return, or a 
 line feed.
 */



//  MARK: Unicode
/*
 Unicode is an international standard for encoding, representing, and processing
 text in different writing systems.
 Swift's native 'String' type is built from Unicode scalar values.
 A Unicode scalar is a unique 21-bit number for a character or modifier, such as
 'U+0061' for 'LATIN SMALL LETTER A ("a")', or 'U+1F425' for 'FRONT_FACING BABY
 CHICK("🐥")'
 */

/*
 NOTE:  A Unicode scalar is any Unicode code point in the range 'U+0000' to 
 'U+D7FF' inclusive or 'U+E000' to 'U+10FFFF' inclusive. Unicode scalars do not
 include the Unicode surrogate pair code points, which are the code points in 
 the range 'U+D800' to 'U+DFFF' inclusive.
 */



//  MARK: Special Characters in String Literals
/*
 String literal can include the follwing special characters:
    The escaped special characters '\0' (null character), '\\' (backslash),
'\t' (horizontal tab), '\n' (line feed), '\r' (carriage return), 
 '\"' (double quote) and '\'' (single quote)
    An arbitrary Unicode scalar, written as '\u{n}', where n is a 1-8 digit 
 hexadecimal number with a value equal to a valid Unicode code point.
 Unicode scalar format example:
 */
let wiseWords = "\"Imagination is more important than knowledge\" - Einstein"
let dollarSign = "\u{24}"
let blackHeart = "\u{2665}"
let sparklingHeart = "\u{1F496}"
print(wiseWords)    //  "Imagination is more important than knowledge" - Einstein
print(dollarSign)   //  $, Unicode scalar U+0024
print(blackHeart)   //  ♥, Unicode scalar U+2665
print(sparklingHeart)   //  💖, Unicode scalar U+1F496

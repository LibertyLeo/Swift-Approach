//
//  main.swift
//  Strings_and_Characters
//
//  Created by Leo_Lei on 5/12/17.
//  Copyright © 2017 LibertyLeo. All rights reserved.
//

import Foundation

/*
 NOTE:
 Swift's String tyoe is bridge with Foundation's NSString class.
 If you import Foundation, you can access those NSString methods on String
 without casting.
 */

//  MARK: String Literals
/*
 You can include predefined String values within your code as string literals.
 Use a string literal as an initial value for a constant or variable
 */
let someString = "Some string literal value"



//  MARK: Initializing an Empty String
/*
 To create an empty String value as the starting point for building a longer
 string, either assign an empty string literal to a variable, or initialize a
 new String instance with initializer syntax.
 */
var emptyString = ""    //  empty string literal
var anotherEmptyString = String()   //  initializer syntax
//  These two strings are both empty, and are equivalent to each other

/*
 Find out whether a String value is empty by checking its Boolean isEmpty
 property.
 */
if emptyString.isEmpty {
    print("Nothing to see here")
}
//  Prints "Nothing to see here"



//  MARK: String Mutability
/*
 You indicate whether a particular String can be modified(or mutated) by
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
 Swift's String type is a value type.
 Swift's copy-by-default String behavior ensures that when a funciton or method
 passes you a String value, it is clear that you own that exact String value,
 regardless of where it came from.
 Behind the scenes, Swift's compiler optimizes string usage so that actual
 copying takes place only when absolutely necessary.
 */



//  MARK: Working with Characters
/*
 You can access the individual Character values for a String by iterating
 over its characters property with a for-in loop.
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
 Alternatively, you can create a stand-alone Charcter constant or variable
 from a single-character string literal by providing a Charcter type annotation.
 */
let exclamationMark: Character = "!"

/*
 String values can be constructed by passing an array of Character values
 as an argument to its initializer
 */
let catCharacter: [Character] = ["C", "a", "t", "!", "🐱"]
let catString = String(catCharacter)
print(catString)
//  Prints "Cat!🐱"



//  MARK: Concatenating Strings and Characters
/*
 String value can be added together (or concatenated) in three ways:
 With the addition operator (+) to create a new String value.
 With the addition assignment operator (+=).
 With the String type's append() method.
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
 NOTE:
 You can't append a String or Character to an existing Character variable,
 because a Character value must contain a single character only.
 */



//  MARK: String Interpolation
/*
 String interpolation is a way to construct a new String value from a mix
 of constants, variables, literals, and expressions by including their values
 inside a string literal.
 Each item that you insert into the string literal is wrapped in a pair of
 parentheses, prefixed by a backslash (\)
 */
let multiplier = 3
let message = "\(multiplier) times 2.5 is \(Double(multiplier) * 2.5)"
//  message is "3 times 2.5 is 7.5

/*
 NOTE:
 The expressions you write inside parentheses within an interpolated string
 cannot contain an unescaped backslash (\), a carriage return, or a line feed.
 */



//  MARK: Unicode
/*
 Unicode is an international standard for encoding, representing, and processing
 text in different writing systems.
 Swift's native String type is built from Unicode scalar values.
 A Unicode scalar is a unique 21-bit number for a character or modifier, such as
 U+0061 for 'LATIN SMALL LETTER A ("a")', or U+1F425 for 'FRONT_FACING BABY
 CHICK("🐥")'
 */

/*
 NOTE:
 A Unicode scalar is any Unicode code point in the range U+0000 to U+D7FF
 inclusive or U+E000 to U+10FFFF inclusive. Unicode scalars do not include
 the Unicode surrogate pair code points, which are the code points in the range
 U+D800 to U+DFFF inclusive.
 */



//  MARK: Special Characters in String Literals
/*
 String literal can include the follwing special characters:
 The escaped special characters \0 (null character), \\ (backslash),
 \t (horizontal tab), \n (line feed), \r (carriage return),
 \" (double quote) and \' (single quote)
 An arbitrary Unicode scalar, written as \u{n}, where n is a 1-8 digit
 hexadecimal number with a value equal to a valid Unicode code point.
 Unicode scalar format example:
 */
let wiseWords = "\"Imagination is more important than knowledge\" - Einstein"
//  "Imagination is more important than knowledge" - Einstein
let dollarSign = "\u{24}"           //  $, Unicode scalar U+0024
let blackHeart = "\u{2665}"         //  ♥, Unicode scalar U+2665
let sparklingHeart = "\u{1F496}"    //  💖, Unicode scalar U+1F496

//  MARK: Extended Grapheme Clusters
/*
 Every instance of Swift's Character type represents a single extended
 grapheme cluster.
 The letter é can be representd as the single Unicode scalar é (LATEN SMALL
 LETTER E WITH ACUTE, or U+00E9). However, the same letter can also be
 represented as a pair of scalars--a standard letter e (LATIN SMALL LETTER E,
 or U+0065), followed by the 'COMBINING ACUTE ACCENT' scalar(U+0301).
 */
let eAcute: Character = "\u{E9}"                //  é
let combinedEAcute: Character = "\u{65}\u{301}" //  é followed by '
// eAcute is é, combinedEAcute is é

/*
 Extended grapheme clusters are a flexiblle way to represent many complex script
 characters as a single Character vallue.
 For example, Hangul syllables from the Korean alphabet can be represented as
 precomposed or decomposed sequence.
 */
let precomposed: Character = "\u{D55C}"                 //  한
let decomposed: Character = "\u{1112}\u{1161}\u{11AB}"  //  ᄒ   ᅡ   ᆫ
// precompsed is 한, decomposed is 한

/*
 Extended grapheme clusters enable scalars for enclosing marks to enclose other
 Unicode scalars as part of a single Character value.
 */
let enclosedEAcute: Character = "\u{E9}\u{20DD}"
// enclosedEAcute is é⃝

/*
 Unicode scalars for reegional indicator symbols can be combined in pairs.
 */
let regionalIndicatorForUS: Character = "\u{1F1F8}"
// regionalIndicatorForUS is 🇺🇸



//  MARK: Counting Characters
/*
 To retrieve a count of the Character values in a string, use the count
 property of the string's characters property
 */
let unusualMenagerie = "Koala 🐨, Snail 🐌, Penguin 🐧, Dromedary 🐫"
print("unusualMenagerie has \(unusualMenagerie.characters.count) charcters")
// Prints "unusualMenagerie has 40 characters

/*
 Swift's use of extended grapheme clusters for Character values means that
 string concatenation and modification may not always affect a string's
 character count.
 */
var word = "cafe"
print("the number of chacters in \(word) is \(word.characters.count)")
// Prints "the number of characters in cafe is 4"

word += "\u{301}"   //  COMBINING ACUTE ACCENT, U+0301
print("the number of chacters in \(word) is \(word.characters.count)")
// Prints "the number of characters in cafe is 4"



//  MARK: Accessing and Modifying a String
/*
 Each String value has an associated index type, String.Index, which
 corresponds to the position of each Character in the String.
 In order to determine which Characters is at a particular position, you
 must iterate over each Unicode scalar from the start or end of the String.
 For this reason, Swift strings cannot be indexed by integer values.
 You can use subscript syntax to access the Character at a particular String
 index.
 */
let greeting = "Guten Tag!"
greeting[greeting.startIndex]
// G
greeting[greeting.index(before: greeting.endIndex)]
// !
greeting[greeting.index(after: greeting.startIndex)]
// u
let index = greeting.index(greeting.startIndex, offsetBy: 7)
// a
greeting[index]

/*
 Attempting to access an index outside of a string's range or a Chacter at an
 index outside of a string's range will trigger a runtime error.
 */
//greeting[greeting.endIndex]                 // Error
//greeting.index(after: greeting.endIndex)    // Error

/*
 Use the indices property of the character property to access all of the
 indices of individual charaters in a string.
 */
for index in greeting.characters.indices {
    print("\(greeting[index])", terminator: " ")
}
print("")
//  Prints "G u t e n   T a g ! "

/*
 NOTE:
 You can use the startIndex and endIndex properties and the
 (index(before:), index(after:), and (index(_:offsetBy:) methods on any
 type that conforms to the Collection protocol. This includes String, as
 shown here, as well as collection types such as Array, Dictionary, and Set.
 */



//  MARK: Inserting and Removing
/*
 To insert a single character into a string at a specified index, use the
 insert(_:at:) method, and to insert the contents of another string at a
 specified index, use the insert(contentsOf:at:) method.
 */
var welcomeInsert = "hello"
welcomeInsert.insert("!", at: welcomeInsert.endIndex)
// welcomeInsert now equals "hello!"

welcomeInsert.insert(contentsOf: " there".characters,
                     at: welcomeInsert.index(before : welcomeInsert.endIndex))
// welcomeInsert now equal "hello there!"

/*
 To remove a single character from a string at a specified index, use the
 remove(at:) method, and to remove a substring at a specified range, use the
 removeSubrange(_:) method
 */
welcomeInsert.remove(at: welcomeInsert.index(before: welcomeInsert.endIndex))
// welcome now equals "hello there"

let range = welcomeInsert.index(welcomeInsert.endIndex, offsetBy: -6)..<welcomeInsert.endIndex
welcomeInsert.removeSubrange(range)
// welcome now equals "hello"

/*
 NOTE:
 Above methods on any type that conforms the RangeReplaceableCollection
 protocol. This includes String as shown here, as well as collection types
 such as Array, Dictionary, and Set.
 */



/*
 Swift provides three ways to compare textual values: string and character
 equality, prefix equality and suffix equality.
 */
//  MARK: String and Character Equality
/*
 String and charater equality is checked with the "equal to" operator (==) and
 the "not equal to" operator (!=).
 */
let quotation = "We're a lot alike, you and I."
let sameQuotation = "We're a lot alike, you and I."
if quotation == sameQuotation {
    print("These two strings are considered equal")
}
// Prints "These two strings are considered equal"

/*
 Two String values (or two Character values) are considered equal if their
 extended grapheme clusters are canonically equivalent. Extend grapheme clusters
 are canonically equivalent if they have the same linguistic meaning and
 appearance, even if they are composed from different Unicode scalars behind
 the scenes.
 */
//  "Voulez-vous un café?" using LATIN SMALL LETTER E WITH ACUTE
let eAcuteQuestion = "Voulez-vous un caf\u{E9}?"

//  "Voulez-vous un café?" using LATIN SMALL LETTER E and COMBINING ACUTE ACCENT
let combinedEAcuteQustion = "Voulez-vous un caf\u{65}\u{301}?"

if eAcuteQuestion == combinedEAcuteQustion {
    print("These two strings are considered equal")
}
// Prints "These two strings are considered equal"

/*
 Conversely, LATIN CAPITAL LETTER A (U+0041, or "A"), as used in English, is
 not quivalent to CYRILLIC CAPITAL LETTER A (U+0410, or "A"), as used in
 Russian. THe characters are visually similar, but do not have the same
 linguistic meaning
 */
let latinCapitalLetterA: Character = "\u{41}"
let cyrillicCapitalLetterA: Character = "\u{0410}"

if latinCapitalLetterA != cyrillicCapitalLetterA {
    print("These two characters are not equivalent.")
}
// Prints "These two strings are not equivalent."

/*
 NOTE:  String and character comparisions in Swift are not local-sensitive.
 */



//  MARK: Prefix and Suffix Equality
/*
 To check whether a string has a particular string prefix or suffix, call the
 string's hasPrefix(_:) and hasSuffix(_:) methods, both of which take a
 single argument of type String and return a Boolean value.
 */
let romeoAndJuliet = [
    "Act 1 Scene 1: Verona, A public place",
    "Act 1 Scene 2: Capulet's mansion",
    "Act 1 Scene 3: A room in Capulet's mansion",
    "Act 1 Scene 4: A street outside Capulet's mansion",
    "Act 1 Scene 5: The Great Hall in Capulet's mansion",
    "Act 2 Scene 1: Outside Capulet's mansion",
    "Act 2 Scene 2: Capulet's orchard",
    "Act 2 Scene 3: Outside Friar Lawrence's cell",
    "Act 2 Scene 4: A street in Verona",
    "Act 2 Scene 5: Capulet's mansion",
    "Act 2 Scene 6: Friar Lawrence's cell",
]

/*
 You can use the hasPrefix(_:) method with the romeoAndJuilet array to count
 the number of scenens in Act 1 of the play.
 */
var act1SceneCount = 0
for scene in romeoAndJuliet {
    if scene.hasPrefix("Act 1 ") {
        act1SceneCount += 1
    }
}

print("There are \(act1SceneCount) scenes in Act 1")
// Prints "There are 5 scenes in Act 1"

/*
 Similarly, use the hasSuffix(_:) method to count the number of scenes that
 take place in or around Capulet's mansion and Friar Lawrence's cell.
 */
var mansionCount = 0
var cellCount = 0
for scene in romeoAndJuliet {
    if scene.hasSuffix("Capulet's mansion") {
        mansionCount += 1
    } else if scene.hasSuffix("Friar Lawrence's cell") {
        cellCount += 1
    }
}

print("\(mansionCount) mansion scenes; \(cellCount) cell scenes")
// Prints "6 mansion scenes; 2 cell scenes"

/*
 NOTE:
 The hasPrefix(_:) and hasSuffix(_:) methods perform a character-by-character
 canonical equivalence comparison between the extended grapheme clusters in each
 string.
 */



//  MARK: Unicode Representations of Strings
/*
 When a Unicode string is written to a text file or some other storage, the
 Unicode scalars in that string are encoded in one of several Unicode-defined
 encoding forms.
 Each form encodes the string in small chunks known as code units.
 You can iterate over the string with a for-in statement, to access its
 individual Character values as Unicode extended grapheme clusters.

 Alternatively, access a String value in one of three other
 Unicode-compliant epresentations:
 A collection of UTF-8 code units (accessed with the string's utf8
 property)
 A collection of UTF-16 code units (accessed with the string's utf16
 property)
 A collection of 21-bit Unicode scalar values, equivalent to string's
 UTF-32 encoding form (accessed with the string's unicodeScalars property)

 Each example below shows a different representation of the following string,
 which is made up of the characters D, o, g, !! (DOUBLE EXCLAMATION
 MARK, or Unicode scalar U+203C), and the 🐶 character (DOG FACE, or
 Unicode scalar U+1F436)
 */
let dogString = "Dog‼🐶"

/*
 UTF-8 Representation
 You can access a UTF-8 representation of a String by iterating over its utf8
 property. This property is of type String.UTF8View, which is a collection of
 unsigned 8-bit (UInt8) values, one for each byte in the string's UTF-8
 representation.

 Character     D       o       g         ‼            🐶
 U+0044  U+006F  U+0067   U+203C        U+1F436

 UTF-8         68      111     103   226 128 188    240 159 144 182
 Code Unit

 Position      0       1       2     3   4   5      6   7   8   9

 */
for codeUnit in dogString.utf8 {
    print("\(codeUnit)", terminator:" ")
}
print("")
//  Prints "68 111 103 226 128 188 240 159 144 182"

/*
 In the example above:
 The first three decimal codeUnit values (68, 111, 103) represent the
 characters D, o, and g, whost UTF-8 representation is the same as their
 ASCII representations.
 The next three decimal codeUnit values (226, 128, 188) are a three-byte UTF-8
 representation of the 'DOUBLE EXCLAMATION MARK' character.
 The last four codeUnit values (240, 159, 144, 182) are a four-byte UTF-8
 representation of the 'DOG FACE' character.
 */

/*
 UTF-16 Representation
 Access for utf16 property which is of type String.UTF16View.

 Character     D       o       g       ‼         🐶
 U+0044  U+006F   U+0067  U+203C    U+1F436

 UTF-16       68      111     103    8252      55357 56374
 Code Unit

 Position      0       1       2     3         4     5
 */
for codeUnit in dogString.utf16 {
    print("\(codeUnit)", terminator:" ")
}
print("")
//  Prints "68 111 103 8252 55357 56374"

/*
 Unicode Scalar Representation
 Access for unicodeScalars property which is of type UnicodeScalarView, is
 a collection of values of type UnicodeScalar.

 Character     D       o       g       ‼         🐶
 U+0044  U+006F   U+0067  U+203C    U+1F436

 UnitCode
 Scalar       68      111     103     8252     128054
 Code Unit

 Position      0       1       2       3       4
 */
for codeUnit in dogString.utf16 {
    print("\(codeUnit)", terminator:" ")
}
print("")
//  Prints "68 111 103 8252 128054"

/*
 As an alternatively to querying their value properties, each UnicodeScalar
 value can also be used to construct a new String value, such as with string
 interpolation
 */
for scalar in dogString.unicodeScalars {
    print("\(scalar)")
}

//  D
//  o
//  g
//  !!
//  🐶

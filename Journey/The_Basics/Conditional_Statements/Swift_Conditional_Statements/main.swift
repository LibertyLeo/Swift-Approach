//
//  main.swift
//  Swift_Conditional_Statements
//
//  Created by Leo_Lei on 5/18/17.
//  Copyright © 2017 LibertyLeo. All rights reserved.
//

import Foundation

//  MARK: Conditional Statements
/*
 Swift provides two ways to add conditional branches to your code: the if
 statement and the switch statement.
 Typically, you use the if statement to evaluate simple conditions with only a
 few possible outcomes.
 The switch statement is better suited to more complex conditions with multiple
 possible permutations and is useful in situations where pattern matching can
 help select an appropriate code branch to execute.
 */

//  MARK: - If
/*
 In its simplest form, the if statement has a single if condition.
 */
var temperatureInFahrenheit = 30
if temperatureInFahrenheit <= 32 {
    print("It's very code. Consider wearing a scarf.")
}
//  Prints "It's very code. Consider wearing a scarf."

/*
 The if statement can provide an alternative set of statements, known as an
 else clause, for situations when the if condition is false.
 */
temperatureInFahrenheit = 40
if temperatureInFahrenheit <= 32 {
    print("It's very code. Consider wearing a scarf.")
} else {
    print("It's not that cold. Wear a t-shirt.")
}
//  Prints "It's not that cold. Wear a t-shirt."

/*
 You can chain multiple if statements together to consider additional clauses.
 */
temperatureInFahrenheit = 90
if temperatureInFahrenheit <= 32 {
    print("It's very code. Consider wearing a scarf.")
} else if temperatureInFahrenheit >= 86 {
    print("It's really warm. Don't forget to wear sunscreen.")
} else {
    print("It's not that cold. Wear a t-shirt.")
}
//  Prints "It's really warm. Don't forget to wear sunscreen."

/*
 The final else clause is optional, however, and can be excluded if the set of
 conditions does not need to be complete.
 */
temperatureInFahrenheit = 72
if temperatureInFahrenheit <= 32 {
    print("It's very code. Consider wearing a scarf.")
} else if temperatureInFahrenheit >= 86 {
    print("It's really warm. Don't forget to wear sunscreen.")
}

//  MARK: - Switch
/*
 A switch statement considers a value and compares it against several possible
 matching patterns.
 A switch statement provides an alternative to the if statement for
 responding to multiple potential states.

 ///    switch <#some value to consider#> {
 ///    case <#value 1#>:
 ///    <#respond to value 1#>
 ///    case <#value 2#>:
 ///         <#value 3#>:
 ///    <#respond to value 2 or 3#>
 ///    default:
 ///    <#otherwise, do somthing else#>
 ///    }

 Every switch statement consists of multiple posiible cases, each of which
 begins with the case keyword.
 Every switch statement must be exhaustive. That is, every possible value of
 the type begin considered must be matched by one of the switch cases.
 If it's not appropriate to provide a case for every possible value, you can
 define a default case indicated by the default keyword, and must always appear
 last.
 */
let someCharacter: Character = "z"
switch someCharacter {
case "a":
    print("The first letter of the alphabet")
case "z":
    print("The last letter of the alphabet")
default:
    print("Some other character")
}
//  Prints "The last letter of the alphabet"



//  MARK: No implicit Fallthrough
/*
 switch statements in Swift do not fall through the bottom of each case and
 into the next one by default.
 The entire switch statement finishes its executing as soon as the first
 matching switch case is completed, without requiring an explict break
 statement.

 NOTE:
 Although break is not required in Swift, you can use a break statement to
 match and ignore a particular case or to break out of a matched case before
 that case has completed its execution.
 */

/*
 The body of each case must contain at least one executable statement.
 It is not valid to write the following code, because the first case is empty.
 */
let anotherCharacter: Character = "a"
switch anotherCharacter {
    //  FIXME: Uncomment me
//case "a":   //  Invalid, the case has an empty body
case "A":
    print("The letter A")
default:
    print("Not the letter A")
}
//  This will report a compile-time error.
/*
 This approach avoid accidental fallthrough from one case to another and makes
 for safe code that is clearer in its intent.
 To make a switch with a single case that matches both "a" and "A", combine
 the two values into a compound case, separating the values with commas.
 */
let anotherCharacterCombine: Character = "a"
switch anotherCharacter {
case "a", "A":
    print("The letter A")
default:
    print("Not the letter A")
}
//  Prints "The letter A"
/*
 For readability, a compound case can also be written over multiple lines.

 NOTE:
 To explicitly fall through at the end of a particular switch case, use the
 fallthrough keyword.
 */



//  MARK: Interval Matching
//  Value in switch case can be checked for their inclusion in an interval.
let approximateCount = 62
let countedThings = "moons orbiting Saturn"
let naturalCount: String
switch approximateCount {
case 0:
    naturalCount = "no"
case 1..<5:
    naturalCount = "a few"
case 5..<12:
    naturalCount = "several"
case 12..<100:
    naturalCount = "dozens of"
case 100..<1000:
    naturalCount = "hundreds of"
default:
    naturalCount = "many"
}
print("There are \(naturalCount) \(countedThings).")
//  Prints "There are several moons orbiting Saturn."



//  MARK: Tuples
/*
 You can use tuples to test multiple values in the same switch statement.
 Each element of the tuple can be tested against a different value or interval
 of values.
 Alternatively, use the underscore character (_), also known as the wildcard
 pattern, to match any possible value.
 */
let somePoint = (1, 1)
switch somePoint {
case (0, 0):
    print("\(somePoint) is at the origin")
case (_, 0):
    print("\(somePoint) is on the x-axis")
case (0, _):
    print("\(somePoint) is on the y-axis")
case (-2...2, -2...2):
    print("\(somePoint) is outside of the box")
default:
    print("\(somePoint) is inside of the box")
}
//  Prints "(1, 1) is inside the box
/*
 In fact, the point (0, 0) could match all four of the cases in this example.
 However, if multiple matches are possible, the first matching case is always
 used. The point (0, 0) would match case (0, 0) first, and so all other 
 matching cases would be ignore.
 */



//  MARK: Value Bindings
/*
 A switch case can name the value or values it matches to temporary constants
 or variables, for use in the body of the case.
 This behavior is known as value binding, because the values are bound to 
 temporary constants or variables within the case's body.
 */
let anotherPoint = (2, 0)
switch anotherPoint {
case (let x, 0):
    print("on the x-axis with an x value of \(x)")
case (0, let y):
    print("on the y-axis with a y  value of \(y)")
case let (x, y):
    print("somewhere else at (\(x), \(y))")
}
// Prints "on the x-axis with an x value of 2"
/*
 The switch statement does not have a default case.
 The final case, case let (x, y), declares a tuple of two placehoder constants
 that can match any value.
 Because anotherPoint is always a tuple of two values, this case matches all
 possible remaining values, and a default case is not needed to make the
 switch statement exhaustive.
 */



//  MARK: Where
//  A switch case can use a where clause to check for additional conditions.
let yetAnotherPoint = (1, -1)
switch yetAnotherPoint {
case let (x, y) where x == y:
    print("(\(x), \(y)) is on the line x == y")
case let (x, y) where x == -y:
    print("(\(x), \(y)) is on the line x == -y")
case let (x, y):
    print("(\(x), \(y)) is just some arbitrary point")
}



//  MARK: Compound Cases
/*
 Multiple switch cases that share the same body can be combined by writting
 several patterns after case, with a comma between each of the patters.
 The patterns can be written over multiple lines if the list is long.
 */
let someCharacterCombine: Character = "e"
switch someCharacterCombine {
case "a", "e", "i", "o", "u":
    print("\(someCharacterCombine) is a vowel")
case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m", "n", "p", "q", "r", "s",
     "t", "v", "w", "x", "y", "z":
    print("\(someCharacterCombine) is a consonant")
default :
    print("\(someCharacterCombine) is not a vowel or a consonant")
}
// Prints "e is a vowel"

/*
 Compounds cases can also include value bindings.
 No matter which part of the compound case matched, the code in the body of the
 case can always access a value for the bindings and that the value always has 
 the same type.
 */
let stillAnotherPoint = (9, 0)
switch stillAnotherPoint {
case (let distance, 0), (0, let distance):
    print("On an axis, \(distance) from the origin")
default:
    print("Not on an axis")
}
// Prints "On an axis, 9 from the origin"
/*
 Both patterns include a binding for distance and distance is an integer in
 both patterns--which means that the code in the body of the case can always a
 value for distance
 */

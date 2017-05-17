//
//  main.swift
//  Swift_Basic_Operators
//
//  Created by Leo_Lei on 5/12/17.
//  Copyright © 2017 LibertyLeo. All rights reserved.
//

import Foundation

//  MARK: Terminology
/*
 Operators are unary, binary, ternary.
    Unary prefix operators appear immediately before their tagert(such as !b),
 and unary postfix operators appear immediately after their targer(such as c!).
    Binary operators operate on two targets(such as 2 + 3) and are infix 
 because they appear in between their two targets.
    Ternary operators operate on three targets. Like C, Swift has only one 
 ternary operator, the ternary conditional operator(a ? b : c).
 */



//  MARK: Arithmetic Operator
//  The additional operator is also supported for 'String' concatenation.
if ("hello, " + "world") == "hello, world" {
    print("The additional operator can be supported for String concatenation.")
}



//  MARK: Remainder Operator
/*
 The sign of 'b' is ignored for negative value of 'b'.
 This means that 'a % b' and 'a % -b' always given the same answer.
 */
if (-9 % 4) == (-9 % (-4)) {
    print("Both expression's result are just same.")
}



//  MARK: Compound Assign Operators
/*
 NOTE: 
 The compound assignment operators do not return a value.
 For example, you cannot write let b = a+= 2.
 */



//  MARK: Comparison Operators
/*
 Swift also provides two identity operators (=== and !==), which you use to 
 test whether two object refrences both refer to the same object instance.

 Both 'Int' and 'String' can be compared, which means tuples of the type 
 (Int, String) can be compared.
 Tuples are compared from left to right, one value at a time, until the
 comparision find two values that aren't equal.
 */
if (1, "zebra") < (2, "apple") {
    print("1 is less than 2, \"zebra\" and \"apple\" are not compared.")
}

if (3, "apple") < (3, "bird") {
    print("3 is equal to 3, and \"apple\" is less than \"bird\".")
}

if (4, "dog") == (4, "dog") {
    print("4 is equal to 4, and \"dog\" is equal to \"dog\".")
}

/*
 NOTE:
 The Swift standard library includes tuple comparison operators for tuples with 
 fewer than seven elements. To compare tuples with seven or more elements, you 
 must implement the comparison operators yourself.
 */



//  MARK: Ternary Conditional Operator
/*
 The ternary conditional operator is a special operator with three parts, which
 takes the form 'question ? answer1 : answer2'.
 The ternary conditional operator provides an efficient shorthand for deciding
 which of two expression to consider. But its conciseness can lead to 
 hard-to-read code if overused. Avoid combining multiple instances of the 
 ternary conditional operator into one compounds statement.
 */



//  MARK: Nil-Coalescing Operator
/*
 The nil-coalescing operator (a ?? b) unwraps an optional 'a' if it contains a
 value, or returns a default value 'b' is 'a' is 'nil'.
 The nil-coalescing operator is shorthand for the code(a != nil ? a! : b).
 The nil-coalescing operator provides a more elegant way to encapsulate this
 conditional checking and unwrapping in a concise and readable form.( a ?? b)
 */



//  MARK: - Range Operators
//  MARK: Closed Range Operator
/*
 The closed range operator (a...b) defines a range that returns from 'a' to 'b',
 and includes the values 'a' and 'b'.
 The value of 'a' must not be greater than 'b'.
 */



//  MARK: Half-Open Range Operator
/*
 The half-open range operator (a..<b) defines a range that runs from 'a' to 'b',
 but does not include 'b'.
 */



//  MARK: Combining Logical Operators
/*
 You can combine multiple logical operator to create longer compound expressions.
 However, the '&&' amd '||' operators still operator on only two values, so this
 is actually three smaller expressions chained together.
 The example can be read as:
 If we've entered the correct door code and passed the retina scan, or if we
 have a valid door key, or if we know the emergency override password, then
 allow access.
 */
let enteredDoorCode = true
let passedRetinaScan = false
let hasDoorKey = false
let knowsOverridePassword = true

if enteredDoorCode && passedRetinaScan || hasDoorKey || knowsOverridePassword {
    print("Welcome!")
} else {
    print("Access Denied!")
}

/*
 NOTE:
 The Swift logical operators '&&' and '||' are left-associative, meaning that
 compound expressions with multiple logical operators evaluate the leftmost
 subexpression first.
 */



//  MARK: Explicit Parentheses
/*
 It is sometimes useful to include parentheses when they are not strictly needed,
 to make the intention of a complex expression easier to read.
 In the door access example above, it is useful to add parentheses around the 
 first part of the compound experssion to make its intent explicit.
 */
if (enteredDoorCode && passedRetinaScan) || hasDoorKey || knowsOverridePassword {
    print("Welcome!")
} else {
    print("Access Denied!")
}

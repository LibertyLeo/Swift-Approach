//
//  main.swift
//  Swift_Array
//
//  Created by Leo_Lei on 5/15/17.
//  Copyright © 2017 LibertyLeo. All rights reserved.
//

import Foundation

/*
 Swift provides three primary collection types, known as arrays, sets, and
 dictionaries, for storing collections of values.
 Arrays are ordered collections of values.
 Sets are unordered collections of unique values.
 Dictionaries are unordered collections of key-value associations.

 Arrays, sets, and dictionaries in Swift are always clear about the types of
 values and keys that they can store. This means that you cannot insert a value
 of the wrong type into a collection by mistake. It also means you can be
 confident about the type of values you will retrieve from a collection.
 */



//  MARK: Mutability of Collections
/*
 If you create an array, a set, or a dictionary, and assign it to a variable, the
 collection that is created will be mutable.
 If you assign an array, a set, or a dictionary to a constant, that collection
 is immutable, and its size and contents cannot be change.
 It enables the Swift complier to optimize the performance of the collections
 you create.
 */



//  MARK: - Arrays
/*
 An array stores values of the same type in an ordered list.
 The same value can appear in an array multiple times at different positions.
 Swift's 'Array' type is bridged to Foundation's 'NSArray' class.
 */




//  MARK: Array Type Shorthand Syntax
/*
 The type of a Swift array is written in full as 'Array<Element>', where
 'Element' is the type of values the array is allowed to store.
 You can also write the type of an array in shorthand form as [Element] which is
 preferred.
 */



//  MARK: Creating an Empty Array
var someInts = [Int]()
print("someInts is of type [Int] with \(someInts.count) items.")
// Prints "someInts is of type [Int] with 0 items."

/*
 Note that the type of the 'someInts' variable is inferred to be [Int] from the
 type of the initializer.
 Alternatively, if the context already provides type information, such as a
 function argument or an already typed variable or constant, you can create an
 empty array with an empty array literal, which is written as [] (an empty pair
 of square brackets)
 */
someInts.append(3)
// someInts now contains 1 value of type Int
someInts = []
// someInts is now an empty array, but is still of type [Int]



//  MARK: Creating an Array with a Default Value
/*
 Swift's 'Array' type also provides an intializer for creating an array of a
 certain size with all of its values set to the same default value.
 You pass initializer a default value of the appropriate type (called 'repeating'),
 and the number of times that value is repeated in the new array (called 'count').
 */
var threeDoubles = Array(repeating: 0.0, count: 3)
// threeDoubles is of type [Double], and equal to [0.0, 0.0, 0.0]



//  MARK: Creating an Array by Adding Two Arrays Together
/*
 You can create a new array by adding together two existing arrays with
 compatible types with the addition operator ('+').
 */
var anotherThreeDoubles = Array(repeating: 2.5, count: 3)
// anotherThreeDoubles is of type [Double], and equals [2.5, 2.5, 2.5]

var sixDoubles = threeDoubles + anotherThreeDoubles
// sicDoubles is inferred as [Double], and equals [0.0, 0.0, 0.0, 2.5, 2.5, 2.5]



//  MARK: Creating an Array with an Array Literal
/*
 You can also initialize an array with an array literal, which is a shorthand
 way to write one or more values as an array collection. An array literal is
 written as a list of values, separated by commas, surrounded by a pair of square
 brackets
 */
var shoppingList: [String] = ["Eggs", "Milk"]
// shoppingList has been initialized with two initial items

/*
 Thanks to Swift's type inference, you don't have to write the type of the arry
 if you're initailizing it with an array literal containing values of the same
 type.
 */
var shoppingListShort = ["Eggs", "Milk"]



//  MARK: Accessing and Modifying an Array
/*
 You access and modify an array through its methods and properties, or by using
 subscript syntax.
 */
print("The shopping list contains \(shoppingList.count) items.")
// Prints "The shopping list contains 2 items."

/*
 Use the Boolean 'isEmpty' property as a shortcut for checking whether the
 'count' property is equal to '0'
 */
if shoppingList.isEmpty {
    print("The shopping list is empty.")
} else {
    print("The shopping list is not empty.")
}
// Prints "The shopping list is not empty.

/*
 You can add a new item to the end of an array by calling the array's
 'append(_:)' method, or with the additon assignment operator ('+=').
 */
shoppingList.append("Flour")
// shoppingList now contains 3 items, and someone is making pancakes.

shoppingList += ["Baking Powder"]
// shoppingList now contains 4 items
shoppingList += ["Chocalate Spread", "Cheese", "Butter"]
// shoppingList now contains 7 items

/*
 Retrieve a value from the array by using subscript syntax, passing the index
 of the value you want to retrieve within square brackets immediately after the
 name of the array.
 */
var firstItem = shoppingList[0]
// firstItem is equal to "Eggs"

/*
 NOTE:
 The first item in the array has an index of '0', not '1'.
 Arrays in Swift are always zero-indexed.
 */

// You can use subscript syntax to change an existing value at a given index.
shoppingList[0] = "Six eggs"
// the first item in the list is now equal to "Six eggs" rather than "Eggs"

/*
 When you use subscript syntax, the index you specify need to be valid.
 For example, writing 'shoppingList[shoppingList.count] = "Salt"' to try to
 append an item to the end of the array result in a runtime error.

 You can also use subscript syntax to change a range of values at once, even if
 the replacement set of values has a different length than the range you are
 replacing.
 */
shoppingList[4...6] = ["Bananas", "Apples"]
// shoppingList now contains 6 items

/*
 To insert an item into the array at a specified index, call the array's
 'insert(_:at:)' method
 */
shoppingList.insert("Maple Syrup", at: 0)
// shoppingList now contains 7 items
// "Maple Syrup" is now the first item in the list

/*
 Similarly, you remove an item from the array with the 'remove(at:)' method.
 This method removes the item at the specified index and returns the removed
 item (although you can ignore the returned value if you do not need it)
 */
let mapleSyrup = shoppingList.remove(at: 0)
// the item that was at index 0 has just been removed
// shoppingList now contains 6 items, and no Maple Syrup
// the mapleSyrup constant is now equal to the removed "Maple Syrup" string

/*
 NOTE:
 If you try to access or modify a value for an index that is outside of an
 array's existing bounds, you will trigger a runtime error.
 The largest valid index in an array is 'count-1' because arrays are indexed
 from zero--however, when 'count' is '0' (meaning the array is empty), there are
 no valid indexes.
 */

/*
 Any gaps in an array are closed when an item is removed, and so the value at
 index '0' is once again equal to '"Six eggs"'
 */
firstItem = shoppingList[0]
// firstItem is now equal to "Six eggs"

/*
 If you want to remove the final item from an array, use the 'removeLast()'
 method rather the 'remove(at:)' method to avoid the need to query the array's
 count property.
 */
let apples = shoppingList.removeLast()
// the last item in the array has just been removed
// shoppingList now contains 5 items, and no apples.
// the apples constant is now equal to the removed "Apples" string



//  MARK: Iterating Over an Array
/*
 You can iterate over the entire sets of values in an array with the
 'for-in' loop
 */
for item in shoppingList {
    print(item)
}
// Six eggs
// Milk
// Flour
// Baking Powder
// Bananas

/*
 If you need the integer index of each item as well as its values, use the
 'enumerated()' method to iterate over the array instead.
 For each item in the array, the 'enumerated()' method returns a tuple composed
 of an integer and the item.
 If you enumerate over a whole array, these integers match the items' indices.
 You can decompose the tuple into temporary constant or variables as part of the
 iteration
 */
for (index, value) in shoppingList.enumerated() {
    print("Item \(index + 1): \(value)")
}
// Item 1: Six eggs
// Item 2: Milk
// Item 3: Flour
// Item 4: Baking Powder
// Item 5: Bananas

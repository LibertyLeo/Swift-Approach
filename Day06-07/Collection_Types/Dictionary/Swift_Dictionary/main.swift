//
//  main.swift
//  Swift_Dictionary
//
//  Created by Leo_Lei on 5/16/17.
//  Copyright © 2017 LibertyLeo. All rights reserved.
//

import Foundation

//  MARK: Dictionaries
/*
 A dictionary store associations between keys of the same type and values of the
 same type in a collection with no defined ordering.
 Each value is associated with a unique key, which acts as an identifier for 
 that value within the dictionary.
 Swift's 'Dictionary' type is bridged to Foundation's 'NSDictionary' class.
 */



//  MARK: Dicitonary Type Shorthand Syntax
/*
 The type of a Swift dictionary is written in full as 'Dictionary<Key, Value>',
 where 'Key' is the type of value that can be used as a dictionary key, and
 'Value' is the type of value that the dictionary stores for those keys.
 You can also write the type of a dictionary in shorthand form as '[Key: Value]'.
 */



//  MARK: Creating an Empty Dictionary
/*
 As with arrays, you can create an empty 'Dictionary' of a certain type by using
 intializer syntax.
 */
var namesOfIntegers = [Int: String]()
// namesOfIntegers is an empty [Int: String] dictionary

/*
 If the context already provides type information, you can create an empty 
 dictionary with an empty dicitonary literal, which written as '[:]' (a colon
 inside a pair of square brackets):
 */
namesOfIntegers[16] = "sixteen"
// namesOfIntegers now contain 1 key-value pair
namesOfIntegers = [:]
// namesOfIntegers is once again an empty dictionary of type [Int: String]



//  MARK: Creating a Dictionary with a Dictionary Literal
/*
 A dictionary literal is a shorthand way to write one or more key-value pairs as
 a 'Dictionary' collection.
 The key-value pairs written as a list, separated by commas, surrounded by a 
 pair of square brackets
 */
var airports: [String: String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]

/*
 As with arrays, you don't have to write the type of the dictionary if you're
 intializing it with a dictionary literal whose keys and values have consistent
 types.
 The initialization of 'airpots' could have been written in a shorter form 
 instead.
 */
var airportsShort = ["YYZ":" Toronto Pearson", "DUB": "Dublin"]



//  MARK: Accessing and Modifying a Dictionary
/*
 As with an array, you find out the number of items in a 'Dictionary' by 
 checking its read-only 'count' property
 */
print("The airports dictionary contains \(airports.count) items.")
// Prints "The airports dictionary contains 2 items."

/*
 Use the Boolean 'isEmpty' property as a shortcut for checking whether the
 'count' property is equal to '0'
 */
if airports.isEmpty {
    print("The airports dictionary is empty.")
} else {
    print("The airports dictionary is not empty.")
}
// Prints "The airports dictionary is not empty."

/*
 You can add a new item to a dictionary with subscript syntax. Use a new key of
 the appropriate type as the subscript index, and assign a new value of the 
 appropriate type.
 */
airports["LHR"] = "London"
// the airports dictionary now contains 3 items

/*
 You can also use subscript syntax to change the value associated with a 
 particular key.
 */
airports["LHR"] = "London Heathrow"
// the value for "LHR" has been change to "London Heathrow"

/*
 As an alternative to subscripting, use a dictionary's 'updateValue(_:forKey:)'
 method to set or update the value for a particular key.
 The 'updateValue(_:forKey:)' method sets a value for a key if none exists, or
 updates that value if that key already exists.
 Unlike the old value after performing an update. This enables you to check
 whether or not an update took place.
 */


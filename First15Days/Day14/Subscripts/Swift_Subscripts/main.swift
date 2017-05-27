//
//  main.swift
//  Swift_Subscripts
//
//  Created by Leo_Lei on 5/25/17.
//  Copyright © 2017 LibertyLeo. All rights reserved.
//

import Foundation

//  MARK: Subscripts
/*
 Classes, structures, and enumerations can define subscripts, which are 
 shortcuts for accessing the member elements of a collection, list, or sequence.
 You use subscripts to set and retrieve values by index without needing 
 separate methods for setting and retrieval.
 Subscripts are not limited to a single dimension, and you can define 
 subscripts with multiple input parameters to suit your custom type’s needs.
 */



//  MARK: Subscript Syntax
/*
 Subscripts enable you to query instances of a type by writing one or more 
 values in square brackets after the instance name.
 You write subscript definitions with the subscript keyword, and specify one or
 more input parameters and a return type, in the same way as instance methods.

 /// subscript(index: Int) -> Int {
 ///     get {
 ///         //  return an appropriate subscript value here
 ///     }
 ///     set(newValue) {
 ///         //  perform a suitable setting action here
 ///     }
 /// }
 */


/*
 As with read-only computed properties, you can simplify the declaration of a
 read-only subscript by removing the get keyword and its braces.
 
 /// subscript(index: Int) -> Int {
 /// //  return an appropriate subscript value here
 /// }
 
 Here’s an example of a read-only subscript implementation, which defines a
 TimesTable structure to represent an n-times-table of integers.
 */
struct TimesTable {
    let multiplier: Int
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}
let threeTimesTables = TimesTable(multiplier: 3)
print("six times three is \(threeTimesTables[6])")
//  Print "six times three is 18"
/*
 NOTE:
 An n-times-table is based on a fixed mathematical rule. 
 It is not appropriate to set threeTimesTable[someIndex] to a new value, and so
 the subscript for TimesTable is defined as a read-only subscript.
 */



//  MARK: Subscript Usage
/*
 The exact meaning of subscript depends on the context in which it is used. 
 For example, Swift’s Dictionary type implements a subscript to set and 
 retrieve the values stored in a Dictionary instance.
 */
var numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
numberOfLegs["bird"] = 2
/*
 NOTE:
 Swift’s Dictionary type implements its key-value subscripting as a subscript
 that takes and returns an optional type.
 The Dictionary type uses an optional subscript type to model the fact that not
 every key will have a value, and to give a way to delete a value for a key by 
 assigning a nil value for that key.
 */



//  MARK: Subscript Options
/*
 Subscripts can take any number of input parameters, and these input parameters 
 can be of any type. Subscripts can also return any type. Subscripts can use
 variadic parameters, but they can’t use in-out parameters or provide default 
 parameter values.

 While it is most common for a subscript to take a single parameter, you can 
 also define a subscript with multiple parameters if it is appropriate for 
 your type.
 */
struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(repeating: 0.0, count: rows * columns)
    }

    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }

    subscript(row: Int, column: Int) -> Double {
        get {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}

//  Counstruct a new Matrix instance by passing an row and column count.
var matrix = Matrix(rows: 2, columns: 2)
/*
 Values in the matrix can be set by passing row and column values into the 
 subscript, separated by a comma:
 */
matrix[0, 1] = 1.5
matrix[1, 0] = 3.2

/*
 The Matrix subscript’s getter and setter both contain an assertion to check 
 that the subscript’s row and column values are valid.
 An assertion is triggered if you try to access a subscript that is outside of 
 the matrix bounds:
 */
let someValue = matrix[2, 2]
//  this triggers an assert, because [2, 2] is outside of the matrix bounds.

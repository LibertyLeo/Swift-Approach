//
//  main.swift
//  Swift_Generics
//
//  Created by Leo_Lei on 5/10/17.
//  Copyright © 2017 LibertyLeo. All rights reserved.
//

import Foundation

//  Write a name inside angle brackets to make a generic function or type.
func makeArray<Item>(repeating item: Item, numberOfTimes: Int) -> [Item] {
    var result = [Item]()
    for _ in 0..<numberOfTimes {
        result.append(item)
    }
    return result
}

let circleArray = makeArray(repeating: "knock", numberOfTimes: 4)
print(circleArray)

/*
 You can make generic forms of functions and methods, as well as classes,
 enumerations, and structures
 */
//  Reimplement the Swift standard library's optional type
enum OptionalValue<Wrapped> {
    case none
    case some(Wrapped)
}

var possibleInteger: OptionalValue<Int> = .none
possibleInteger = .some(100)
//possibleInteger = .some(10.2)   //  Uncomment to see the error

/*
 Use where right before the body to specify a list of requirements--for example,
 to require a type to implement a protocol, to require two types to be the same,
 or to require a class to have a particular superclass.
 */
func anyCommonElements<T: Sequence, U: Sequence>(_ lhs: T, _ rhs: U) -> Bool
    where T.Iterator.Element: Equatable, T.Iterator.Element == U.Iterator.Element {
        for lhsItem in lhs {
            for rhsItem in rhs {
                if lhsItem == rhsItem {
                    return true
                }
            }
        }
        return false
}

let commonElements: Bool = anyCommonElements([1, 2, 3], [3])
print(commonElements)

/*
 Modify the 'anyCommonElements(_:_:)' function to make a function that returns 
 an array of the elements that any two sequences have in common.   (Exp)
 */
func anyCommonElementsInArray<T: Sequence, U: Sequence>(_ lhs: T, _ rhs: U) -> [T.Iterator.Element]
    where T.Iterator.Element: Equatable, T.Iterator.Element == U.Iterator.Element {
        var commonArray: [T.Iterator.Element] = []
        commonArray = []
        for lhsItem in lhs {
            for rhsItem in rhs {
                if lhsItem == rhsItem {
                    commonArray.append(lhsItem)
                }
            }
        }
        return commonArray
}

let commonElementArrays = anyCommonElementsInArray([1, 2, 3], [3])
print(commonElementArrays)

//  Writing <T: Equatable> is the same as writing <T> ... where T: Equatable.

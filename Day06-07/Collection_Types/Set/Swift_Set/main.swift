//
//  main.swift
//  Swift_Set
//
//  Created by Leo_Lei on 5/16/17.
//  Copyright © 2017 LibertyLeo. All rights reserved.
//

import Foundation

//  MARK: Sets
/*
 A set store distinct values of the same type in a collection of no defined
 ordering.
 You can use a set instead of an array when the order of items is not important,
 or when you need to ensure that an item only appears once.
 Swift's 'Set' type is bridged to Foundation's 'NSSet' class.
 */



//  MARK: Hash Values for Set Types
/*
 A type must be hashable in order to stored in a set.
 All of Swift's basic types (such as 'String', 'Int', 'Double', and 'Bool') are
 hashable by default, and can be used as set value types or dictionary key types.
 Enumeration case values without associated values are also hashable by default.
 */
/*
 NOTE:
 You can use your own custom types as set value types or dictionary key types by
 making them conform to the 'Hashable' protocol from Swift's standard library.
 Types that conform to the 'Hashable' protocol must provide a gettable 'Int'
 property called 'hashValue'. 
 The value returned by a type's 'hashValue' property is not required to be the
 same across different of the same program, or in different programs.
 Because the 'Hashable' protocol conforms to 'Equatable', confrom types must
 also provide an implementation of the equals operator (==).
 An implementation of == must satify the following three conditions, for all 
 values 'a', 'b', and 'c'.
    /*
    a == a (Reflexivity)
    a == b implies b == a (Symmetry)
    a == b && b == c implies a == c (Transitivity)
    */
 */



//  MARK: Set Type Syntax
/*
 The type of a Swift set is written as Set<Element>, where 'Element' is the type
 that the set is allowed to store.
 Unlike arrays, sets do not have an equivalent shorthand form.
 */



//  MARK: Creating and Initializing an Empty Set
var letters = Set<Character>()
print("leeters is of type Set<Element> with \(letters.count) items.")
//  Prints "leeters is of type Set<Element> with 0 items."

/*
 Alternatively, if the context provided type information, such as a function
 argument or an already typed variable or constant, you can create an empty set
 with an empty array literal
 */
letters.insert("a")
//  letters now contains 1 value of type Character

letters = []
//  letters is now an empty set, but is still of type Set<Character>



//  MARK: Createing a Set with an Array Literal
/*
 You can also initialize a set with an array literal, as a shorthand way to 
 write one or more values as a set collection.
 */
var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip hop"]
// favoriteGenres has been initialized with three initial items

/*
 A set type cannot be inferred from an array literal alone, so the type 'Set'
 must be explicitly declared.
 However, because of Swift's type inference, you don't have to write the type of
 the set if you're initializing it with an array literal containing values of 
 the same type.
 */
var favoriteGenresShort: Set = ["Rock", "Classical", "Hip hop"]



//  MARK: Accessing and Modifying a Set
/*
 To find out the number of items in a set, check ites read-only 'count' property;
 */
print("I have \(favoriteGenres) favorite music genres.")
// Prints "I have 3 favorite music genres.")

/*
 Use the Boolean 'isEmpty' property as shortcut for checking whether the 'count'
 property is equal to '0'
 */
if favoriteGenres.isEmpty {
    print("As far as music goes, I'm not picky")
} else {
    print("I have particular music preferences.")
}
//  Prints "I have particular music preferences."

//  You can add a new item into a set by calling the set's 'insert(_:)' method.
favoriteGenres.insert("Jazz")
//  favoriteGeneras now contains 4 items

/*
 You can remove an item from a set by calling the set's 'remove(_:)' method,
 which removes the item if it's a member of the set, and returns the removed 
 value, or return 'nil' if the set did not contain it.
 Alternatively, all items in a set can be removed with its 'removeAll()' method.
 */
if let removedGenre = favoriteGenres.remove("Rock") {
    print("\(removedGenre)? I'm over it.")
} else {
    print("I never much cared for that.")
}
//  Prints "Rock? I'm over it.

/*
 To check whether a set contains a particular item, use the 'contains(_:)' method.
 */
if favoriteGenres.contains("Funk") {
    print("I get up on the good foot")
} else {
    print("It's too funky in here.")
}
//  Prints "It's too funky in here."



//  MARK: Iterating Over a Set
for genre in favoriteGenres {
    print("\(genre)")
}
//  Jazz
//  Hip hop
//  Classical

/*
 Swift's 'Set' type does not have a defined ordering.
 To iterate over the values of a set in a specific order, use 'sorted()' method,
 which returns the set's elements as an array sorted using the '<' operator.
 */
for genre in favoriteGenres.sorted() {
    print("\(genre)")
}
//  Classical
//  Hip hop
//  Jazz



//  MARK: Fundamental Set Operations
/*
 The case below describes two sets--'a' and 'b'--with the results of various set
 operations.

        Use the 'intersection(_:)' method to create a new set with only the values
    common to both sets.
        Use the 'symmetricDifference(_:)' method to create a new set with values
    in either set, but not both.
        Use the 'union(_:)' method to create a new set with all of the values
    in both sets.
        Use the 'subtracting(_:)' method to create a new set with values not in
    the specified set.
 */
let oddDigits: Set = [1, 3, 5, 7, 9]
let evenDigits: Set = [0, 2, 4, 6, 8]
let singleDigitPrimeNumber: Set = [2, 3, 5, 7]

oddDigits.union(evenDigits).sorted()
//  [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
oddDigits.intersection(evenDigits).sorted()
//  []
oddDigits.subtracting(singleDigitPrimeNumber).sorted()
//  [1, 9]
oddDigits.symmetricDifference(singleDigitPrimeNumber).sorted()
//  [1, 2, 9]



//  MARK: Set Membership and Equality
/*
 The case below describes three sets--'a', 'b' and 'c'--with the representing of
 elments shared among sets.
 Set 'a' is a superseet of set 'b', because 'a' contains all elements in 'b'.
 Conversely, set 'b' is a subset of set 'a', because all elements in 'b' are 
 also contained by 'a'.
 Set 'b' and Set 'c' are disjoint with one another, because they share no 
 elements in common.

        Use the "is equal" operator (==) to determine whether two sets contain 
    all of the same values.
        Use the 'isSubset(of:)' method to determine whether all of the values of
    a set are contained in the specified set.
        Use the 'isSuperset(of:)' method to determine whether a set contains all
    of the values in a specified set.
        Use the 'isStrictSubset(of:)' or 'isStrictSuperSet(of:)' methods to
    determine whether a set is a subset or superset, but not equal to, a 
    specified set.
        Use the 'isDisjoint(with:)' method to determine whether two sets have no
    values in common.
 */
let houseAnimals: Set = ["🐶", "🐱"]
let farmAnimals: Set = ["🐮", "🐔", "🐑", "🐶", "🐱"]
let cityAnimals: Set = ["🐦", "🐭"]

houseAnimals.isSubset(of: farmAnimals)
// true
farmAnimals.isSuperset(of: houseAnimals)
// true
farmAnimals.isDisjoint(with: cityAnimals)
// true

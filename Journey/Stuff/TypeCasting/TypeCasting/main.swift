//
//  main.swift
//  TypeCasting
//
//  Created by Leo_Lei on 6/5/17.
//  Copyright © 2017 LibertyLeo. All rights reserved.
//

import Foundation

/*
 Type casting is a way to check the type of an instance, or to treat that
 instance as a different superclass or subclass from somewhere else in its own
 class hierarchy.
 Type casting in Swift is implemented with the is and as operators.
 You can also use type casting to check whether a type conforms to a protocol.
 */



//  MARK: Defining a Class Hierarchy for Type Casting
/*
 You can use type casting with a hierarchy of classes and subclasses to check
 the type of a particular class instance and to cast that instance to another
 class within the same hierarchy.

 The code below define a hierarchy of classes and an array containing instances
 of those classes, for use in an example of type casting.
 */
class MediaItem {
    var name: String
    init(name: String) {
        self.name = name
    }
}

class Movie: MediaItem {
    var director: String
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}

class Song: MediaItem {
    var artist: String
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}

let library = [
    Movie(name: "Casablance", director: "Michael Curtiz"),
    Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
    Movie(name: "Citizen Kane", director: "Orson Welles"),
    Song(name: "The One And Only", artist: "Chesney Hawkes"),
    Song(name: "Never Gone Give You Up", artist: "Rick Astley")
]
// the type of "Library" is inferred to be [MediaItem]
/*
 The items stored in library are still Movie and Song instances behind the
 scenes. However, if you iterate over the contents of this array, the items
 you receive back are typed as MediaItem, and not as Movie or Song. In order
 to work with them as their native type, you need to check their type, or
 downcast them to a different type,
 */



//  MARK: - Checking Type
/*
 Use the type check operator (is) to check whether an instance is of a certain s
 ubclass type. The type check operator returns true if the instance is of that
 subclass type and false if it is not.
 */
var movieCount = 0
var songCount = 0
for item in library {
    if item is Movie {
        movieCount += 1
    } else if item is Song {
        songCount += 1
    }
}

print("Media Library contains \(movieCount) movies and \(songCount) songs")
// Prints "Media Library contains 2 movies and 3 songs"
/*
 This example iterates through all items in the library array. On each pass,
 the for-in loop sets the item constant to the next MediaItem in the array.
 */



//  MARK: Downcasting
/*
 A constant or variable of a certain class type may actually refer to an
 instance of a subclass behind the scenes. Where you believe this is the case,
 you can try to downcast to the subclass type with a type cast operator (as?
 or as!).
 The conditional form, as?, returns an optional value of the type you are
 trying to downcast to. The forced form, as!, attempts the downcast and
 force-unwraps the result as a single compound action.

 In this example, each item in the array might be a Movie, or it might be a
 Song. You don’t know in advance which actual class to use for each item,
 and so it is appropriate to use the conditional form of the type cast
 operator (as?) to check the downcast each time through the loop:
 */
for item in library {
    if let movie = item as? Movie {
        print("Movie: \(movie.name), dir. \(movie.director)")
    } else if let song = item as? Song {
        print("Song: \(song.name), by \(song.artist)")
    }
}
// Movie: Casablance, dir. Michael Curtiz
// Song: Blue Suede Shoes, by Elvis Presley
// Movie: Citizen Kane, dir. Orson Welles
// Song: The One And Only, by Chesney Hawkes
// Song: Never Gone Give You Up, by Rick Astley
/*
 Downcasting to Movie fails when applied to the Song instances in the library
 array. To cope with this, the example above uses optional binding to check
 whether the optional Movie actually contains a value (that is, to find ou
 whether the downcast succeeded.) This optional binding is written if let
 movie = item as? Movie, which can be read as:

 Try to access item as a Movie. If this is successful, set a new temporary
 constant called movie to the value stored in the returned optional Movie.

 NOTE:
 Casting does not actually modify the instance or change its values. The
 underlying instance remains the same; it is simply treated and accessed as
 an instance of the type to which it has been cast.
 */



//  MARK: - Type Casting for Any and AnyObject
/*
 Swift provides two special types for working with nonspecific types:

 Any can represent an instance of any type at all, including function types.
 AnyObject can represent an instance of any class type.

 Use Any and AnyObject only when you explicitly need the behavior and
 capabilities they provide. It is always better to be specific about the types
 you expect to work with in your code.
 Here’s an example of using Any to work with a mix of different types,
 including function types and non-class types.
 */
var things = [Any]()

things.append(0)
things.append(0.0)
things.append(42)
things.append(3.14159)
things.append("hello")
things.append((3.0, 5.0))
things.append(Movie(name: "Ghostbusters", director: "Ivan Reitman"))
things.append({ (name: String) -> String in "Hello, \(name)" })

/*
 To discover the specific type of a constant or variable that is known only
 to be of type Any or AnyObject, you can use an is or as pattern in a switch
 statement’s cases.
 */
for thing in things {
    switch thing {
    case 0 as Int:
        print("zero as an Int")
    case 0 as Double:
        print("zero as a double")
    case let someInt as Int:
        print("an integer value of \(someInt)")
    case let someDouble as Double where someDouble > 0:
        print("a position double value of \(someDouble)")
    case is Double:
        print("some other double value that I don't want to print")
    case let someString as String:
        print("a string value of \"\(someString)\"")
    case let (x, y) as (Double, Double):
        print("an (x, y) point at \(x), \(y)")
    case let movie as Movie:
        print("a movie called \(movie.name), dir. \(movie.director)")
    case let stringConverter as (String) -> String:
        print(stringConverter("Michael"))
    default:
        print("something else")
    }
}
// zero as an Int
// zero as a double
// an integer value of 42
// a position double value of 3.14159
// a string value of "hello"
// an (x, y) point at 3.0, 5.0
// a movie called Ghostbusters, dir. Ivan Reitman

/*
 The Any type represents values of any type, including optional types. Swift
 gives you a warning if you use an optional value where a value of type Any
 is expected. If you really do need to use an optional value as an Any value,
 you can use the as operator to explicitly cast the optional to Any, as shown
 below.
 */
let optionalNumber: Int? = 3
things.append(optionalNumber) //  Warning
things.append(optionalNumber as Any) // No Warning

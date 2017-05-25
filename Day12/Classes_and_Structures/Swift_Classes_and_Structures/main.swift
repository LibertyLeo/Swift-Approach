//
//  main.swift
//  Swift_Classes_and_Structures
//
//  Created by Leo_Lei on 5/23/17.
//  Copyright © 2017 LibertyLeo. All rights reserved.
//

import Foundation

//  MARK: Classes and Structures
/*
 Classes and structures are general-purpose, flexible constructs that become 
 the building blocks of your program's code.
 Unlike other programming languages, Swift does not require you to create 
 separate interface and implementaion files for custom classes and structures.
 In Swift, you define a class or a structure in a single file, and the external
 interface to that class or structure is automatically made available for other
 code to use.
 */



//  MARK: - Comparing Classes and Structures
/*
 Classes and structures in Swift have many things in common. Both can:
    - Define properties to store values
    - Define methods to provide functionality
    - Define subscripts to provide access to their values using subscript syntax
    - Define initializer to set up their initial state
    - Be extended to expand their functionality beyond a default implementation
    - Conform to protocols to provide standard functionality of a certain kind
 
 Classes have additional capabilities that structures do not:
    - Inheritance enables one class to inherit the charcteristics of another.
    - Type casting enables you to check and interpret the type of a class
 instance at runtime.
    - Deinitializer enables an instance of a class to free up any resources it
 has assigned.
    - Reference counting allows more than one reference to a class instance.
 
 NOTE:
 Structures are always copied when they are passed around in your code, and do
 not use reference counting.
 */



//  MARK: Definition Syntax
/*
 Classes and structures have a similar definition syntax.
 You introduce classes with the class keyword and structures with the struct
 keyword.
 */
class someClass {
    //  class definition goes here
}

struct someStructure {
    //  structure definition goes here
}

/*
 NOTE:
 Give types UpperCamelCase names (such as SomeClass and SomeStructure here)
 to match the capitalization of standard Swift types (such as String, Int,
 and Bool).
 Conversely, always give properties and methods lowerCamelCase names (such as
 frameRate and incrementCount) to different them from type names.
 */
struct Resolution {
    var width = 0
    var height = 0
}

class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}



//  MARK: Class and Structure Instaces
/*
 The syntax for creating instances is very similar for both structures and 
 classes.
 */
let someSoulution = Resolution()
let someViedeoMode = VideoMode()



//  MARK: Accessing Properties
/*
 You can access the properties of an instance using dot syntax.
 In dot syntax, you write the property name immediately after the instance name,
 separated by a period(.) without any spaces
 */
print("The width of someSoulution is \(someSoulution.width)")
//  Prints "The width of someSoulution is 0"

/*
 You can drill down into sub-properties, such as the width property in the 
 resolution property of a VideoMode
 */
print("The width of someVideoMode is \(someViedeoMode.resolution.width)")
//  Prints ""The width of someVideoMode is 0"

//  You can also use dot syntax to assign a new value to a variable property
someViedeoMode.resolution.width = 1280
print("The width of someVideoMode is now \(someViedeoMode.resolution.width)")
//  Prints ""The width of someVideoMode is now 1280"

/*
 NOTE:
 Unlike Objective-C, Swift enables you to set sub-properties of a structure
 property directly.
 In the last example above, the width property of the resoulution property
 of someVideoMode is set directly, without your needing to set the entire
 resolution property to a new value.
 */



//  MARK: - Memberwise Initializers for Structure Types
/*
 All structures have an automatically-generated memberwise initializer, which
 you can use to initialize the member properties of new structure instances.
 Initial values for the properties of the new instance can be passed to the
 memberwise initializer by name
 */
let vga = Resolution(width: 640, height: 480)
/*
 Unlike structures, class instances do not receive a default memberwise 
 inializer.
 */



//  MARK: Structures and Enumerations Are Value Types
/*
 A value type is a type whose value is copied when it is assigned to a variable
 or constant, or when it is passsed to a function.
 
 All structures and enumerations are value types in Swift. This means that any
 structures and enumeration instances you create--and any value types they have
 as properties--are always copied when they are passed around in your code.
 */
let hd = Resolution(width: 1920, height: 1080)
var cinema = hd
/*
 Because Resolution is a structure, a copy of the existing instance is made, 
 and this new copy is assigned to cinema. Even though hd and cinema now 
 have the same width and height, they are two completely different instances
 behind the scenes.
 */
cinema.width = 2048

/* 
 Checking the width property of cinema shows that it has indeed changed to
 be 2048
 */
print("cinema is now \(cinema.width) pixels wide")
//  Prints "cinema is now 2048 pixels wide"

/*
 However, the width property of the original hd instance still has the old 
 value of 1920
 */
print("hd is still \(hd.width) pixels wide")
//  Prints "hd is still 1920 pixels wide"

/*
 When cinema was given the current value of hd, the values stored in hd
 were copied into the new cinema instance. The end result is two completely
 separate instances, which just happened to contain the same numeric value.
 Because they are separate instances, setting the width of cinema to 2048
 doesn't affect the width stored in hd.
 */
enum CompassPoint {
    case north, south, east, west
}
var currentDirection = CompassPoint.west
let rememberedDirection = currentDirection
currentDirection = .east
if rememberedDirection == .west {
    print("The remembered direction is still .west")
}
//  Prints "The remembered direction is still .west"



//  MARK: Classes Are Reference Types
/*
 Unlike value types, reference types are not copied when they are assigned to a
 variable or constant, or when they are passed to a function.
 Rather than a copy, a reference to the same existing instance is used instead.
 */
let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0

/*
 tenEighty is assigned to a new constant, called alsoTenEighty, and the 
 frame rate of alsoTenEighty is modified.
 */
let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0

/*
 Because classes are reference types, tenEighty and alsoTenEighty actually
 both refer to the same VideioMode instance. Effectively, they are just two
 different names for the same single instance.
 */
print("The frameRate property of tenEighty is now \(tenEighty.frameRate)")
//  Prints "The frameRate property of tenEighty is now 30.0"

/*
 Note that tenEighty and alsoTenEighty are declared as constants, rather
 than variables. However, you can still change tenEighty.frameRate and 
 alsoTenEighty.frameRate because the values of the tenEighty and 
 alasoTenEighty constants themselves do not actually change.
 tenEighty and alsoTenEighty themeselves do not "store" the Video instance.
 It is the frameRate property of the underlying VideoMode that is changed,
 not the values of the constant references to that VideoMode.
 */



//  MARK: - Identity Operators
/*
 Because classes are reference types, it is possible for multiple constants and 
 variables to refer to the same single instance of a class behind the scenes.
 It can sometimes be useful to find out if two constants or variable refer to
 exactly the same instance of a class.

 To enable this, Swift provide two identity operators:
    - Identical to (===)
    - Not identical to (==)
 
 Use these operators to check whether two constants or variables refer to the 
 same single instance
 */
if tenEighty === alsoTenEighty {
    print("tenEighty and alsoTenEighty refer to same VideoMode instance.")
}
//  Prints "tenEighty and alsoTenEighty refer to same VideoMode instance."
/*
 Note that "identical to" (represented by three equals signs, or ===) does not
 mean the same thing as "equal to" (represented by two equal signs, or ==):
    - "Identical to" means that two constants or variables of class type refer
 to exactly the same class instance.
    - "Equal to" means that two instances are considered "equal" or "equivalent"
 in value, for some appropriate meaning of "equal", as defined by the type's
 designer.
 */



//  MARK: - Pointers
/*
 A Swift constant or variable that refers to an instance of some reference type
 is similar to a pointer in C, but is not a direct pointer to an address in
 memory, and does not require you to write an asterisk (*) to indicate that you
 are creating a reference.
 Instead, these references are defined like any other constant or variable in 
 Swift.
 */



//  MARK: - Choosing Between Classes and Structures
/*
 You can use both classes and structures to define custom data types to use as
 the building blocks of your program's code.
 However, structure instances are always passed by value, and class instance 
 are always passed by reference. This means that they are suited to different
 kinds of tasks.
 
 As a general guideline, consider creating a structure when one or more of these
 conditions apply:
    - The structure's primary purpose is to encapsulate a few relatively simple
 data values.
    - It is reasonable to expect that the encapsulated values will be copied 
 rather than referenced when you assign or pass around an instance of that 
 structure.
    - Any properties stored by the structure are themselves value types, which
 would also be expected to be copied rather than referenced.
    - The structure does not need to inherit properties or behavior from another
 existing type.
 
 Example of good candidates for structures include:
    - The size of a geometric shape, perhaps encapsulating a width property
 and a height property, both of type Double.
    - A way to refer to ranges within a series, perhaps encapsulating a start
 property and a length property, both of type Int.
    - A point in a 3D coordinate system, perhaps encapsulating x, y and z
 properties, each of type Double.
 */



//  MARK: - Assignment and Copy Behavior for Strings, Arrays, and Dictionaries
/*
 In Swift, many basic data types such as String, Array, and Dictionary are
 implemented as structures. This means that data such as strings, arrays, and 
 dictionaries are copied when they are assigned to a new constant or variable,
 or when they are passed to a function or method.

 This behavior is different from Foundation: NSString, NSArray, and NSDictionary
 are implemented as classes, not structures. Strings, arrays, and dictionaries 
 in Foundation are always assigned and passed around as a reference to an
 existing instance, rather than as a copy.
 
 NOTE:
 The description above refers to the "copying" of strings, arrays, and 
 dictionaries. The behavior you see in your code will always be as if a copy 
 took place. However, Swift only performs an actual copy behind the scenes when
 it is absolutely necessary to do so. 
 Swift manages all value copying to ensure optimal performance, and you should
 not avoid assignment to try to preempt this optimization.
 */

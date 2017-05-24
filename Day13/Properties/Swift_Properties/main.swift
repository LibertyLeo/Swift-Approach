//
//  main.swift
//  Swift_Properties
//
//  Created by Leo_Lei on 5/24/17.
//  Copyright © 2017 LibertyLeo. All rights reserved.
//

import Foundation

//  MARK: Properties
/*
 Properties associate values with a particular class, structure, or enumeration.
 Stored properties store constant and variable values as part of an instance,
 whereas computed properties calculate (rather than store) a value.
 Computed properties are provided by classes, structures, and enumerations.
 Sotred properties are provided only by classes and structures.
 */



//  MARK: -  Stored Properties
/*
 In its simplest form, a stored property is a constant or variable that is 
 stored as part of an instance of a particular class or structure.
 Stored properties can be either variable stored properties (introduced by the 
 'var' keyword) or constant stored properties (introduced by the 'let' keyword).

 You can provide a default value for a stored property as part of its 
 definition.
 You can also set and modify the initial value for a stored property during 
 initialization. 
 This is true even for constant stored properties.
 */
struct FixedLengthRange {
    var firstValue: Int
    let length: Int
}
var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
//  the range represents integer value 0, 1, and 2
rangeOfThreeItems.firstValue = 6
//  the range now represents integer values 6, 7, 8
/*
 In the example above, 'length' is initialized when the new range is created and
 cannot be changed thereafter, because it is a constant property.
 */



//  MARK: Stored Properties of Constant Structure Instances
/*
 If you create an instance of a structure and assign that instance to a 
 constant, you cannot modify the instance’s properties, even if they were 
 declared as variable properties.
 */
let rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4)
//  this range represents integer value 0, 1, 2, and 3
//rangeOfFourItems.firstValue = 6   //  Uncomment to see the error
//  this will report an error, even though firstValue is a variable property



//  MARK: Lazy Stored Properties
/*
 A lazy stored property is a property whose initial value is not calculated
 until the first time it is used. You indicate a lazy stored property by
 writing the `lazy` modifier before its declaration.
 
 NOTE:
 You must always declare a lazy property as a variable (with the `var` keyword),
 Constant properties must always have a value before initialization completes,
 and therefore cannot be declared as lazy.
 
 Lazy properties are useful when the initial value for a property is dependent
 on outside factors whose values are not known until after an instance’s 
 initialization is complete.
 */
class DataImporter {
    /*
     DateImporter is a class to import data from an external file.
     The class is assumed to take a non-trivial amount of time to initialize.
     */
    var fileName = "data.txt"
    //  the DataImporter class would provide data importing functionality here
}

class DataManager {
    lazy var importer = DataImporter()
    var data = [String]()
    //  the Datamanager class would provide data management functionality here
}

let manager = DataManager()
manager.data.append("Some data")
manager.data.append("Some more data")
//  the DataImporter instance for the importer property has not yet been created

/*
 Because it is marked with the `lazy` modifier, the `DataImporter` instance for
 the `importer` property is only created when the `importer` property is first 
 accessed, such as when its `filename` property is queried:
 */
print(manager.importer.fileName)
//  the DataImporter instance for the importer property has now been created
//  Prints "data.txt"

/*
 NOTE:
 If a property marked with the `lazy` modifier is accessed by multiple threads 
 simultaneously and the property has not yet been initialized, there is no 
 guarantee that the property will be initialized only once.
 */



//  MARK: Stored Properties and Instance Variables
/*
 A Swift property does not have a corresponding instance variable, and the
 backing store for a property is not accessed directly.
 All information about the property—-including its name, type, and memory
 management characteristics--is defined in a single location as part of the
 type’s definition.
 */



//  MARK: - Computed Properties
/*
 In addition to stored properties, classes, structures, and enumerations can 
 define computed properties, which do not actually store a value.
 Instead, they provide a getter and an optional setter to retrieve and set 
 other properties and values indirectly.
 */
struct Point {
    var x = 0.0, y = 0.0
}

struct Size {
    var width = 0.0, height = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set(newCenter) {
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2)
        }
    }
}

var square = Rect(origin: Point(x: 0.0, y: 0.0),
                  size: Size(width: 10.0, height: 10.0))
let initialSquareCenter = square.center
square.center = Point(x: 15.0, y: 15.0)
print("square.origin is now at (\(square.origin.x), \(square.origin.y))")
//  Prints "square.origin is now at (10.0, 10.0)"

/*
 This example defines three structures for working with geometric shapes:

    - `Point` encapsulates the x- and y-coordinate of a point.
    - `Size` encapsulates a `width` and a `height`.
    - `Rect` defines a rectangle by an origin point and a size.
 
 The Rect structure also provides a computed property called `center`.
 The current center position of a `Rect` can always be determined from its 
 `origin` and `size`, and so you don’t need to store the center point as an 
 explicit `Point` value.

 Setting the `center` property calls the setter for `center`, which modifies 
 the `x` and `y` values of the stored `origin` property, and moves the square
 to its new position.
 */



//  MARK: Shorthand Setter Declaration
/*
 If a computed property’s setter does not define a name for the new value to 
 be set, a default name of `newValue` is used.
 */
struct AlternativeRect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}



//  MARK: Read-Only Computed Properties
/*
 A computed property with a getter but no setter is known as a read-only
 computed property. A read-only computed property always returns a value, 
 and can be accessed through dot syntax, but cannot be set to a different value.
 
 NOTE:
 You must declare computed properties—including read-only computed 
 properties—-as variable properties with the var keyword, because their value 
 is not fixed. The let keyword is only used for constant properties, to 
 indicate that their values cannot be changed once they are set as part of 
 instance initialization.
 */
struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
        return width * height * depth
    }
}
let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
print("the volume of fourByFiveByTwo is \(fourByFiveByTwo.volume)")
//  Print "he volume of fourByFiveByTwo is 40.0"



//  MARK: - Property Observes
/*
 Property observers observe and respond to changes in a property’s value. 
 Property observers are called every time a property’s value is set, even if
 the new value is the same as the property’s current value.
 You can add property observers to any stored properties you define, except 
 for lazy stored properties.
 
 You have the option to define either or both of these observers on a property:
    - `willSet` is called just before the value is stored.
    - `didSet` is called immediately after the new value is stored.
 
 NOTE:
 The `willSet` and `didSet` observers of superclass properties are called when 
 a property is set in a subclass initializer, after the superclass initializer 
 has been called. 
 They are not called while a class is setting its own properties, before the 
 superclass initializer has been called.
 */
class StepCounter {
    var totalStep: Int = 0 {
        willSet(newTotalStep) {
            print("About to set totalSteps to \(newTotalStep)")
        }
        didSet {
            if totalStep > oldValue {
                print("Added \(totalStep - oldValue) steps")
            }
        }
    }
}

let stepCounter = StepCounter()
stepCounter.totalStep = 200
//  About to set totalSteps to 200
//  Added 200 steps
stepCounter.totalStep = 360
//  About to set totalSteps to 360
//  Added 160 steps
stepCounter.totalStep = 896
//  About to set totalSteps to 896
//  Added 536 steps

/*
 NOTE:

 If you pass a property that has observers to a function as an in-out parameter,
 the `willSet` and `didSet` observers are always called. This is because of the
 copy-in copy-out memory model for in-out parameters: The value is always 
 written back to the property at the end of the function.
 */



//  MARK: Global and Local Variables
/*
 The capabilities described above for computing and observing properties are 
 also available to global variables and local variables.
 Global variables are variables that are defined outside of any function, 
 method, closure, or type context. 
 Local variables are variables that are defined within a function, method,
 or closure context.
 
 NOTE:
 Global constants and variables are always computed lazily,
 in a similar manner to lazy stored properties. 
 Unlike lazy stored properties, global constants and variables do not need to 
 be marked with the lazy modifier.

 Local constants and variables are never computed lazily.
 */



//  MARK: - Type Properties
/*
 Instance properties are properties that belong to an instance of a particular
 type.
 You can also define properties that belong to the type itself, not to any one
 instance of that type. There will only ever be one copy of these properties, 
 no matter how many instances of that type you create.
 These kinds of properties are called type properties.
 
 Stored type properties can be variables or constants. 
 Computed type properties are always declared as variable properties, 
 in the same way as computed instance properties.
 
 NOTE:
 Unlike stored instance properties, you must always give stored type properties 
 a default value. This is because the type itself does not have an initializer 
 that can assign a value to a stored type property at initialization time.

 Stored type properties are lazily initialized on their first access. They are
 guaranteed to be initialized only once, even when accessed by multiple threads
 simultaneously, and they do not need to be marked with the `lazy` modifier.
 */



//  MARK: - Type Property Syntax
/*
 Type properties are written as part of the type’s definition, within the 
 type’s outer curly braces, and each type property is explicitly scoped to the 
 type it supports.

 You define type properties with the `static` keyword. For computed type
 properties for class types, you can use the `class` keyword instead to allow
 subclasses to override the superclass’s implementation.
 */
struct SomeStructure {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 1
    }
}

enum SomeEnumeration {
    static var storedTypePropery = "Some Value."
    static var computedTypeProperty: Int {
        return 6
    }
}

class SomeClass {
    static var storedTypeProperty = "Some Value."
    static var computedTypePropery: Int {
        return 27
    }
    class var overrideableComputedTypeProperty: Int {
        return 107
    }
}



//  MARK: Querying and Setting Type Properties
/*
 Type properties are queried and set with dot syntax, just like instance
 properties.
 */
print(SomeStructure.storedTypeProperty)
//  Prints "Some value."
SomeStructure.storedTypeProperty = "Another Value."
print(SomeStructure.storedTypeProperty)
//  Prints "Another value"
print(SomeEnumeration.computedTypeProperty)
//  Prints "6"
print(SomeClass.computedTypePropery)
//  Prints "27"

/*
 The examples that follow use two stored type properties as part of a structure 
 that models an audio level meter for a number of audio channels. Each channel 
 has an integer audio level between 0 and 10 inclusive.
 
 The figure below illustrates how two of these audio channels can be combined
 to model a stereo audio level meter.
 */
struct AudioChannel {
    static let thresholdLevel = 10
    static var maxInputLevelForAllChannels = 0
    var currentLevel: Int = 0 {
        didSet {
            if currentLevel > AudioChannel.thresholdLevel {
                //  cap the new audio level to the threshold level
                currentLevel = AudioChannel.thresholdLevel
            }
            if currentLevel > AudioChannel.maxInputLevelForAllChannels {
                //  store this as the new overall maximum input level
                AudioChannel.maxInputLevelForAllChannels = currentLevel
            }
        }
    }
}

/*
 The `currentLevel` property has a `didSet` property observer to check the 
 value of `currentLevel` whenever it is set. This observer performs two checks:

    - If the new value of `currentLevel` is greater than the allowed 
 `thresholdLevel`, the property observer caps `currentLevel` to `thresholdLevel`.
    - If the new value of `currentLevel` (after any capping) is higher than any
 value previously received by any `AudioChannel` instance, the property observer 
 stores the new `currentLevel` value in the `maxInputLevelForAllChannels`
 type property.”
 
 NOTE:
 In the first of these two checks, the didSet observer sets currentLevel to a
 different value. This does not, however, cause the observer to be called again.
 */

/*
 Also, we can use the 'AudioChaneel' structure to create two new audio channels
 called 'leftChannel' and 'rightChannel', to represent the audio levels of a
 stereo sound system.
 */
var leftChannel = AudioChannel()
var rightChannel = AudioChannel()

/*
 If you set the `currentLevel` of the left channel to 7, you can see that the
 `maxInputLevelForAllChannels` type property is updated to equal 7.
 */
leftChannel.currentLevel = 7
print(leftChannel.currentLevel)
//  Prints "7"
print(AudioChannel.maxInputLevelForAllChannels)
//  Prints "7"

/*
 If you try to set the `currentLevel` of the right channel to 11, you can see 
 that the right channel’s `currentLevel` property is capped to the maximum 
 value of 10, and the `maxInputLevelForAllChannels` type property is updated 
 to equal 10:
 */
rightChannel.currentLevel = 11
print(rightChannel.currentLevel)
//  Prints "10"
print(AudioChannel.maxInputLevelForAllChannels)
//  Prints "10"

//
//  main.swift
//  Swift_Initialization
//
//  Created by Leo_Lei on 5/27/17.
//  Copyright © 2017 LibertyLeo. All rights reserved.
//

import Foundation

//  MARK: Initialization
/*
 Initialization is the process of preparing an instance of a class, structure,
 or enumeration for use.
 Swift initializers do not return a value. Their primary role is to ensure that
 new instances of a type are correctly initialized before they are used for the
 first time.
 Instances of class types can also implement a deinitializer, which performs
 any custom cleanup just before an instance of that class is deallocated.
 */



//  MARK: - Setting Initial Values for Stored properties
/*
  Classes and structures must set all of their stored properties to an 
 appropriate initial value by the time an instance of that class or structure
 is created.
 You can set an initial value for a stored property within an initializer, or 
 by assigning a default property value as part of the property’s definition.

 NOTE:
 When you assign a default value to a stored property, or set its initial 
 value within an initializer, the value of that property is set directly, 
 without calling any property observers.
 */



//  MARK: Initializers
/*
 Initializers are called to create a new instance of a particular type.
 In its simplest form, an initializer is like an instance method with no 
 parameters, written using the init keyword:
 ///    init() {
 ///    //  perform some initialization here
 ///    }
 */
struct Fahrenheit {
    var temperature: Double
    init() {
        temperature = 32.0
    }
}
var f = Fahrenheit()
print("The default temperature is \(f.temperature) Fahrenheit")
//  Prints "The default temperature is 32.0 Fahrenheit"



//  MARK: Default Property Values
/*
 Alternatively, you can specify a default property value as part of the
 property’s declaration.

 NOTE:
 If a property always takes the same initial value, provide a default value
 rather than setting a value within an initializer.
 The default value ties the property’s initialization more closely to its 
 declaration. It makes for shorter, clearer initializers and enables you to
 infer the type of the property from its default value.
 
 You can write the Fahrenheit structure from above in a simpler form by 
 providing a default value.
 */
struct FahrenheitDefault {
    var temperature = 32.0
}



//  MARK: - Customizing Initialization
/*
 You can customize the initialization process with input parameters and 
 optional property types, or by assigning constant properties during 
 initialization.
 */



//  MARK: Initialization Parameters
/*
 You can provide initialization parameters as part of an initializer’s
 definition, to define the types and names of values that customize the
 initialization process.
 */
struct Celsius {
    var temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }

    init(fromKevin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
}

let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
//  Prints "boilngPointOfWater.temperatureInCelsius is 100.0
let freezingPointOfWader = Celsius(fromKevin: 273.15)
//  Prints "freezingPointOfWater.temperatureInCelsius is 0.0



//  MARK: Parameter Names and Argument Labels
/*
 As with function and method parameters, initialization parameters can have 
 both a parameter name for use within the initializer’s body and an argument
 label for use when calling the initializer.
 The names and types of an initializer’s parameters play a particularly 
 important role in identifying which initializer should be called.
 */
struct Color {
    let red, green, blue: Double
    init(red: Double, green: Double, blue: Double) {
        self.red   = red
        self.green = green
        self.blue  = blue
    }

    init(white: Double) {
        red   = white
        green = white
        blue  = white
    }
}

/*
 Both initializers can be used to create a new Color instance, by providing
 named values for each initializer parameter:
 */
let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
let halfGray = Color(white: 0.5)

/*
 Note that it is not possible to call these initializers without using argument
 labels. Argument labels must always be used in an initializer if they are
 defined, and omitting them is a compile-time error.
 */
//let veryGreen = Color(0.0, 1.0, 0.0)
//  this reports a compile-time error - argument labels are required



//  MARK: Initializer Parameters Without Argument Labels
/*
 If you do not want to use an argument label for an initializer parameter,
 write an underscore (_) instead of an explicit argument label for that 
 parameter to override the default behavior.
 */
struct CelsiusWithoutArgumentLabels {
    var temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }

    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }

    init(_ celsius: Double) {
        temperatureInCelsius = celsius
    }
}
let bodyTemperature = CelsiusWithoutArgumentLabels(37.0)
//  bodyTemperature.temperatureInCelsius is 37.0



//  MARK: Optional Property Types
/*
 If your custom type has a stored property that is logically allowed to have 
 no value—perhaps because its value cannot be set during initialization, or 
 because it is allowed to have no value at some later point—declare the 
 property with an optional type.
 Properties of optional type are automatically initialized with a value of
 nil, indicating that the property is deliberately intended to have no value
 yet during initialization.
 */
class SurveyQustion {
    var text: String
    var response: String?
    init(text: String) {
        self.text = text
    }

    func ask() {
        print(text)
    }
}
let cheeseQustion = SurveyQustion(text: "Do you like cheese?")
cheeseQustion.ask()
//  Prints "Do you like cheese?"
cheeseQustion.response = "Yes, I do like cheese."
/*
 The response to a survey question cannot be known until it is asked, and so 
 the response property is declared with a type of String?, or optional String.
 */



//  MARK: Assigning Constant Properties During initialization
/*
 You can assign a value to a constant property at any point during
 initialization.
 Once a constant property is assigned a value, it can’t be further 
 modified.

 NOTE:
 For class instances, a constant property can be modified during initialization
 only by the class that introduces it. It cannot be modified by a subclass.

 You can revise the SurveyQuestion example from above to use a constant 
 property rather than a variable property for the text property of the 
 question, to indicate that the question does not change once an instance of 
 SurveyQuestion is created.
 */
class SurveyQustionNotModified {
    let text: String
    var response: String?
    init(text: String) {
        self.text = text
    }

    func ask() {
        print(text)
    }
}

let beetsQustion = SurveyQustionNotModified(text: "How about beets")
beetsQustion.ask()
//  Prints "How about beets?"
beetsQustion.response = "I also like beets. (But not with cheese.)"



//  MARK: - Default Initializers
/*
 Swift provides a default initializer for any structure or class that provides
 default values for all of its properties and does not provide at least one
 initializer itself.
 */
class ShoppingListItem {
    var name: String?
    var quantity = 1
    var purchased = false
}
var item = ShoppingListItem()
/*
 Because all properties of the ShoppingListItem class have default values,
 and because it is a base class with no superclass, ShoppingListItem 
 automatically gains a default initializer implementation that creates a new 
 instance with all of its properties set to their default values.
 */



//  MARK: Memberwise Initializer for Structure Types
/*
 Structure types automatically receive a memberwise initializer if they do not
 define any of their own custom initializers.
 Unlike a default initializer, the structure receives a memberwise initializer
 even if it has stored properties that do not have default values.

 The Size structure automatically receives an init(width:height:) memberwise
 initializer, which you can use to initialize a new Size instance:
 */
struct Size {
    var width = 0.0, height = 0.0
}
let twoByTwo = Size(width: 2.0, height: 2.0)



//  MARK: Initializer Delegation for Value Types
/*
 Initializers can call other initializers to perform part of an instance’s
 initialization. This process, known as initializer delegation, avoids 
 duplicating code across multiple initializers.
 
 Value types (structures and enumerations) do not support inheritance, and so 
 their initializer delegation process is relatively simple, because they can
 only delegate to another initializer that they provide themselves.
 Classes, however, can inherit from other classes, as described in Inheritance.
 This means that classes have additional responsibilities for ensuring that all
 stored properties they inherit are assigned a suitable value during 
 initialization.

 For value types, you can call self.init only from within an intializer.
 Note that if you define a custom initializer for a value type, you will no
 longer have access to the default initializer (or the memberwise initializer, 
 if it is a structure) for that type. This constraint prevents a situation in 
 which additional essential setup provided in a more complex initializer is
 accidentally circumvented by someone using one of the automatic initializers.

 NOTE:
 If you want your custom value type to be initializable with the default 
 initializer and memberwise initializer, and also with your own custom
 initializers, write your custom initializers in an extension rather than as
 part of the value type’s original implementation.
 */
struct SizeForRect {
    var width = 0.0, height = 0.0
}
struct PointForRect {
    var x = 0.0, y = 0.0
}

/*
 You can initialize the Rect structure below in one of three ways:
    By using its default zero-initialized origin and size property values.
    By providing a specific origin point and size.
    By providing a specific center point and size. 
 */
struct Rect {
    var origin = PointForRect()
    var size = SizeForRect()
    init() {}

    init(origin: PointForRect, size: SizeForRect) {
        self.origin = origin
        self.size   = size
    }

    init(center: PointForRect, size: SizeForRect) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: PointForRect(x: originX, y: originY), size: size)
    }
}

/*
 The first Rect initializer, init(), is functionally the same as the default
 initializer that the structure would have received if it did not have its
 own custom initializers.
 */
let basicRect = Rect()
//  basicRect's origin is (0.0, 0.0) and its size is (0.0, 0.0)

/*
 The second Rect initializer, init(origin:size:), is functionally the same as
 the memberwise initializer that the structure would have received if it did
 not have its own custom initializers.
 */
let originRect = Rect(origin: PointForRect(x: 2.0, y: 2.0),
                        size: SizeForRect(width: 5.0, height: 5.0))
//  originRect's origin is (2.0, 2.0) and its size is (5.0, 5.0)

/*
 The third Rect initializer, starts by calculating an appropriate origin point
 based on a center point and a size value. It then calls (or delegates) to the 
 init(origin:size:) initializer, which stores the new origin and size values
 in the appropriate properties:
 */
let centerRect = Rect(center: PointForRect(x: 4.0, y: 4.0),
                        size: SizeForRect(width: 3.0, height: 3.0))
//  centerRect's origin is (2.5, 2.5) and its size is (3.0, 3.0)

/*
 NOTE:
 For an alternative way to write this example without defining the init() and 
 init(origin:size:) initializers yourself.
 */

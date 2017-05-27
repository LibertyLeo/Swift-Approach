//
//  main.swift
//  Swift_Inheritance
//
//  Created by Leo_Lei on 5/25/17.
//  Copyright © 2017 LibertyLeo. All rights reserved.
//

import Foundation

//  MARK: Inheritance
/*
 A class can inherit methods, properties, and other characteristics from 
 another class. When one class inherits from another, the inheriting class is
 known as a subclass, and the class it inherits from is known as its superclass.

 Classes can also add property observers to inherited properties in order to be
 notified when the value of a property changes.
 */



//  MARK: Defining a Base Class
/*
 Any class that does not inherit from another class is known as a base class.

 NOTE:
 Swift classes do not inherit from a universal base class. Classes you define
 without specifying a superclass automatically become base classes for you to 
 build upon.
 
 The Vehicle base class also defines a method called makeNoise. This method 
 does not actually do anything for a base Vehicle instance, but will be
 customized by subclasses of Vehicle later on:
 */
class Vehicle {
    var currentSpeed = 0.0
    var description: String {
        return "traveling at \(currentSpeed) miles per hour"
    }
    func makeNoise() {
        //  do nothing - an arbitrary vehicle doesn't necessarily make an noise
    }
}

let someVehicle = Vehicle()
print("Vehicle: \(someVehicle.description)")
//  Vehicle: traveling at 0.0 miles per hour



//  MARK: Subclassing
/*
 Subclassing is the act of basing a new class on an existing class. The 
 subclass inherits characteristics from the existing class, which you can then
 refine. You can also add new characteristics to the subclass.

 To indicate that a subclass has a superclass, write the subclass name before
 the superclass name, separated by a colon:

 /// class SomeSubClass: SomeSuperClass {
 /// //  subclass definition goes here
 /// }
 */
class Bicycle: Vehicle {
    var hasBasket = false
}

/*
 By default, any new Bicycle instance you create will not have a basket. You 
 can set the hasBasket property to true for a particular Bicycle instance after
 that instance is created:
 */
let bicycle = Bicycle()
bicycle.hasBasket = true

/*
 You can also modify the inherited currentSpeed property of a Bicycle instance,
 and query the instance’s inherited description property:
 */
bicycle.currentSpeed = 15.0
print("Bicycle: \(bicycle.description)")
//  Bicycle: traveling at 15.0 miles per hour

/*
 Subclasses can themselves be subclassed. The next example creates a subclass 
 of Bicycle for a two-seater bicycle known as a tandem:
 */
class Tandem: Bicycle {
    var currentNumberOfPassengers = 0
}

/*
 If you create an instance of Tandem, you can work with any of its new and
 inherited properties, and query the read-only description property it inherits
 from Vehicle:
 */
let tandem = Tandem()
tandem.hasBasket = true
tandem.currentNumberOfPassengers = 2
tandem.currentSpeed = 22.0
print("Tandem: \(tandem.description)")
//  Tandem: traveling at 22.0 miles per hour



//  MARK: - Overriding
/*
 A subclass can provide its own custom implementation of an instance method,
 type method, instance property, type property, or subscript that it would
 otherwise inherit from a superclass. This is known as overriding.
 
 To override a characteristic that would otherwise be inherited, you prefix 
 your overriding definition with the override keyword. Doing so clarifies that
 you intend to provide an override and have not provided a matching definition
 by mistake. 
 Overriding by accident can cause unexpected behavior, and any overrides
 without the override keyword are diagnosed as an error when your code is 
 compiled.
 */



//  MARK: Accessing Superclass Methods, Properties, and Subscripts
/*
 When you provide a method, property, or subscript override for a subclass, 
 it is sometimes useful to use the existing superclass implementation as part 
 of your override.

 Where this is appropriate, you access the superclass version of a method,
 property, or subscript by using the super prefix:

    - An overridden method named someMethod() can call the superclass version 
 of someMethod() by calling super.someMethod() within the overriding method
 implementation.
    - An overridden property called someProperty can access the superclass 
 version of someProperty as super.someProperty within the overriding getter or
 setter implementation.
    - An overridden subscript for someIndex can access the superclass version 
 of the same subscript as super[someIndex] from within the overriding subscript 
 implementation.
 */



//  MARK: Overriding Methods
/*
 You can override an inherited instance or type method to provide a tailored 
 or alternative implementation of the method within your subclass.
 */
class Train: Vehicle {
    override func makeNoise() {
        print("Choo Choo")
    }
}
let train = Train()
train.makeNoise()
//  Prints "Choo Choo"



//  MARK: Overriding Properties
/*
 You can override an inherited instance or type property to provide your own
 custom getter and setter for that property, or to add property observers to 
 enable the overriding property to observe when the underlying property value
 changes.
 */



//  MARK: Overriding Property Getters and Setters
/*
 You can provide a custom getter (and setter, if appropriate) to override any
 inherited property, regardless of whether the inherited property is 
 implemented as a stored or computed property at source.
 You must always state both the name and the type of the property you are 
 overriding, to enable the compiler to check that your override matches a
 superclass property with the same name and type.
 
 You can present an inherited read-only property as a read-write property by
 providing both a getter and a setter in your subclass property override. 
 But cannot, present an inherited read-write property as a read-only property.
 
 NOTE:
 If you provide a setter as part of a property override, you must also provide 
 a getter for that override. If you don’t want to modify the inherited 
 property’s value within the overriding getter, you can simply pass through the
 inherited value by returning super.someProperty from the getter, where 
 someProperty is the name of the property you are overriding.
 */
class Car: Vehicle {
    var gear = 1
    override var description: String {
        return super.description + " in gear \(gear)"
    }
}

/*
 The Car class’s version of description then adds some extra text onto the end 
 of this description to provide information about the current gear.
 */
let car = Car()
car.currentSpeed = 25.0
car.gear = 3
print("Car: \(car.description)")
//  ar: traveling at 25.0 miles per hour in gear 3



//  MARK: Overriding Property Observes
/*
 You can use property overriding to add property observers to an inherited 
 property.
 
 NOTE:
 You cannot add property observers to inherited constant stored properties or
 inherited read-only computed properties.

 If you want to observe changes to a property’s value, and you are already
 providing a custom setter for that property, you can simply observe any value
 changes from within the custom setter.
 */
class AutomaticCar: Car {
    override var currentSpeed: Double {
        didSet {
            gear = Int(currentSpeed / 10.0) + 1
        }
    }
}

let automatic = AutomaticCar()
automatic.currentSpeed = 35.0
print("AutomaticCar: \(automatic.description)")
//  Prints "AutomaticCar: traveling at 35.0 miles per hour in gear 4"



//  MARK: Preventing Overrides
/*
 You can prevent a method, property, or subscript from being overridden by 
 marking it as final.
 
 Do this by writing the final modifier before the method, property, or 
 subscript’s introducer keyword (such as final var, final func, 
 final class func, and final subscript).
 
 Any attempt to override a final method, property, or subscript in a subclass
 is reported as a compile-time error. Methods, properties, or subscripts that 
 you add to a class in an extension can also be marked as final within the
 extension’s definition.

 You can mark an entire class as final by writing the final modifier before the
 class keyword in its class definition (final class). Any attempt to subclass a 
 final class is reported as a compile-time error.
 */

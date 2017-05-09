//
//  main.swift
//  Swift_Objects_and_Classes
//
//  Created by Leo_Lei on 5/9/17.
//  Copyright © 2017 LibertyLeo. All rights reserved.
//

import Foundation

/*
 Use class followed by the class's name to create a class.
 Add a constant property with let, and add another method 
 that takes an argument.   (Exp)
 */
class Shape {
    var numberOfSides = 0
    let status = "closed"
    
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
    
    func simpleParam(param: String) -> String {
        return "A shape with \(param) param."
    }
}

//  Create an instance of a class.
var shape = Shape()
shape.numberOfSides = 7
var shapeDescription = shape.simpleDescription()
print(shapeDescription)

//  A class with an initializer to set up the class when an instance is created.
class NamedShape {
    var numberOfSides: Int = 0
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
}

// A standard subclass with override function
class Square: NamedShape {
    var sideLength: Double
    
    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 4;
    }
    
    func area() -> Double {
        return sideLength * sideLength
    }
    
    override func simpleDescription() -> String {
        return "A square with sides of length \(sideLength)."
    }
}

let test = Square(sideLength: 5.2, name: "my test square")
print(test.area())
print(test.simpleDescription())

/*  
 A subclass named circle to do the same job just as the square do.
 With radius and name as arguments to its initializer. Implement an area() 
 and a simpleDescription() method on the circle class   (Exp)
 */
class Circle: NamedShape {
    var radius: Double
    
    init(radius: Double, name: String) {
        self.radius = radius
        super .init(name: name)
        numberOfSides = 0
    }
    
    func area() -> Double {
        let pi = 3.14159265359
        return pi * radius * radius
    }
    
    override func simpleDescription() -> String {
        return "A circle with radius \(radius)"
    }
}
let testCircle = Circle(radius: 3, name: "my test Circle")
print(testCircle.area())
print(testCircle.simpleDescription())

/* 
 In addition to simple properties that are stored, properties can have 
 a getter and setter.
 During the initializer take thress steps:
 1. Setting the value of properties that the subclass declares.
 2. Calling the superclass's initializer.
 3. Changing the value of properties defined by the superclass.Any additional 
 setup work that uses methods, getters, or setters can also be done at this point.
 */
class EquilateralTriangle: NamedShape {
    var sideLength: Double = 0.0
    
    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 3
    }
    
    var perimeter: Double {
        get {
            return 3.0 * sideLength
        }
        set {
            sideLength = newValue / 3.0
        }
    }
    
    override func simpleDescription() -> String {
        return "An equilateral triangle with sides of lenth\(sideLength)."
    }
}

var triangle = EquilateralTriangle(sideLength: 3.1, name: "a triangle")
print(triangle.perimeter)
triangle.perimeter = 9.9
print(triangle.sideLength)

/* 
 If you don't need to compute the property but still need to provide code that
 is run before and after setting a new value, use willSet and didSet.
 The class below ensures that the side length of its triangle is always the 
 same as the side length of its square.
 */
class TriangleAndSquare {
    var triangle: EquilateralTriangle {
        willSet {
            square.sideLength = newValue.sideLength
        }
    }
    
    var square: Square {
        willSet {
            triangle.sideLength = newValue.sideLength
        }
    }
    
    init(size: Double, name: String) {
        square = Square(sideLength: size, name: name)
        triangle = EquilateralTriangle(sideLength: size, name: name)
    }
}

var triangleAndSquare = TriangleAndSquare(size: 10, name: "another test shape")
print(triangleAndSquare.square.sideLength)
print(triangleAndSquare.triangle.sideLength)
triangleAndSquare.square = Square(sideLength: 50, name: "larger square")
print(triangleAndSquare.triangle.sideLength)
print(triangleAndSquare.square.sideLength)

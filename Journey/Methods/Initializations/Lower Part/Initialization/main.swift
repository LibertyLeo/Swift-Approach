//
//  main.swift
//  Initialization
//
//  Created by Leo_Lei on 5/31/17.
//  Copyright © 2017 LibertyLeo. All rights reserved.
//

import Foundation

//  MARK: Class Inheritance and Initialization
/*
 All of a class’s stored properties—including any properties the class inherits 
 from its superclass—must be assigned an initial value during initialization.
 Swift defines two kinds of initializers for class types to help ensure all 
 stored properties receive an initial value. These are known as designated
 initializers and convenience initializers.
 */



//  MARK: Designated Initializers and Convenience Initializers
/*
 Designated initializers are the primary initializers for a class. A designated 
 initializer fully initializes all properties introduced by that class and
 calls an appropriate superclass initializer to continue the initialization 
 process up the superclass chain.
 Convenience initializers are secondary, supporting initializers for a class.
 You can define a convenience initializer to call a designated initializer 
 from the same class as the convenience initializer with some of the designated 
 initializer’s parameters set to default values. You can also define a 
 convenience initializer to create an instance of that class for a specific
 use case or input value type.
 */



//  MARK: Syntax for Designated and Convenience Initializers
/*
 Designated initializers for classes are written in the same way as simple 
 initializers for value types:
 ///    init(<#parameters#>) {
 ///    <#statement#>
 ///    }
 
 Convenience initializers are written in the same style, but with the 
 convenience modifier placed before the init keyword, separated by a space:
 ///    convenience init(<#parameters#>) {
 ///    <#statement#>
 ///    }
 */



//  MARK: Initializer Delegation for Class Type
/*
 To simplify the relationships between designated and convenience initializers,
 Swift applies the following three rules for delegation calls between 
 initializers:

 Rule 1
    A designated initializer must call a designated initializer from its
 immediate superclass.

 Rule 2
    A convenience initializer must call another initializer from the
 same class.

 Rule 3
    A convenience initializer must ultimately call a designated
 initializer.

 These rules are illustrated in the figure below:
                Superclass
 Designated <-- Convenience <-- Convenience
    ↑     ↖︎
    |       \
    |        \
    |         \ Subclass
 Designated <-- Designated <-- Convenience
 
 NOTE: The rules only affect how you write the implementation of the class's
 initializers.
 
 The figure below shows a more complex class hierarchy for four classes.
 
 Designated <-- Convenience <-- Convenience
           ↖︎
             \
              \
               \
 Convenience --> Designated <-- Convenience
                     ↑
                     |
 Convenience --> Designated <-- Convenience
               ↗︎     ↑
              /      |
             /       |
            /        |
 Designated      Designated <-- Convenience
 */



//  MARK: Two-Phase Initialization
/*
 Class initialization in Swift is a two-phase process. In the first phase, 
 each stored property is assigned an initial value by the class that introduced
 it. Once the initial state for every stored property has been determined,
 the second phase begins, and each class is given the opportunity to customize
 its stored properties further before the new instance is considered ready
 for use.
 Two-phase initialization prevents property values from being accessed before 
 they are initialized, and prevents property values from being set to a 
 different value by another initializer unexpectedly.
 
 Swift’s compiler performs four helpful safety-checks to make sure that
 two-phase initialization is completed without error:

 Safety check 1
 A designated initializer must ensure that all of the properties introduced by 
 its class are initialized before it delegates up to a superclass initializer.

 Safety check 2
 A designated initializer must delegate up to a superclass initializer before 
 assigning a value to an inherited property. If it doesn’t, the new value the
 designated initializer assigns will be overwritten by the superclass as part
 of its own initialization.

 Safety check 3
 A convenience initializer must delegate to another initializer before
 assigning a value to any property (including properties defined by the same 
 class). If it doesn’t, the new value the convenience initializer assigns
 will be overwritten by its own class’s designated initializer.

 Safety check 4
 An initializer cannot call any instance methods, read the values of any 
 instance properties, or refer to self as a value until after the first phase
 of initialization is complete.
 
 Here’s how two-phase initialization plays out, based on the four safety 
 checks above:
 Phase 1
    A designated or convenience initializer is called on a class.
    Memory for a new instance of that class is allocated. The memory is not 
 yet initialized.
    A designated initializer for that class confirms that all stored properties
 introduced by that class have a value. The memory for these stored properties 
 is now initialized.
    The designated initializer hands off to a superclass initializer to perform 
 the same task for its own stored properties.
    This continues up the class inheritance chain until the top of the chain 
 is reached.
    Once the top of the chain is reached, and the final class in the chain has
 ensured that all of its stored properties have a value, the instance’s memory
 is considered to be fully initialized, and phase 1 is complete.

 Phase 2
    Working back down from the top of the chain, each designated initializer 
 in the chain has the option to customize the instance further. Initializers 
 are now able to access self and can modify its properties, call its instance
 methods, and so on.
    Finally, any convenience initializers in the chain have the option to 
 customize the instance and to work with self.
 
 Here’s how phase 1 looks for an initialization call for a hypothetical 
 subclass and superclass:
                Superclass
 Safety Check 1 
            ↖︎
              \ Subclass
                SafetyCheck <-- Called

 Here’s how phase 2 looks for the same initialization call:
                Superclass
 Custommize
            \
             ↘︎ Subclass
                Customize --> Customize
 */



//  MARK: - Initializer Inheritance and Overriding
/*
 Unlike subclasses in Objective-C, Swift subclasses do not inherit their 
 superclass initializers by default. Swift’s approach prevents a situation in 
 which a simple initializer from a superclass is inherited by a more 
 specialized subclass and is used to create a new instance of the subclass that
 is not fully or correctly initialized.
 
 When you write a subclass initializer that matches a superclass designated 
 initializer, you are effectively providing an override of that designated 
 initializer.
 
 NOTE:
 You always write the override modifier when overriding a superclass designated 
 initializer, even if your subclass’s implementation of the initializer is a
 convenience initializer.
 */
class Vehicle {
    var numberOfWheels = 0
    var description: String {
        return "\(numberOfWheels) wheel(s)"
    }
}

/*
 The Vehicle class provides a default value for its only stored property, and 
 does not provide any custom initializers itself.
 The default initializer (when available) is always a designated initializer 
 for a class, and can be used to create a new Vehicle instance with a 
 numberOfWheels of 0:
 */
let vehicle = Vehicle()
print("Vehicle: \(vehicle.description)")
//  Vehicle: 0 wheel(s)

/*
 The Bicycle subclass defines a custom designated initializer, init(). This 
 designated initializer matches a designated initializer from the superclass 
 of Bicycle, and so the Bicycle version of this initializer is marked with the
 override modifier.
 */
class Bicycle: Vehicle {
    override init() {
        super.init()
        numberOfWheels = 2
    }
}

/*
 If you create an instance of Bicycle, you can call its inherited description 
 computed property to see how its numberOfWheels property has been updated:
 */
let bicycle = Bicycle()
print("Bicycle: \(bicycle.description)")
//  Bicycle: 2 wheel(s)
/*
 NOTE:
 Subclasses can modify inherited variable properties during initialization, but
 can not modify inherited constant properties.
 */



//  MARK: Automatic Initializer Inheritance
/*
 As mentioned above, subclasses do not inherit their superclass initializers by
 default. However, superclass initializers are automatically inherited if 
 certain conditions are met.
 Assuming that you provide default values for any new properties you introduce
 in a subclass, the following two rules apply:

 Rule 1
 If your subclass doesn’t define any designated initializers, it automatically 
 inherits all of its superclass designated initializers.

 Rule 2
 If your subclass provides an implementation of all of its superclass
 designated initializers—either by inheriting them as per rule 1, or by 
 providing a custom implementation as part of its definition—then it
 automatically inherits all of the superclass convenience initializers. 
 
 NOTE:
 A subclass can implement a superclass designated initializer as a subclass 
 convenience initializer as part of satisfying rule 2.
 */



//  MARK: - Designated and Convenience Initializers in Action
/*
 The following example shows designated initializers, convenience initializers,
 and automatic initializer inheritance in action.
 The base class in the hierarchy is called Food, which is a simple class to
 encapsulate the name of a foodstuff.
 */
class Food {
    var name: String
    init(name: String) {
        self.name = name
    }

    convenience init() {
        self.init(name: "[Unnamed]")
    }
}
/*
 The figure below shows the initializer chain for the Food class:
                        class Food
                     var name: String

 Convenience            Designated
    init() -----------> init(name)
 */

/*
 Classes do not have a default memberwise initializer, and so the Food class
 provides a designated initializer that takes a single argument called name. 
 This initializer can be used to create a new Food instance with a specific name:
 */
let namedMeat = Food(name: "Bacon")
//  namedMeat's name is "Bacon"

/*
 The Food class also provides a convenience initializer, init(), with no 
 arguments. The init() initializer provides a default placeholder name for a
 new food by delegating across to the Food class’s init(name: String) with a
 name value of [Unnamed]:
 */
let mysteryMeat = Food()
//  mysteryMeat's name is "[Unnamed]"

/*
 The second class in the hierarchy is a subclass of Food called RecipeIngredient.
 */
class RecipeIngredient: Food {
    var quantity: Int
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }

    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }
}
/*
 The figure below shows the initializer chain for the RecipeIngredient class:
                    class Food
                var name: String

 Convenience        Designated
    init() -------> init(name)
                        ↑
                        |
                        ——————————————————————
                class RecipeIngredient: Food |
                    var quantity: Int        |
                                             |
 Inherited          Convenience        Designated
   init() --------> init(name) ------> init(name, quantity)
 */

/*
 In this example, the superclass for RecipeIngredient is Food, which has a 
 single convenience initializer called init(). This initializer is therefore 
 inherited by RecipeIngredient.
 All three of these initializers can be used to create new RecipeIngredient
 instances:
 */
let oneMysteryItem = RecipeIngredient()
let oneBacon = RecipeIngredient(name: "Bacon")
let sixEggs = RecipeIngredient(name: "Eggs", quantity: 6)

/*
 The third and final class in the hierarchy is a subclass of RecipeIngredient 
 called ShoppingListItem. The ShoppingListItem class models a recipe ingredient 
 as it appears in a shopping list.
 */
class ShoppingListItem: RecipeIngredient {
    var purchased = false
    var description: String {
        var output = "\(quantity) x \(name)"
        output += purchased ? " ✔" : " ✘"
        return output
    }
}
/*
 NOTE:
 ShoppingListItem does not define an initializer to provide an initial value
 for purchased, because items in a shopping list (as modeled here) always start
 out unpurchased.

 The figure below shows the overall initializer chain for all three classes:
                    class Food
                var name: String

 Convenience        Designated
    init() -------> init(name)
                        ↑
                        |
                        ——————————————————————
                class RecipeIngredient: Food |
                    var quantity: Int        |
                                             |
 Inherited          Convenience        Designated
   init() --------> init(name) ------> init(name, quantity)
 
        class ShoppingListItem: RecipeIngredient
                var purchased = false

 Inherited          Inherited          Inherited
   init() --------> init(name) ------> init(name, quantity)
 
 You can use all three of the inherited initializers to create a new
 ShoppingListItem instance:
 */
var breakfastList = [
    ShoppingListItem(),
    ShoppingListItem(name: "Bacon"),
    ShoppingListItem(name: "Eggs", quantity: 6)
]
breakfastList[0].name = "Orange juice"
breakfastList[0].purchased = true
for item in breakfastList {
    print(item.description)
}



//  MARK: - Failable Initializers
/*
 It is sometimes useful to define a class, structure, or enumeration for which 
 initialization can fail. This failure might be triggered by invalid 
 initialization parameter values, the absence of a required external resource, 
 or some other condition that prevents initialization from succeeding.

 You write a failable initializer by placing a question mark after the init 
 keyword (init?).

 NOTE:
 You cannot define a failable and a nonfailable initializer with the same 
 parameter types and names.
 
 A failable initializer creates an optional value of the type it initializes.
 You write return nil within a failable initializer to indicate a point at 
 which initialization failure can be triggered.

 NOTE:
 Strictly speaking, initializers do not return a value. Rather, their role is
 to ensure that self is fully and correctly initialized by the time that
 initialization ends. Although you write return nil to trigger an
 initialization failure, you do not use the return keyword to indicate 
 initialization success.

 For instance, failable initializers are implemented for numeric type 
 conversions. To ensure conversion between numeric types maintains the value
 exactly, use the init(exactly:) initializer. If the type conversion cannot
 maintain the value, the initializer fails.
 */
let wholeNumber: Double = 12345.0
let pi = 3.14159

if let valueMaintained = Int(exactly: wholeNumber) {
    print("\(wholeNumber) conversion to Int maintains value")
}
//  Prints "12345.0 conversion to Int maintains value"

let valueChanged = Int(exactly: pi)
//  valueChanged is of type Int?, not Int

if valueChanged == nil {
    print("\(pi) conversion to Int does not maintain value")
}
//  Prints "3.14159 conversion to Int does not maintain value"

/*
 The Animal structure also defines a failable initializer with a single
 parameter called species. This initializer checks if the species value passed
 to the initializer is an empty string.
 */
struct Animal {
    let species: String
    init?(species: String) {
        if species.isEmpty { return nil }
        self.species = species
    }
}

let someCreature = Animal(species: "Giraffe")
//  SomeCreature is of type Animal?, not Animal

if let giraffe = someCreature {
    print("An animal was initialized with a species of \(giraffe.species)")
}
//  Prints "An animal was initialized with a species of Giraffe"

/*
 If you pass an empty string value to the failable initializer’s species
 parameter, the initializer triggers an initialization failure:
 */
let anonymousCreature = Animal(species: "")
//  anonymousCreature is of type Animal?, not Animal

if anonymousCreature == nil {
    print("The anonymous creature could not be initialized")
}
//  Prints "The anonymous creature could not be initialized"
/*
 NOTE:
 Checking for an empty string value (such as "" rather than "Giraffe") is not
 the same as checking for nil to indicate the absence of an optional String
 value. In the example above, an empty string ("") is a valid, nonoptional
 String. However, it is not appropriate for an animal to have an empty string 
 as the value of its species property. To model this restriction, the failable
 initializer triggers an initialization failure if an empty string is found.
 */



//  MARK: Failable Initializers for Enumeration
/*
 You can use a failable initializer to select an appropriate enumeration case 
 based on one or more parameters. The initializer can then fail if the provided
 parameters do not match an appropriate enumeration case.
 A failable initializer is used to find an appropriate enumeration case for a
 Character value representing a temperature symbol:
 */
enum Temperature {
    case kelvin, celsius, fahrenheit
    init?(symbol: Character) {
        switch symbol {
        case "K":
            self = .kelvin
        case "C":
            self = .celsius
        case "F":
            self = .fahrenheit
        default:
            return nil
        }
    }
}

/*
 You can use this failable initializer to choose an appropriate enumeration
 case for the three possible states and to cause initialization to fail if the
 parameter does not match one of these states:
 */
let fahrenheitUnit = Temperature(symbol: "F")
if fahrenheitUnit != nil {
    print("This is a defined temperature unit, so initialization succeeded.")
}
//  Prints "This is a defined temperature unit, so initialization succeeded."

let unknowUnit = Temperature(symbol: "X")
if unknowUnit == nil {
    print("This is not a define temperature unit, so initialization failed.")
}
//  Prints "This is not a define temperature unit, so initialization failed."



//  MARK: Failable Initializers for Enumeration with Raw Values
/*
 Enumerations with raw values automatically receive a failable initializer, 
 init?(rawValue:), that takes a parameter called rawValue of the appropriate 
 raw-value type and selects a matching enumeration case if one is found, or 
 triggers an initialization failure if no matching value exists.
 */
enum TemperatureUnit: Character {
    case kelvin = "K", celsius = "C", fahrenheit = "F"
}
let fahrenheitUnitCopy = TemperatureUnit(rawValue: "F")
if fahrenheitUnitCopy != nil {
    print("This is a defined temperature unit, so initialization succeeded.")
}
//  Prints "This is a defined temperature unit, so initialization succeeded."

let unknowUnitCopy = TemperatureUnit(rawValue: "X")
if unknowUnitCopy == nil {
    print("This is not a define temperature unit, so initialization failed.")
}
//  Prints "This is not a define temperature unit, so initialization failed."



//  MARK: Propagation of Initialization Failure
/*
 A subclass failable initializer can delegate up to a superclass failable
 initializer.
 In either case, if you delegate to another initializer that causes 
 initialization to fail, the entire initialization process fails immediately,
 and no further initialization code is executed.
 NOTE:
 A failable initializer can also delegate to a nonfailable initializer. Use 
 this approach if you need to add a potential failure state to an existing 
 initialization process that does not otherwise fail.
 */
class Product {
    let name: String
    init?(name: String) {
        if name.isEmpty { return nil }
        self.name = name
    }
}

class CartItem: Product {
    let quantity: Int
    init?(name: String, quantity: Int) {
        if quantity < 1 { return nil }
        self.quantity = quantity
        super.init(name: name)
    }
}
/*
 The failable initializer for CartItem starts by validating that it has 
 received a quantity value of 1 or more. If the quantity is invalid, the entire 
 initialization process fails immediately and no further initialization code 
 is executed.
 */
if let twoSocks = CartItem(name: "sock", quantity: 2) {
    print("Item: \(twoSocks.name), quantity: \(twoSocks.quantity)")
}
//  Prints "Item: sock, quantity: 2"

/*
 If you try to create a CartItem instance with a quantity value of 0, the 
 CartItem initializer causes initialization to fail:
 */
if let zeroShirts = CartItem(name: "shirt", quantity: 0) {
    print("Item: \(zeroShirts.name), quantity: \(zeroShirts.quantity)")
} else {
    print("Unable to initialize zero shirts")
}
//  Prints "Unable to initialize zero shirts"

/*
 Similarly, if you try to create a CartItem instance with an empty name value,
 the superclass Product initializer causes initialization to fail:
 */
if let oneUnnamed = CartItem(name: "", quantity: 1) {
    print("Item: \(oneUnnamed.name), quantity: \(oneUnnamed.quantity)")
} else {
    print("Unable to initialize one unnamed product")
}
//  Prints "Unable to initialize one unnamed product"



//  MARK: Overriding a Failable Initializer
/*
 You can override a superclass failable initializer with a subclass nonfailable
 initializer. This enables you to define a subclass for which initialization 
 cannot fail, even though initialization of the superclass is allowed to fail.
 NOTE:
 You can override a failable initializer with a nonfailable initializer but not
 the other way around.
 */
class Document {
    var name: String?
    //  this initializer creates a document with a nil name value
    init() {}
    //  this initializer creates a document with a nonempty name value

    init?(name: String) {
        if name.isEmpty { return nil }
        self.name = name
    }
}

/*
 The AutomaticallyNamedDocument subclass overrides both of the designated 
 initializers introduced by Document. These overrides ensure that an 
 AutomaticallyNamedDocument instance has an initial name value of "[Untitled]"
 if the instance is initialized without a name, or if an empty string is passed
 to the init(name:) initializer:
 */
class AutomaticallyNamedDocument: Document {
    override init() {
        super.init()
        self.name = "[Untitled]"
    }

    override init(name: String) {
        super.init()
        if name.isEmpty {
            self.name = "[Untitled]"
        } else {
            self.name = name
        }
    }
}

/*
 You can use forced unwrapping in an initializer to call a failable initializer
 from the superclass as part of the implementation of a subclass’s nonfailable 
 initializer.
 */
class UntitledDocument: Document {
    override init() {
        super.init(name: "[Untitled]")!
    }
}



//  MARK: The init! Failable Initializer
/*
 You can define a failable initializer that creates an implicitly unwrapped
 optional instance of the appropriate type. Do this by placing an exclamation 
 mark after the init keyword (init!) instead of a question mark.
 You can delegate from init? to init! and vice versa, and you can override
 init? with init! and vice versa. You can also delegate from init to init!, 
 although doing so will trigger an assertion if the init! initializer causes
 initialization to fail.
 */



//  MARK: - Required Initializers
/*
 Write the required modifier before the definition of a class initializer to 
 indicate that every subclass of the class must implement that initializer:
 */
class SomeClass {
    required init() {
        //  initializer implementation goes here
    }
}

/*
 You must also write the required modifier before every subclass implementation
 of a required initializer, to indicate that the initializer requirement 
 applies to further subclasses in the chain. You do not write the override 
 modifier when overriding a required designated initializer:
 NOTE:
 You do not have to provide an explicit implementation of a required 
 initializer if you can satisfy the requirement with an inherited initializer.
 */
class SomeSubclass: SomeClass {
    required init() {
        //  suclass implementation of the required initializer goes here
    }
}



//  MARK: Setting a Default Property Value with a Closure or Function
/*
 If a stored property’s default value requires some customization or setup, you 
 can use a closure or global function to provide a customized default.
 ///    class SomeClassWithClosure {
 ///        let someProperty: SomeType = {
 ///        //  create a default value for someProperty inside this closure
 ///        //  someValue must be of the same type as SomeType
 ///        return someValue
 ///    }()
 ///    }
 */

/*
 Note that the closure’s end curly brace is followed by an empty pair of 
 parentheses. This tells Swift to execute the closure immediately. If you omit
 these parentheses, you are trying to assign the closure itself to the 
 property, and not the return value of the closure.
 
 NOTE:
 If you use a closure to initialize a property, remember that the rest of the 
 instance has not yet been initialized at the point that the closure is 
 executed. This means that you cannot access any other property values from
 within your closure, even if those properties have default values. You also
 cannot use the implicit self property, or call any of the instance’s methods.
 */

/*
 The example below defines a structure called Chessboard, which models a board
 for the game of chess. Chess is played on an 8 x 8 board, with alternating 
 black and white squares.
 */
struct Chessboard {
    let boardColors: [Bool] = {
        var temporaryBoard = [Bool]()
        var isBlack = false
        for i in 1...8 {
            for j in 1...8 {
                temporaryBoard.append(isBlack)
                isBlack = !isBlack
            }
            isBlack = !isBlack
        }
        return temporaryBoard
    }()

    func squareIsBlackAt(row: Int, column: Int) -> Bool {
        return boardColors[(row * 8) + column]
    }
}

/*
 Whenever a new Chessboard instance is created, the closure is executed, and 
 the default value of boardColors is calculated and returned. The closure in 
 the example above calculates and sets the appropriate color for each square 
 on the board in a temporary array called temporaryBoard, and returns this 
 temporary array as the closure’s return value once its setup is complete. The
 returned array value is stored in boardColors and can be queried with the 
 squareIsBlackAt(row:column:) utility function:
 */
let board = Chessboard()
print(board.squareIsBlackAt(row: 0, column: 1))
//  Prints "true"
print(board.squareIsBlackAt(row: 7, column: 7))
//  Prints "false"

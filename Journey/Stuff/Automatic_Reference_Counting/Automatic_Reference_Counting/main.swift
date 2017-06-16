//
//  main.swift
//  Automatic_Reference_Counting
//
//  Created by Leo_Lei on 6/1/17.
//  Copyright © 2017 LibertyLeo. All rights reserved.
//

import Foundation

/*
 Swift uses Automatic Reference Counting (ARC) to track and manage your app’s 
 memory usage. In most cases, this means that memory management just works in
 Swift, and you do not need to think about memory management yourself. ARC
 automatically frees up the memory used by class instances when those instances
 are no longer needed.

 NOTE:
 Reference counting only applies to instances of classes. Structures and 
 enumerations are value types, not reference types, and are not stored and 
 passed by reference.
 */



//  MARK: How ARC works
/*
 Every time you create a new instance of a class, ARC allocates a chunk of 
 memory to store information about that instance. when an instance is no longer
 needed, ARC frees up the memory used by that instance so that the memory can 
 be used for other purposes instead.
 However, if ARC were to deallocate an instance that was still in use, it would
 no longer be possible to access that instance’s properties, or call that 
 instance’s methods. Indeed, if you tried to access the instance, your app
 would most likely crash.

 ARC will not deallocate an instance as long as at least one active reference 
 to that instance still exists.

 To make this possible, whenever you assign a class instance to a property, 
 constant, or variable, that property, constant, or variable makes a strong 
 reference to the instance, it keeps a firm hold on that instance, and does not
 allow it to be deallocated for as long as that strong reference remains.
 */



//  MARK: ARC in Action
/*
 Here’s an example of how Automatic Reference Counting works. This example 
 starts with a simple class called Person, which defines a stored constant
 property called name:
 */
class Person {
    let name: String
    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }

    deinit {
        print("\(name) is being deinitialized")
    }
}

/*
 The next code snippet defines three variables of type Person?, which are used 
 to set up multiple references to a new Person instance in subsequent code 
 snippets. Because these variables are of an optional type (Person?, not
 Person), they are automatically initialized with a value of nil, and do not
 currently reference a Person instance.
 */
var reference1: Person?
var reference2: Person?
var reference3: Person?

/*
 You can now create a new Person instance and assign it to one of these three
 variables:
 */
reference1 = Person(name: "John Applesed")
// Prints "John Applesed is being initialized"

/*
 Because the new Person instance has been assigned to the reference1 variable,
 there is now a strong reference from reference1 to the new Person instance.

 If you assign the same Person instance to two more variables, two more strong
 references to that instance are established:
 */
reference2 = reference1
reference3 = reference1

/*
 There are now three strong references to this single Person instance.
 If you break two of these strong references (including the original reference) 
 by assigning nil to two of the variables, a single strong reference remains,
 and the Person instance is not deallocated:
 */
reference1 = nil
reference2 = nil

/*
 ARC does not deallocate the Person instance until the third and final strong 
 reference is broken, at which point it’s clear that you are no longer using 
 the Person instance:
 */
reference3 = nil
// Prints "John Applesed is being deinitialized"



//  MARK: - Strong Reference Cycle Between Class Instances
/*
 It’s possible to write code in which an instance of a class never gets to a 
 point where it has zero strong references. This can happen if two class 
 instances hold a strong reference to each other, such that each instance keeps
 the other alive. This is known as a strong reference cycle.
 You resolve strong reference cycles by defining some of the relationships
 between classes as weak or unowned references instead of as strong references.
 Before you learn how to resolve a strong reference cycle, it’s useful to
 understand how such a cycle is caused.
 */
class PersonCycle {
    let name: String
    init(name: String) { self.name = name }
    var apartment: Apartment?
    deinit { print("\(name) is being deinitialized") }
}

class Apartment {
    let unit: String
    init(unit: String) { self.unit = unit }
    var tenant: PersonCycle?
    deinit { print("Apartment \(unit) is being deintialized") }
}

/*
 This next code snippet defines two variables of optional type called john and 
 unit4A, which will be set to a specific Apartment and Person instance below. 
 Both of these variables have an initial value of nil, by virtue of being 
 optional:
 */
var john: PersonCycle?
var unit4A: Apartment?

/*
 You can now create a specific Person instance and Apartment instance and 
 assign these new instances to the john and unit4A variables:
 */
john = PersonCycle(name: "John Applesed")
unit4A = Apartment(unit: "4A")

/*
 Here’s how the strong references look after creating and assigning these two 
 instances.
            var john            var unit4A
               |                    |
               | strong             | strong
               ↓                    ↓
        <PersonCycle instance>  <Apartment instance>
        name: "John Applesed"   unit: "4A"
        apartment: nil          tenant: nil
 
 You can now link the two instances together so that the person has an
 apartment, and the apartment has a tenant. Note that an exclamation mark (!) 
 is used to unwrap and access the instances stored inside the john and unit4A 
 optional variables, so that the properties of those instances can be set:
 */
john!.apartment = unit4A
unit4A!.tenant = john // this will cause reference cycle

/*
 Here’s how the strong references look after you link the two instances together:
            var john                                var unit4A
                |                                       |
                | strong                                | strong
                ↓                                       ↓
        <PersonCycle instance>          strong  <Apartment instance>
        name: "John Applesed"           ----→   unit: "4A"
        apartment: <Apartment instance> ←----   tenant: <Person instance>
                                        strong

 Unfortunately, linking these two instances creates a strong reference cycle
 between them.
 Therefore, when you break the strong references held by the john and unit4A 
 variables, the reference counts do not drop to zero, and the instances are not
 deallocated by ARC:
 */
unit4A = nil
john = nil

/*
 Note that neither deinitializer was called when you set these two variables 
 to nil.
 Here’s how the strong references look after you set the john and unit4A 
 variables to nil:
        var john                                var unit4A

    <PersonCycle instance>          strong  <Apartment instance>
    name: "John Applesed"           ----→   unit: "4A"
    apartment: <Apartment instance> ←----   tenant: <Person instance>
                                    strong
 
 The strong references between the Person instance and the Apartment instance
 remain and cannot be broken.
 */



//  MARK: - Resolving Strong Reference Cycle Between Class Instance
/*
 Two ways are provided to resolve strong reference cycles when you work with 
 properties of class type: weak references and unowned references.
 Weak and unowned references enable one instance in a reference cycle to refer 
 to the other instance without keeping a strong hold on it.

 Use a weak reference when the other instance has a shorter lifetime—that is, 
 when the other instance can be deallocated first.
 */



//  MARK: Weak Reference
/*
 A weak reference prevents the reference from becoming part of a strong 
 reference cycle. You indicate a weak reference by placing the weak keyword
 before a property or variable declaration.
 Because a weak reference does not keep a strong hold on the instance it refers
 to, it’s possible for that instance to be deallocated while the weak reference 
 is still referring to it. Therefore, ARC automatically sets a weak reference 
 to nil when the instance that it refers to is deallocated. And, because weak 
 references need to allow their value to be changed to nil at runtime, they are
 always declared as variables, rather than constants, of an optional type.

 NOTE:
 Property observers aren’t called when ARC sets a weak reference to nil.

 This time around, the Apartment type’s tenant property is declared as a weak
 reference:
 */
class PersonWeak {
    let name: String
    init(name: String) { self.name = name }
    var apartment: ApartmentWeak?
    deinit { print("\(name) is being deinitialized") }
}

class ApartmentWeak {
    let unit: String
    init(unit: String) { self.unit = unit }
    weak var tenant: PersonWeak?
    deinit { print("Apartment \(unit) is being deintialized") }
}

/*
 The strong references from the two variables (john and unit4A) and the links
 between the two instances are created as before:
 */
var marilyn: PersonWeak?
var unit5B: ApartmentWeak?
marilyn = PersonWeak(name: "Marilyn Monroe")
unit5B = ApartmentWeak(unit: "5B")

marilyn!.apartment = unit5B
unit5B!.tenant = marilyn

/*
 Here’s how the references look now that you’ve linked the two instances together:
            var marilyn                             var unit5B
                |                                       |
                | strong                                | strong
                ↓                                       ↓
        <PersonWeak instance>               strong  <ApartmentWeak instance>
        name: "Marilyn Monroe"              ----→   unit: "5B"
        apartment: <ApartmentWeak instance> ←----   tenant: <PersonWeak instance>
                                            weak
 
 This time when you break the strong reference held by the john variable by 
 setting it to nil, there are no more strong references to the Person instance:
 */
marilyn = nil
// Prints "Marilyn Monroe is being deinitialized"

/*
 Because there are no more strong references to the Person instance, it’s
 deallocated and the tenant property is set to nil:

            var marilyn            var unit5B
                                    |
                                    | strong
                                    ↓
                            <ApartmentWeak instance>
                            unit: "5B"
                            tenant: nil 
 */
unit5B = nil
// Prints "Apartment 5B is being deintialized"

/*Because there are no more strong references to the Apartment instance, it 
 too is deallocated:
            var john            var unit4A
 */



//  MARK: Unowned References
/*
 An unowned reference is used when the other instance has the same lifetime or
 a longer lifetime. You indicate an unowned reference by placing the unowned 
 keyword before a property or variable declaration.
 An unowned reference is expected to always have a value.
 
 IMPORTANT
 Use an unowned reference only when you are sure that the reference always 
 refers to an instance that has not been deallocated.
 If you try to access the value of an unowned reference after that instance has
 been deallocated, you’ll get a runtime error.

 The following example defines two classes, Customer and CreditCar. These two 
 classes each store an instance of the other class as a property. This 
 relationship has the potential to create a strong reference cycle.

 Because a credit card will always have a customer, you define its customer
 property as an unowned reference, to avoid a strong reference cycle:
 */
class Customer {
    let name: String
    var card: CreditCard?
    init(name: String) { self.name = name }
    deinit { print("\(name) is being deinitialized") }
}

class CreditCard {
    let number: UInt64
    unowned let customer: Customer
    init(number: UInt64, customer: Customer) {
        self.number = number
        self.customer = customer
    }

    deinit { print("Card #\(number) is being deinitialized") }
}

/*
 NOTE:
 The number property of the CreditCard class is defined with a type of UInt64 
 rather than Int, to ensure that the number property’s capacity is large enough
 to store a 16-digit card number on both 32-bit and 64-bit systems.
 */

/*
 This variable has an intial value of nil, by virtue of being optional, and you
 can create a Customer instance, and use it to initialize and assign a new 
 CreditCard instance as that customer’s card property:
 */
var leo: Customer?
leo = Customer(name: "Leo Lei")
leo!.card = CreditCard(number: 1234_5678_9012_3456, customer: leo!)
/*
 Here’s how the references look, now that you’ve linked the two instances:
        var leo
            |
            | strong
            ↓
    <Customer instance>         strong  <CreditCard instance>
    name: "Leo Lei"             -----→  number: 1234_5678_9012_3456
    card: <CreditCard instance> ←-----  customer: <Customer instance?
                                unowned
 
 Because of the unowned customer reference, when you break the strong referenc
 held by the john variable, there are no more strong references to the Customer 
 instance:
        var leo

    <Customer instance>         strong  <CreditCard instance>
    name: "Leo Lei"             -----→  number: 1234_5678_9012_3456
    card: <CreditCard instance> ←-----  customer: <Customer instance?
                                unowned
 
 Because there are no more strong references to the Customer instance, it’s 
 deallocated. After this happens, there are no more strong references to the 
 CreditCard instance, and it too is deallocated:
 */
leo = nil
//  Prints "Leo Lei is being deinitialized"
//  Prints "Card #1234567890123456 is being deinitialized"

/*
 NOTE:
 The examples above show how to use safe unowned references. Swift also 
 provides unsafe unowned references for cases where you need to disable runtime
 safety checks—As with all unsafe operations, you take on the responsiblity for
 checking that code for safety.

 You indicate an unsafe unowned reference by writing unowned(unsafe). If you 
 try to access an unsafe unowned reference after the instance that it refers to
 is deallocated, your program will try to access the memory location where the 
 instance used to be, which is an unsafe operation.
 */



//  MARK: - Unowned References and Implicitly Unwrapped Optional
//  MARK: Properties
/*
 The examples for weak and unowned references above cover two of the more common
 scenarios in which it’s necessary to break a strong reference cycle.
 The Person and Apartment example is best resolved with a weak reference.
 The Customer and CreditCard example is best resolved with an unowned reference.
 There is a third scenario, in which both properties should always have a value,
 and neither property should ever be nil once initialization is complete. In 
 this scenario, it’s useful to combine an unowned property on one class with an 
 implicitly unwrapped optional property on the other class.
 */
class Country {
    let name: String
    var capitalCity: City!
    init(name: String, capitalName: String) {
        self.name = name
        self.capitalCity = City(name: capitalName, country: self)
    }
}

class City {
    let name: String
    unowned let country: Country
    init(name: String, country: Country) {
        self.name = name
        self.country = country
    }
}

/*
 The initializer for City is called from within the initializer for Country. 
 However, the initializer for Country cannot pass self to the City initializer
 until a new Country instance is fully initialized.
 Because capitalCity has a default nil value, a new Country instance is 
 considered fully initialized as soon as the Country instance sets its name 
 property within its initializer. This means that the Country initializer can 
 start to reference and pass around the implicit self property as soon as the 
 name property is set. The Country initializer can therefore pass self as one
 of the parameters for the City initializer when the Country initializer is
 setting its own capitalCity property.
 */
var country = Country(name: "Canada", capitalName: "Ottawa")
print("\(country.name)'s capital city is called \(country.capitalCity.name)")
// Prints "Canada's capital city is called Ottawa"



//  MARK: - Strong Reference Cycles for Closures
/*
 A strong reference cycle can also occur if you assign a closure to a property
 of a class instance, and the body of that closure captures the instance.
 This capture might occur because the closure’s body accesses a property of the
 instance, such as self.someProperty, or because the closure calls a method on 
 the instance, such as self.someMethod(). In either case, these accesses cause
 the closure to capture” self, creating a strong reference cycle.
 Swift provides an elegant solution to this problem, known as a closure capture 
 list.
 */
class HTMLElement {
    let name: String
    let text: String?

    lazy var asHTML: () -> String = {
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }

    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }

    deinit {
        print("\(name) is being deinitialized")
    }
}

/*
 In addition to name and text properties, the HTMLElement class defines a lazy
 property called asHTML. This property references a closure that combines name
 and text into an HTML string fragment.
 */
let heading = HTMLElement(name: "h1")
let defaultText = "some default text"
heading.asHTML = {
    return "<\(heading.name)>\(heading.text ?? defaultText)</\(heading.name)>"
}
print(heading.asHTML())
// Prints "<h1>some default text</h1>"

/*
 The asHTML property is declared as a lazy property, because it’s only needed 
 if and when the element actually needs to be rendered as a string value for 
 some HTML output target. The fact that asHTML is a lazy property means that 
 you can refer to self within the default closure, because the lazy property 
 will not be accessed until after initialization has been completed and self is
 known to exist.
 */

/*
 Here’s how you use the HTMLElement class to create and print a new instance:
 */
var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")
print(paragraph!.asHTML())
// Prints "<p>hello, world</p>"

/*
 NOTE:
 The paragraph variable above is defined as an optional HTMLElement, so that 
 it can be set to nil below to demonstrate the presence of a strong reference
 cycle.

 Unfortunately, the HTMLElement class, as written above, creates a strong 
 reference cycle between an HTMLElement instance and the closure used for its 
 default asHTML value. Here’s how the cycle looks:
                var paragraph
                    |
                    | strong
                    ↓
        <HTMLElement instance>  strong      () -> String
            name: "p"           ←------
        text: "hello, world"    strong      self.text, self.name
        asHTML: () -> String    ------→
 
 The instance’s asHTML property holds a strong reference to its closure. 
 However, because the closure refers to self within its body (as a way to
 reference self.name and self.text), the closure captures self, which means 
 
 that it holds a strong reference back to the HTMLElement instance. A strong 
 reference cycle is created between the two.
 
 NOTE:
 Even though the closure refers to self multiple times, it only captures one 
 strong reference to the HTMLElement instance.
 */

/*
 If you set the paragraph variable to nil and break its strong reference to the 
 HTMLElement instance, neither the HTMLElement instance nor its closure are 
 deallocated, because of the strong reference cycle:
 */
paragraph = nil



//  MARK: - Resolving Strong Reference Cycles for Closures
/*
 You resolve a strong reference cycle between a closure and a class instance 
 by defining a capture list as part of the closure’s definition.
 A capture list defines the rules to use when capturing one or more reference 
 types within the closure’s body.
 
 NOTE:
 Swift requires you to write self.someProperty or self.someMethod() (rather 
 than just someProperty or someMethod()) whenever you refer to a member of self 
 within a closure. This helps you remember that it’s possible to capture self 
 by accident.
 */



//  MARK: Defining a Capture List
/*
 Each item in a capture list is a pairing of the weak or unowned keyword with
 a reference to a class instance (such as self) or a variable initialized with
 some value (such as delegate = self.delegate!). These pairings are written
 within a pair of square braces, separated by commas.
 
 Place the capture list before a closure’s parameter list and return type if
 they are provided:
 ///    lazy var someClosure: (Int, String) -> String = {
 ///        [unowned self, weak delegate = self.delegate!] (index: Int, stringToProcess: String) -> String in
 ///        // closure body goes here
 ///    }
 
 If a closure does not specify a parameter list or return type because they can
 be inferred from context, place the capture list at the very start of the 
 closure, followed by the in keyword:
 ///    lazy var someClosure: () -> String = {
 ///        [unowned self, weak delegate = self.delegate!] in
 ///        // closure body goes here
 ///    }
 */



//  MARK: Weak and Unowned References
/*
 Define a capture in a closure as an unowned reference when the closure and the 
 instance it captures will always refer to each other, and will always be
 deallocated at the same time.

 Conversely, define a capture as a weak reference when the captured reference 
 may become nil at some point in the future. Weak references are always of an 
 optional type, and automatically become nil when the instance they reference 
 is deallocated. This enables you to check for their existence within the
 closure’s body.
 
 NOTE:
 If the captured reference will never become nil, it should always be captured
 as an unowned reference, rather than a weak reference.
 */

/*
 An unowned reference is the appropriate capture method to use to resolve the 
 strong reference cycle in the HTMLElement example from earlier.
 */
class HTMLElementFix {
    let name: String
    let text: String?

    lazy var asHTML: () -> String = {
        [unowned self] in
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }

    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }

    deinit {
        print("\(name) is being deinitialized")
    }
}
/*
 In this case, the capture list is [unowned self], which means capture self as 
 an unowned reference rather than a strong reference”.
 */
var paragraphFix: HTMLElementFix? = HTMLElementFix(name: "p", text: "hello, world")
print(paragraphFix!.asHTML())
// Prints "<p>hello, world</p>

/*
 Here’s how the references look with the capture list in place:

    var paragraph
        |
        | strong
        ↓
 <HTMLElementFix instance>      unowned     () -> String
 name: "p"                      ←------     [unowned self]
 text: "hello, world"           strong      self.text, self.name
 asHTML: () -> String           ------→
 
 This time, the capture of self by the closure is an unowned reference, and 
 does not keep a strong hold on the HTMLElement instance it has captured.
 */
paragraphFix = nil
//  Prints "p is being deinitialized"

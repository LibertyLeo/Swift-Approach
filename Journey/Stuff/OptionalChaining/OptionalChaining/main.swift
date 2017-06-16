//
//  main.swift
//  OptionalChaining
//
//  Created by Leo_Lei on 6/2/17.
//  Copyright © 2017 LibertyLeo. All rights reserved.
//

import Foundation

/*
 Optional chaining is a process for querying and calling properties, methods,
 and subscripts on an optional that might currently be nil. Multiple queries
 can be chained together, and the entire chain fails gracefully if any link in
 the chain is nil.
 */



//  MARK: Optional Chaining as an Alternative to Forced Unwrapping
/*
 You specify optional chaining by placing a question mark (?) after the
 optional value on which you wish to call a property, method or subscript if
 the optional is non-nil.
 To reflect the fact that optional chaining can be called on a nil value, the
 result of an optional chaining call is always an optional value, even if the
 property, method, or subscript you are querying returns a nonoptional value.
 You can use this optional return value to check whether the optional chaining
 call was successful (the returned optional contains a value), or did not
 succeed due to a nil value in the chain (the returned optional value is nil).
 Specifically, the result of an optional chaining call is of the same type as
 the expected return value, but wrapped in an optional.
 */
class Person {
    var residence: Residence?
}

class Residence {
    var numberOfRooms = 1
}

/*
 If you create a new Person instance, its residence property is default
 initialized to nil, by virtue of being optional. In the code below, john
 has a residence property value of nil:
 */
let john = Person()

/*
 If you try to access the numberOfRooms property of this person’s residence,
 by placing an exclamation mark after residence to force the unwrapping of its
 value, you trigger a runtime error, because there is no residence value to
 unwrap:
 */
//let roomCount = john.residence!.numberOfRooms
// this trigger a runtime error

/*
 Optional chaining provides an alternative way to access the value of
 numberOfRooms. To use optional chaining, use a question mark in place of the
 exclamation mark:
 */
if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}
// Prints "Unable to retrieve the number of rooms."

/*
 Note that this is true even though numberOfRooms is a nonoptional Int. The
 fact that it is queried through an optional chain means that the call to
 numberOfRooms will always return an Int? instead of an Int.

 You can assign a Residence instance to john.residence, so that it no longer
 has a nil value:
 */
john.residence = Residence()

/*
 If you try to access numberOfRooms with the same optional chaining as before,
 it will now return an Int? that contains the default numberOfRooms value of 1:
 */
if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}
// Prints "John's residence has 1 room(s)."



//  MARK: - Definiing Model Classes for Optional Chaining
/*
 You can use optional chaining with calls to properties, methods, and
 subscripts that are more than one level deep. This enables you to drill down
 into subproperties within complex models of interrelated types, and to check
 whether it is possible to access properties, methods, and subscripts on those
 subproperties.
 As we define four model classes for use in several subsequent examples,
 including examples of multilevel optional chaining.
 */
class PersonModel {
    var residence: ResidenceModel?
}

/*
 As a shortcut to accessing its rooms array, this version of Residence provides
 a read-write subscript that provides access to the room at the requested
 index in the rooms array.
 */
class ResidenceModel {
    var rooms = [Room]()
    var numberOfRooms: Int {
        return rooms.count
    }

    subscript(i: Int) -> Room {
        get {
            return rooms[i]
        }
        set {
            rooms[i] = newValue
        }
    }

    func printNumberOfRooms() {
        print("The number of rooms is \(numberOfRooms)")
    }
    var address: Address?
}

/*
 The Room class used for the rooms array is a simple class with one property
 called name, and an initializer to set that property to a suitable room name:
 */
class Room {
    let name: String
    init(name: String) { self.name = name }
}

/*
 The Address class also provides a method called buildingIdentifier(), which
 has a return type of String?. This method checks the properties of the address
 and returns buildingName if it has a value, or buildingNumber concatenated
 with street if both have values, or nil otherwise.
 */
class Address {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?

    func buildingIdentifier() -> String? {
        if let buildingNumber = buildingNumber, let street = street {
            return "\(buildingNumber) \(street)"
        } else if buildingName != nil {
            return buildingName
        } else {
            return nil
        }
    }
}



//  MARK: Accessing Properties Through Optional Chaining
/*
 You can use optional chaining to access a property on an optional value, and
 to check if that property access is successful.
 */
let leo = PersonModel()
if let roomCount = leo.residence?.numberOfRooms {
    print("Leo's residence has \(roomCount) room(s)")
} else {
    print("Unable to retrieve the number of rooms")
}

/*
 Because leo.residence is nil, this optional chaining call fails in the same
 way as before.

 You can also attempt to set a property’s value through optional chaining:
 */
let someAddress = Address()
someAddress.buildingNumber = "29"
someAddress.street = "Acacia Road"
leo.residence?.address = someAddress

/*
 The listing below does the same assignment, but it uses a function to create
 the address. The function prints Function was called” before returning a
 value, which lets you see whether the right hand side of the = operator was
 evaluated.
 */
func createAddress() -> Address {
    print("Function was called")

    let someAddress = Address()
    someAddress.buildingName = "29"
    someAddress.street = "Acacia Road"

    return someAddress
}
leo.residence?.address = createAddress()



//  MARK: Calling Methods Through Optional Chaining
/*
 You can use optional chaining to call a method on an optional value, and to
 check whether that method call is successful. You can do this even if that
 method does not define a return value.

 If you call this method on an optional value with optional chaining, the
 method’s return type will be Void?, not Void, because return values are
 always of an optional type when called through optional chaining.
 */
if leo.residence?.printNumberOfRooms() != nil {
    print("It was possible to print the number of rooms.")
} else {
    print("It was not possible to print the number of rooms")
}
// Prints "It was not possible to print the number of rooms"

/*
 The same is true if you attempt to set a property through optional chaining.
 */
if (leo.residence?.address = someAddress) != nil {
    print("It was possible to set the address.")
} else {
    print("It was not possible to set the address.")
}
// Prints "It was not possible to set the address."



//  MARK: Accessing Subscripts Through Optional Chaining
/*
 You can use optional chaining to try to retrieve and set a value from a
 subscript on an optional value, and to check whether that subscript call
 is successful.

 NOTE:
 When you access a subscript on an optional value through optional chaining,
 you place the question mark before the subscript’s brackets, not after. The
 optional chaining question mark always follows immediately after the part of
 the expression that is optional.
 */
if let firstRoomName = leo.residence?[0].name {
    print("The first room name is \(firstRoomName).")
} else {
    print("Unable to retrieve the first room name.")
}
// Prints "Unable to retrieve the first room name."

/*
 The optional chaining question mark in this subscript call is placed
 immediately after leo.residence, before the subscript brackets, because
 leo.residence is the optional value on which optional chaining is being
 attempted.
 */
leo.residence?[0] = Room(name: "Bathroom")
// This subscript setting attempt also fails, because residence is currently
nil.

/*
 If you create and assign an actual Residence instance to leo.residence, with
 one or more Room instances in its rooms array, you can use the Residence
 subscript to access the actual items in the rooms array through optional
 chaining:
 */
let leosHouse = ResidenceModel()
leosHouse.rooms.append(Room(name: "Living Room"))
leosHouse.rooms.append(Room(name: "Kitchen"))
leo.residence = leosHouse

if let firstRootName = leo.residence?[0].name {
    print("The first room name is \(firstRootName).")
} else {
    print("Unable to retrieve the first room name")
}
// Prints "The first room name is Living Room."



//  MARK: Accessing Subscripts of Optional Type
/*
 If a subscript returns a value of optional type—such as the key subscript of
 Swift’s Dictionary type—place a question mark after the subscript’s closing
 bracket to chain on its optional return value:
 */
var testScores = ["Dave": [86, 82, 84], "Bev": [79, 94, 81]]
testScores["Dave"]?[0] = 91
testScores["Bev"]?[0] += 1
testScores["Brian"]?[0] = 72
// the "Dave" array is now [91, 82, 84] and the "Bev" array is now [80, 94, 81]



//  MARK: - Linking Multiple Levels of Chaining
/*
 You can link together multiple levels of optional chaining to drill down to
 properties, methods, and subscripts deeper within a model. However, multiple
 levels of optional chaining do not add more levels of optionality to the
 returned value.

 To put it another way:

 If the type you are trying to retrieve is not optional, it will become
 optional because of the optional chaining.
 If the type you are trying to retrieve is already optional, it will not
 become more optional because of the chaining.
 Therefore:

 If you try to retrieve an Int value through optional chaining, an Int? is
 always returned, no matter how many levels of chaining are used.
 Similarly, if you try to retrieve an Int? value through optional chaining,
 an Int? is always returned, no matter how many levels of chaining are used.
 */

/*
 The example below tries to access the street property of the address property
 of the residence property of leo. There are two levels of optional chaining
 in use here, to chain through the residence and address properties, both of
 which are of optional type:
 */
if let leosStreet = leo.residence?.address?.street {
    print("Leo's street name is \(leosStreet).")
} else {
    print("Unable to retrieve the address.")
}
// Prints "Unable to retrieve the address."
/*
 The value of leo.residence currently contains a valid Residence instance.
 However, the value of leo.residence.address is currently nil. Because of this,
 the call to leo.residence?.address?.street fails.
 */

/*
 If you set an actual Address instance as the value for leo.residence.address,
 and set an actual value for the address’s street property, you can access the
 value of the street property through multilevel optional chaining:
 */
let leosAddress = Address()
leosAddress.buildingName = "The Larches"
leosAddress.street = "Laurel Street"
leo.residence?.address = leosAddress

if let leosStreet = leo.residence?.address?.street {
    print("Leo's street name is \(leosStreet).")
} else {
    print("Unable to retrieve the address.")
}
// Prints "Leo's street name is Laurel Street."
/*
 In this example, the attempt to set the address property of john.residence
 will succeed, because the value of john.residence currently contains a valid
 Residence instance.
 */



//  MARK: - Chaining on Methods with Optional Return Value
/*
 The previous example shows how to retrieve the value of a property of optional
 type through optional chaining. You can also use optional chaining to call a
 method that returns a value of optional type, and to chain on that method’s
 return value if needed.
 */
if let buildingIdentifier = leo.residence?.address?.buildingIdentifier() {
    print("Leo's building identifier is \(buildingIdentifier).")
}
// Prints "Leo's building identifier is The Larches."

/*
 If you want to perform further optional chaining on this method’s return
 value, place the optional chaining question mark after the method’s
 parentheses:
 */
if let beginsWithThe = leo.residence?.address?.buildingIdentifier()?.hasPrefix("The") {
    if beginsWithThe {
        print("Leo's building identifier begins with \"The\".")
    } else {
        print("Leo's building identifier does not begin with \"The\".")
    }
}
// Prints "Leo's building identifier begins with "The"."
/*
 NOTE:
 In the example above, you place the optional chaining question mark after
 the parentheses, because the optional value you are chaining on is the
 buildingIdentifier() method’s return value, and not the buildingIdentifier()
 method itself.
 */

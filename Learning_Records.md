# Learning_Records
## Day01 May 8, 2017
Some usage and grammar for `constant`, `variable`, `sets`, `control flow`.  
It is only the brief introduction of basic use.

## Day02 May 9, 2017
1. **`Function`** includes **`Closures`** usage of swift.
2. **`Objects`** and **`Classes`**'s creation, also about its subclass and keywords such as `willSet`, `didSet`, `override`, `init`.  
Remeber to the initializer of subclass needs three different steps:  
1. Setting the value of properties that subclass declares.
2. Calling the superclass's initializer.
3. Changing the value of properties defined by the superclass. Any additional setup work that use methods, getters, or setters can also be done at this point.
3. **`Enumeration`** and **`Structure`** creation.	

## Day03 May 10, 2017
1. **`Protocol`** and **`Extension`** usage for expand original type such as classes, enumerations, strcture.
2. **`Error handling`**. Use `error` and `do-catch` with `try` to handle error that you use `throw` to throw it out.
3. **`Generics`** is to defined the specified type of the function or type.

## Day04 May 11, 2017
Some missing parts that was not declared in detail in the front three-days work.

## Day05 May 12, 2017
1. Warming up. The supplementary job of basic parts.
2. **`Basic_Operators`**.  
Some extension of Swift's operators that compared by C and Objc.
3. **`String literals`** and **`Characters`**.  
Some interesting Unicode knowledge that I have never known.

## Day06 May 15, 2017
1. **`Unicode Scalars`** usage and representation about **`String literals`**.
2. Learn about one of the collection types, **`Array`**.  
Knows its creation, accessing, modifying and iterating.

## Day07 May 16, 2017
1. Learn about **`Set`**, and provide the most important parts of declaration about the relationship between Sets.
2. Learn about **`Dictionary`**.  
Knows its common usage and convenient method 'updateValue(_:forKey:)' to check out whether or not an update took place.

## Day08 May 17, 2017
1. Fulfill of the **`Dictionary`** with removal and iteration parts.
2. **`Control Flow`** of displaying about 'for-in', 'while', 'repeat-while' loops, and also 'if' conditional statements.

## Day09 May 18, 2017
1. Make **`Conditional Statements`** which take high attention to **`switch`** usage, separate from **`Control Flow`**.  
And also many extraordinary apply of **`Interval Matching`**, **`Tuples`**, **`Value Bindings`** and so on.
2. Focus on the difference of **`Control Transfer Statement`** between Swift and C.  
By using **`Labeled Statements`** to make it more clear when control statement needs to be terminated, and use `guard` for requirements improves the readability of code, compare to doing the same check with an `if` statement.

## Day10 May 19, 2017
Learn about Swift's **`Function`**.  
Not only just the grammar difference from the past language, but also for the new usage of the function type and the **`Nested function`** is also great help!

## Day11 May 22, 2017
Learn about **`Closures`**.  
The **`escaping closures`** and **`autoclosures`** are the most import part for writing a marvelous closures.  
The concept of closures remains to be understood.

## Day12 May 23, 2017
1. **`Enumerations`**.  
Not just the extension for enumeration cases' type of string, character, or any value of any integer of floating point, **`Associated Values`** and **`Raw Values`** is quiet different from the original enumeration.  
A **`Recursive Enumeration`** is also allowed to make a better code structure.
2. **`Classes`** and **`Structures`**.  
It declares the difference types between themselves, and also when you choosing one of them to build you program, you have some simply ways to balance.

## Day13 May 24, 2017
1. **`Properties`** usage.
Besides `Stored Properties` and `Computed Properties`, Swift also provide `Property Observer` through `willSet` and `didSet` observer. In that way, we can know the `newValue` and `oldValue` that we assign just now.
2. **`Methods`**.  
Not just know the `Instance Methods`, we introduce `Type Methods` as well now.  
And also the experiment LevelTracker is great help for understood this chapter.

## Day14 May 25, 2017
1. **`Subscripts`** is much similar usage both in Swift and Objc.  
What makes difference is we can set multiple parameters as it is appropriate for our types.
2. **`Inheritance`** in Swift is much similar to that in Objc.  
And you can also add `final` prefix by methods, properties, or subscript's to prevent being modified.

## Day15 May 27, 2017
**`Initializations`** of all types in Swift.  
Without set a default value or `initializer`, struct may have `memberwise initializer` while class have
default initializer.

## Day16 May 31, 2017
The rest part of **`Initializations`** which has been started on May 27.  
I recommend you to look through the comments in first part, or you can skip into
the second part as well.  
In this project, it introduces `Designated`、 `Convenience`、 `Failable` and `Required` initializers.   
Each of them has its own function declared in detail in project.

## Day17 Jun 1, 2017
1. Use a simple Bank and Player example to explain the **`Deinitializations`**.  
Remember deinitializer is only avaiable on class types.
2. **`Automatic Reference Counting`** is very similar to that in Objc.  
To resolve `reference cycle` is also to break the strong link between each other.  
Normally, you can use `weak` or `unowned` reference to resolve the cycle of property while use `capture list` to resolve cycle of closure.

## Day18 Jun 2, 2017
1. **`Optional Chaining`** is a process for querying and calling properties, methos, and subscripts on
an optional that might currently be nil.  
It is a much graceful alternative to use optional chaining rather than forced unwrapping to handle optional type.
2. Declare about **`Error Handling`** which is much resembling for that in other language, through using such as `try`, `do-catch` statements to handle errors.

## Day19 Jun 5, 2017
1. Fulfill the rest of parts for **`Error Handling`**.
2. Use **`Type Casting`** to check the type of an instance, or to treat that instance as a different superclass or subclass from somewhere else in its own class hierarchy through `is` and `as` operators.
3. **`Nested Types`** helps you more convenient to define utility classes and structures purely for use within the context of a more complex type rather than a separated and messed small pieces of classes.

## Day20 Jun 7, 2017
**`Extensions`** are similar to the categories in Objc, but without the name.  
Extension in Swift can add computed instance properties and computed type properties, define instance methods and type methods, provide new initializers, define subscripts, define and use new nested types, mak an existing type confrom to a protocol.

## Day21 Jun 12, 2017
**`Protocols`** defines a blueprint of methods, properties, and other requirements that suit a particular task or piece of functionality.  
Though `protocol` do not actually implement any functionality themselves.  
Nonetheless, any `protocol` you create will become a fully-fledged type for use in your code.

## Day22 Jun 13, 2017
Continue learns some **`Protocol`** standard, such as define some `constraints` to `protocol`, define `class-only` protocols, and also use `type casting` to check the protocol conformance and so on.

## Day23 Jun 14, 2017
The most powerful type **`Generics`** enables you to write flexible, reusable functions and types that can work with any type, subject to requirements that you define.  
You can write code that avoids duplication and expresses its intent in a clear, abstracted manner.

## Day24 Jun 15, 2017
1. An associated type gives a placeholder name to a type that is used as part of the protocol.  
We adopt it to make more constraints for `Generics` extension.  
A generic where clause enables us to require that an associated type must conform to a certain protocol, or that certain type parameters and associated types must be the same.
2. Through **`Access Control`**, we can hide the implementation details of a specific piece of functionality.  
By take good use of `access control`, we can easily control the self-zone.

## Day25 Jun 16, 2017
When using **`Advanced Operators`** in Swift, we should know the precedence and associativity.  
We can easily use `bitwise operators`, `overflow operators` to the safety of our code.  
And also use `operator methods`, even custom methods for making class or structure even convenient for some handler. 

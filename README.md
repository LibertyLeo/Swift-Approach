# Swift_Learning
A repository created for swift learning recording.    
The comment follwed by `(Exp)` are the experiment declared by the Apple Inc.    
You can download the [Swift's Official][Official] for reading and get a better understanding as you wish.    
Alternatively, if you find it's hard to read the original, a [Chinese Version][Chinese] is also provided.    
But we take no responsibility of misunderstanding on the translation.:-)

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
1. **`Protocol`** and **`Extension`** usage for expand original type such as classes, enumerations, strcture...
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
**`Subscripts`** is much similar usage both in Swift and Objc.    
What makes difference is we can set multiple parameters as it is appropriate for our types.

[Official]:https://github.com/LibertyLeo/Swift_Learning/raw/master/Document/The%20Swift%20Programming%20Language%20(Swift%203.1).epub
[Chinese]:https://github.com/LibertyLeo/Swift_Learning/raw/master/Document/The%20Swift%20Programming%20Language%20中文版3.0.epub

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
1. **`Function`** includes **`closures`** usage of swift.
2. **`Objects`** and **`classes's`** creation, also about its subclass and keywords such as `willSet`, `didSet`, `override`, `init`.    
Remeber to the initializer of subclass needs three different steps:    
	1. Setting the value of properties that subclass declares.
	2. Calling the superclass's initializer.
	3. Changing the value of properties defined by the superclass. Any additional setup work that use methods, getters, or setters can also be done at this point.
3. **`Enumeration`** and **`struct`** creation.	

## Day03 May 10, 2017
1. **`Protocol`** and **`extension`** usage for expand original type such as classes, enumerations, strcture...
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
Fulfill of the **`Dictionary`** with removal and iteration parts.

[Official]:https://github.com/LibertyLeo/Swift_Learning/raw/master/Document/The%20Swift%20Programming%20Language%20(Swift%203.1).epub
[Chinese]:https://github.com/LibertyLeo/Swift_Learning/raw/master/Document/The%20Swift%20Programming%20Language%20中文版3.0.epub

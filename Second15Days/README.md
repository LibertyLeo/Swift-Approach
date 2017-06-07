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

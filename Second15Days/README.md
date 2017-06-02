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
**`Optional Chaining`** is a process for querying and calling properties, methos, and subscripts on
an optional that might currently be nil.  
It is a much graceful alternative to use optional chaining rather than forced unwrapping to handle optional type.

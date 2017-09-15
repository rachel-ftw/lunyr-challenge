# Lunyr Coding Challenge

Applying to the front end developer position.
[Website](http://www.rachelralston.com)
[UI Design Portfolio](http://www.dribbble.com/)

#### Process Outline
1. Read and understand the contract. Find all plainly obvious bugs. see [insecure-firstPassNotes.sol](https://github.com/rachel-ftw/lunyr-challenge/blob/master/insecure-firstPassNotes.sol)
1. Run the contract through the [remix compiler](https://remix.ethereum.org/) and check their analysis ([remix-compiler-notes.md](https://github.com/rachel-ftw/lunyr-challenge/blob/master/remix-compiler-notes.md)). Resolve all bugs.
1. Think through the problem: Where can you use modifiers to encapsulate code? Are you emitting events where you should be? Have you thought about as many security angles as you can?
1. run it through the compiler again to catch any additional bugs.

As I went back through the contract I:
- added a struct to the shares map
- added some modifiers to ensure that only authorized users could engage certain parts & to lock the contract against reentrance.
- added more events to mark different locations of execution success or failure.
- I wrapped parts of the execution in `if`/`else` statements to be more precise and to allow for both success and failure events.

The gas cost is a concern with the `for` loop in the `dispense` function. If there are enough shareholders the gas will run out.

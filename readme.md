# Nimbed

## Goal

> To create a framework for resource-constrained microcontrollers
> and ease development of safe and reliable embedded systems
> using Nim's elegent syntax, rich data types, strong typing,
> and useful build system.

## Status

I have only started to make rough drafts of a couple foundation modules.
I am still learning Nim and experimenting with how to use advanced features
of Nim's type system.

## Influences

- Leverage a convenient development environment like [PlatformIO](https://platformio.org)
- Create peripheral API abstractions like [Mbed](https://os.mbed.com)
- [Type states](https://docs.rust-embedded.org/book/static-guarantees/typestate-programming.html) and zero-cost abstractions from [rust-embedded](https://github.com/rust-embedded)
- Actor-based, run-to-completion concurrency using augmented hierarchical state machines ala [Quantum Platform](https://www.state-machine.com/products/qp)

### Anti goals

- wrap C libs
- creation of dogmatic threads, semaphores and mutexes
- support processors with MMUs / Virtual Memory
- create something that requires >5 yrs of embedded experience to use

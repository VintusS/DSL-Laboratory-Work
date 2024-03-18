# Lexer & Scanner Laboratory

### Course: Formal Languages & Finite Automata

### Author: Mindrescu Dragomir

## Overview

The lexer, short for lexical analyzer, plays a critical role in the process of compiling or interpreting code. It converts a sequence of characters from source code into a stream of tokens. These tokens, which represent syntactic elements like identifiers, literals, and operators, are then used by parsers to create a syntactic structure.

This project aims to implement a simple lexer to understand the fundamentals of lexical analysis, which is pivotal in the realms of formal languages and finite automata.

## Objectives

1. **Understand Lexical Analysis**: Grasp the concept of lexical analysis and its importance in the compilation process.
2. **Lexer Mechanics**: Explore the inner workings of a lexer and how it transforms a string of characters into a stream of tokens.
3. **Implement a Lexer**: Develop a basic lexer to tokenize an input string and identify various elements like identifiers, numbers, and operators.

## Implementation

The lexer is implemented in Swift, providing a concise and effective demonstration of lexical analysis. The core functionality includes recognizing identifiers, numbers, operators, and assigning appropriate token types to different segments of the input string.

### Key Components

- `TokenType`: Enum to define various types of tokens like identifiers, numbers, and operators.
- `Token`: Struct to represent individual tokens with a type and value.
- `Lexer`: Class responsible for the lexical analysis, capable of tokenizing an input string.

## Usage

To use the lexer, initialize it with a string, and then call the `tokenize` method to produce a stream of tokens.

```swift
let lexer = Lexer(input: "let someVariable = 12 + 34")
let tokens = lexer.tokenize()
```

## Conclusion

This lexer project serves as a practical introduction to lexical analysis, a fundamental component of compilers and interpreters. By implementing a basic lexer, students gain hands-on experience with the process of tokenizing strings, understanding the intricacies of lexical tokens, and the importance of precise syntax analysis in programming language design. This project not only reinforces theoretical concepts learned in the study of formal languages and finite automata but also provides a foundational tool for further exploration in the field of compiler construction.


## References
1. COJUHARI Irina, Duca Ludmila, Fiodorv Ion. "Formal Languages and Finite Automata: Guide for practical lessons". Technical University of Moldova
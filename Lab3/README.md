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

The lexer implementation in Swift showcases an efficient approach to lexical analysis, critical for parsing and interpreting code. The primary objective of the lexer is to convert a sequence of characters into a stream of tokens that represent syntactic meaning, such as identifiers, numbers, and operators. Each token is classified according to type, which is crucial for the subsequent phases of parsing and compilation.

### Key Components

- `TokenType`: This is an enumeration that defines the possible types of tokens. It includes categories like identifiers, numbers, operators, and whitespace, allowing the lexer to categorize parts of the string based on their role in the syntax of the language.
- `Token`: A struct that encapsulates a token in the lexical analysis process. Each token has a type, derived from the TokenType enum, and a value, which is the actual string excerpt representing the token in the source code.
- `Lexer`: A class responsible for the core functionality of lexical analysis. It takes an input string and processes it to extract tokens by recognizing patterns that match different types of syntax elements (like numbers or identifiers).

## Usage

The lexer is designed to be user-friendly and easy to integrate into larger applications. Here’s how you can utilize the lexer:

```swift
print("Enter your code line:", terminator: " ")
if let code = readLine() {
    let lexer = Lexer(input: code)
    let tokens = lexer.tokenize()
}
```

This is the output for the following input `let someVariable = 12 + 34`:

```bash
identifier: 'let'
whitespace: ' '
identifier: 'someVariable'
whitespace: ' '
operatorSymbol: '='
whitespace: ' '
number: '12'
whitespace: ' '
operatorSymbol: '+'
whitespace: ' '
number: '34'
```

## Conclusion

Through this lexer project, students encounter the foundational aspects of compiler technology, specifically lexical analysis. The project not only reinforces theoretical concepts from the study of formal languages and automata but also serves as a practical tool for further explorations in compiler construction and language design. The implementation highlights the meticulous nature of lexical token identification and its significance in the broader context of software development and programming language theory. This hands-on experience lays the groundwork for more advanced studies in compiler construction and language processing.


## References
1. COJUHARI Irina, Duca Ludmila, Fiodorv Ion. "Formal Languages and Finite Automata: Guide for practical lessons". Technical University of Moldova
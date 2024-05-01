# Parser & Building an Abstract Syntax Tree

### Course: Formal Languages & Finite Automata

### Author: Mindrescu Dragomir

----

## Overview
&ensp;&ensp;&ensp; The process of gathering syntactical meaning or doing a syntactical analysis over some text can also be called parsing. It usually results in a parse tree which can also contain semantic information that could be used in subsequent stages of compilation, for example.

&ensp;&ensp;&ensp; Similarly to a parse tree, in order to represent the structure of an input text one could create an Abstract Syntax Tree (AST). This is a data structure that is organized hierarchically in abstraction layers that represent the constructs or entities that form up the initial text. These can come in handy also in the analysis of programs or some processes involved in compilation.


## Objectives:
1. Get familiar with parsing, what it is and how it can be programmed [1].
2. Get familiar with the concept of AST [2].
3. In addition to what has been done in the 3rd lab work do the following:
   1. In case you didn't have a type that denotes the possible types of tokens you need to:
      1. Have a type __*TokenType*__ (like an enum) that can be used in the lexical analysis to categorize the tokens. 
      2. Please use regular expressions to identify the type of the token.
   2. Implement the necessary data structures for an AST that could be used for the text you have processed in the 3rd lab work.
   3. Implement a simple parser program that could extract the syntactic information from the input text.

----

## Implementation:

```swift
import Foundation

enum TokenType: CaseIterable, CustomStringConvertible {
    case openParenthesis, closeParenthesis, mathOperation, numbers, unknowns, start

    var description: String {
        switch self {
        case .openParenthesis: return "openParenthesis"
        case .closeParenthesis: return "closeParenthesis"
        case .mathOperation: return "mathOperation"
        case .numbers: return "numbers"
        case .unknowns: return "unknowns"
        case .start: return "start"
        }
    }
}
```

This Swift script outlines the setup for a basic lexer by defining types of tokens, utilizing regular expressions for matching tokens of each type, and detailing transitions between these types. In Swift, enumerations are used to create symbolic names for sets of related values, which enhances code readability and maintainability. The `TokenType` enumeration class in this script categorizes different kinds of tokens, such as numbers, operations, and unknown variables.

To handle regular expressions, Swift uses its built-in capabilities to match patterns in strings. Regular expressions are a powerful tool for string manipulation, allowing the specification of complex search patterns to identify and extract specified segments of text. In this Swift implementation, regular expressions define how to match various token types, such as numbers, parentheses, and mathematical operations, in the input string. These regular expressions are then used to tokenize the input string into meaningful chunks.

Additionally, the script manages transitions between token types to ensure the logical flow of tokens based on the specified grammar rules. This setup helps in building a lexer that not only tokenizes input based on predefined patterns but also validates the sequence of tokens to prevent syntactic errors.

```swift
class Lexer {
    var equation: String

    init(equation: String) {
        self.equation = equation
    }

    func lexer() -> ([TokenType], [String])? {
        let cleanedEquation = equation.replacingOccurrences(of: " ", with: "")
        var tokens: [String] = []
        var types: [TokenType] = [.start]
        var buffer = ""
        var lastType: TokenType?

        for char in cleanedEquation {
            let symbol = String(char)
            if let type = determineTokenType(for: symbol) {
                if let last = lastType, last == type {
                    buffer += symbol
                } else {
                    if !buffer.isEmpty {
                        tokens.append(buffer)
                        types.append(lastType!)
                    }
                    buffer = symbol
                    lastType = type
                }
            }
        }

        if !buffer.isEmpty {
            tokens.append(buffer)
            types.append(lastType!)
        }

        return (types, tokens)
    }
```

The `token_type` enum class in this Swift script defines five types of tokens: START, MATH_OPERATION, OPEN_PARENTHESIS, CLOSE_PARENTHESIS, and NUMBERS. Each token type is automatically given a unique identifier using the `auto()` function from the Enum module. The transitions between these token types are mapped out in the `transitions` dictionary, which outlines permissible follow-ups for each token type—for example, after an OPEN_PARENTHESIS, the next token can either be NUMBERS or another OPEN_PARENTHESIS.

```swift
let data: [TokenType: [String]] = [
    .openParenthesis: ["\\("],
    .closeParenthesis: ["\\)"],
    .mathOperation: ["[+\\-*/%^]"],
    .numbers: ["\\d+"],  
    .unknowns: ["[a-zA-Z]+"]
]

let transitions: [TokenType: [TokenType]] = [
    .openParenthesis: [.numbers, .unknowns, .openParenthesis],
    .mathOperation: [.numbers, .unknowns, .openParenthesis],
    .closeParenthesis: [.mathOperation, .closeParenthesis],
    .numbers: [.mathOperation, .closeParenthesis],
    .unknowns: [.mathOperation, .closeParenthesis],
    .start: [.openParenthesis, .numbers, .unknowns]
]
```

In addition, a dictionary called `data` holds regular expressions that correspond to each token type. These regular expressions are used to match parts of the input string to identify tokens accurately.

The Lexer class is specifically crafted to tokenize mathematical equations. It begins by removing any spaces from the equation string using the `replace(" ", "")` method. It also initializes a list called `seq_parenthesis` to keep track of open parentheses encountered during tokenization. The tokenization process starts with the initialization of the `category_mapping` with a START token, indicating the beginning of tokenization. The string `failed_on` is used to track symbols that cause tokenization to fail, starting as an empty string. The `valid_tokens` list stores the successfully extracted tokens from the equation.

The method iterates over every symbol in the equation. If a symbol is an open parenthesis, it is added to `seq_parenthesis`. To categorize the symbol, it iterates through the `data` dictionary, which contains regular expressions associated with different token types. If a symbol matches any of the patterns, it is assigned to `current_category`. If no match is found, an error message is generated indicating that the symbol does not belong to any recognized category.

The transitions dictionary in this Swift implementation serves as a critical guide to determine the legality of transitions between different token categories. The lexer checks these transitions as it processes each symbol, and if an invalid transition is detected, it generates an error message indicating that the transition is not permitted.

Once all symbols are processed, the lexer evaluates whether there are any unpaired open parentheses remaining. If any are found, it issues an error stating that not all parentheses have been closed, indicating an imbalance in the equation.

If the tokenization process concludes without issues, the lexer successfully returns both `category_mapping` and `valid_tokens`, which represent the types and values of the tokens extracted from the mathematical expression.

```swift
class Parser {
    var categoryMapping: [TokenType]
    var validTokens: [String]

    init(categoryMapping: [TokenType], validTokens: [String]) {
        self.categoryMapping = categoryMapping
        self.validTokens = validTokens
    }

    func parse() {
        let root = Node(value: categoryMapping[0].description)
        var parent = root
        for (token, category) in zip(validTokens, categoryMapping[1...]) {
            let node = Node(value: token, parent: parent)
            parent = Node(value: category.description, parent: parent)
        }

        // Print tree
        root.printTree()
    }
}
```

The Parser class in Swift is designed to construct a parse tree from the tokenized output provided by the Lexer. The `parse` method begins by creating a root node named after the first token type in `category_mapping`. It then iterates through each token paired with its corresponding category from `valid_tokens` and the rest of `category_mapping`.

For each token, the Parser creates a new node with the token as its value and attaches it to the current parent node. Subsequently, it updates the current parent to a new node representing the token's category. This systematic approach builds a hierarchical parse tree where each node represents either a specific token or a token category.

After the parse tree is assembled, the Parser employs the Render Tree function from the anytree module to visually display the tree structure. This function traverses the tree in a pre-order fashion, printing each node’s name with appropriate indentation to clearly depict the hierarchical relationships between nodes, thereby making the structure of the parsed mathematical expression easily understandable.

## Results:

The two primary outputs of the tokenization process are the `category_mapping` and `valid_tokens` lists. The `category_mapping` list identifies the type of each token encountered during the tokenization of the equation, while the `valid_tokens` list contains the actual tokens extracted from the equation. These elements form the basis for constructing the parse tree.

In the parse tree, the root node represents the START token type, marking the beginning of the tree structure. Each subsequent level in the tree delineates a hierarchy of tokens and their corresponding categories. The indentation in the visualization of the parse tree clearly illustrates the hierarchical relationships between nodes. This indentation helps to show how different categories and tokens are nested within each other, reflecting the structural composition of the original equation.

### Example 1
```bash
Enter your equation: ab+cd*(12+45)^3
start
  ab
  unknowns
    +
    mathOperation
      cd
      unknowns
        *
        mathOperation
          (
          openParenthesis
            12
            numbers
              +
              mathOperation
                45
                numbers
                  )
                  closeParenthesis
                    ^
                    mathOperation
                      3
                      numbers
```

### Example 2

```bash
Enter your equation: 47^2+13^9*(12^2-17/3)
start
  47
  numbers
    ^
    mathOperation
      2
      numbers
        +
        mathOperation
          13
          numbers
            ^
            mathOperation
              9
              numbers
                *
                mathOperation
                  (
                  openParenthesis
                    12
                    numbers
                      ^
                      mathOperation
                        2
                        numbers
                          -
                          mathOperation
                            17
                            numbers
                              /
                              mathOperation
                                3
                                numbers
                                  )
                                  closeParenthesis
```

## Conclusions:

In this laboratory work, I delved deeply into the realms of lexical analysis and syntax parsing by developing a lexer and parser for mathematical expressions. This experience significantly expanded my theoretical knowledge, particularly in understanding how strings are transformed into meaningful tokens and how these tokens are subsequently organized into parse trees to depict their syntactic relationships. Through the practical application of creating regular expressions to identify various tokens such as numbers, operations, and identifiers, and implementing a robust system to validate the logical flow of tokens, I gained a comprehensive insight into the workings of compilers and interpreters. This project not only solidified my understanding of the theoretical aspects but also allowed me to apply these concepts to a concrete problem, enhancing both my learning and engagement with the subject matter.

The development process began with the definition of token types using an enumeration in Swift, which helped categorize different elements of mathematical expressions. From there, I crafted regular expressions that accurately matched each token type from the input strings. The lexer was designed to iterate over the input, using these patterns to extract tokens while ensuring valid transitions between them based on predefined rules. Subsequent to token extraction, the parser was implemented to take these tokens and build a hierarchical structure, the parse tree, which visually represented the tokens according to the grammar rules of mathematical expressions. Throughout this process, I employed rigorous testing and debugging to refine the functionality and ensure the system's reliability and accuracy in processing complex expressions.

This laboratory exercise profoundly enhanced my technical skills, particularly in Swift programming, where I further developed my capabilities with advanced features such as regular expressions and complex data structures like trees. Additionally, it honed my analytical and problem-solving skills, as I learned to dissect complex problems into manageable components and debug them systematically. These skills are invaluable, as they are applicable to a wide range of software development tasks beyond just compiler construction. The project was not only a significant learning opportunity but also a chance to improve my methodological approach to software development, preparing me for future challenges in my academic and professional career.

## References
1. COJUHARI Irina, Duca Ludmila, Fiodorv Ion. "Formal Languages and Finite Automata: Guide for practical lessons". Technical University of Moldova
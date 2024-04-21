# Regular expressions

### Course: Formal Languages & Finite Automata

### Author: Mindrescu Dragomir

## Overview

Regular expressions (regex) are powerful tools used for pattern matching, text manipulation, validation, parsing, and text processing in programming and data analysis. This README provides a brief overview of regex and its key uses.

## Key Uses

- **Pattern Matching:** Find specific text patterns within larger text bodies.
- **Text Manipulation:** Replace or extract parts of strings based on patterns.
- **Validation:** Check if input data matches specified formats (e.g., email addresses, phone numbers).
- **Parsing:** Extract structured data from text (e.g., CSV files, log files).
- **Text Processing:** Tokenization, stemming, and normalization of text data.

## Importance

Regular expressions are essential for tasks such as data cleaning, validation, and text analysis in software development and data processing workflows. Mastery of regex can significantly enhance your ability to work with textual data efficiently and effectively.

# Objectives:

1. Write and cover what regular expressions are, what they are used for;

2. Below you will find 3 complex regular expressions per each variant. Take a variant depending on your number in the list of students and do the following:

    a. Write a code that will generate valid combinations of symbols conform given regular expressions (examples will be shown).

    b. In case you have an example, where symbol may be written undefined number of times, take a limit of 5 times (to evade generation of extremely long combinations);

    c. **Bonus point**: write a function that will show sequence of processing regular expression (like, what you do first, second and so on)

Write a good report covering all performed actions and faced difficulties.

# Variants:

## Variant 4:

![Variant 4](/Lab4/variant_4_task.png)
Examples of what must be generated:

{SUWWY24, SVWY24, ...}
{LMOOOPPPQ2, LNOOOPQ3, ...}
{RSTWXX, RRRSUWYY, ...}


# Implementation

## Version 1: Basic String Generation

In the first version of my implementation, RegexV1.swift, I focused on creating strings based on predefined rules without a specific processing sequence. Here's a breakdown of the key functions and their code snippets:

### First String

``` swift
func randFirstStr() -> String {
    var finalString: String
    let a = ["S", "T"]
    let b = ["U", "V"]
    let c = Int.random(in: 0..<6)
    let d = Int.random(in: 1..<6)
    
    finalString = a.randomElement()! + b.randomElement()! + concatenateSymbols(symbol: "W", count: c) + concatenateSymbols(symbol: "Y", count: d) + "24"
    
    return finalString
}
```

### Second String

``` swift
func randSecondStr() -> String {
    var finalString: String
    let a = ["M", "N"]
    let b = Int.random(in: 0..<6)
    let c = ["2", "3"]
    
    // MARK: -GENERATING SECOND STRING LO
    finalString = "L" + a.randomElement()! + "OOO" + concatenateSymbols(symbol: "P", count: b) + "Q" + c.randomElement()!
    
    return finalString
}
```

### Third String

``` swift
func randThirdStr() -> String {
    var finalString: String
    let a = Int.random(in: 0..<6)
    let b = ["T", "U", "V"]
    let c = ["X", "Y", "Z"]
    
    // MARK: GENERATING THIRD STRING SO
    finalString = concatenateSymbols(symbol: "R", count: a) + "S" + b.randomElement()! + "W" + concatenateSymbols(symbol: Character(c.randomElement()!), count: 2)
    
    return finalString
}
```

### Calling the Functions

``` swift
str1 = randFirstStr()
str2 = randSecondStr()
str3 = randThirdStr()

print("First string: " + str1)
print("Second string: " + str2)
print("Third string: " + str3)
```

### Output examples:

#### Example 1:

``` bash
First string: TVWWWWWYY24
Second string: LNOOOPPPQ2
Third string: RRSUWXX
```

#### Example 2: 

``` bash
First string: SUWWWWWYY24
Second string: LNOOOPPPQ2
Third string: RRRSTWZZ
```

## Version 2: Enhanced String Generation with Processing Sequence

The second version, RegexV2.swift, enhances the string generation process by adding a sequence of processing steps for each string. The auxiliar functions are situated in AuxiliarFunctions.swift. Here are the modified functions and their code snippets:

### First String

``` swift
func randFirstStr() {
    var finalString: String
    let a = ["S", "T"]
    let b = ["U", "V"]
    let c = Int.random(in: 0..<6)
    let d = Int.random(in: 1..<6)
    
    finalString = a.randomElement()!
    print(randomSymbol(choices: a), terminator: "-> ")
    print(finalString)
    finalString += b.randomElement()!
    print(randomSymbol(choices: b), terminator: "-> ")
    print(finalString)
    finalString += concatenateSymbols(symbol: "W", count: c)
    print(random_Concatenation_V1(symbol: "W", count: c), terminator: "-> ")
    print(finalString)
    finalString += concatenateSymbols(symbol: "Y", count: d)
    print(random_Concatenation_V2(symbol: "Y", count: d), terminator: "-> ")
    print(finalString)
    finalString += "24"
    print(regularSimpleConcatenation(string: "24"), terminator: "-> ")
    print(finalString)
    breakLine()
    finalResult(result: finalString)
    print()
}
```

### Second String

``` swift
func randSecondStr() {
    var finalString: String
    let a = ["M", "N"]
    let b = Int.random(in: 0..<6)
    let c = ["2", "3"]
    
    finalString = "L"
    print(regularSimpleConcatenation(string: "L"), terminator: "-> ")
    print(finalString)
    finalString += a.randomElement()!
    print(randomSymbol(choices: a), terminator: "-> ")
    print(finalString)
    finalString += concatenateSymbols(symbol: "O", count: 3)
    print(regularMultipleConcatenation(string: "O", count: 3), terminator: "-> ")
    print(finalString)
    finalString += concatenateSymbols(symbol: "P", count: b)
    print(random_Concatenation_V1(symbol: "P", count: b), terminator: "-> ")
    print(finalString)
    finalString += "Q"
    print(regularSimpleConcatenation(string: "Q"), terminator: "-> ")
    print(finalString)
    finalString += c.randomElement()!
    print(randomSymbol(choices: c), terminator: "-> ")
    print(finalString)
    breakLine()
    finalResult(result: finalString)
    print()
    
}
```

### Third String

``` swift
func randThirdStr() {
    var finalString: String
    let a = Int.random(in: 0..<6)
    let b = ["T", "U", "V"]
    let c = ["X", "Y", "Z"]
    
    finalString = concatenateSymbols(symbol: "R", count: a)
    print(random_Concatenation_V1(symbol: "R", count: a), terminator: "-> ")
    print(finalString)
    finalString += "S"
    print(regularSimpleConcatenation(string: "S"), terminator: "-> ")
    print(finalString)
    finalString += b.randomElement()!
    print(randomSymbol(choices: b), terminator: "-> ")
    print(finalString)
    finalString += "W"
    print(regularSimpleConcatenation(string: "W"), terminator: "-> ")
    print(finalString)
    finalString += concatenateSymbols(symbol: Character(c.randomElement()!), count: 2)
    print(regularMultipleConcatenation(string: String(c.randomElement()!), count: 2), terminator: "-> ")
    print(finalString)
    breakLine()
    finalResult(result: finalString)
    print()
}
```

### Calling the Functions

``` swift
randFirstStr()
randSecondStr()
randThirdStr()
```

### Output examples:

#### Example 1:

``` bash
Concatenating one random symbol from the following choices ["S", "T"]: -> T
Concatenating one random symbol from the following choices ["U", "V"]: -> TU
Concatenating "W" 3 times: -> TUWWW
Concatenating "Y" 1 times: -> TUWWWY
Concatenating "24": -> TUWWWY24
------------------------------------------
Final Result: TUWWWY24

Concatenating "L": -> L
Concatenating one random symbol from the following choices ["M", "N"]: -> LM
Concatenating "O" 3 times: -> LMOOO
Concatenating "P" 2 times: -> LMOOOPP
Concatenating "Q": -> LMOOOPPQ
Concatenating one random symbol from the following choices ["2", "3"]: -> LMOOOPPQ2
------------------------------------------
Final Result: LMOOOPPQ2

Concatenating "R" 0 times: -> 
Concatenating "S": -> S
Concatenating one random symbol from the following choices ["T", "U", "V"]: -> SU
Concatenating "W": -> SUW
Concatenating "Y" 2 times: -> SUWXX
------------------------------------------
Final Result: SUWXX
```

#### Example 2: 

``` bash
Concatenating one random symbol from the following choices ["S", "T"]: -> S
Concatenating one random symbol from the following choices ["U", "V"]: -> SV
Concatenating "W" 2 times: -> SVWW
Concatenating "Y" 3 times: -> SVWWYYY
Concatenating "24": -> SVWWYYY24
------------------------------------------
Final Result: SVWWYYY24

Concatenating "L": -> L
Concatenating one random symbol from the following choices ["M", "N"]: -> LM
Concatenating "O" 3 times: -> LMOOO
Concatenating "P" 0 times: -> LMOOO
Concatenating "Q": -> LMOOOQ
Concatenating one random symbol from the following choices ["2", "3"]: -> LMOOOQ3
------------------------------------------
Final Result: LMOOOQ3

Concatenating "R" 4 times: -> RRRR
Concatenating "S": -> RRRRS
Concatenating one random symbol from the following choices ["T", "U", "V"]: -> RRRRSV
Concatenating "W": -> RRRRSVW
Concatenating "X" 2 times: -> RRRRSVWZZ
------------------------------------------
Final Result: RRRRSVWZZ
```

## Conclusion

This report presented two versions of string generation implementations in Swift: a basic version without a specific processing sequence and an enhanced version with a structured processing sequence. The basic version offered simplicity in generating strings based on predefined rules, while the enhanced version provided a more systematic approach with clear processing steps. Both versions highlight Swift's versatility in handling string generation tasks, allowing developers to choose the appropriate approach based on their needs and requirements.


## References
1. COJUHARI Irina, Duca Ludmila, Fiodorv Ion. "Formal Languages and Finite Automata: Guide for practical lessons". Technical University of Moldova
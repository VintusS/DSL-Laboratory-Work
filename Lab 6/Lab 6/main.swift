//
//  main.swift
//  Lab 6
//
//  Created by Dragomir Mindrescu on 01.05.2024.
//

import Foundation

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

// Test Parser
if let testEquation = readLine() {
    let lexer = Lexer(equation: testEquation)
    if let (categoryMapping, validTokens) = lexer.lexer() {
        let parser = Parser(categoryMapping: categoryMapping, validTokens: validTokens)
        parser.parse()
    }
}

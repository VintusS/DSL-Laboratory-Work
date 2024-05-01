//
//  main.swift
//  Lab 6
//
//  Created by Dragomir Mindrescu on 01.05.2024.
//

import Foundation

let transitions: [TokenType: [TokenType]] = [
    .openParenthesis: [.numbers, .openParenthesis],
    .mathOperation: [.numbers, .openParenthesis],
    .closeParenthesis: [.mathOperation, .closeParenthesis],
    .numbers: [.numbers, .closeParenthesis, .mathOperation],
    .start: [.openParenthesis, .numbers]
]

let data: [TokenType: [String]] = [
    .openParenthesis: ["\\(", "\\["],
    .closeParenthesis: ["\\)", "\\]"],
    .mathOperation: ["[+\\-*/%^]"],
    .numbers: ["\\d+"]
]

// Test Parser
if let testEquation = readLine() {
    let lexer = Lexer(equation: testEquation)
    if let (categoryMapping, validTokens) = lexer.lexer() {
        let parser = Parser(categoryMapping: categoryMapping, validTokens: validTokens)
        parser.parse()
    }
}

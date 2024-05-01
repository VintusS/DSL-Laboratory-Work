//
//  main.swift
//  Lab 6
//
//  Created by Dragomir Mindrescu on 01.05.2024.
//

import Foundation

class Node {
    var value: String
    var children: [Node] = []
    weak var parent: Node?

    init(value: String, parent: Node? = nil) {
        self.value = value
        self.parent = parent
        parent?.children.append(self)
    }

    func printTree(level: Int = 0) {
        print(String(repeating: " ", count: level * 2) + value)
        children.forEach { $0.printTree(level: level + 1) }
    }
}


enum TokenType: CaseIterable, CustomStringConvertible {
    case openParenthesis, closeParenthesis, mathOperation, numbers, start

    var description: String {
        switch self {
        case .openParenthesis: return "openParenthesis"
        case .closeParenthesis: return "closeParenthesis"
        case .mathOperation: return "mathOperation"
        case .numbers: return "numbers"
        case .start: return "start"
        }
    }
}


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


let testEquation = "2*(3+4)"
let lexer = Lexer(equation: testEquation)
if let (categoryMapping, validTokens) = lexer.lexer() {
    let parser = Parser(categoryMapping: categoryMapping, validTokens: validTokens)
    parser.parse()
}

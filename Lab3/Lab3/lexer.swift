//
//  main.swift
//  CommandLineTemplate
//
//  Created by Dragomir Mindrescu on 18.03.2024.
//

import Foundation

enum TokenType {
    case identifier
    case number
    case operatorSymbol
    case whitespace
}

struct Token {
    let type: TokenType
    let value: String
}

class Lexer {
    private let input: String
    private var index: String.Index

    init(input: String) {
        self.input = input
        self.index = input.startIndex
    }

    private func peek() -> Character? {
        guard index < input.endIndex else { return nil }
        return input[index]
    }

    private func advance() {
        index = input.index(after: index)
    }

    func tokenize() -> [Token] {
        var tokens = [Token]()

        while let currentChar = peek() {
            switch currentChar {
            case _ where currentChar.isWhitespace:
                tokens.append(Token(type: .whitespace, value: String(currentChar)))
                advance()
            case _ where currentChar.isNumber:
                let number = extractNumber()
                tokens.append(Token(type: .number, value: number))
            case _ where currentChar.isLetter:
                let identifier = extractIdentifier()
                tokens.append(Token(type: .identifier, value: identifier))
            case "+", "-", "*", "/", "=":
                tokens.append(Token(type: .operatorSymbol, value: String(currentChar)))
                advance()
            default:
                advance() 
            }
        }

        return tokens
    }

    private func extractNumber() -> String {
        var number = ""
        while let currentChar = peek(), currentChar.isNumber {
            number += String(currentChar)
            advance()
        }
        return number
    }

    private func extractIdentifier() -> String {
        var identifier = ""
        while let currentChar = peek(), currentChar.isLetter || currentChar == "_" {
            identifier += String(currentChar)
            advance()
        }
        return identifier
    }
}



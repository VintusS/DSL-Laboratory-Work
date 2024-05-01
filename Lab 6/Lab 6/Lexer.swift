//
//  Lexer.swift
//  Lab 6
//
//  Created by Dragomir Mindrescu on 01.05.2024.
//

import Foundation

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

    private func determineTokenType(for symbol: String) -> TokenType? {
        return TokenType.allCases.first { type in
            data[type]?.contains(where: { NSPredicate(format: "SELF MATCHES %@", $0).evaluate(with: symbol) }) == true
        }
    }
}

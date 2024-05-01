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
        equation = equation.replacingOccurrences(of: " ", with: "")
        var seqParenthesis: [String] = []
        var categoryMapping: [TokenType] = [.start]
        var failedOn = ""
        var validTokens: [String] = []

        var buffer = ""
        var lastCategory: TokenType?

        for char in equation + " " { 
            let symbol = String(char)

            let currentCategory = data.first { (_, patterns) in
                patterns.contains { NSPredicate(format:"SELF MATCHES %@", $0).evaluate(with: symbol) }
            }?.key

            if let lastCategory = lastCategory, currentCategory == lastCategory {
                buffer += symbol
            } else {
                if !buffer.isEmpty {

                    validTokens.append(buffer)
                    categoryMapping.append(lastCategory!)
                    buffer = ""
                }

                if currentCategory != nil {
                    buffer = symbol
                    lastCategory = currentCategory
                }
            }
        }

        for i in 1..<categoryMapping.count {
            if !(transitions[categoryMapping[i - 1]]?.contains(categoryMapping[i]) ?? false) {
                print("ERROR: Transition not allowed from '\(categoryMapping[i - 1])' to '\(categoryMapping[i])'.")
                print("Failed on symbol \(validTokens[i - 1])")
                return nil
            }
        }

        if !seqParenthesis.isEmpty {
            print("ERROR: Not all parentheses were closed.")
            print("Failed on symbol \(failedOn)")
            return nil
        }

        return (categoryMapping, validTokens)
    }
}

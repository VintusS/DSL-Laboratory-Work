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

        for char in equation {
            let symbol = String(char)
            if data[.openParenthesis]?.contains(where: { NSPredicate(format:"SELF MATCHES %@", $0).evaluate(with: symbol) }) == true {
                seqParenthesis.append(symbol)
            } else if data[.closeParenthesis]?.contains(where: { NSPredicate(format:"SELF MATCHES %@", $0).evaluate(with: symbol) }) == true {
                guard !seqParenthesis.isEmpty else {
                    print("ERROR: Extra closing parenthesis found.")
                    print("Failed on symbol \(failedOn)")
                    return nil
                }

                let lastOpen = seqParenthesis.removeLast()
                if (symbol == ")" && lastOpen != "(") || (symbol == "]" && lastOpen != "[") {
                    print("ERROR: Mismatched closing parenthesis found.")
                    print("Failed on symbol \(failedOn)")
                    return nil
                }
            }

            var foundCategory: TokenType?
            for (category, patterns) in data {
                if patterns.contains(where: { NSPredicate(format:"SELF MATCHES %@", $0).evaluate(with: symbol) }) {
                    foundCategory = category
                    break
                }
            }
            
            guard let currentCategory = foundCategory else {
                print("ERROR: Symbol '\(symbol)' does not belong to any known category.")
                print("Failed on symbol \(failedOn)")
                return nil
            }

            if !(transitions[categoryMapping.last!]?.contains(currentCategory) ?? false) {
                print("ERROR: Transition not allowed from '\(categoryMapping.last!)' to '\(currentCategory)'.")
                print("Failed on symbol \(failedOn)")
                return nil
            }

            categoryMapping.append(currentCategory)
            validTokens.append(symbol)
            failedOn += symbol
        }

        if !seqParenthesis.isEmpty {
            print("ERROR: Not all parentheses were closed.")
            print("Failed on symbol \(failedOn)")
            return nil
        }
        
        return (categoryMapping, validTokens)
    }
}

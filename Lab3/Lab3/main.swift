//
//  main0.swift
//  Lab3
//
//  Created by Dragomir Mindrescu on 18.03.2024.
//

import Foundation

print("Enter your code line:", terminator: " ")
if let code = readLine() {
    let lexer = Lexer(input: code)
    let tokens = lexer.tokenize()
    
    for token in tokens {
        print("\(token.type): '\(token.value)'")
    }
}

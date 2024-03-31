//
//  StringGenerationsV3.swift
//  Lab4
//
//  Created by Dragomir Mindrescu on 01.04.2024.
//

import Foundation

// This version of implementation will take as an input a regular expression and will process it

func StringGenerationsV3() {
    print("Enter the Regular Expression: ")
    if let input = readLine() {
        // MARK: -SEPARATING THE REGULAR EXPRESSION
        var separatedOrSymbols: [String]
        
        
        var startingIndexOr = 0
        var endingIndexOr = 0
        for index in 0..<input.count {
            let i = input.index(input.startIndex, offsetBy: index)
            if input[i] == "(" {
                startingIndexOr = index
            }
            if input[i] == ")" {
                endingIndexOr = index
            }
        }
        
    }
}

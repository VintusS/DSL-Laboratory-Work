//
//  StringGenerationsV2.swift
//  Lab4
//
//  Created by Dragomir Mindrescu on 31.03.2024.
//

import Foundation

// This version of implementation is for the BONUS POINT (added the sequence of processing)
func StringGenerationsV2() {
    
    func randFirstStr() {
        var finalString: String
        let a = ["S", "T"]
        let b = ["U", "V"]
        let c = Int.random(in: 0..<6)
        let d = Int.random(in: 1..<6)
        
        // MARK: -GENERATING FIRST STRING YO
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
    
    func randSecondStr() {
        var finalString: String
        let a = ["M", "N"]
        let b = Int.random(in: 0..<6)
        let c = ["2", "3"]
        
        // MARK: -GENERATING SECOND STRING LO
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
    
    func randThirdStr() {
        var finalString: String
        let a = Int.random(in: 0..<6)
        let b = ["T", "U", "V"]
        let c = ["X", "Y", "Z"]
        
        // MARK: GENERATING THIRD STRING SO
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
    
    randFirstStr()
    randSecondStr()
    randThirdStr()
}

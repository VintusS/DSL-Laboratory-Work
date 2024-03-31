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
        finalString = a.randomElement()! + b.randomElement()! + concatenateSymbols(symbol: "W", count: c) + concatenateSymbols(symbol: "Y", count: d) + "24"
        print(RandomSymbol(choices: a))
    }
    
    func randSecondStr() {
        var finalString: String
        let a = ["M", "N"]
        let b = Int.random(in: 0..<6)
        let c = ["2", "3"]
        
        // MARK: -GENERATING SECOND STRING LO
        finalString = "L" + a.randomElement()! + "OOO" + concatenateSymbols(symbol: "P", count: b) + "Q" + c.randomElement()!
        
    }
    
    func randThirdStr() {
        var finalString: String
        let a = Int.random(in: 0..<6)
        let b = ["T", "U", "V"]
        let c = ["X", "Y", "Z"]
        
        // MARK: GENERATING THIRD STRING SO
        finalString = concatenateSymbols(symbol: "R", count: a) + "S" + b.randomElement()! + "W" + concatenateSymbols(symbol: Character(c.randomElement()!), count: 2)
        
    }
    
    randFirstStr()
}

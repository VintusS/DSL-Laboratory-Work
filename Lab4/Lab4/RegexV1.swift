//
//  StringGenerations.swift
//  Lab4
//
//  Created by Dragomir Mindrescu on 31.03.2024.
//

import Foundation

// This version of implementation is the basic one without any sequence of processing the regular expression
func StringGenerationsV1() {
    // MARK: -VARIABLES
    var str1 = String()
    var str2 = String()
    var str3 = String()
    
    func randFirstStr() -> String {
        var finalString: String
        let a = ["S", "T"]
        let b = ["U", "V"]
        let c = Int.random(in: 0..<6)
        let d = Int.random(in: 1..<6)
        
        // MARK: -GENERATING FIRST STRING YO
        finalString = a.randomElement()! + b.randomElement()! + concatenateSymbols(symbol: "W", count: c) + concatenateSymbols(symbol: "Y", count: d) + "24"
        
        return finalString
    }
    
    func randSecondStr() -> String {
        var finalString: String
        let a = ["M", "N"]
        let b = Int.random(in: 0..<6)
        let c = ["2", "3"]
        
        // MARK: -GENERATING SECOND STRING LO
        finalString = "L" + a.randomElement()! + "OOO" + concatenateSymbols(symbol: "P", count: b) + "Q" + c.randomElement()!
        
        return finalString
    }
    
    func randThirdStr() -> String {
        var finalString: String
        let a = Int.random(in: 0..<6)
        let b = ["T", "U", "V"]
        let c = ["X", "Y", "Z"]
        
        // MARK: GENERATING THIRD STRING SO
        finalString = concatenateSymbols(symbol: "R", count: a) + "S" + b.randomElement()! + "W" + concatenateSymbols(symbol: Character(c.randomElement()!), count: 2)
        
        return finalString
    }
    
    // MARK: -LINKING THE STRINGS WITH FUNCTIONS AND PRINTING THEM
    str1 = randFirstStr()
    str2 = randSecondStr()
    str3 = randThirdStr()
    
    print("First string: " + str1)
    print("Second string: " + str2)
    print("Third string: " + str3)
}

// print(Int.random(in: 1..<100))

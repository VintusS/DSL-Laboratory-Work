//
//  AuxiliarFunctions.swift
//  Lab4
//
//  Created by Dragomir Mindrescu on 31.03.2024.
//

import Foundation

// MARK: -CONCATENATING A NUMBER OF SYMBOLS IN A STRING
func concatenateSymbols(symbol: Character, count: Int) -> String {
    var result = ""
    for _ in 0..<count {
        result.append(symbol)
    }
    return result
}

// MARK: -PRINTING FUNCTIONS FOR STR_GEN_V2

// MARK: -RANDOM SYMBOL
func randomSymbol(choices: [String]) -> String {
    var response = "Concatenating one random symbol from the following choices ["
    for choice in choices {
        response += "\"" + choice + "\", "
    }
    response = String(response.dropLast(2))
    response += "]: "
    
    return response
}

// MARK: -REGULAR SIMPLE CONCATENATION
func regularSimpleConcatenation(string: String) -> String {
    let response = "Concatenating \"\(string)\": "
    return response
}

// MARK: -REGULAR MULTIPLE CONCATENATION
func regularMultipleConcatenation(string: String, count: Int) -> String {
    let response = "Concatenating \"\(string)\" \(count) times: "
    return response
}

// MARK: -(^*) CONCATENATING
func random_Concatenation_V1(symbol: Character, count: Int) -> String {
    let response = "Concatenating \"\(symbol)\" \(count) times: "
    return response
}

// MARK: -(^+) CONCATENATING
func random_Concatenation_V2(symbol: Character, count: Int) -> String {
    let response = "Concatenating \"\(symbol)\" \(count) times: "
    return response
}

// MARK: -OUTPUT BREAKLINE
func breakLine() {
    print("------------------------------------------")
}

// MARK: -FINAL RESULT OUTPUT
func finalResult(result: String) {
    print("Final Result: \(result)")
}

//
//  StringGenerationsV3.swift
//  Lab4
//
//  Created by Dragomir Mindrescu on 01.04.2024.
//

import Foundation

// This version of implementation will take as an input a regular expression and will process it

func processRegex(_ regex: String) -> [String] {
    var result: [String] = []
    
    // Regular expression to match the patterns
    let pattern = "\\(([^)]+)\\)(\\^\\*|\\^\\+|\\^\\d+|\\?)?"
    
    do {
        let regex = try NSRegularExpression(pattern: pattern, options: [])
        let matches = regex.matches(in: regex, options: [], range: NSRange(location: 0, length: regex.utf16.count))
        
        for match in matches {
            // Extracting the substring and repetition symbol
            if let range = Range(match.range(at: 1), in: regex),
               let substring = String(regex[range]),
               let repeatSymbolRange = Range(match.range(at: 2), in: regex),
               let repeatSymbol = String(regex[repeatSymbolRange]) {
                
                // Process the substring based on the repetition symbol
                var processedSubstring: [String] = []
                switch repeatSymbol {
                case "^*":
                    processedSubstring.append("")
                case "^+":
                    processedSubstring.append(substring)
                case "^":
                    if let n = Int(substring) {
                        for _ in 0..<n {
                            processedSubstring.append(substring)
                        }
                    }
                case "?":
                    processedSubstring.append(substring)
                    processedSubstring.append("")
                default:
                    break
                }
                
                // Add processed substrings to result
                result.append(contentsOf: processedSubstring)
            }
        }
    } catch {
        print("Error processing regex: \(error)")
    }
    
    return result
}

func RegexV3() {
    // Example usage
    let inputRegex = "(S|T)^*N?^+"
    let output = processRegex(inputRegex)
    print(output)
}

//
//  StringGenerationsV3.swift
//  Lab4
//
//  Created by Dragomir Mindrescu on 01.04.2024.
//

import Foundation

// This version of implementation will take as an input a regular expression and will process it
func RegexV3() {
    print("Enter the regular expression for processing: ")
    if let input = readLine() {

        func processString(_ input: String) -> String {
            var processedString = input
            var comments = [String]()

            func processParentheses(_ string: String) -> String {
                var result = string
                let regex = try! NSRegularExpression(pattern: "\\(([^()]+)\\)")
                let matches = regex.matches(in: string, range: NSRange(string.startIndex..., in: string))

                for match in matches.reversed() {
                    guard let range = Range(match.range, in: string) else { continue }
                    let matchedText = String(string[range])
                    let options = matchedText.dropFirst().dropLast().split(separator: "|").map(String.init)
                    if let selectedOption = options.randomElement() {
                        result.replaceSubrange(range, with: selectedOption)
                        comments.append("Chose '\(selectedOption)' from '\(matchedText)'")
                    }
                }
                return result
            }

            func processRepetitionsAndOptionals(_ string: String) -> String {
                var result = string

                let patterns: [(regex: NSRegularExpression, min: Int, max: Int?)] = [
                    (try! NSRegularExpression(pattern: "(.)(\\^\\*)"), 0, 5),
                    (try! NSRegularExpression(pattern: "(.)(\\^\\+)"), 1, 5),
                    (try! NSRegularExpression(pattern: "(.)(\\^[0-9]+)"), 0, nil),
                    (try! NSRegularExpression(pattern: "(.)(\\?)"), 0, 1)
                ]

                var didReplace: Bool
                repeat {
                    didReplace = false
                    for pattern in patterns {
                        let matches = pattern.regex.matches(in: result, range: NSRange(result.startIndex..., in: result))
                        
                        for match in matches.reversed() {
                            guard let range = Range(match.range, in: result),
                                  let firstRange = Range(match.range(at: 1), in: result) else { continue }
                            
                            let matchedText = String(result[firstRange])
                            let fullMatchText = String(result[range])
                            var repetitions = pattern.min

                            if let max = pattern.max {
                                repetitions = Int.random(in: repetitions...max)
                            } else if fullMatchText.last!.isNumber {
                                repetitions = Int(fullMatchText.dropFirst(2)) ?? 0
                            } else if fullMatchText.contains("?") {
                                repetitions = Bool.random() ? 1 : 0
                                comments.append("Optional '\(matchedText)' was \(repetitions == 1 ? "included" : "excluded")")
                            }

                            let replacement = String(repeating: matchedText, count: repetitions)
                            result.replaceSubrange(range, with: replacement)
                            didReplace = true
                            if fullMatchText.contains("^") {
                                comments.append("Repeated '\(matchedText)' \(repetitions) time(s)")
                            }
                        }
                    }
                } while didReplace

                return result
            }

            processedString = processParentheses(processedString)
            processedString = processRepetitionsAndOptionals(processedString)

            return  "Comments: \n" + comments.joined(separator: "\n ") + "\n Final String: " + processedString
        }

        let output = processString(input)
        print(output)


    }
}

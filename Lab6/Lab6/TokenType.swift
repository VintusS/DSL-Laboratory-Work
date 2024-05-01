//
//  TokenType.swift
//  Lab 6
//
//  Created by Dragomir Mindrescu on 01.05.2024.
//

import Foundation

enum TokenType: CaseIterable, CustomStringConvertible {
    case openParenthesis, closeParenthesis, mathOperation, numbers, unknowns, start

    var description: String {
        switch self {
        case .openParenthesis: return "openParenthesis"
        case .closeParenthesis: return "closeParenthesis"
        case .mathOperation: return "mathOperation"
        case .numbers: return "numbers"
        case .unknowns: return "unknowns"
        case .start: return "start"
        }
    }
}

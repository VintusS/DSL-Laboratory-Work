//
//  main.swift
//  Lab 5
//
//  Created by Dragomir Mindrescu on 22.04.2024.
//

import Foundation

//Initial grammar
let grammar = Grammar()
let productions = grammar.returnProductions()

//Productions after processing of the unit tests
print("Productions after processing:")
for (index, production) in productions.enumerated() {
    print("Step \(index + 1):")
    print(production)
}

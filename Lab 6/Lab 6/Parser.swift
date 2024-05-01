//
//  Parser.swift
//  Lab 6
//
//  Created by Dragomir Mindrescu on 01.05.2024.
//

import Foundation

class Parser {
    var categoryMapping: [TokenType]
    var validTokens: [String]

    init(categoryMapping: [TokenType], validTokens: [String]) {
        self.categoryMapping = categoryMapping
        self.validTokens = validTokens
    }

    func parse() {
        let root = Node(value: categoryMapping[0].description)
        var parent = root
        for (token, category) in zip(validTokens, categoryMapping[1...]) {
            let node = Node(value: token, parent: parent)
            parent = Node(value: category.description, parent: parent)
        }

        // Print tree
        root.printTree()
    }
}

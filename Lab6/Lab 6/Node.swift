//
//  Node.swift
//  Lab 6
//
//  Created by Dragomir Mindrescu on 01.05.2024.
//

import Foundation

class Node {
    var value: String
    var children: [Node] = []
    weak var parent: Node?

    init(value: String, parent: Node? = nil) {
        self.value = value
        self.parent = parent
        parent?.children.append(self)
    }

    func printTree(level: Int = 0) {
        print(String(repeating: " ", count: level * 2) + value)
        children.forEach { $0.printTree(level: level + 1) }
    }
}

//
//  Grammar.swift
//  Lab 5
//
//  Created by Dragomir Mindrescu on 22.04.2024.
//  Variant 20

import Foundation

class Grammar {
    var P: [String: [String]]
    var V_N: [String]
    var V_T: [String]

    init() {
        self.P = [
            "S": ["aB", "bA", "A"],
            "A": ["B", "Sa", "bBA", "b"],
            "B": ["b", "bS", "aD", "eps"],
            "D": ["AA"],
            "C": ["Ba"]
        ]
        self.V_N = ["S", "A", "B", "C", "D"]
        self.V_T = ["a", "b"]
    }

    func removeEpsilon() -> [String: [String]] {
        var nt_epsilon: [String] = []
        for (key, value) in P {
            if value.contains("eps") {
                nt_epsilon.append(key)
            }
        }

        var P1 = P
        for key in nt_epsilon {
            if let productions = P1[key] {
                for production in productions {
                    if production == "eps", productions.count > 1 {
                        P1[key] = productions.filter { $0 != "eps" }
                    }
                }
            }
        }

        print("1. After removing epsilon productions:\n\(P1)")
        return P1
    }

    func eliminateUnitProductions() -> [String: [String]] {
        var P2 = P
        for (key, values) in P {
            for value in values where V_N.contains(value) {
                if let newProductions = P[value] {
                    P2[key]?.removeAll(where: { $0 == value })
                    P2[key]?.append(contentsOf: newProductions)
                }
            }
        }

        print("2. After removing unit productions:\n\(P2)")
        return P2
    }

    func eliminateInaccessibleSymbols() -> [String: [String]] {
        var P3 = P
        let accessibleSymbols = Set(V_N)
        for (key, _) in P3 {
            if !accessibleSymbols.contains(key) {
                P3.removeValue(forKey: key)
            }
        }

        print("3. After removing inaccessible symbols:\n\(P3)")
        return P3
    }

    func removeNonproductive() -> [String: [String]] {
        var P4 = P
        for (key, values) in P4 {
            if values.allSatisfy({ $0.count == 1 && V_T.contains($0) }) {
                P4.removeValue(forKey: key)
            }
        }

        print("4. After removing non-productive symbols:\n\(P4)")
        return P4
    }

    func chomskyNormalForm() -> [String: [String]] {
        var P5 = P
        // Implementation of converting to Chomsky Normal Form should go here

        print("5. Final CNF:\n\(P5)")
        return P5
    }

    func returnProductions() -> ([String: [String]], [String: [String]], [String: [String]], [String: [String]], [String: [String]]) {
        print("Initial Grammar:\n\(P)")
        let P1 = removeEpsilon()
        let P2 = eliminateUnitProductions()
        let P3 = eliminateInaccessibleSymbols()
        let P4 = removeNonproductive()
        let P5 = chomskyNormalForm()
        return (P1, P2, P3, P4, P5)
    }
}

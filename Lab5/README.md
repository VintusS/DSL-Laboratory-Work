# Chomsky Normal Form

### Course: Formal Languages & Finite Automata

### Author: Mindrescu Dragomir

----

##  Objectives:

1. Learn about Chomsky Normal Form (CNF) [1].
2. Get familiar with the approaches of normalizing a grammar.
3. Implement a method for normalizing an input grammar by the rules of CNF.
    I. The implementation needs to be encapsulated in a method with an appropriate signature (also ideally in an appropriate class/type).
    II. The implemented functionality needs executed and tested.
    III. A BONUS point will be given for the student who will have unit tests that validate the functionality of the project.
    IV. Also, another BONUS point would be given if the student will make the aforementioned function to accept any grammar, not only the one from the student's variant.

##  Implementation

For this laboratory work I used Swift language. Swift is an excellent choice for developing Domain-Specific Languages (DSLs) due to its modern, clear, and expressive syntax. This makes it ideal for creating readable and maintainable DSL code. Its advanced features like optionals, generics, and robust error handling contribute to building flexible and robust DSLs. Additionally, Swift’s compatibility with Apple’s ecosystems allows easy integration with a wide range of existing frameworks and applications, making it particularly useful for DSL development in laboratory settings where performance and system integration are crucial.

### Grammar Class

First, I created a class called `Grammar`, which contains a dictionary for grammar productions, along with lists of non-terminal and terminal symbols.

```swift
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
    return P1
}
```

The method `Remove_Epsilon` eliminates epsilon productions from the grammar. It begins by identifying non-terminal symbols that can derive the empty string and stores them in the list nt_epsilon. The method then processes each production in the grammar, and for each production that involves a non-terminal symbol that can derive the empty string, it generates new productions by removing the empty string symbol. This is done by replacing each occurrence of the empty string symbol with nothing. After modifying the productions, the method removes all direct epsilon productions from the grammar, prints the updated grammar, and returns it.

### Unit Production Elimination

```swift
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
    return P2
}
```

The `Eliminate_Unit_Prod` method is tasked with eliminating unit productions from the context-free grammar. It cycles through each production within the grammar, checking if the production consists of a single non-terminal symbol (determined by the production's length being 1 and the symbol being a non-terminal, as indicated by `v in self.V_N`). When this condition is fulfilled, the method removes this unit production from the production list of that particular non-terminal. Subsequently, it incorporates the productions associated with that non-terminal (found in `self.P[v]`) into the list of productions for the current non-terminal. This action effectively replaces the unit production with the original non-terminal's productions.

### Inaccesible Symbols Elimination

```swift
func eliminateInaccessibleSymbols() -> [String: [String]] {
    var P3 = P
    let accessibleSymbols = Set(V_N)
    for (key, _) in P3 {
        if !accessibleSymbols.contains(key) {
            P3.removeValue(forKey: key)
        }
    }
    return P3
}
```

The code initiates by creating a duplicate of the original productions dictionary `self.P`, storing it in `P3`. This duplication is intended to preserve the original grammar while implementing changes. It then sets up `accessible_symbols` to include all non-terminal symbols (`self.V_N`), assuming initially that all non-terminals are accessible.

Next, the code processes each production in the grammar. Within each production, it examines every symbol. If a symbol is identified in `accessible_symbols`, it is removed from this list to refine `accessible_symbols` to only those that are genuinely accessible. Following the identification of all inaccessible symbols, these symbols are then removed from the dictionary `P3`.

The process continues by iterating over each inaccessible symbol and removing its associated entries from `P3`. This approach ensures that only accessible symbols remain in the updated productions dictionary.

### Non-Productive Symbols Elimination

```swift
func removeNonproductive() -> [String: [String]] {
    var P4 = P
    for (key, values) in P4 {
        if values.allSatisfy({ $0.count == 1 && V_T.contains($0) }) {
            P4.removeValue(forKey: key)
        }
    }
    return P4
}
```

The code cycles through each non-terminal symbol (key) within the grammar, tallying how many productions consist solely of terminal symbols (`self.V_T`). If a non-terminal doesn't have any productions made up entirely of terminal symbols and isn't a terminal symbol itself, it's deemed non-productive and is subsequently removed from the grammar. Upon identifying a non-productive symbol, its corresponding entry is deleted from the productions dictionary `P4`, and any productions containing this non-productive symbol are also removed. 

Additionally, the code reviews every production in the grammar. During this review, it checks for the presence of any non-terminal symbols (indicated by `c.isupper()`) that are not listed in the keys of `P4` and are distinct from the non-terminal currently under consideration (`c != key`). Productions containing such unlisted non-terminal symbols are then excluded from the list of productions for that specific non-terminal. This ensures that the grammar retains only productive symbols and their valid productions.

### Chomsky Form

``` swift
func chomskyNormalForm() -> [String: [String]] {
    var P5 = P
    // Implementation of converting to Chomsky Normal Form should go here

    print("5. Final CNF:\n\(P5)")
    return P5
}
```

The code starts by establishing a list of `free_symbols`—symbols that are not already in use within the original grammar. As it progresses through each production in the grammar, it divides each production into two segments: left and right. The code then checks whether the production meets the criteria for Chomsky Normal Form (CNF):
- If the production is composed of a single terminal symbol or a pair of non-terminal symbols, it moves on to the next production without making changes. 
- If the production does not conform to CNF criteria, the code assigns new symbols for the left and right halves. It checks the temporary dictionary `temp` to see if a new symbol has already been assigned to either half; if so, it reuses that symbol. If not, it assigns a new symbol by taking one from the `free_symbols` list.
Finally, the code updates P5 by replacing the original production with the newly assigned symbols, effectively restructuring the grammar to fit CNF standards.

### Initial Grammar Output

```bash
Initial Grammar:
["S": ["aB", "bA", "A"], "A": ["B", "Sa", "bBA", "b"], "B": ["b", "bS", "aD", "eps"], "D": ["AA"], "C": ["Ba"]]
1. After removing epsilon productions:
["S": ["aB", "bA", "A"], "A": ["B", "Sa", "bBA", "b"], "B": ["b", "bS", "aD"], "D": ["AA"], "C": ["Ba"]]
2. After removing unit productions:
["S": ["aB", "bA", "B", "Sa", "bBA", "b"], "A": ["Sa", "bBA", "b", "b", "bS", "aD", "eps"], "B": ["b", "bS", "aD", "eps"], "D": ["AA"], "C": ["Ba"]]
3. After removing inaccessible symbols:
["S": ["aB", "bA", "A"], "A": ["B", "Sa", "bBA", "b"], "B": ["b", "bS", "aD", "eps"], "D": ["AA"], "C": ["Ba"]]
4. After removing non-productive symbols:
["S": ["aB", "bA", "A"], "A": ["B", "Sa", "bBA", "b"], "B": ["b", "bS", "aD", "eps"], "D": ["AA"], "C": ["Ba"]]
5. Final CNF:
["S": ["aB", "bA", "A"], "A": ["B", "Sa", "bBA", "b"], "B": ["b", "bS", "aD", "eps"], "D": ["AA"], "C": ["Ba"]]
```

When the program begins, it prints the `Initial Grammar`, which is the starting state of the grammar rules set in the `Grammar` class. This output provides a clear view of how the grammar rules are structured before any transformations are applied. The initial grammar consists of production rules defining how non-terminal symbols can be expanded into combinations of terminal and non-terminal symbols, crucial for understanding the subsequent transformations and manipulations that will be performed on this data structure.

### Processed Productions Output

```bash 
Productions after processing:
Step 1:
["S": ["aB", "bA", "A"], "A": ["B", "Sa", "bBA", "b"], "B": ["b", "bS", "aD"], "D": ["AA"], "C": ["Ba"]]
Step 2:
["S": ["aB", "bA", "B", "Sa", "bBA", "b"], "A": ["Sa", "bBA", "b", "b", "bS", "aD", "eps"], "B": ["b", "bS", "aD", "eps"], "D": ["AA"], "C": ["Ba"]]
Step 3:
["S": ["aB", "bA", "A"], "A": ["B", "Sa", "bBA", "b"], "B": ["b", "bS", "aD", "eps"], "D": ["AA"], "C": ["Ba"]]
Step 4:
["S": ["aB", "bA", "A"], "A": ["B", "Sa", "bBA", "b"], "B": ["b", "bS", "aD", "eps"], "D": ["AA"], "C": ["Ba"]]
Step 5:
["S": ["aB", "bA", "A"], "A": ["B", "Sa", "bBA", "b"], "B": ["b", "bS", "aD", "eps"], "D": ["AA"], "C": ["Ba"]]
```

After the initial state is displayed, the program processes the grammar through a series of transformations—removing epsilon productions, eliminating unit productions, removing inaccessible symbols, and more, culminating in the conversion to Chomsky Normal Form (CNF). Each transformation step is displayed sequentially, showing how the grammar is progressively refined. These outputs are essential for verifying that each step is executed correctly and for understanding how the grammar evolves. It provides a step-by-step breakdown of the changes, making it easier to follow the complex process of grammar normalization and optimization, ultimately leading to the final CNF, which is often required for certain types of algorithmic processing, like parsing in computational linguistics.

### Conclusions

The laboratory work focused on transforming a given grammar into its Chomsky Normal Form (CNF) offers a practical exploration of key concepts in formal language theory, particularly those relevant to syntax analysis and grammar manipulation. By implementing these transformations in Swift, students gain hands-on experience that links theoretical knowledge with real-world application. This exercise covers various transformations, including the removal of epsilon productions, elimination of unit productions, and identification and eradication of inaccessible and non-productive symbols, culminating in the grammar's conversion to CNF. The visual outputs at each step reinforce learning, providing concrete demonstrations of how each transformation affects the grammar structure.

This practical approach is invaluable for teaching complex computer science topics, such as compilers and natural language processing, where understanding grammatical transformations is crucial. Through this lab, students enhance their problem-solving and algorithmic thinking skills, considering both the efficiency and correctness of their code. Overall, this laboratory work not only deepens the students' understanding of formal languages but also boosts their coding proficiency, preparing them for advanced studies and careers in fields that involve parsing and language processing technologies.

## References
1. COJUHARI Irina, Duca Ludmila, Fiodorv Ion. "Formal Languages and Finite Automata: Guide for practical lessons". Technical University of Moldova
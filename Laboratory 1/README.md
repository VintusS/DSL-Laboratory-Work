# Regular Grammars & Finite Automata

### Course: Formal Languages & Finite Automata

### Author: Mindrescu Dragomir

----
## Theory:

A formal language serves as the medium or format through which information is communicated from a sender to a receiver. The essential elements of a language include:

-The alphabet: A collection of valid symbols;
-The vocabulary: A collection of valid words;
-The grammar: A collection of rules or constraints that govern the language.
These elements can be combined in countless ways, implying that the creation of a language involves choosing its components to best suit its intended application. Often, the selection is influenced by personal preference, leading to the existence of numerous natural, programming, and markup languages that may achieve similar objectives.
##  Objectives:

1. Discover what a language is and what it needs to have in order to be considered a formal one;

2. Provide the initial setup for the evolving project that you will work on during this semester. You can deal with each laboratory work as a separate task or project to demonstrate your understanding of the given themes, but you also can deal with labs as stages of making your own big solution, your own project. Do the following:

    a. Create GitHub repository to deal with storing and updating your project;

    b. Choose a programming language. Pick one that will be easiest for dealing with your tasks, you need to learn how to solve the problem itself, not everything around the problem (like setting up the project, launching it correctly and etc.);

    c. Store reports separately in a way to make verification of your work simpler (duh)

3. According to your variant number, get the grammar definition and do the following:

    a. Implement a type/class for your grammar;

    b. Add one function that would generate 5 valid strings from the language expressed by your given grammar;

    c. Implement some functionality that would convert and object of type Grammar to one of type Finite Automaton;

    d. For the Finite Automaton, please add a method that checks if an input string can be obtained via the state transition from it;

##  Implementation

### Grammar Class

The `ContextFreeGrammar` class represents a context-free grammar (CFG), which is a set of recursive rewriting rules used to generate patterns of strings. A CFG consists of a set of non-terminal symbols, terminal symbols, a start symbol, and production rules.

```python
class ContextFreeGrammar:
    def __init__(self):
        self.symbols_nonterminal = {'S', 'A', 'B', 'C'}
        self.symbols_terminal = {'a', 'b', 'c', 'd'}
        self.rules = {
            'S': ['dA'],
            'A': ['d', 'aB'],
            'B': ['bC'],
            'C': ['cA', 'aS']
        }
        self.symbol_start = 'S'
```

In the above code snippet, the `ContextFreeGrammar` class is initialized with non-terminals `S`, `A`, `B`, `C`, terminals `a`, `b`, `c`, `d`, and production rules that define how non-terminals can be transformed into strings of non-terminals and terminals.

### FiniteAutomaton Class

The `SimpleFiniteAutomaton` class represents a finite automaton (FA), which is a simple machine used to recognize patterns within input taken from some character set (or alphabet).

```python
class SimpleFiniteAutomaton:
    def __init__(self, states, alphabet, transitions, start, ends):
        self.state_list = states
        self.symbol_list = alphabet
        self.transition_map = transitions
        self.starting_state = start
        self.ending_states = ends
```

The `SimpleFiniteAutomaton` class is initialized with a set of states, an alphabet, a transition function, a start state, and a set of final states. The transition function dictates how the automaton moves from one state to another based on input symbols.

### Conversion from Grammar to Finite Automaton

The `grammar_to_automaton` function in the provided code snippet is responsible for converting a given `ContextFreeGrammar` object into a `SimpleFiniteAutomaton` object. The conversion process involves the following steps:

1. **Creating States**: For each non-terminal in the grammar, a corresponding state is created in the finite automaton. Additionally, a special 'FINAL' state is created to represent the accepting state of the automaton.

2. **Defining the Alphabet**: The alphabet of the finite automaton is the same as the set of terminal symbols in the grammar.

3. **Building Transitions**: The transitions of the automaton are derived from the production rules of the grammar. For each production rule, a transition is created from the state corresponding to the non-terminal on the left-hand side to the state corresponding to the non-terminal on the right-hand side (if present), labeled with the terminal symbol that precedes it.

   - If a production rule is of the form `A -> a`, where `A` is a non-terminal and `a` is a terminal, a transition is created from the state corresponding to `A` to the 'FINAL' state, labeled with `a`.
   - If a production rule is of the form `A -> aB`, where `A` and `B` are non-terminals and `a` is a terminal, a transition is created from the state corresponding to `A` to the state corresponding to `B`, labeled with `a`.

4. **Setting Start and Final States**: The start state of the automaton is the state corresponding to the start symbol of the grammar. The set of final states contains only the `FINAL` state.

#### Example

Consider the following grammar production rules:

```
S -> dA
A -> d | aB
B -> bC
C -> cA | aS
```

The conversion process would create states for `S`, `A`, `B`, `C`, and `FINAL`. The transitions would be based on the production rules, such as a transition from state `S` to state `A` labeled with `d`, and a transition from state `A` to `FINAL` labeled with `d`.

#### Code Snippet

```python
def grammar_to_automaton(cf_grammar):
        state_set = cf_grammar.symbols_nonterminal.union({'END'})
        symbols = cf_grammar.symbols_terminal
        state_transitions = {}
        state_final = {'END'}

        for symbol, expansions in cf_grammar.rules.items():
            for expansion in expansions:
                if len(expansion) == 1:
                    terminal = expansion
                    state_transitions[(symbol, terminal)] = {'END'}
                elif len(expansion) == 2:
                    terminal, next_symbol = expansion
                    state_transitions.setdefault((symbol, terminal), set()).add(next_symbol)

        initial_state = cf_grammar.symbol_start
        return SimpleFiniteAutomaton(state_set, symbols, state_transitions, initial_state, state_final)
```

In this code snippet, the `grammar_to_automaton` function iterates over the production rules of the grammar and constructs the transition function for the finite automaton. It handles both types of production rules (ending with a terminal or a terminal followed by a non-terminal) and ensures that the transitions are correctly set up to reflect the grammar's structure.

### String Generation and Validation

The `create_strings` method in the `ContextFreeGrammar` class produces valid strings by recursively applying the grammar's production rules. Starting with the start symbol, the method expands it by randomly selecting one of the applicable productions until a string of terminal symbols is formed. This process ensures that each generated string adheres to the grammar's structure.

```python
def create_strings(self, total=5):
        generated = []
        while len(generated) < total:
            result = self._build_from(self.symbol_start)
            if result not in generated:
                generated.append(result)
        return generated

    def _build_from(self, symbol):
        if symbol in self.symbols_terminal:
            return symbol
        else:
            choice = random.choice(self.rules[symbol])
            return ''.join(self._build_from(s) for s in choice)
```

The `is_accepted` method in the `SimpleFiniteAutomaton` class determines if a string is recognized by the automaton, which corresponds to being a valid string in the language. It uses a recursive approach to simulate the automaton's state transitions based on the input string. If the automaton reaches a final state after consuming the entire string, the string is accepted; otherwise, it is rejected.
```python
def is_accepted(self, sequence):
        def check(state, sequence_remainder):
            if not sequence_remainder:
                return state in self.ending_states
            char = sequence_remainder[0]
            if (state, char) in self.transition_map:
                for nextState in self.transition_map[(state, char)]:
                    if check(nextState, sequence_remainder[1:]):
                        return True
            return False
        return check(self.starting_state, sequence)
```


## Results and Conclusions

**Generated strings:**
```bash
dabcd
dabadd
dabadabadabadd
dabadabcabadabcd
dd
```
As seen, the system is generating the strings correctly.

**Finite Automaton:**
```
States: {'B', 'C', 'FINAL', 'A', 'S'}
Alphabet: {'d', 'b', 'c', 'a'}
Transitions: {
    'S' ('d': A),
    'A' ('d': FINAL),
    'A' ('a': B),
    'B' ('b': C),
    'C' ('c': A),
    'C' ('a': S),
}
Start State: S
Final States: {'FINAL'}
```
Based on the `Grammar` structure, I could generate a Finite Automaton with certain `States` and `Alphabet`. As seen, the `accepts` function is based on the `Transitions` objects, that "guides" on how the string should be structured (language rules).

**String Validation:**
```
dd (belongs to the language)
dabca (doesn't belong to the language)
bbca (doesn't belong to the language)
dabcd (belongs to the language)
dddd (doesn't belong to the language)
```

The generated strings are all valid strings that can be derived from the grammar. The finite automaton correctly accepts the string `dd` as it is a valid string in the language and rejects the other strings, which are not valid according to the grammar's production rules.

In conclusion, the lab gave the basic knowledge on working with DSL and regular grammar.


## References
1. COJUHARI Irina, Duca Ludmila, Fiodorv Ion. "Formal Languages and Finite Automata: Guide for practical lessons". Technical University of Moldova
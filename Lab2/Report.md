# Determinism in Finite Automata. Conversion from NDFA 2 DFA. Chomsky Hierarchy.

### Course: Formal Languages & Finite Automata

### Author: Mindrescu Dragomir

----
## Theory:

&ensp;&ensp;&ensp; A finite automaton is a mechanism used to represent processes of different kinds. It can be compared to a state machine as they both have similar structures and purpose as well. The word finite signifies the fact that an automaton comes with a starting and a set of final states. In other words, for process modeled by an automaton has a beginning and an ending.

&ensp;&ensp;&ensp; Based on the structure of an automaton, there are cases in which with one transition multiple states can be reached which causes non determinism to appear. In general, when talking about systems theory the word determinism characterizes how predictable a system is. If there are random variables involved, the system becomes stochastic or non deterministic.

&ensp;&ensp;&ensp; That being said, the automata can be classified as non-/deterministic, and there is in fact a possibility to reach determinism by following algorithms which modify the structure of the automaton.

##  Objectives:

1. Understand what an automaton is and what it can be used for.

2. Continuing the work in the same repository and the same project, the following need to be added:
    a. Provide a function in your grammar type/class that could classify the grammar based on Chomsky hierarchy.

    b. For this you can use the variant from the previous lab.

3. According to your variant number (by universal convention it is register ID), get the finite automaton definition and do the following tasks:

    a. Implement conversion of a finite automaton to a regular grammar.

    b. Determine whether your FA is deterministic or non-deterministic.

    c. Implement some functionality that would convert an NDFA to a DFA.
    
    d. Represent the finite automaton graphically (Optional, and can be considered as a __*bonus point*__):
      
    - You can use external libraries, tools or APIs to generate the figures/diagrams.
        
    - Your program needs to gather and send the data about the automaton and the lib/tool/API return the visual representation.

##  Implementation

### Grammar Class

# Finite Automaton Variant 20

## States (Q)

Q = {q0, q1, q2, q3}

## Alphabet (∑)

∑ = {a, b, c}

## Accepting States (F)

F = {q3}

## Transition Function (δ)

δ(q0, a) = q0
δ(q0, a) = q1
δ(q2, a) = q2
δ(q1, b) = q2
δ(q2, c) = q3
δ(q3, c) = q3

## Here's the implementation in Python

```python
class FiniteAutomaton:
    def __init__(self):
        self.Q = ['q0', 'q1', 'q2', 'q3']
        self.Sigma = ['a', 'b', 'c']
        self.Delta = {
            ('q0', 'a'): ['q0', 'q1'],
            ('q1', 'b'): ['q2'],
            ('q2', 'c'): ['q3'],
            ('q3', 'c'): ['q3'],
            ('q2', 'a'): ['q2']
        }
        self.q0 = 'q0'
        self.F = ['q3']
```

### This class defines represents the Finite Automaton

```python
 def convert_to_grammar(self):
        S = self.q0
        Vn = self.Q
        Vt = self.Sigma
        P = []
        for state in self.Q:
            for symbol in self.Sigma:
                if (state, symbol) in self.Delta:
                    next_states = self.Delta[(state, symbol)]
                    for next_state in next_states:
                        P.append((state, symbol, next_state))
        for final_state in self.F:
            P.append((final_state, '', 'e'))
        return Grammar(S, Vn, Vt, P)
```

Subsequently, I implemented a function named `convert_to_grammar` within the class that transforms a finite automaton into its equivalent grammar representation. This grammar consists of a start symbol 'S', a set of non-terminal symbols 'Vn', a set of terminal symbols 'VT', and a set of production rules 'P'. The conversion process utilizes a nested iteration mechanism that cycles through each state in the set 'Q' and each symbol within the alphabet '∑'. During the iteration, the function examines whether a transition exists for a given state-symbol combination based on the Delta function. If such a transition is present, the function ascertains the subsequent state corresponding to the state-symbol pair and constructs the appropriate production rule. Furthermore, the function scrutinizes the final states, appending an epsilon-transition to the grammar for each one, thus enabling a transition to an empty string. This method systematically aligns the state transitions of the finite automaton with the production rules of a grammar, thereby encapsulating the finite automaton's behavior within the descriptive power of grammatical structures.

```python
def check_deterministic(self):
        for _, value in self.Delta.items():
            if len(value) > 1:
                return False
        return True
```

The function in question is designed to assess the determinism of the finite automaton. It proceeds by traversing through the entries in the Delta dictionary, which serves as the transition function for the automaton. During this process, it evaluates each pair of state and input symbol by measuring the size of the corresponding set of resultant states. A length exceeding one indicates the presence of multiple transitions for a single state-symbol pair, which is not characteristic of a deterministic finite automaton (DFA). In the context of a DFA, each state is associated with precisely one subsequent state per input symbol.

```python
def nfa_to_dfa(self):
        input_symbols = self.Sigma
        initial_state = self.q0
        states = []
        final_states = self.F

        transitions = {}
        new_states = [initial_state]
        while new_states:
            state = new_states.pop()
            if state not in transitions:
                transitions[state] = {}
                for el in input_symbols:
                    next_states = set()
                    for s in state.split(','):
                        if (s, el) in self.Delta:
                            next_states.update(self.Delta[(s, el)])
                    next_states = ','.join(sorted(list(next_states)))
                    transitions[state][el] = next_states
                    if next_states not in transitions and next_states != '':
                        new_states.append(next_states)

        states = list(transitions.keys())

        print(f"Q = {states}")
        print(f"Sigma = {input_symbols}")
        print(f"Delta = {transitions}")
        print(f"q0 = {initial_state}")
        print(f"F = {final_states}")
```

This particular function is tasked with transforming a non-deterministic finite automaton (NFA) into its deterministic counterpart (DFA). It employs a while loop to sequentially process each state. The loop examines whether a state has been addressed previously; if not, it creates a new entry for that state within the transition dictionary. For every combination of state and input symbol, the function calculates the resultant state set by iterating over the state entries in the NFA's transition function. This method systematically explores the NFA's states and transitions to formulate an equivalent DFA.

```python
class Grammar:
    def __init__(self, S, Vn, Vt, P):
        self.S = S
        self.Vn = Vn
        self.Vt = Vt
        self.P = P

    def show_grammar(self):
        print("VN = {", ', '.join(map(str, self.Vn)), '}')
        print("VT = {", ', '.join(map(str, self.Vt)), '}')
        print("P = { ")
        for el in self.P:
            a, b, c = el
            print(f"    {a} -> {b}{c}")
        print("}")


# main
finite_automaton = FiniteAutomaton()
grammar = finite_automaton.convert_to_grammar()
print("Grammar:")
grammar.show_grammar()
print()

if not finite_automaton.check_deterministic():
    print('NFA\n')
else:
    print('DFA\n')

print("Deterministic Finite Automaton:")
finite_automaton.nfa_to_dfa()
```

## Outputs

### Grammar:

```bash
Grammar:
VN = { q0, q1, q2, q3 }
VT = { a, b, c }
P = { 
    q0 -> aq0
    q0 -> aq1
    q1 -> bq2
    q2 -> aq2
    q2 -> cq3
    q3 -> cq3
    q3 -> e
}
```

### Check if NFA or DFA

```bash
NFA
```

### Converting

```bash
Deterministic Finite Automaton:
Q = ['q0', 'q0,q1', 'q2', 'q3']
Sigma = ['a', 'b', 'c']
Delta = {'q0': {'a': 'q0,q1', 'b': '', 'c': ''}, 'q0,q1': {'a': 'q0,q1', 'b': 'q2', 'c': ''}, 'q2': {'a': 'q2', 'b': '', 'c': 'q3'}, 'q3': {'a': '', 'b': '', 'c': 'q3'}}
q0 = q0
F = ['q3']
```

## Conclusions

In conclusion, this laboratory session facilitated an in-depth understanding of finite automatons by guiding us through the process of converting non-deterministic finite automatons (NFAs) into deterministic finite automatons (DFAs). The hands-on experience with the 'convert_to_grammar' and 'show_grammar' methods bridged the conceptual gap between abstract automaton theory and practical application. The lab also emphasized the significance of verifying determinism in automatons, culminating in a comprehensive exercise that solidified our foundational knowledge in computational theory and programming.

## References
1. COJUHARI Irina, Duca Ludmila, Fiodorv Ion. "Formal Languages and Finite Automata: Guide for practical lessons". Technical University of Moldova

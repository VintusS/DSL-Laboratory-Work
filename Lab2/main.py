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

    def check_deterministic(self):
        for _, value in self.Delta.items():
            if len(value) > 1:
                return False
        return True

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
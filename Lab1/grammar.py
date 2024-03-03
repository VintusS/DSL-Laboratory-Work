import random
from finite_automaton import FiniteAutomaton

class Grammar:
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

    @staticmethod
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
        return FiniteAutomaton(state_set, symbols, state_transitions, initial_state, state_final)
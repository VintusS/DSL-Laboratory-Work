class FiniteAutomaton:
    def __init__(self, states, alphabet, transitions, start, ends):
        self.state_list = states
        self.symbol_list = alphabet
        self.transition_map = transitions
        self.starting_state = start
        self.ending_states = ends

    def __repr__(self):
        representation = "Simple Finite Automaton Representation:\n"
        representation += f"State List: {self.state_list}\n"
        representation += f"Symbol List: {self.symbol_list}\n"
        representation += "Transition Map: {\n"
        for (state, symbol), following_states in self.transition_map.items():
            representation += f"    From '{state}' on '{symbol}': {following_states},\n"
        representation += "}\n"
        representation += f"Starting State: {self.starting_state}\n"
        representation += f"Ending States: {self.ending_states}\n"
        return representation

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

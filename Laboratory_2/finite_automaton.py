def FiniteAutomaton(Q, Sigma, delta, q0, F):
    def __init__(self, Q, Sigma, delta, q0, F):
        self.Q = Q
        self.Sigma = Sigma
        self.delta = delta
        self.q0 = q0
        self.F = F



def main():
    Q = ['q0', 'q1', 'q2', 'q3']
    sigma = ['a', 'b', 'c']
    F = ['q3']
    delta = {
        'q0': {'a': ['q0', 'q1']},
        'q1': {'b': ['q2']},
        'q2': {'a': ['q2'], 'c': ['q3']},
        'q3': {'c': ['q3']}
    }

if __name__ == "__main__":
    main()
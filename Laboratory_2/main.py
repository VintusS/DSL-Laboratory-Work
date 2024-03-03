from Lab1.grammar import Grammar

class ExtendedGrammar(Grammar):
    def __init__(self, VN, VT, P):
        super().__init__(VN, VT, P)
        self.types = ['Type 0', 'Type 1', 'Type 2', 'Type 3']

    def check_type_0(self):
        for state, productions in self.P.items():
            print(state, productions)
            for production in productions:
                print(production)
                if state in production:
                    print(state, production)
                    return False
            print('====================================')
        return True

def main():
    VN = {'S', 'A', 'B', 'C'}
    VT = {'a', 'b', 'c', 'd'}
    P = {
        'S': ['dA'],
            'A': ['d', 'aB'],
            'B': ['bC'],
            'C': ['cA', 'aS']
    }
    grammar = Grammar(VN, VT, P)
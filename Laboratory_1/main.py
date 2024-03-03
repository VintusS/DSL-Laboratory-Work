from grammar import ContextFreeGrammar

cfg = ContextFreeGrammar()

def display_generated(cfg):
    results = cfg.create_strings()
    print("Generated strings:")
    for result in results:
        print(result)

display_generated(cfg)

automaton = cfg.grammar_to_automaton(cfg)
print(automaton)

def validate_strings(strings):
    print("String Validation:")
    for string in strings:
        validation = "belongs to the language" if automaton.is_accepted(string) else "doesn't belong to the language"
        print(f"{string} ({validation})")

test_strings = ["dd", "dabca", "bbca", "dabcd", "dddd"]
validate_strings(test_strings)

from copy import deepcopy

class Scope:
    """code context and scope"""
    def __init__(self):
        self.scope = {
            "kind": "",
            "name": "",
            "locals": [],
            "nonlocals": [],
            "coroutine": False,
        }
        
        self.stack = [deepcopy(self.scope)]

    def last(self):
        return self.stack[-1]

    def push(self, scope):
        s = deepcopy(self.scope)
        s.update(scope)
        self.stack.append(s)

    def pop(self):
        assert len(self.stack) > 1, "Pop context failed. This is a last scope in the stack."
        return self.stack.pop()

    def trace(self):
        pass

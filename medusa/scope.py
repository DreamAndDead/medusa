from copy import deepcopy

class Scope:
    """code context and scope"""
    def __init__(self):
        """
        level: 0 and above
        kind: global/function/lambda/class/generator
        name: ""/func name/""/class name/""
        locals: []
        nonlocals: []
        coroutine: True/False
        """
        self.scope = {
            "level": 0,
            "kind": "",
            "name": "",
            "locals": [],
            "nonlocals": [],
            "coroutine": False,
        }
        
        self.stack = [deepcopy(self.scope)]

    def last(self, kinds=[]):
        if len(kinds) == 0:
            return self.stack[-1]

        for s in reversed(self.stack):
            if s['kind'] in kinds:
                return s
    
    def push(self, scope):
        s = deepcopy(self.scope)
        l = s['level']
        s.update(scope)
        s.update(dict(level=l+1))
        self.stack.append(s)

    def pop(self):
        assert len(self.stack) > 1, "Pop context failed. This is a last scope in the stack."
        return self.stack.pop()

    def trace(self, kinds=[]):
        for s in reversed(self.stack):
            if s['kind'] in kinds:
                return s
            

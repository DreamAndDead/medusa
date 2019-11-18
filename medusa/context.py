from .symbolsstack import SymbolsStack

class Context:
    """code context and scope"""
    def __init__(self, values=None):
        values = values if values is not None else {
            "class_name": "",
            "locals": SymbolsStack(),
            "globals": SymbolsStack(),  # Not working yet
            "loop_label_name": "",
            "docstring": False,
            "generator": False,             # if a generator function
        }

        self.ctx_stack = [values]

    def last(self):
        """Return actual context state"""
        return self.ctx_stack[-1]

    def push(self, values):
        """Push new context state with new values"""
        value = self.ctx_stack[-1].copy()
        value.update({"generator": False})
        value.update(values)
        self.ctx_stack.append(value)

    def pop(self):
        """Pop last context state"""
        assert len(self.ctx_stack) > 1, "Pop context failed. This is a last context in the stack."
        return self.ctx_stack.pop()

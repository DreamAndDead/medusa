class Context:
    def __init__(self, ctx=None):
        ctx = ctx if ctx is not None else {
            "loop_label": "",
            "docstring": False,
        }

        self.label = 0
        self.ctx_stack = [ctx]

    def last(self):
        return self.ctx_stack[-1]

    def push(self, values):
        value = self.ctx_stack[-1].copy()
        value.update(values)
        self.ctx_stack.append(value)

    def push_loop(self):
        self.label += 1
        label = "loop_label_" + str(self.label)
        self.push({"loop_label": label})

    def pop(self):
        assert len(self.ctx_stack) > 1, "Pop context failed. This is a last context in the stack."
        return self.ctx_stack.pop()

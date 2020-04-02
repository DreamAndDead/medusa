# attribute

class T:
    def __init__(self):
        self.name = 'T'

t = T()

assert t.name == 'T'

t.name = 'New'

assert t.name == 'New'

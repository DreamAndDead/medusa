import ast

from .nodevisitor import NodeVisitor

class Translator:
    def __init__(self):
        self.output = []

    def translate(self, pycode):
        error = False

        try:
            py_ast_tree = ast.parse(pycode)
        except SyntaxError as e:
            error = True
            error_msg = "%s at line %d offset %d in code '%s'" % (e.msg, e.lineno, e.offset, e.text.strip())
            return error, error_msg

        visitor = NodeVisitor()

        try:
            visitor.visit(py_ast_tree)
        except RuntimeError as e:
            error = True
            error_msg = e.args[0]
            return error, error_msg

        self.output = visitor.output

        # export module symbols
        symbols = []
        symbols.append('')
        symbols.append('return {')
        for symbol in visitor.scope.first()['locals']:
            symbols.append('    %s = %s,' % (symbol, symbol))
        symbols.append('}')
        
        return error, self.to_code() + '\n'.join(symbols)

    def to_code(self, code=None, indent=0):
        code = code if code is not None else self.output

        def add_indentation(line):
            indentation_width = 4
            indentation_space = " "

            indent_copy = max(indent, 0)

            return indentation_space * indentation_width * indent_copy + line

        lines = []
        for line in code:
            if isinstance(line, str):
                lines.append(add_indentation(line))
            elif isinstance(line, list):
                sub_code = self.to_code(line, indent + 1)
                lines.append(sub_code)

        return "\n".join(lines)


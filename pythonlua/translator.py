"""Python to lua translator class"""

import ast
import os

from .nodevisitor import NodeVisitor

class Translator:
    """translator"""
    def __init__(self):
        self.output = []

    def translate(self, pycode):
        """Translate python code to lua code"""
        py_ast_tree = ast.parse(pycode)
        visitor = NodeVisitor()
        visitor.visit(py_ast_tree)
        self.output = visitor.output

        return self.to_code()

    def to_code(self, code=None, indent=0):
        """Create a lua code from the compiler output"""
        code = code if code is not None else self.output

        def add_indentation(line):
            """Add indentation to the given line"""
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


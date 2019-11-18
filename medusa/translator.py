"""Python to lua translator class"""

import ast
import os

from .nodevisitor import NodeVisitor

class Translator:
    """translator"""
    def __init__(self):
        self.output = []

    def translate(self, pycode):
        """
        Translate python code to lua code

        if error, return True and error_msg
        if not, return False and lua_code
        """
        error = False

        # if python syntax correct
        try:
            py_ast_tree = ast.parse(pycode)
        except SyntaxError as e:
            error = True
            error_msg = "%s at line %d offset %d in code '%s'" % (e.msg, e.lineno, e.offset, e.text.strip())
            return error, error_msg

        visitor = NodeVisitor()

        # if exist node type we don't support
        try:
            visitor.visit(py_ast_tree)
        except RuntimeError as e:
            error = True
            error_msg = e.args[0]
            return error, error_msg

        self.output = visitor.output
        return error, self.to_code()

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


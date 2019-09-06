"""Unary operation description"""
import ast


_DEFAULT_FORMAT = "{operation}{value}"


class UnaryOperationDesc:
    """Unary operation description"""

    OPERATION = {
        ast.USub: {
            "value": "-",
            "format": _DEFAULT_FORMAT,
        },
        ast.UAdd: {
            "value": "",
            "format": _DEFAULT_FORMAT,
        },
        ast.Not: {
            "value": "not",
            "format": "not {value}",
        },
        # TODO: bit op in lua 5.1
        ast.Invert: {
            "value": "~",
            "format": "bit32.bnot({value})",
        },
    }

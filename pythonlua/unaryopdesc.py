"""Unary operation description"""
import ast


_DEFAULT_FORMAT = "{operation}{value}"


class UnaryOperationDesc:
    """Unary operation description"""

    OPERATION = {
        ast.USub: {
            "value": "-",
            "format": "({operation}{value})",
        },
        ast.UAdd: {
            "value": "",
            "format": "{operation}{value}",
        },
        ast.Not: {
            "value": "not",
            "format": "not {value}",
        },
        ast.Invert: {
            "value": "~",
            "format": "bit.bnot({value})",
        },
    }

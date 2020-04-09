import ast

_DEFAULT_FORMAT = "{left} {operation} {right}"

class BinaryOperationDesc:
    OPERATION = {
        ast.Add: {
            "value": "+",
            "format": _DEFAULT_FORMAT,
        },
        ast.Sub: {
            "value": "-",
            "format": _DEFAULT_FORMAT,
        },
        ast.Mult: {
            "value": "*",
            "format": _DEFAULT_FORMAT,
        },
        ast.Div: {
            "value": "/",
            "format": _DEFAULT_FORMAT,
        },
        ast.Mod: {
            "value": "",
            "format": "mod_operator({left}, {right})",
        },
        ast.Pow: {
            "value": "",
            "format": "math.pow({left}, {right})",
        },
        ast.FloorDiv: {
            "value": "/",
            "format": "math.floor({left} {operation} {right})",
        },
        ast.LShift: {
            "value": "",
            "format": "bit.blshift({left}, {right})",
        },
        ast.RShift: {
            "value": "",
            "format": "bit.brshift({left}, {right})",
        },
        ast.BitOr: {
            "value": "",
            "format": "bit.bor({left}, {right})",
        },
        ast.BitAnd: {
            "value": "",
            "format": "bit.band({left}, {right})",
        },
        ast.BitXor: {
            "value": "",
            "format": "bit.bxor({left}, {right})",
        },
    }

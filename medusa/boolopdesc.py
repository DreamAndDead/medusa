import ast

class BooleanOperationDesc:
    OPERATION = {
        ast.And: {
            "value": " and "
        },
        ast.Or: {
            "value": " or "
        },
    }

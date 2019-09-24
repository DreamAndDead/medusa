"""Boolean operation description"""
import ast

class BooleanOperationDesc:
    """Binary operation description"""
    OPERATION = {
        ast.And: {
            "value": " and "
        },
        ast.Or: {
            "value": " or "
        },
    }

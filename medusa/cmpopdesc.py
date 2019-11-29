import ast

class CompareOperationDesc:
    OPERATION = {
        ast.Eq: "==",
        ast.NotEq: "~=",
        ast.Lt: "<",
        ast.LtE: "<=",
        ast.Gt: ">",
        ast.GtE: ">=",
        ast.In: {
            "format": "operator_in({left}, {right})",
        },
        ast.NotIn: {
            "format": "not operator_in({left}, {right})",
        },
        ast.Is: {
            "format": "operator_is({left}, {right})",
        },
        ast.IsNot: {
            "format": "not operator_is({left}, {right})",
        },
    }

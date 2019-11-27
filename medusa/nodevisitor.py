"""
Node visitor

ref:
- https://docs.python.org/3/library/ast.html#abstract-grammar
- https://greentreesnakes.readthedocs.io/en/latest/nodes.html
"""

import ast

from .binopdesc import BinaryOperationDesc
from .boolopdesc import BooleanOperationDesc
from .cmpopdesc import CompareOperationDesc
from .nameconstdesc import NameConstantDesc
from .unaryopdesc import UnaryOperationDesc
from .context import Context
from .scope import Scope

class NodeVisitor(ast.NodeVisitor):
    """Node visitor"""
    def __init__(self, context=None, scope=None):
        self.context = context if context is not None else Context()
        self.scope = scope if scope is not None else Scope()
        self.output = []

    def generic_visit(self, node):
        """
        unsupported nodes

        not support:
        - Raise
        - Try
        - Global
        - ExtSlice
        - NamedExpr
        - With
        - YieldFrom
        """
        raise RuntimeError("unsupported syntax '%s' at line %d col %d" % (node.__class__.__name__, node.lineno, node.col_offset))


    def visit_all(self, nodes, inline=False):
        """
        Visit all nodes in the given list

        inline: 
        - True, return the visit node result, we can manipulate them ourselves
        - False, embed the result in visitor self output
        """
        visitor = NodeVisitor(context=self.context, scope=self.scope)

        if isinstance(nodes, list):
            for node in nodes:
                visitor.visit(node)
            if not inline:
                self.output.append(visitor.output)
        else:
            visitor.visit(nodes)
            if not inline:
                self.output.extend(visitor.output)

        if inline:
            return " ".join(visitor.output)

    def emit(self, code):
        """Add translated code to the output"""
        self.output.append(code)

    def visit_Module(self, node):
        """
        Visit module

        node attr:
        - body, a list of statements
        """
        self.visit_all(node.body)
        # body is a list, it's a list result in output, fetch it with [0]
        self.output = self.output[0]

    def visit_Assert(self, node):
        """
        Visit assert

        node attr:
        - test, commonly a Compare node
        - msg, a Str node or None
        """
        test = self.visit_all(node.test, inline=True)
        if node.msg:
            msg = self.visit_all(node.msg, inline=True)
            self.emit("assert(bool({test}), {msg})".format(test=test, msg=msg))
        else:
            self.emit("assert(bool({test}))".format(test=test))

    def visit_Nonlocal(self, node):
        cur_scope = self.scope.last()

        for name in node.names:
            if name not in cur_scope['nonlocals']:
                cur_scope['nonlocals'].append(name)

    def visit_Assign(self, node):
        """
        TODO:
        - starred may happens here
        """
        cur_scope = self.scope.last()
        
        targets = [self.visit_all(t, inline=True) for t in node.targets]
        value = self.visit_all(node.value, inline=True)

        for target in targets:
            local_keyword = ""

            if "." not in target and "[" not in target and target not in cur_scope['locals'] and target not in cur_scope['nonlocals']:
                local_keyword = "local "
                cur_scope["locals"].append(target)
            
            self.emit("{local}{target} = {value}".format(local=local_keyword,
                                                         target=target,
                                                         value=value))

    def visit_AugAssign(self, node):
        """Visit augassign"""
        operation = BinaryOperationDesc.OPERATION[node.op.__class__]

        target = self.visit_all(node.target, inline=True)

        values = {
            "left": target,
            "right": self.visit_all(node.value, inline=True),
            "operation": operation["value"],
        }

        line = "({})".format(operation["format"])
        line = line.format(**values)

        self.emit("{target} = {line}".format(target=target, line=line))

    def visit_Attribute(self, node):
        """Visit attribute"""
        line = "{object}.{attr}"
        values = {
            "object": self.visit_all(node.value, True),
            "attr": node.attr,
        }
        self.emit(line.format(**values))

    def visit_BinOp(self, node):
        operation = BinaryOperationDesc.OPERATION[node.op.__class__]
        line = "({})".format(operation["format"])
        values = {
            "left": self.visit_all(node.left, True),
            "right": self.visit_all(node.right, True),
            "operation": operation["value"],
        }

        self.emit(line.format(**values))

    def visit_BoolOp(self, node):
        operation = BooleanOperationDesc.OPERATION[node.op.__class__]
        
        values = [self.visit_all(n, inline=True) for n in node.values]

        line = operation["value"].join(values)
        line = "({})".format(line)

        self.emit(line)

    def visit_Break(self, node):
        self.emit("break")

    def visit_Call(self, node):
        """
        TODO:
        - 暂时不支持键值参数，忽略了所有 keywords
        """
        line = "{name}({arguments})"

        name = self.visit_all(node.func, inline=True)
        arguments = [self.visit_all(arg, inline=True) for arg in node.args]

        # 当函数调用中有 *o 这样的形式，解析出来是 unpack，用于将列表展开，传递参数
        if node.starargs:
            starargs = self.visit_all(node.starargs, inline=True)
            arguments.append("unpack(%s)" % starargs)

        self.emit(line.format(name=name, arguments=", ".join(arguments)))

    def visit_ClassDef(self, node):
        last_scope = self.scope.last()

        local_keyword = ""
        if node.name not in last_scope['locals']:
            local_keyword = 'local '
            last_scope['locals'].append(node.name)

        name = node.name

        values = {
            "local": local_keyword,
            "name": name,
            "node_name": node.name,
        }

        self.emit("{local}{name} = class(function({node_name})".format(**values))

        bases = [self.visit_all(base, inline=True) for base in node.bases]

        self.scope.push(dict(kind="class", name=node.name))
        self.visit_all(node.body)
        cls_scope = self.scope.pop()

        # gather symbol and assign to class
        for symbol in cls_scope['locals']:
            self.output[-1].append("{node_name}.{symbol} = {symbol}".format(node_name=node.name, symbol=symbol))

        self.output[-1].append("return {node_name}".format(**values))
        self.emit("end, {{{}}}, \"{}\")".format(", ".join(bases), node.name))

    def visit_Compare(self, node):
        """Visit compare"""

        line = ""

        left = self.visit_all(node.left, inline=True)
        for i in range(len(node.ops)):
            operation = node.ops[i]
            operation = CompareOperationDesc.OPERATION[operation.__class__]

            right = self.visit_all(node.comparators[i], inline=True)

            values = {
                "left": left,
                "right": right,
            }

            if isinstance(operation, str):
                values["op"] = operation
                line += "{left} {op} {right}".format(**values)
            elif isinstance(operation, dict):
                line += operation["format"].format(**values)

            if i < len(node.ops) - 1:
                left = right
                line += " and "

        self.emit("({})".format(line))

    def visit_Continue(self, node):
        last_ctx = self.context.last()
        line = "goto {}".format(last_ctx["loop_label"])
        self.emit(line)

    def visit_Delete(self, node):
        """Visit delete"""
        targets = [self.visit_all(target, inline=True) for target in node.targets]
        nils = ["nil" for _ in targets]
        line = "{targets} = {nils}".format(targets=", ".join(targets),
                                           nils=", ".join(nils))
        self.emit(line)

    def visit_Dict(self, node):
        """Visit dictionary"""
        keys = []

        for key in node.keys:
            value = self.visit_all(key, inline=True)
            value = "[_to_null({})]".format(value)
            keys.append(value)

        values = [self.visit_all(item, inline=True) for item in node.values]

        elements = ["{} = _to_null({})".format(keys[i], values[i]) for i in range(len(keys))]
        elements = ", ".join(elements)
        self.emit("dict {{{}}}".format(elements))

    def visit_DictComp(self, node):
        """Visit dictionary comprehension"""
        self.scope.push(dict(kind="generator"))
        self.emit("(function()")
        self.emit("local result = dict {}")

        ends_count = 0

        for comp in node.generators:
            line = "for _, {target} in {iterator} do"
            values = {
                "target": self.visit_all(comp.target, inline=True),
                "iterator": self.visit_all(comp.iter, inline=True),
            }
            line = line.format(**values)
            self.emit(line)
            ends_count += 1

            for if_ in comp.ifs:
                line = "if bool({}) then".format(self.visit_all(if_, inline=True))
                self.emit(line)
                ends_count += 1

        line = "result[{key}] = {value}"
        values = {
            "key": self.visit_all(node.key, inline=True),
            "value": self.visit_all(node.value, inline=True),
        }
        self.emit(line.format(**values))

        self.emit(" ".join(["end"] * ends_count))

        self.emit("return result")
        self.emit("end)()")
        self.scope.pop()

    def visit_Ellipsis(self, node):
        """Visit ellipsis"""
        self.emit("...")

    def visit_Expr(self, node):
        """
        Visit expr
        
        node attr:
        - value
        """
        # FIXME: something wrong here
        # 在定义函数之后，直接使用 “”“”“” 是一个 Str Expr
        # 而如果我在随便一行写上 "" 一个字符串，用下面的规则，也会被认为是 doc string
        # 这一点对于代码执行是没有影响的，因为 lua 不支持字符串表达式作为语句，并且在 python 中，
        # 一行 Str 语句也没有什么影响，没有副作用，等。
        # 所以在 lua 中，作为一行空白注释也可以理解
        expr_is_docstring = False
        if isinstance(node.value, ast.Str):
            expr_is_docstring = True

        self.context.push({"docstring": expr_is_docstring})
        output = self.visit_all(node.value, inline=True)
        self.context.pop()

        self.output.append(output)

    def visit_FunctionDef(self, node):
        last_scope = self.scope.last()

        line = "{local}function {name}({arguments})"

        local_keyword = ""
        if node.name not in last_scope['locals']:
            local_keyword = "local "
            last_scope['locals'].append(node.name)

        name = node.name

        arguments = [arg.arg for arg in node.args.args]

        if node.args.vararg is not None:
            arguments.append("...")

        function_def = line.format(local=local_keyword,
                                   name=name,
                                   arguments=", ".join(arguments))

        self.emit(function_def)

        self.scope.push(dict(kind="function", name=node.name))
        self.visit_all(node.body)
        cur_scope = self.scope.pop()

        body = self.output[-1]

        if node.args.vararg is not None:
            line = "local {name} = list {{...}}".format(name=node.args.vararg.arg)
            body.insert(0, line)

        # 填充位置参数的默认值
        arg_index = -1
        for d in reversed(node.args.defaults):
            line = "{name} = {name} or {value}"

            arg = node.args.args[arg_index]
            values = {
                "name": arg.arg,
                "value": self.visit_all(d, inline=True),
            }
            body.insert(0, line.format(**values))

            arg_index -= 1

        self.emit("end")

        # coroutine before decorator
        if cur_scope["coroutine"]:
            line = "{name} = meta_generator({name})"
            self.emit(line.format(name=name))

        # 装饰器
        for decorator in reversed(node.decorator_list):
            decorator_name = self.visit_all(decorator, inline=True)
            values = {
                "name": name,
                "decorator": decorator_name,
            }
            line = "{name} = {decorator}({name})".format(**values)
            self.emit(line)

    def visit_Yield(self, node):
        func_scope = self.scope.trace(kinds=['function'])
        if func_scope:
            func_scope["coroutine"] = True
        
        line = "coroutine.yield({})"
        if node.value is None:
            value = ''
        else:
            value = self.visit_all(node.value, inline=True)
            
        self.emit(line.format(value))
            
    def visit_For(self, node):
        """Visit for"""
        line = "for _, {target} in {iter} do"

        values = {
            "target": self.visit_all(node.target, inline=True),
            "iter": self.visit_all(node.iter, inline=True),
        }

        self.emit(line.format(**values))

        self.context.push_loop()
        self.visit_all(node.body)
        last_ctx = self.context.pop()

        self.output[-1].append("::{}::".format(last_ctx["loop_label"]))

        self.emit("end")

    def visit_GeneratorExp(self, node):
        self.scope.push(dict(kind="generator"))
        self.emit("coroutine_wrap(function()")

        ends_count = 0

        for comp in node.generators:
            line = "for _, {target} in {iterator} do"
            values = {
                "target": self.visit_all(comp.target, inline=True),
                "iterator": self.visit_all(comp.iter, inline=True),
            }
            line = line.format(**values)
            self.emit(line)
            ends_count += 1

            for if_ in comp.ifs:
                line = "if bool({}) then".format(self.visit_all(if_, inline=True))
                self.emit(line)
                ends_count += 1

        line = "coroutine.yield({})"
        line = line.format(self.visit_all(node.elt, inline=True))
        self.emit(line)

        self.emit(" ".join(["end"] * ends_count))

        self.emit("end)")
        self.scope.pop()
        
    def visit_If(self, node):
        """Visit if"""
        test = self.visit_all(node.test, inline=True)

        line = "if bool({}) then".format(test)

        self.emit(line)

        self.visit_all(node.body)

        # 其实转化为 elseif 关键字不是必要的，用 else \n if 也可以正常运行，不过代码就不美观
        if node.orelse:
            if isinstance(node.orelse[0], ast.If):
                elseif = node.orelse[0]
                elseif_test = self.visit_all(elseif.test, inline=True)

                line = "elseif bool({}) then".format(elseif_test)
                self.emit(line)

                output_length = len(self.output)
                self.visit_If(node.orelse[0])

                # 删除开始的 if 和 末尾的 end
                del self.output[output_length]
                del self.output[-1]
            else:
                self.emit("else")
                self.visit_all(node.orelse)

        self.emit("end")

    def visit_IfExp(self, node):
        """Visit if expression"""
        line = "bool({cond}) and {true_cond} or {false_cond}"
        values = {
            "cond": self.visit_all(node.test, inline=True),
            "true_cond": self.visit_all(node.body, inline=True),
            "false_cond": self.visit_all(node.orelse, inline=True),
        }

        self.emit(line.format(**values))

    def visit_Import(self, node):
        last_scope = self.scope.last()
        
        line = 'local {asname} = require("{name}")'
        values = {"asname": "", "name": ""}

        for alias in node.names:
            if alias.asname is None:
                values["name"] = alias.name
                values["asname"] = values["name"]
                #values["asname"] = values["asname"].split(".")[-1]
            else:
                values["name"] = alias.name
                values["asname"] = alias.asname

            last_scope['locals'].append(values["asname"])
            self.emit(line.format(**values))

    def visit_ImportFrom(self, node):
        last_scope = self.scope.last()

        line = 'local {asname} = require("{module}").{name}'
        values = {"asname": "", "module": "", "name": ""}

        values["module"] = node.module
        
        for alias in node.names:
            if alias.asname is None:
                values["name"] = alias.name
                values["asname"] = values["name"]
            else:
                values["name"] = alias.name
                values["asname"] = alias.asname

            last_scope['locals'].append(values["asname"])
            self.emit(line.format(**values))

        
    def visit_Index(self, node):
        """Visit index"""
        line = "_to_null({})"
        value = self.visit_all(node.value, inline=True)
        self.emit(line.format(value))

    def visit_Lambda(self, node):
        """Visit lambda"""
        # TODO: ignore key-value parameters
        self.scope.push(dict(kind="lambda"))
        
        line = "function({arguments}) "

        arguments = [arg.arg for arg in node.args.args]
        if node.args.vararg is not None:
            arguments.append("...")

        function_def = line.format(arguments=", ".join(arguments))

        body = []
        if node.args.vararg is not None:
            line = "local {name} = list {{...}}".format(name=node.args.vararg.arg)
            body.insert(0, line)

        arg_index = -1
        for d in reversed(node.args.defaults):
            line = "{name} = {name} or {value}"
            arg = node.args.args[arg_index]
            values = {
                "name": arg.arg,
                "value": self.visit_all(d, inline=True),
            }
            body.insert(0, line.format(**values))

        return_line = "return {} end"
        body.append(return_line.format(self.visit_all(node.body, inline=True)))

        output = function_def + "; ".join(body)
        
        self.emit(output)
        self.scope.pop()

    def visit_List(self, node):
        """Visit list"""
        elements = [self.visit_all(item, inline=True) for item in node.elts]
        line = "list {{_to_null({})}}".format(", ".join(elements))
        self.emit(line)

    def visit_ListComp(self, node):
        self.scope.push(dict(kind="generator"))
        self.emit("(function()")
        self.emit("local result = list {}")

        ends_count = 0

        for comp in node.generators:
            line = "for _, {target} in {iterator} do"
            values = {
                "target": self.visit_all(comp.target, inline=True),
                "iterator": self.visit_all(comp.iter, inline=True),
            }
            line = line.format(**values)
            self.emit(line)
            ends_count += 1

            for if_ in comp.ifs:
                line = "if bool({}) then".format(self.visit_all(if_, inline=True))
                self.emit(line)
                ends_count += 1

        line = "result.append({})"
        line = line.format(self.visit_all(node.elt, inline=True))
        self.emit(line)

        self.emit(" ".join(["end"] * ends_count))

        self.emit("return result")
        self.emit("end)()")
        self.scope.pop()
        
    def visit_Name(self, node):
        """Visit name"""
        self.emit(node.id)

    def visit_NameConstant(self, node):
        """Visit name constant"""
        self.emit(NameConstantDesc.NAME[node.value])

    def visit_Num(self, node):
        """Visit number"""
        self.emit(str(node.n))

    def visit_Pass(self, node):
        """Visit pass"""
        pass

    def visit_Return(self, node):
        """Visit return"""
        line = "return "
        if node.value:
            line += self.visit_all(node.value, inline=True)
            
        self.emit(line)

    def visit_Starred(self, node):
        """Visit starred object"""

        # TODO, 在 python 3.5 之后, 在 function call 中有些变化
        # https://greentreesnakes.readthedocs.io/en/latest/nodes.html#Starred
        value = self.visit_all(node.value, inline=True)
        line = "unpack({})".format(value)
        self.emit(line)

    def visit_Set(self, node):
        elements = [self.visit_all(item, inline=True) for item in node.elts]
        line = "set {{_to_null({})}}".format(", ".join(elements))
        self.emit(line)

    def visit_SetComp(self, node):
        self.scope.push(dict(kind="generator"))
        self.emit("(function()")
        self.emit("local result = set {}")

        ends_count = 0

        for comp in node.generators:
            line = "for _, {target} in {iterator} do"
            values = {
                "target": self.visit_all(comp.target, inline=True),
                "iterator": self.visit_all(comp.iter, inline=True),
            }
            line = line.format(**values)
            self.emit(line)
            ends_count += 1

            for if_ in comp.ifs:
                line = "if bool({}) then".format(self.visit_all(if_, inline=True))
                self.emit(line)
                ends_count += 1

        line = "result.add({})"
        line = line.format(self.visit_all(node.elt, inline=True))
        self.emit(line)

        self.emit(" ".join(["end"] * ends_count))

        self.emit("return result")
        self.emit("end)()")
        self.scope.pop()
        
    def visit_Slice(self, node):
        line = "slice({start}, {stop}, {step})"
        values = {
            "start": self.visit_all(node.lower, inline=True) if node.lower is not None else "nil",
            "stop": self.visit_all(node.upper, inline=True) if node.upper is not None else "nil",
            "step": self.visit_all(node.step, inline=True) if node.step is not None else "nil",
        }
        self.emit(line.format(**values))

    def visit_Str(self, node):
        """Visit str"""
        value = node.s
        if self.context.last()["docstring"]:
            self.emit('--[[{}]]'.format(node.s))
        else:
            self.emit('"{}"'.format(node.s))

    def visit_Subscript(self, node):
        """
        - Index
        - Slice
        """
        line = "{name}[{index}]"
        values = {
            "name": self.visit_all(node.value, inline=True),
            "index": self.visit_all(node.slice, inline=True),
        }

        self.emit(line.format(**values))

    def visit_Tuple(self, node):
        """Visit tuple"""
        elements = [self.visit_all(item, inline=True) for item in node.elts]
        # 暂不支持 tuple 字面量
        #line = "tuple {{{}}}".format(", ".join(elements))
        #self.emit(line)
        self.emit(", ".join(elements))

    def visit_UnaryOp(self, node):
        """Visit unary operator"""
        operation = UnaryOperationDesc.OPERATION[node.op.__class__]
        value = self.visit_all(node.operand, inline=True)

        line = operation["format"]
        values = {
            "value": value,
            "operation": operation["value"],
        }

        self.emit(line.format(**values))

    def visit_While(self, node):
        """Visit while"""
        test = self.visit_all(node.test, inline=True)

        self.emit("while bool({}) do".format(test))

        self.context.push_loop()
        self.visit_all(node.body)
        last_ctx = self.context.pop()

        self.output[-1].append("::{}::".format(last_ctx["loop_label"]))

        self.emit("end")



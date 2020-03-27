import ast

from .binopdesc import BinaryOperationDesc
from .boolopdesc import BooleanOperationDesc
from .cmpopdesc import CompareOperationDesc
from .nameconstdesc import NameConstantDesc
from .unaryopdesc import UnaryOperationDesc
from .context import Context
from .scope import Scope

class NodeVisitor(ast.NodeVisitor):
    def __init__(self, context=None, scope=None):
        self.context = context if context is not None else Context()
        self.scope = scope if scope is not None else Scope()
        self.output = []

    def generic_visit(self, node):
        """
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
        if nodes is None and inline:
            return "nil"
            
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
        self.output.append(code)

    def visit_Module(self, node):
        self.visit_all(node.body)
        # body is a list, it's a list result in output, fetch it with [0]
        self.output = self.output[0]

    def visit_Assert(self, node):
        test = self.visit_all(node.test, inline=True)
        if node.msg:
            msg = self.visit_all(node.msg, inline=True)
            self.emit("assert(bool({{}}, {test}), {msg})".format(test=test, msg=msg))
        else:
            self.emit("assert(bool({{}}, {test}))".format(test=test))

    def visit_Nonlocal(self, node):
        cur_scope = self.scope.last()

        for name in node.names:
            if name not in cur_scope['nonlocals']:
                cur_scope['nonlocals'].append(name)

    def visit_Assign(self, node):
        """
        TODO:
        - star may happens here
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
        line = "{name}({arguments})"

        name = self.visit_all(node.func, inline=True)
        arguments = [self.visit_all(arg, inline=True) for arg in node.args]

        if node.kwargs:
            kwargs = self.visit_all(node.kwargs, inline=True)
        else:
            kwargs = '{}'

        kvs = ['{} = {}'.format(k.arg, self.visit_all(k.value, inline=True)) for k in node.keywords]
        arguments.insert(0, 'merge_kwargs({{{}}}, {})'.format(", ".join(kvs), kwargs))

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
        targets = [self.visit_all(target, inline=True) for target in node.targets]
        nils = ["nil" for _ in targets]
        line = "{targets} = {nils}".format(targets=", ".join(targets),
                                           nils=", ".join(nils))
        self.emit(line)

    def visit_Dict(self, node):
        keys = []

        for key in node.keys:
            value = self.visit_all(key, inline=True)
            value = "[_to_null({})]".format(value)
            keys.append(value)

        values = [self.visit_all(item, inline=True) for item in node.values]

        elements = ["{} = _to_null({})".format(keys[i], values[i]) for i in range(len(keys))]
        elements = ", ".join(elements)
        self.emit("dict({{}}, {{{}}})".format(elements))

    def visit_DictComp(self, node):
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
                line = "if bool({{}}, {}) then".format(self.visit_all(if_, inline=True))
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
        self.emit("...")

    def visit_Expr(self, node):
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

        # kvs means key-value s
        line = "{local}function {name}({arguments})"

        local_keyword = ""
        if node.name not in last_scope['locals']:
            local_keyword = "local "
            last_scope['locals'].append(node.name)

        name = node.name

        # if first argument is self in class definations
        arguments = [arg.arg for arg in node.args.args]
        arguments = ['kvs'] + arguments

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

        all_except_varkwargs = node.args.args + node.args.kwonlyargs

        if node.args.kwarg is not None:
            line = "local {} = get_kwargs(kvs, {{{}}})".format(node.args.kwarg.arg, ", ".join(map(lambda a: "{} = true".format(a.arg), all_except_varkwargs)))
            body.insert(0, line)

        for k, v in reversed(list(zip(node.args.kwonlyargs, node.args.kw_defaults))):
            line = "local {} = get_kwonlyarg(kvs, '{}', {}, '{}')".format(k.arg, k.arg, self.visit_all(v, inline=True) if v else "nil", node.name)
            body.insert(0, line)
            
        if node.args.vararg is not None:
            line = "local {name} = list {{...}}".format(name=node.args.vararg.arg)
            body.insert(0, line)

        defaults = [None] * (len(node.args.args) - len(node.args.defaults)) + node.args.defaults
        for arg, d in reversed(list(zip(node.args.args, defaults))):
            line = "{} = get_posarg(kvs, '{}', {}, {}, '{}')".format(
                arg.arg,
                arg.arg,
                arg.arg,
                self.visit_all(d, inline=True),
                node.name
            )

            body.insert(0, line)

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
            line = "{name} = {decorator}({{}}, {name})".format(**values)
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
                line = "if bool({{}}, {}) then".format(self.visit_all(if_, inline=True))
                self.emit(line)
                ends_count += 1

        line = "coroutine.yield({})"
        line = line.format(self.visit_all(node.elt, inline=True))
        self.emit(line)

        self.emit(" ".join(["end"] * ends_count))

        self.emit("end)")
        self.scope.pop()
        
    def visit_If(self, node):
        test = self.visit_all(node.test, inline=True)

        line = "if bool({{}}, {}) then".format(test)

        self.emit(line)

        self.visit_all(node.body)

        # 其实转化为 elseif 关键字不是必要的，用 else \n if 也可以正常运行，不过代码就不美观
        if node.orelse:
            if isinstance(node.orelse[0], ast.If):
                elseif = node.orelse[0]
                elseif_test = self.visit_all(elseif.test, inline=True)

                line = "elseif bool({{}}, {}) then".format(elseif_test)
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
        line = "bool({{}}, {cond}) and {true_cond} or {false_cond}"
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
        line = "_to_null({})"
        value = self.visit_all(node.value, inline=True)
        self.emit(line.format(value))

    def visit_Lambda(self, node):
        self.scope.push(dict(kind="lambda"))
        
        line = "function({arguments}) "

        arguments = [arg.arg for arg in node.args.args]
        arguments = ['kvs'] + arguments

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
        elements = [self.visit_all(item, inline=True) for item in node.elts]
        line = "list({{}}, {{_to_null({})}})".format(", ".join(elements))
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
                line = "if bool({{}}, {}) then".format(self.visit_all(if_, inline=True))
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
        self.emit(node.id)

    def visit_NameConstant(self, node):
        self.emit(NameConstantDesc.NAME[node.value])

    def visit_Num(self, node):
        self.emit(str(node.n))

    def visit_Pass(self, node):
        pass

    def visit_Return(self, node):
        line = "return "
        if node.value:
            line += self.visit_all(node.value, inline=True)
            
        self.emit(line)

    def visit_Starred(self, node):
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
                line = "if bool({{}}, {}) then".format(self.visit_all(if_, inline=True))
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
        value = node.s
        if self.context.last()["docstring"]:
            self.emit('--[[{}]]'.format(node.s))
        else:
            self.emit('"{}"'.format(node.s))

    def visit_Subscript(self, node):
        line = "{name}[{index}]"
        values = {
            "name": self.visit_all(node.value, inline=True),
            "index": self.visit_all(node.slice, inline=True),
        }

        self.emit(line.format(**values))

    def visit_Tuple(self, node):
        elements = [self.visit_all(item, inline=True) for item in node.elts]
        # TODO: 暂不支持 tuple 字面量
        #line = "tuple {{{}}}".format(", ".join(elements))
        #self.emit(line)
        self.emit(", ".join(elements))

    def visit_UnaryOp(self, node):
        operation = UnaryOperationDesc.OPERATION[node.op.__class__]
        value = self.visit_all(node.operand, inline=True)

        line = operation["format"]
        values = {
            "value": value,
            "operation": operation["value"],
        }

        self.emit(line.format(**values))

    def visit_While(self, node):
        test = self.visit_all(node.test, inline=True)

        self.emit("while bool({{}}, {}) do".format(test))

        self.context.push_loop()
        self.visit_all(node.body)
        last_ctx = self.context.pop()

        self.output[-1].append("::{}::".format(last_ctx["loop_label"]))

        self.emit("end")



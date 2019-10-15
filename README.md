# py2lua

A pyscript for transpiling pycode to luacode and can be distributed as a single executable file.

## usage

### prerequisite

- install python 3.4 or higher
- install pyinstaller by pip

### run

执行 tranpiler 程序，从 stdin 读取 python 代码，在 stdout 输出翻译的 lua 代码。

```
$ python py2lua.py
```

也可以使用文件重定向的方式读取 python 代码文件

```
$ python py2lua.py < pycode.py
```

### polyfill

python 语言和 lua 语言在单纯的语法结构上有很大程度的类似，但是 python 比 lua 有更丰富的内建函数（比如 dir, hex, etc）和内建数据结构（比如 list, dict, etc）。

对于 lua 本身并不支持的上述概念，就需要在 lua 层面用语言来实现，比如用 lua 实现一个 list 结构，提供在 python 中一样的操作接口，这样就可以将在语法层面转换过来的代码，在真实的 lua 环境执行。
这个过程称作 polyfill。

这部分功能的实现都在 `pypolyfill.lua` 文件中，如果要执行转换后的 lua 代码，引用 `pypolyfill.lua` 是必不可少的。

### distribute

将代码打包为不依赖平台环境的可执行文件

```
$ python distribute.py
```

在 `dist` 目录下，生成 `py2lua` 可执行文件。

使用方法和之前相同，默认从 stdin 读取 python 代码，在 stdout 输出翻译的 lua 代码。


## features

支持的 python 语言以 python 3.4 为基准，支持大部分 feature。

具体可见 [features](./features.md)


## development

### file structure

```
.
|-build/              # pyinstaller 的中间目录
|-codeblock/          # 针对 codeblock 功能的 py 测试代码
|-dist/               # pyinstaller 的生成目录
|-distribute.py       # 调用 pyinstaller 的入口
|-exe_version.txt     # 用于给生成的可执行文件设置元数据（针对 windows 平台）
|-inspect.sh          # 调试脚本，将指定 python 代码打印为 ast 树形结构
|-py2lua.py           # tranpiler 脚本入口
|-py2lua.spec         # pyinstaller 生成的中间文件
|-pyast.py            # py 脚本，由 inspect.sh 调用
|-pypolyfill.lua      # polyfill 脚本，用 lua 补足相应的 python 功能
|-pythonlua/          # tranpiler 功能模块代码
|-README.md           # readme
+-run_test.sh         # 使用 tranpiler 测试 codeblock 下的测试代码
```

### test

测试 codeblock 下的代码。

```
$ ./run_test.sh
```

脚本会遍历所有 codeblock 下的 py 代码，转换为 lua 代码，并同时运行 py 代码和 lua 代码，比较两者的输出结果。


### debug

针对单个 py 文件，可以具体的查看 ast 树形结构

```
$ ./inspect.sh [py_file_path]
```


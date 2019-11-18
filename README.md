# py2lua

A python project for transpiling pycode to luacode and can be distributed as a single executable file for npl mod.

## usage

### prerequisite

- install python 3.4 or higher
- install pyinstaller by pip

### run

执行 tranpiler 程序，从 stdin 读取 python 代码，在 stdout 输出翻译的 lua 代码。

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


## features

支持的 python 语言以 python 3.4 为基准，支持大部分 feature。

具体可见 :point_right: [features](./doc/features.md) :point_left:



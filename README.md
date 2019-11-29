# medusa

A python project to transpile python code to lua code. *this project is just for research not for production*.

## usage

### prerequisite

- python 3.4
- luajit (for test)

### run

运行 `medusa.py`，从 stdin 读取 python 代码，在 stdout 输出转译的 lua 代码。

```
$ python medusa.py < py_code_file.py
```

**or**

使用脚本 `transpile.sh`，对 python 代码文件/目录进行批量转译。

```
$ ./transpile.sh [py_code_file.py | py_code_dir]+
```

### test

所有测试用例在 [tests](./tests/)，执行 `run_tesh.sh`，可运行所有 tests，

```
$ ./run_test.sh
```

其中
- 使用 `assert` 函数进行断言测试
- 使用 `setfenv` 加载 polyfill 运行环境


## doc

## features

转译语言以 python 3.4 为基准，支持大部分 features，转译为 lua 5.1 (准确的说是 luajit) 同义可执行代码。

具体可见 [features](./doc/features.md)

## internals

关于 medusa 运行的内部原理，可参考 [medusa internals](./doc/internals.md)


## refs

Heavily borrowed the idea from [NeonMercury/python-lua](https://github.com/NeonMercury/python-lua), thanks.


# medusa

A python project to transpile python code to lua code. *this project is just for research not for production*.

## usage

### prerequisite

**python 3.4**

因为使用了 python 标准库 `ast` 来解析 python 代码，在更高版本的 python ast 库中，些许字段有变动，所以最好使用 3.4 版本来运行。

### run

执行 `medusa.py`，从 stdin 读取 python 代码，在 stdout 输出转译的 lua 代码。

```
$ python medusa.py < py_code_file.py
```

或者

使用脚本 `transpile.sh`，将 python 代码文件/目录进行批量转译。

```
$ ./transpile.sh py_code_file.py py_code_dir/
```

## features

支持的 python 语言以 python 3.4 为基准，支持大部分 feature，转换为 lua5.1 版本来执行。

具体可见 :point_right: [features](./doc/features.md)

## test

所有测试用例在 :point_right: [tests](./tests/)，使用 `assert` 函数进行断言测试。

运行所有测试用例，

```
$ ./run_test.sh
```

## example


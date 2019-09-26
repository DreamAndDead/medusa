# py2lua

## usage

```
$ pipenv install --three
$ python py2lua.py
```

从标准输入读取 python 代码，在文件终止后，输出翻译的 lua 代码

## test

测试 codeblock 下的代码

```
$ ./run_test.sh
```

针对单个文件，查看 ast 结构

```
$ ./inspect.sh [py_file_path]
```

## package

目前使用 `pyinstaller` 进行打包发布，遇到的问题是在 windows 高版本上打包的程序，无法在 win xp 上运行。
而在 win xp 上打包的程序可以运行在高版本。

因为很多用户依然使用 paracraft 在 win xp 平台上，所以我们要在 win xp 上进行打包，其中 win xp 只支持到 py 3.4 版本。
这里我们对程序进行一些修改，使其适配 py 3.4 和其它 feature。


将代码打包为不依赖平台环境的可执行文件

```
$ python pack.py
```

在 `dist` 目录下，生成 `py2lua` 可执行文件。

## features

新版本添加的 语法和builtin函数，暂时不支持。

[python 3.5](https://docs.python.org/3/whatsnew/3.5.html)
- 新增了 async, await 语法
- 新的矩阵乘法操作符 `a @ b`
- 在函数调用中，不限制 `* **` 解压的数量，同时 tuple list set dict 都支持解压

[python 3.6](https://docs.python.org/3/whatsnew/3.6.html)
- 添加新的字符串字面量 formatted string literals `f"He said his name"`
- 增加了变量类型提示 type hints
- 数字字面量支持 _ 
- 异步的生成器 await + yield
- 异步的生成表达式 await + for

[python 3.7](https://docs.python.org/3/whatsnew/3.7.html)
- type hints 的延时执行
- builtin breakpoint


兼容 python 3.4 版本，部分特性和未来版本的新特性暂不支持

|feature|type|support?|python version|
|:-:|:-:|:-:|:-:|
|||||

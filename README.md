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

将代码打包为不依赖平台环境的可执行文件

```
$ python pack.py
```

在 `dist` 目录下，生成 `py2lua` 可执行文件。

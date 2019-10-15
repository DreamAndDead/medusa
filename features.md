# supported features

transpiler 支持的 python 语言以 3.4 为基准，支持大部分语言功能。

## feature list

|feature|type|support?|python version|
|:-:|:-:|:-:|:-:|
|||||


## python newer than 3.4

在 python 3.4 版本之后（3.5, 3.6, 3.7）添加的 `新语法和 builtin 函数`，当前**不支持**。

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

# py2lua internals

how to do transpiling work?





transpiler 运行在编译层面，运行时出现的问题它也不能解决。

用另一种语言实现语言。

不需要集成语言，而进行翻译，可以使用大部分已知的系统的功能。

https://docs.python.org/3.5/library/stdtypes.html



单纯的转换和实现是不同的
自然语言的翻译类比
实际编程语言是一种程序




扩展了原有系统的功能

比如 math.pow()，你知道它转换后是原封不动的，就可以在 python 中这样写。



错误的对应关系。



做标准解释器做的事情。



将代码看作文本，进行规则集的操作



两种语言的异同


todo:
- sequence operations https://docs.python.org/3.5/library/stdtypes.html#common-sequence-operations
- mutable seq https://docs.python.org/3.5/library/stdtypes.html#mutable-sequence-types
- string method https://docs.python.org/3.5/library/stdtypes.html#string-methods
- set op https://docs.python.org/3.5/library/stdtypes.html#set-types-set-frozenset
- class https://docs.python.org/3.5/library/stdtypes.html#special-attributes

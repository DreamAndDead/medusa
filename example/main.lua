local lib.fib = require("lib.fib")
fib(10)
return {
    lib.fib = lib.fib,
}

local var = 3
assert(bool({}, (var == 3)))
var = (var + 3)
assert(bool({}, (var == 6)))
return {
    var = var,
}

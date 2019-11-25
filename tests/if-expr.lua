local a = bool(true) and 1 or 0
assert(bool((a == 1)))
a = bool(false) and 0 or 1
assert(bool((a == 1)))
a = bool((false or 0 or "" or nil)) and 0 or 1
assert(bool((a == 1)))
return {
    a = a,
}

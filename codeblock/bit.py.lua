dofile('./polyfill/pypolyfill.lua')
assert(((bit.brshift(10, 1)) == 5))
assert(((bit.brshift(10, 2)) == 2))
assert(((bit.brshift(10, 3)) == 1))
assert(((bit.brshift(10, 4)) == 0))
assert(((bit.brshift(10, 14)) == 0))
assert(((bit.brshift(10, 24)) == 0))
assert(((bit.brshift(10, 34)) == 0))
assert(((bit.brshift((-10), 1)) == (-5)))
assert(((bit.brshift((-10), 2)) == (-3)))
assert(((bit.brshift((-10), 3)) == (-2)))
assert(((bit.brshift((-10), 4)) == (-1)))
assert(((bit.brshift((-10), 5)) == (-1)))
assert(((bit.brshift((-10), 6)) == (-1)))
assert(((bit.brshift((-10), 16)) == (-1)))
assert(((bit.brshift((-10), 26)) == (-1)))
assert(((bit.brshift((-10), 36)) == (-1)))
assert(((bit.blshift(1, 0)) == 1))
assert(((bit.blshift(1, 1)) == 2))
assert(((bit.blshift(1, 2)) == 4))
assert(((bit.blshift(1, 10)) == 1024))
assert(((bit.blshift(1, 20)) == 1048576))
assert(((bit.blshift(1, 30)) == 1073741824))
assert(((bit.band(15, 0)) == 0))
assert(((bit.band(15, 2)) == 2))
assert(((bit.band(15, 4)) == 4))
assert(((bit.band(15, 8)) == 8))
assert(((bit.band(15, 10)) == 10))
assert(((bit.band(15, 5)) == 5))
assert(((bit.bor(15, 0)) == 15))
assert(((bit.bor(15, 2)) == 15))
assert(((bit.bor(15, 4)) == 15))
assert(((bit.bor(15, 8)) == 15))
assert(((bit.bor(15, 10)) == 15))
assert(((bit.bor(15, 5)) == 15))
assert((bit.bnot(1) == (-2)))
assert((bit.bnot(10) == (-11)))
assert(((bit.bxor(15, 15)) == 0))
assert(((bit.bxor(15, 11)) == 4))
assert(((bit.bxor(15, 13)) == 2))
assert(((bit.bxor(15, 14)) == 1))

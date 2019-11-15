dofile('./polyfill/pypolyfill.lua')
local s = set {_to_null(0, 1, 2, 3, nil, nil)}
assert((len(s) == 5))
assert((operator_in(0, s)))
assert((operator_in(1, s)))
assert((operator_in(2, s)))
assert((operator_in(3, s)))
assert((operator_in(nil, s)))
s = set {_to_null(0, 1, 2, 3)}
s.add(1)
s.add(4)
s.add(nil)
assert((len(s) == 6))
assert((operator_in(0, s)))
assert((operator_in(1, s)))
assert((operator_in(2, s)))
assert((operator_in(3, s)))
assert((operator_in(4, s)))
assert((operator_in(nil, s)))
s = set {_to_null(0, 1, 2, 3)}
s.clear()
assert((len(s) == 0))
assert((not operator_in(1, s)))
assert((not operator_in(2, s)))
assert((not operator_in(nil, s)))
s = set {_to_null(0, 1, 2, 3)}
local sc = s.copy()
sc.add(4)
sc.add(5)
sc.add(6)
sc.add(nil)
assert((len(s) == 4))
assert((len(sc) == 8))
assert((not operator_in(4, s)))
assert((not operator_in(5, s)))
assert((not operator_in(6, s)))
assert((not operator_in(nil, s)))
assert((operator_in(4, sc)))
assert((operator_in(5, sc)))
assert((operator_in(6, sc)))
assert((operator_in(nil, sc)))
local s1 = set {_to_null(1, 2, 3, 4, 5, 6, nil)}
local s2 = set {_to_null(2, 4, 6, 8, nil)}
local s3 = set {_to_null(0, 10, 3)}
local s1_2 = s1.difference(s2)
assert((len(s1_2) == 3))
assert((operator_in(1, s1_2)))
assert((operator_in(3, s1_2)))
assert((operator_in(5, s1_2)))
local s1_2_3 = s1.difference(s2, s3)
assert((len(s1_2_3) == 2))
assert((operator_in(1, s1_2_3)))
assert((operator_in(5, s1_2_3)))
s1 = set {_to_null(1, 2, 3, 4, 5, 6, nil)}
s2 = set {_to_null(2, 4, 6, 8, nil)}
s3 = set {_to_null(0, 10, 3)}
s1.difference_update(s2)
assert((len(s1) == 3))
assert((operator_in(1, s1)))
assert((operator_in(3, s1)))
assert((operator_in(5, s1)))
s1 = set {_to_null(1, 2, 3, 4, 5, 6, nil)}
s1.difference_update(s2, s3)
assert((len(s1) == 2))
assert((operator_in(1, s1)))
assert((operator_in(5, s1)))
s = set {_to_null("a", 1, "c", "a", "d", nil)}
assert((len(s) == 5))
s.discard(1)
assert((not operator_in(1, s)))
s.discard("a")
s.discard("c")
s.discard(nil)
assert((not operator_in("a", s)))
assert((not operator_in("c", s)))
assert((not operator_in(nil, s)))
s1 = set {_to_null(1, 2, 3, 4, 5, 6, nil)}
s2 = set {_to_null(2, 4, 6, 8, nil)}
s3 = set {_to_null(0, 10, 3)}
local s1and2 = s1.intersection(s2)
assert((len(s1and2) == 4))
assert((operator_in(2, s1and2)))
assert((operator_in(4, s1and2)))
assert((operator_in(6, s1and2)))
assert((operator_in(nil, s1and2)))
assert((not operator_in(1, s1and2)))
assert((not operator_in(3, s1and2)))
assert((not operator_in(5, s1and2)))
assert((not operator_in(8, s1and2)))
local s1and2and3 = s1.intersection(s2, s3)
assert((len(s1and2and3) == 0))
s1 = set {_to_null(1, 2, 3, 4, 5, 6, nil)}
s2 = set {_to_null(2, 4, 6, 8, nil)}
s3 = set {_to_null(0, 10, 3)}
s1.intersection_update(s2)
assert((len(s1) == 4))
assert((operator_in(2, s1)))
assert((operator_in(4, s1)))
assert((operator_in(6, s1)))
assert((operator_in(nil, s1)))
assert((not operator_in(1, s1)))
assert((not operator_in(3, s1)))
assert((not operator_in(5, s1)))
assert((not operator_in(8, s1)))
s1.intersection_update(s2, s3)
assert((len(s1) == 0))
s1 = set {_to_null(1, 2, 3, 4, 5, 6, nil)}
s2 = set {_to_null(2, 4, 6, 8, nil)}
s3 = set {_to_null(0, 10, 3)}
assert(not s1.isdisjoint(s2))
assert(not s1.isdisjoint(s3))
assert(s2.isdisjoint(s3))
s1 = set {_to_null(1, 2, 3, 4, 5, 6, nil)}
s2 = set {_to_null(2, 4, 6, 8)}
s3 = set {_to_null(0, 10, 3)}
local s4 = set {_to_null(2, 6)}
assert(s1.issubset(s1))
assert(not s1.issubset(s2))
assert(not s1.issubset(s3))
assert(not s1.issubset(s4))
assert(s4.issubset(s1))
assert(s4.issubset(s2))
assert(not s4.issubset(s3))
assert(s4.issubset(s4))
s1 = set {_to_null(1, 2, 3, 4, 5, 6, nil)}
s2 = set {_to_null(2, 4, 6, 8)}
s3 = set {_to_null(0, 10, 3)}
s4 = set {_to_null(2, 6)}
assert(s1.issuperset(s1))
assert(not s1.issuperset(s2))
assert(not s1.issuperset(s3))
assert(s1.issuperset(s4))
assert(not s4.issuperset(s1))
assert(not s4.issuperset(s2))
assert(not s4.issuperset(s3))
assert(s4.issuperset(s4))
s1 = set {_to_null(1, 2, 3, 4, 5, 6, nil)}
s2 = s1.copy()
for _, i in range(len(s1)) do
    local e = s1.pop()
    assert((not operator_in(e, s1)))
    assert((operator_in(e, s2)))
end
assert((len(s1) == 0))
s = set {_to_null("a", 1, "c", nil)}
assert((len(s) == 4))
assert((operator_in("a", s)))
assert((operator_in(1, s)))
assert((operator_in("c", s)))
assert((operator_in(nil, s)))
s.remove("a")
s.remove(1)
assert((len(s) == 2))
assert((not operator_in("a", s)))
assert((not operator_in(1, s)))
assert((operator_in("c", s)))
assert((operator_in(nil, s)))
s1 = set {_to_null(1, 2, 3, 4, 5, 6)}
s2 = set {_to_null(2, 4, 6, 8)}
s3 = set {_to_null(0, 10, 3)}
s4 = set {_to_null(2, 6)}
local s1_sym_s1 = s1.symmetric_difference(s1)
local s1_sym_s2 = s1.symmetric_difference(s2)
local s1_sym_s3 = s1.symmetric_difference(s3)
local s1_sym_s4 = s1.symmetric_difference(s4)
assert((len(s1_sym_s1) == 0))
assert((len(s1_sym_s2) == 4))
assert((operator_in(1, s1_sym_s2)))
assert((operator_in(3, s1_sym_s2)))
assert((operator_in(5, s1_sym_s2)))
assert((operator_in(8, s1_sym_s2)))
assert((len(s1_sym_s3) == 7))
assert((operator_in(1, s1_sym_s3)))
assert((operator_in(2, s1_sym_s3)))
assert((operator_in(4, s1_sym_s3)))
assert((operator_in(5, s1_sym_s3)))
assert((operator_in(6, s1_sym_s3)))
assert((operator_in(0, s1_sym_s3)))
assert((operator_in(10, s1_sym_s3)))
assert((len(s1_sym_s4) == 4))
assert((operator_in(1, s1_sym_s4)))
assert((operator_in(3, s1_sym_s4)))
assert((operator_in(4, s1_sym_s4)))
assert((operator_in(5, s1_sym_s4)))
s1 = set {_to_null(1, 2, 3, 4, 5, 6)}
s2 = set {_to_null(2, 4, 6, 8)}
s3 = set {_to_null(0, 10, 3)}
s4 = set {_to_null(2, 6)}
s1 = set {_to_null(1, 2, 3, 4, 5, 6)}
s1.symmetric_difference_update(s1)
assert((len(s1) == 0))
s1 = set {_to_null(1, 2, 3, 4, 5, 6)}
s1.symmetric_difference_update(s2)
assert((len(s1) == 4))
assert((operator_in(1, s1)))
assert((operator_in(3, s1)))
assert((operator_in(5, s1)))
assert((operator_in(8, s1)))
s1 = set {_to_null(1, 2, 3, 4, 5, 6)}
s1.symmetric_difference_update(s3)
assert((len(s1) == 7))
assert((operator_in(1, s1)))
assert((operator_in(2, s1)))
assert((operator_in(4, s1)))
assert((operator_in(5, s1)))
assert((operator_in(6, s1)))
assert((operator_in(0, s1)))
assert((operator_in(10, s1)))
s1 = set {_to_null(1, 2, 3, 4, 5, 6)}
s1.symmetric_difference_update(s4)
assert((len(s1) == 4))
assert((operator_in(1, s1)))
assert((operator_in(3, s1)))
assert((operator_in(4, s1)))
assert((operator_in(5, s1)))
s1 = set {_to_null(1, 2, 3, 4, 5, 6)}
s2 = set {_to_null(2, 4, 6, 8)}
s3 = set {_to_null(0, 10, 3)}
local s1_union_s2s3 = s1.union(s2, s3)
assert((len(s1_union_s2s3) == 9))
assert((operator_in(1, s1_union_s2s3)))
assert((operator_in(2, s1_union_s2s3)))
assert((operator_in(3, s1_union_s2s3)))
assert((operator_in(4, s1_union_s2s3)))
assert((operator_in(5, s1_union_s2s3)))
assert((operator_in(6, s1_union_s2s3)))
assert((operator_in(8, s1_union_s2s3)))
assert((operator_in(0, s1_union_s2s3)))
assert((operator_in(10, s1_union_s2s3)))
s1 = set {_to_null(1, 2, 3, 4, 5, 6)}
s2 = set {_to_null(2, 4, 6, 8)}
s3 = set {_to_null(0, 10, 3)}
s1.update(s2, s3)
assert((len(s1) == 9))
assert((operator_in(1, s1)))
assert((operator_in(2, s1)))
assert((operator_in(3, s1)))
assert((operator_in(4, s1)))
assert((operator_in(5, s1)))
assert((operator_in(6, s1)))
assert((operator_in(8, s1)))
assert((operator_in(0, s1)))
assert((operator_in(10, s1)))

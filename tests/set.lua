local s = set {_to_null(0, 1, 2, 3, nil, nil)}
assert(bool((len(merge_kwargs({}, {}), s) == 5)))
assert(bool((operator_in(0, s))))
assert(bool((operator_in(1, s))))
assert(bool((operator_in(2, s))))
assert(bool((operator_in(3, s))))
assert(bool((operator_in(nil, s))))
s = set {_to_null(0, 1, 2, 3)}
s.add(merge_kwargs({}, {}), 1)
s.add(merge_kwargs({}, {}), 4)
s.add(merge_kwargs({}, {}), nil)
assert(bool((len(merge_kwargs({}, {}), s) == 6)))
assert(bool((operator_in(0, s))))
assert(bool((operator_in(1, s))))
assert(bool((operator_in(2, s))))
assert(bool((operator_in(3, s))))
assert(bool((operator_in(4, s))))
assert(bool((operator_in(nil, s))))
s = set {_to_null(0, 1, 2, 3)}
s.clear(merge_kwargs({}, {}))
assert(bool((len(merge_kwargs({}, {}), s) == 0)))
assert(bool((not operator_in(1, s))))
assert(bool((not operator_in(2, s))))
assert(bool((not operator_in(nil, s))))
s = set {_to_null(0, 1, 2, 3)}
local sc = s.copy(merge_kwargs({}, {}))
sc.add(merge_kwargs({}, {}), 4)
sc.add(merge_kwargs({}, {}), 5)
sc.add(merge_kwargs({}, {}), 6)
sc.add(merge_kwargs({}, {}), nil)
assert(bool((len(merge_kwargs({}, {}), s) == 4)))
assert(bool((len(merge_kwargs({}, {}), sc) == 8)))
assert(bool((not operator_in(4, s))))
assert(bool((not operator_in(5, s))))
assert(bool((not operator_in(6, s))))
assert(bool((not operator_in(nil, s))))
assert(bool((operator_in(4, sc))))
assert(bool((operator_in(5, sc))))
assert(bool((operator_in(6, sc))))
assert(bool((operator_in(nil, sc))))
local s1 = set {_to_null(1, 2, 3, 4, 5, 6, nil)}
local s2 = set {_to_null(2, 4, 6, 8, nil)}
local s3 = set {_to_null(0, 10, 3)}
local s1_2 = s1.difference(merge_kwargs({}, {}), s2)
assert(bool((len(merge_kwargs({}, {}), s1_2) == 3)))
assert(bool((operator_in(1, s1_2))))
assert(bool((operator_in(3, s1_2))))
assert(bool((operator_in(5, s1_2))))
local s1_2_3 = s1.difference(merge_kwargs({}, {}), s2, s3)
assert(bool((len(merge_kwargs({}, {}), s1_2_3) == 2)))
assert(bool((operator_in(1, s1_2_3))))
assert(bool((operator_in(5, s1_2_3))))
s1 = set {_to_null(1, 2, 3, 4, 5, 6, nil)}
s2 = set {_to_null(2, 4, 6, 8, nil)}
s3 = set {_to_null(0, 10, 3)}
s1.difference_update(merge_kwargs({}, {}), s2)
assert(bool((len(merge_kwargs({}, {}), s1) == 3)))
assert(bool((operator_in(1, s1))))
assert(bool((operator_in(3, s1))))
assert(bool((operator_in(5, s1))))
s1 = set {_to_null(1, 2, 3, 4, 5, 6, nil)}
s1.difference_update(merge_kwargs({}, {}), s2, s3)
assert(bool((len(merge_kwargs({}, {}), s1) == 2)))
assert(bool((operator_in(1, s1))))
assert(bool((operator_in(5, s1))))
s = set {_to_null("a", 1, "c", "a", "d", nil)}
assert(bool((len(merge_kwargs({}, {}), s) == 5)))
s.discard(merge_kwargs({}, {}), 1)
assert(bool((not operator_in(1, s))))
s.discard(merge_kwargs({}, {}), "a")
s.discard(merge_kwargs({}, {}), "c")
s.discard(merge_kwargs({}, {}), nil)
assert(bool((not operator_in("a", s))))
assert(bool((not operator_in("c", s))))
assert(bool((not operator_in(nil, s))))
s1 = set {_to_null(1, 2, 3, 4, 5, 6, nil)}
s2 = set {_to_null(2, 4, 6, 8, nil)}
s3 = set {_to_null(0, 10, 3)}
local s1and2 = s1.intersection(merge_kwargs({}, {}), s2)
assert(bool((len(merge_kwargs({}, {}), s1and2) == 4)))
assert(bool((operator_in(2, s1and2))))
assert(bool((operator_in(4, s1and2))))
assert(bool((operator_in(6, s1and2))))
assert(bool((operator_in(nil, s1and2))))
assert(bool((not operator_in(1, s1and2))))
assert(bool((not operator_in(3, s1and2))))
assert(bool((not operator_in(5, s1and2))))
assert(bool((not operator_in(8, s1and2))))
local s1and2and3 = s1.intersection(merge_kwargs({}, {}), s2, s3)
assert(bool((len(merge_kwargs({}, {}), s1and2and3) == 0)))
s1 = set {_to_null(1, 2, 3, 4, 5, 6, nil)}
s2 = set {_to_null(2, 4, 6, 8, nil)}
s3 = set {_to_null(0, 10, 3)}
s1.intersection_update(merge_kwargs({}, {}), s2)
assert(bool((len(merge_kwargs({}, {}), s1) == 4)))
assert(bool((operator_in(2, s1))))
assert(bool((operator_in(4, s1))))
assert(bool((operator_in(6, s1))))
assert(bool((operator_in(nil, s1))))
assert(bool((not operator_in(1, s1))))
assert(bool((not operator_in(3, s1))))
assert(bool((not operator_in(5, s1))))
assert(bool((not operator_in(8, s1))))
s1.intersection_update(merge_kwargs({}, {}), s2, s3)
assert(bool((len(merge_kwargs({}, {}), s1) == 0)))
s1 = set {_to_null(1, 2, 3, 4, 5, 6, nil)}
s2 = set {_to_null(2, 4, 6, 8, nil)}
s3 = set {_to_null(0, 10, 3)}
assert(bool(not bool(s1.isdisjoint(merge_kwargs({}, {}), s2))))
assert(bool(not bool(s1.isdisjoint(merge_kwargs({}, {}), s3))))
assert(bool(s2.isdisjoint(merge_kwargs({}, {}), s3)))
s1 = set {_to_null(1, 2, 3, 4, 5, 6, nil)}
s2 = set {_to_null(2, 4, 6, 8)}
s3 = set {_to_null(0, 10, 3)}
local s4 = set {_to_null(2, 6)}
assert(bool(s1.issubset(merge_kwargs({}, {}), s1)))
assert(bool(not bool(s1.issubset(merge_kwargs({}, {}), s2))))
assert(bool(not bool(s1.issubset(merge_kwargs({}, {}), s3))))
assert(bool(not bool(s1.issubset(merge_kwargs({}, {}), s4))))
assert(bool(s4.issubset(merge_kwargs({}, {}), s1)))
assert(bool(s4.issubset(merge_kwargs({}, {}), s2)))
assert(bool(not bool(s4.issubset(merge_kwargs({}, {}), s3))))
assert(bool(s4.issubset(merge_kwargs({}, {}), s4)))
s1 = set {_to_null(1, 2, 3, 4, 5, 6, nil)}
s2 = set {_to_null(2, 4, 6, 8)}
s3 = set {_to_null(0, 10, 3)}
s4 = set {_to_null(2, 6)}
assert(bool(s1.issuperset(merge_kwargs({}, {}), s1)))
assert(bool(not bool(s1.issuperset(merge_kwargs({}, {}), s2))))
assert(bool(not bool(s1.issuperset(merge_kwargs({}, {}), s3))))
assert(bool(s1.issuperset(merge_kwargs({}, {}), s4)))
assert(bool(not bool(s4.issuperset(merge_kwargs({}, {}), s1))))
assert(bool(not bool(s4.issuperset(merge_kwargs({}, {}), s2))))
assert(bool(not bool(s4.issuperset(merge_kwargs({}, {}), s3))))
assert(bool(s4.issuperset(merge_kwargs({}, {}), s4)))
s1 = set {_to_null(1, 2, 3, 4, 5, 6, nil)}
s2 = s1.copy(merge_kwargs({}, {}))
for _, i in range(merge_kwargs({}, {}), len(merge_kwargs({}, {}), s1)) do
    local e = s1.pop(merge_kwargs({}, {}))
    assert(bool((not operator_in(e, s1))))
    assert(bool((operator_in(e, s2))))
    ::loop_label_1::
end
assert(bool((len(merge_kwargs({}, {}), s1) == 0)))
s = set {_to_null("a", 1, "c", nil)}
assert(bool((len(merge_kwargs({}, {}), s) == 4)))
assert(bool((operator_in("a", s))))
assert(bool((operator_in(1, s))))
assert(bool((operator_in("c", s))))
assert(bool((operator_in(nil, s))))
s.remove(merge_kwargs({}, {}), "a")
s.remove(merge_kwargs({}, {}), 1)
assert(bool((len(merge_kwargs({}, {}), s) == 2)))
assert(bool((not operator_in("a", s))))
assert(bool((not operator_in(1, s))))
assert(bool((operator_in("c", s))))
assert(bool((operator_in(nil, s))))
s1 = set {_to_null(1, 2, 3, 4, 5, 6)}
s2 = set {_to_null(2, 4, 6, 8)}
s3 = set {_to_null(0, 10, 3)}
s4 = set {_to_null(2, 6)}
local s1_sym_s1 = s1.symmetric_difference(merge_kwargs({}, {}), s1)
local s1_sym_s2 = s1.symmetric_difference(merge_kwargs({}, {}), s2)
local s1_sym_s3 = s1.symmetric_difference(merge_kwargs({}, {}), s3)
local s1_sym_s4 = s1.symmetric_difference(merge_kwargs({}, {}), s4)
assert(bool((len(merge_kwargs({}, {}), s1_sym_s1) == 0)))
assert(bool((len(merge_kwargs({}, {}), s1_sym_s2) == 4)))
assert(bool((operator_in(1, s1_sym_s2))))
assert(bool((operator_in(3, s1_sym_s2))))
assert(bool((operator_in(5, s1_sym_s2))))
assert(bool((operator_in(8, s1_sym_s2))))
assert(bool((len(merge_kwargs({}, {}), s1_sym_s3) == 7)))
assert(bool((operator_in(1, s1_sym_s3))))
assert(bool((operator_in(2, s1_sym_s3))))
assert(bool((operator_in(4, s1_sym_s3))))
assert(bool((operator_in(5, s1_sym_s3))))
assert(bool((operator_in(6, s1_sym_s3))))
assert(bool((operator_in(0, s1_sym_s3))))
assert(bool((operator_in(10, s1_sym_s3))))
assert(bool((len(merge_kwargs({}, {}), s1_sym_s4) == 4)))
assert(bool((operator_in(1, s1_sym_s4))))
assert(bool((operator_in(3, s1_sym_s4))))
assert(bool((operator_in(4, s1_sym_s4))))
assert(bool((operator_in(5, s1_sym_s4))))
s1 = set {_to_null(1, 2, 3, 4, 5, 6)}
s2 = set {_to_null(2, 4, 6, 8)}
s3 = set {_to_null(0, 10, 3)}
s4 = set {_to_null(2, 6)}
s1 = set {_to_null(1, 2, 3, 4, 5, 6)}
s1.symmetric_difference_update(merge_kwargs({}, {}), s1)
assert(bool((len(merge_kwargs({}, {}), s1) == 0)))
s1 = set {_to_null(1, 2, 3, 4, 5, 6)}
s1.symmetric_difference_update(merge_kwargs({}, {}), s2)
assert(bool((len(merge_kwargs({}, {}), s1) == 4)))
assert(bool((operator_in(1, s1))))
assert(bool((operator_in(3, s1))))
assert(bool((operator_in(5, s1))))
assert(bool((operator_in(8, s1))))
s1 = set {_to_null(1, 2, 3, 4, 5, 6)}
s1.symmetric_difference_update(merge_kwargs({}, {}), s3)
assert(bool((len(merge_kwargs({}, {}), s1) == 7)))
assert(bool((operator_in(1, s1))))
assert(bool((operator_in(2, s1))))
assert(bool((operator_in(4, s1))))
assert(bool((operator_in(5, s1))))
assert(bool((operator_in(6, s1))))
assert(bool((operator_in(0, s1))))
assert(bool((operator_in(10, s1))))
s1 = set {_to_null(1, 2, 3, 4, 5, 6)}
s1.symmetric_difference_update(merge_kwargs({}, {}), s4)
assert(bool((len(merge_kwargs({}, {}), s1) == 4)))
assert(bool((operator_in(1, s1))))
assert(bool((operator_in(3, s1))))
assert(bool((operator_in(4, s1))))
assert(bool((operator_in(5, s1))))
s1 = set {_to_null(1, 2, 3, 4, 5, 6)}
s2 = set {_to_null(2, 4, 6, 8)}
s3 = set {_to_null(0, 10, 3)}
local s1_union_s2s3 = s1.union(merge_kwargs({}, {}), s2, s3)
assert(bool((len(merge_kwargs({}, {}), s1_union_s2s3) == 9)))
assert(bool((operator_in(1, s1_union_s2s3))))
assert(bool((operator_in(2, s1_union_s2s3))))
assert(bool((operator_in(3, s1_union_s2s3))))
assert(bool((operator_in(4, s1_union_s2s3))))
assert(bool((operator_in(5, s1_union_s2s3))))
assert(bool((operator_in(6, s1_union_s2s3))))
assert(bool((operator_in(8, s1_union_s2s3))))
assert(bool((operator_in(0, s1_union_s2s3))))
assert(bool((operator_in(10, s1_union_s2s3))))
s1 = set {_to_null(1, 2, 3, 4, 5, 6)}
s2 = set {_to_null(2, 4, 6, 8)}
s3 = set {_to_null(0, 10, 3)}
s1.update(merge_kwargs({}, {}), s2, s3)
assert(bool((len(merge_kwargs({}, {}), s1) == 9)))
assert(bool((operator_in(1, s1))))
assert(bool((operator_in(2, s1))))
assert(bool((operator_in(3, s1))))
assert(bool((operator_in(4, s1))))
assert(bool((operator_in(5, s1))))
assert(bool((operator_in(6, s1))))
assert(bool((operator_in(8, s1))))
assert(bool((operator_in(0, s1))))
assert(bool((operator_in(10, s1))))
s = set {_to_null(1, 2, 3, 4, 5, 6)}
assert(bool((operator_in(1, s))))
assert(bool((not operator_in(7, s))))
s1 = set {_to_null(1, 2, 3, 4, 5, 6)}
s2 = set {_to_null(2, 4, 6, 8)}
s = (bit.bor(s1, s2))
assert(bool((len(merge_kwargs({}, {}), s) == 7)))
assert(bool((operator_in(1, s))))
assert(bool((operator_in(2, s))))
assert(bool((operator_in(3, s))))
assert(bool((operator_in(4, s))))
assert(bool((operator_in(5, s))))
assert(bool((operator_in(6, s))))
assert(bool((operator_in(8, s))))
s1 = set {_to_null(1, 2, 3, 4, 5, 6)}
s2 = set {_to_null(2, 4, 6, 8)}
s = (bit.band(s1, s2))
assert(bool((len(merge_kwargs({}, {}), s) == 3)))
assert(bool((operator_in(2, s))))
assert(bool((operator_in(4, s))))
assert(bool((operator_in(6, s))))
s1 = set {_to_null(1, 2, 3, 4, 5, 6)}
s2 = set {_to_null(2, 4, 6, 8)}
s = (s1 - s2)
assert(bool((len(merge_kwargs({}, {}), s) == 3)))
assert(bool((operator_in(1, s))))
assert(bool((operator_in(3, s))))
assert(bool((operator_in(5, s))))
s1 = set {_to_null(1, 2, 3, 4, 5, 6)}
s2 = set {_to_null(2, 4, 6, 8)}
s = (bit.bxor(s1, s2))
assert(bool((len(merge_kwargs({}, {}), s) == 4)))
assert(bool((operator_in(1, s))))
assert(bool((operator_in(3, s))))
assert(bool((operator_in(5, s))))
assert(bool((operator_in(8, s))))
return {
    s = s,
    sc = sc,
    s1 = s1,
    s2 = s2,
    s3 = s3,
    s1_2 = s1_2,
    s1_2_3 = s1_2_3,
    s1and2 = s1and2,
    s1and2and3 = s1and2and3,
    s4 = s4,
    e = e,
    s1_sym_s1 = s1_sym_s1,
    s1_sym_s2 = s1_sym_s2,
    s1_sym_s3 = s1_sym_s3,
    s1_sym_s4 = s1_sym_s4,
    s1_union_s2s3 = s1_union_s2s3,
}

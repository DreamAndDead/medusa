# frozenset

s = frozenset({ 0, 1, 2, 3, None })

assert len(s) == 5
assert 0 in s
assert 1 in s
assert 2 in s
assert 3 in s
assert None in s

## copy

s = frozenset({ 0, 1, 2, 3, None })

sc = s.copy()

assert len(s) == 5
assert len(sc) == 5
# high efficency
assert s is sc

## difference

s1 = frozenset({ 1, 2, 3, 4, 5, 6, None })
s2 = frozenset({ 2, 4, 6, 8, None })
s3 = frozenset({ 0, 10, 3 })

s1_2 = s1.difference(s2)

assert len(s1_2) == 3
assert 1 in s1_2
assert 3 in s1_2
assert 5 in s1_2

s1_2_3 = s1.difference(s2, s3)

assert len(s1_2_3) == 2
assert 1 in s1_2_3
assert 5 in s1_2_3


## intersection

s1 = frozenset({ 1, 2, 3, 4, 5, 6, None })
s2 = frozenset({ 2, 4, 6, 8, None })
s3 = frozenset({ 0, 10, 3 })

s1and2 = s1.intersection(s2)

assert len(s1and2) == 4
assert 2 in s1and2
assert 4 in s1and2
assert 6 in s1and2
assert None in s1and2
assert 1 not in s1and2
assert 3 not in s1and2
assert 5 not in s1and2
assert 8 not in s1and2

s1and2and3 = s1.intersection(s2, s3)

assert len(s1and2and3) == 0


## isdisjoint

s1 = frozenset({ 1, 2, 3, 4, 5, 6, None })
s2 = frozenset({ 2, 4, 6, 8, None })
s3 = frozenset({ 0, 10, 3 })

assert not s1.isdisjoint(s2)
assert not s1.isdisjoint(s3)
assert s2.isdisjoint(s3)


## issubset

s1 = frozenset({ 1, 2, 3, 4, 5, 6, None })
s2 = frozenset({ 2, 4, 6, 8 })
s3 = frozenset({ 0, 10, 3 })
s4 = frozenset({ 2, 6 })

assert s1.issubset(s1)
assert not s1.issubset(s2)
assert not s1.issubset(s3)
assert not s1.issubset(s4)
assert s4.issubset(s1)
assert s4.issubset(s2)
assert not s4.issubset(s3)
assert s4.issubset(s4)

## issuperset

s1 = frozenset({ 1, 2, 3, 4, 5, 6, None })
s2 = frozenset({ 2, 4, 6, 8 })
s3 = frozenset({ 0, 10, 3 })
s4 = frozenset({ 2, 6 })

assert s1.issuperset(s1)
assert not s1.issuperset(s2)
assert not s1.issuperset(s3)
assert s1.issuperset(s4)
assert not s4.issuperset(s1)
assert not s4.issuperset(s2)
assert not s4.issuperset(s3)
assert s4.issuperset(s4)


## symmetric_difference

s1 = frozenset({ 1, 2, 3, 4, 5, 6 })
s2 = frozenset({ 2, 4, 6, 8 })
s3 = frozenset({ 0, 10, 3 })
s4 = frozenset({ 2, 6 })

s1_sym_s1 = s1.symmetric_difference(s1)
s1_sym_s2 = s1.symmetric_difference(s2)
s1_sym_s3 = s1.symmetric_difference(s3)
s1_sym_s4 = s1.symmetric_difference(s4)

assert len(s1_sym_s1) == 0

assert len(s1_sym_s2) == 4
assert 1 in s1_sym_s2
assert 3 in s1_sym_s2
assert 5 in s1_sym_s2
assert 8 in s1_sym_s2

assert len(s1_sym_s3) == 7
assert 1 in s1_sym_s3
assert 2 in s1_sym_s3
assert 4 in s1_sym_s3
assert 5 in s1_sym_s3
assert 6 in s1_sym_s3
assert 0 in s1_sym_s3
assert 10 in s1_sym_s3

assert len(s1_sym_s4) == 4
assert 1 in s1_sym_s4
assert 3 in s1_sym_s4
assert 4 in s1_sym_s4
assert 5 in s1_sym_s4


## union

s1 = frozenset({ 1, 2, 3, 4, 5, 6 })
s2 = frozenset({ 2, 4, 6, 8 })
s3 = frozenset({ 0, 10, 3 })

s1_union_s2s3 = s1.union(s2, s3)

assert len(s1_union_s2s3) == 9
assert 1 in s1_union_s2s3
assert 2 in s1_union_s2s3
assert 3 in s1_union_s2s3
assert 4 in s1_union_s2s3
assert 5 in s1_union_s2s3
assert 6 in s1_union_s2s3
assert 8 in s1_union_s2s3
assert 0 in s1_union_s2s3
assert 10 in s1_union_s2s3


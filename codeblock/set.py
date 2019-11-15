# set 字面量

s = { 0, 1, 2, 3, None, None }

assert len(s) == 5
assert 0 in s
assert 1 in s
assert 2 in s
assert 3 in s
assert None in s

## add

s = { 0, 1, 2, 3 }
s.add(1)
s.add(4)
s.add(None)

assert len(s) == 6
assert 0 in s
assert 1 in s
assert 2 in s
assert 3 in s
assert 4 in s
assert None in s


## clear

s = { 0, 1, 2, 3 }

s.clear()

assert len(s) == 0
assert 1 not in s
assert 2 not in s
assert None not in s

## copy

s = { 0, 1, 2, 3 }

sc = s.copy()

sc.add(4)
sc.add(5)
sc.add(6)
sc.add(None)

assert len(s) == 4
assert len(sc) == 8

assert 4 not in s
assert 5 not in s
assert 6 not in s
assert None not in s
assert 4 in sc
assert 5 in sc
assert 6 in sc
assert None in sc


## difference

s1 = { 1, 2, 3, 4, 5, 6, None }
s2 = { 2, 4, 6, 8, None }
s3 = { 0, 10, 3 }

s1_2 = s1.difference(s2)

assert len(s1_2) == 3
assert 1 in s1_2
assert 3 in s1_2
assert 5 in s1_2

s1_2_3 = s1.difference(s2, s3)

assert len(s1_2_3) == 2
assert 1 in s1_2_3
assert 5 in s1_2_3


## difference_update

s1 = { 1, 2, 3, 4, 5, 6, None }
s2 = { 2, 4, 6, 8, None }
s3 = { 0, 10, 3 }

s1.difference_update(s2)

assert len(s1) == 3
assert 1 in s1
assert 3 in s1
assert 5 in s1

s1 = { 1, 2, 3, 4, 5, 6, None }
s1.difference_update(s2, s3)

assert len(s1) == 2
assert 1 in s1
assert 5 in s1


## discard

s = {'a', 1, 'c', 'a', 'd', None}

assert len(s) == 5

s.discard(1)
assert 1 not in s

s.discard('a')
s.discard('c')
s.discard(None)
assert 'a' not in s
assert 'c' not in s
assert None not in s


## intersection

s1 = { 1, 2, 3, 4, 5, 6, None }
s2 = { 2, 4, 6, 8, None }
s3 = { 0, 10, 3 }

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

## intersection_update

s1 = { 1, 2, 3, 4, 5, 6, None }
s2 = { 2, 4, 6, 8, None }
s3 = { 0, 10, 3 }

s1.intersection_update(s2)

assert len(s1) == 4
assert 2 in s1
assert 4 in s1
assert 6 in s1
assert None in s1
assert 1 not in s1
assert 3 not in s1
assert 5 not in s1
assert 8 not in s1

s1.intersection_update(s2, s3)

assert len(s1) == 0

## isdisjoint

s1 = { 1, 2, 3, 4, 5, 6, None }
s2 = { 2, 4, 6, 8, None}
s3 = { 0, 10, 3 }

assert not s1.isdisjoint(s2)
assert not s1.isdisjoint(s3)
assert s2.isdisjoint(s3)


## issubset

s1 = { 1, 2, 3, 4, 5, 6, None }
s2 = { 2, 4, 6, 8 }
s3 = { 0, 10, 3 }
s4 = { 2, 6 }

assert s1.issubset(s1)
assert not s1.issubset(s2)
assert not s1.issubset(s3)
assert not s1.issubset(s4)
assert s4.issubset(s1)
assert s4.issubset(s2)
assert not s4.issubset(s3)
assert s4.issubset(s4)

## issuperset

s1 = { 1, 2, 3, 4, 5, 6, None }
s2 = { 2, 4, 6, 8 }
s3 = { 0, 10, 3 }
s4 = { 2, 6 }

assert s1.issuperset(s1)
assert not s1.issuperset(s2)
assert not s1.issuperset(s3)
assert s1.issuperset(s4)
assert not s4.issuperset(s1)
assert not s4.issuperset(s2)
assert not s4.issuperset(s3)
assert s4.issuperset(s4)


## pop

s1 = { 1, 2, 3, 4, 5, 6, None }
s2 = s1.copy()

for i in range(len(s1)):
    e = s1.pop()
    assert e not in s1
    assert e in s2

assert len(s1) == 0


## remove

s = {'a', 1, 'c', None}

assert len(s) == 4
assert 'a' in s
assert 1 in s
assert 'c' in s
assert None in s

s.remove('a')
s.remove(1)

assert len(s) == 2
assert 'a' not in s
assert 1 not in s
assert 'c' in s
assert None in s

## symmetric_difference

s1 = { 1, 2, 3, 4, 5, 6 }
s2 = { 2, 4, 6, 8 }
s3 = { 0, 10, 3 }
s4 = { 2, 6 }

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

## symmetric_difference_update

s1 = { 1, 2, 3, 4, 5, 6 }
s2 = { 2, 4, 6, 8 }
s3 = { 0, 10, 3 }
s4 = { 2, 6 }

s1 = { 1, 2, 3, 4, 5, 6 }
s1.symmetric_difference_update(s1)

assert len(s1) == 0

s1 = { 1, 2, 3, 4, 5, 6 }
s1.symmetric_difference_update(s2)

assert len(s1) == 4
assert 1 in s1
assert 3 in s1
assert 5 in s1
assert 8 in s1

s1 = { 1, 2, 3, 4, 5, 6 }
s1.symmetric_difference_update(s3)

assert len(s1) == 7
assert 1 in s1
assert 2 in s1
assert 4 in s1
assert 5 in s1
assert 6 in s1
assert 0 in s1
assert 10 in s1

s1 = { 1, 2, 3, 4, 5, 6 }
s1.symmetric_difference_update(s4)

assert len(s1) == 4
assert 1 in s1
assert 3 in s1
assert 4 in s1
assert 5 in s1


## union

s1 = { 1, 2, 3, 4, 5, 6 }
s2 = { 2, 4, 6, 8 }
s3 = { 0, 10, 3 }

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

## update

s1 = { 1, 2, 3, 4, 5, 6 }
s2 = { 2, 4, 6, 8 }
s3 = { 0, 10, 3 }

s1.update(s2, s3)

assert len(s1) == 9
assert 1 in s1
assert 2 in s1
assert 3 in s1
assert 4 in s1
assert 5 in s1
assert 6 in s1
assert 8 in s1
assert 0 in s1
assert 10 in s1


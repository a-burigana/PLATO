% *** GOALS ***
goal(b(a,sb)).
goal(b(b,sc)).
goal(b(c,sa)).
formula(neg(b(a,sc))).
goal(neg(b(a,sc))).
formula(neg(b(c,sb))).
goal(neg(b(c,sb))).
formula(b(c,neg(sa))).
formula(or(b(c,sa),b(c,neg(sa)))).
formula(b(b,or(b(c,sa),b(c,neg(sa))))).
formula(neg(b(b,or(b(c,sa),b(c,neg(sa)))))).
goal(neg(b(b,or(b(c,sa),b(c,neg(sa)))))).
goal(at_a_1).
goal(at_b_1).
goal(at_c_1).

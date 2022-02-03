% *** GOALS ***
formula(b(b,at_1)).
goal(b(b,at_1)).
formula(b(c,q)).
formula(b(a,b(c,q))).
formula(b(c,b(a,b(c,q)))).
goal(b(c,b(a,b(c,q)))).
formula(b(b,q)).
formula(neg(b(b,q))).
formula(neg(q)).
formula(b(b,neg(q))).
formula(neg(b(b,neg(q)))).
formula(and(neg(b(b,q)),neg(b(b,neg(q))))).
goal(and(neg(b(b,q)),neg(b(b,neg(q))))).

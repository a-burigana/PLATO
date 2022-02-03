% *** GOALS ***
formula(neg(b(a,tail))).
formula(neg(tail)).
formula(b(a,neg(tail))).
formula(neg(b(a,neg(tail)))).
formula(and(neg(b(a,tail)),neg(b(a,neg(tail))))).
formula(b(b,and(neg(b(a,tail)),neg(b(a,neg(tail)))))).
goal(b(b,and(neg(b(a,tail)),neg(b(a,neg(tail)))))).
formula(b(c,neg(tail))).
formula(or(b(c,tail),b(c,neg(tail)))).
formula(b(a,or(b(c,tail),b(c,neg(tail))))).
formula(neg(b(a,or(b(c,tail),b(c,neg(tail)))))).
goal(neg(b(a,or(b(c,tail),b(c,neg(tail)))))).
agent_set(bc).
contains_ag(bc,b).
contains_ag(bc,c).
formula(c(bc,tail)).
goal(c(bc,tail)).

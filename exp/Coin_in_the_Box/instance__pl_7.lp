% *** GOALS ***
formula(neg(b(a,tail))).
formula(-tail).
formula(b(a,-tail)).
formula(neg(b(a,-tail))).
formula(and(neg(b(a,tail)),neg(b(a,-tail)))).
formula(b(b,and(neg(b(a,tail)),neg(b(a,-tail))))).
goal(b(b,and(neg(b(a,tail)),neg(b(a,-tail))))).
formula(b(c,b(a,tail))).
goal(b(c,b(a,tail))).
agent_set(bc).
contains_ag(bc,b).
contains_ag(bc,c).
formula(c(bc,tail)).
goal(c(bc,tail)).

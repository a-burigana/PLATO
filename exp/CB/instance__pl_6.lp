% *** GOALS ***
agent_set(bc).
contains_ag(bc,b).
contains_ag(bc,c).

goal(box(b,and(neg(box(a,tail)),neg(box(a,neg(tail)))))).
goal(neg(box(a,or(box(c,tail),box(c,neg(tail)))))).
goal(c(bc,tail)).

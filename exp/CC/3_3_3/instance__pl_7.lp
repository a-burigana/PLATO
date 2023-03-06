% *** GOALS ***
goal(box(b,at_b1_1)).
goal(box(b,at_b2_3)).
agent_set(ab).
contains_ag(ab,a).
contains_ag(ab,b).
goal(c(ab,at_b2_3)).
goal(box(a,at_b1_1)).
goal(box(a,neg(and(box(b,at_b1_1),neg(box(b,neg(at_b1_1))))))).
goal(box(a,at_a_2)).
goal(box(b,at_a_2)).

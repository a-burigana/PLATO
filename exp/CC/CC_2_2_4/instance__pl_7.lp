% *** GOALS ***
goal(b(b,at_b1_1)).
goal(b(b,at_b2_3)).
goal(b(a,at_b2_3)).
formula(neg(at_b2_3)).
formula(b(b,neg(at_b2_3))).
formula(neg(b(b,neg(at_b2_3)))).
formula(neg(b(b,at_b2_3))).
formula(and(neg(b(b,at_b2_3)),neg(b(b,neg(at_b2_3))))).
formula(b(a,and(neg(b(b,at_b2_3)),neg(b(b,neg(at_b2_3)))))).
goal(b(a,and(neg(b(b,at_b2_3)),neg(b(b,neg(at_b2_3)))))).
goal(b(a,at_a_3)).
formula(b(b,at_a_3)).
goal(b(b,at_a_3)).

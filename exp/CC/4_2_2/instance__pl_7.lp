% *** GOALS ***
% goal(neg(dia(b,neg(at_box1_room1)))).
% goal(neg(dia(b,neg(at_box2_room3)))).
% goal(neg(dia(a,neg(at_box2_room3)))).
% goal(box(a,and(neg(neg(dia(b,neg(at_box2_room3)))),neg(box(b,neg(at_box2_room3)))))).
% goal(neg(dia(a,neg(at_a_room3)))).
% goal(neg(dia(b,neg(at_a_room3)))).

goal(neg(dia(b,neg(at_box1_room1)))).
goal(neg(dia(a,neg(at_box3_room3)))).
goal(at_a_room3).
goal(at_b_room2).

goal(neg(dia(AG, neg(at_box2_room3)))) :- agent(AG).
goal(neg(dia(AG1, dia(AG2,neg(at_box2_room3)) ))) :- agent(AG1), agent(AG2), AG1 != AG2.

% Solution: plan(1,right_a). plan(2,left_b). plan(3,b_check_b1_1). plan(4,a_check_b2_3). plan(5,tell_a_b2_3). plan(6,a_check_b3_3).

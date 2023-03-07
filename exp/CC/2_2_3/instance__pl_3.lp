
#program base.
% *** GOALS ***
% goal(c(all_agents,at_box1_room1)).

goal(neg(dia(AG, neg(at_box1_room1)))) :- agent(AG).
goal(neg(dia(AG1, dia(AG2,neg(at_box1_room1)) ))) :- agent(AG1), agent(AG2), AG1 != AG2.
% goal(neg(dia(AG1, dia(AG2, dia(AG3,neg(at_box1_room1)) )) )) :- agent(AG1), agent(AG2), agent(AG3), AG1 != AG2, AG1 != AG3, AG2 != AG3.

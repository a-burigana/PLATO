% *** GOALS ***
formula(c(all_agents,at_b1_1)).
goal(c(all_agents,at_b1_1)).

#program step(t).
goal(t) :- dw(t, W, Ew, Hw), not -goal(t).
-goal(t) :- dw(t, W, Ew, Hw), w(Tv, V, Ev, Hv), reaches(t, W, Ew, Hw, Tv, V, Ev, Hv, all_agents), holds(Tv, V, Ev, Hv, -at_b1_1).

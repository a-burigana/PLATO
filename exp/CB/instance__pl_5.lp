#program check(t).

goal(t) :- dw(t, Hw), not -goal(t).
-goal(t) :- dw(t, Hw), w(Tv, Hv), reaches(t, Hw, Tv, Hv, all_agents), holds(Tv, Hv, -tail).

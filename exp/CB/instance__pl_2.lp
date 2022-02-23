% *** GOALS ***
#program step(t).

goal(t) :- dw(t, Hw), not -goal(t).
-goal(t) :- dw(t, Hw), w(Tv, Hv), r(t, Hw, Tv, Hv, a), holds(Tv, Hv, -tail).

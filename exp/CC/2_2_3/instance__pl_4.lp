% *** GOALS ***
goal(b(b,at_b2_3)).
goal(b(a,at_b1_1)).

#program step(t).
goal(t) :- dw(t, W, Ew, Hw), not -goal(t).
-goal(t) :- dw(t, W, Ew, Hw), w(Tv, V, Ev, Hv), r(t, W, Ew, Hw, Tv, V, Ev, Hv, b), holds(Tv, V, Ev, Hv, -at_b2_3).
-goal(t) :- dw(t, W, Ew, Hw), w(Tv, V, Ev, Hv), r(t, W, Ew, Hw, Tv, V, Ev, Hv, a), holds(Tv, V, Ev, Hv, -at_b1_1).

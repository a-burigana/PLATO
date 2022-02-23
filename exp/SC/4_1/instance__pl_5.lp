% *** GOALS ***
#program step(t).

goal(t)  :- dw(t, W), w(Tv, V), r(t, W, Tv, V, b), holds(Tv, V, -q), not -goal(t).
-goal(t) :- dw(t, W), w(Tv, V), r(t, W, Tv, V, c), holds(Tv, V, -q).

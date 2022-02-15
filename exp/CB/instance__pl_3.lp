% *** GOALS ***
#program step(t).

goal(t) :- dw(t, W, Ew, Hw), not -goal(t).
-goal(t) :- dw(t, W, Ew, Hw), w(Tv, V, Ev, Hv), r(t, W, Ew, Hw, Tv, V, Ev, Hv, b), not holds(Tv, V, Ev, Hv, tail).

% goal(b(b,tail)).

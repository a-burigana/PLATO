% *** GOALS ***
formula(b(c,q)).
goal(b(c,q)).
formula(b(b,q)).
formula(neg(b(b,q))).
goal(neg(b(b,q))).

#program step(t).

goal(t) :- dw(t, W, Ew, Hw), w(Tv, V, Ev, Hv), r(t, W, Ew, Hw, Tv, V, Ev, Hv, b), not holds(Tv, V, Ev, Hv, q), not -goal(t).
-goal(t) :- dw(t, W, Ew, Hw), w(Tv, V, Ev, Hv), r(t, W, Ew, Hw, Tv, V, Ev, Hv, c), not holds(Tv, V, Ev, Hv, q).

% *** GOALS ***
goal(box(b,at_b2_3)).
goal(box(a,at_b1_1)).

#program step(t).
goal(t) :- dw(t, W, Ew, Hw), not neg(goal)(t).
neg(goal)(t) :- dw(t, W, Ew, Hw), w(Tv, V, Ev, Hv), r(t, W, Ew, Hw, Tv, V, Ev, Hv, b), holds(Tv, V, Ev, Hv, neg(at_b2_3)).
neg(goal)(t) :- dw(t, W, Ew, Hw), w(Tv, V, Ev, Hv), r(t, W, Ew, Hw, Tv, V, Ev, Hv, a), holds(Tv, V, Ev, Hv, neg(at_b1_1)).

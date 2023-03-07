% *** GOALS ***
goal(box(b,at_box2_room3)).
goal(box(a,at_box1_room1)).

#program step(t).
goal(t) :- dw(t, W, Ew, Hw), not neg(goal)(t).
neg(goal)(t) :- dw(t, W, Ew, Hw), w(Tv, V, Ev, Hv), r(t, W, Ew, Hw, Tv, V, Ev, Hv, b), holds(Tv, V, Ev, Hv, neg(at_box2_room3)).
neg(goal)(t) :- dw(t, W, Ew, Hw), w(Tv, V, Ev, Hv), r(t, W, Ew, Hw, Tv, V, Ev, Hv, a), holds(Tv, V, Ev, Hv, neg(at_box1_room1)).

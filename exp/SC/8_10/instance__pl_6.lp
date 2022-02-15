% *** GOALS ***
goal(b(a,q)).
% formula(b(e,b(a,q))).
goal(b(e,b(a,q))).
% formula(b(f,b(a,q))).
goal(b(f,b(a,q))).
% formula(b(g,b(a,q))).
goal(b(g,b(a,q))).
% formula(b(h,b(a,q))).
goal(b(h,b(a,q))).

#program step(t).

goal(t) :- dw(t, W, Ew, Hw), not -goal(t).

-goal(t) :- dw(t, W, Ew, Hw), w(Tv, V, Ev, Hv), r(t, W, Ew, Hw, Tv, V, Ev, Hv, a), not holds(Tv, V, Ev, Hv, q).

-goal(t) :- dw(t, W, Ew, Hw), w(Tv, V, Ev, Hv), w(Tu, U, Eu, Hu), not holds(Tu, U, Eu, Hu, q),
            r(t, W, Ew, Hw, Tv, V, Ev, Hv, e), r(Tv, V, Ev, Hv, Tu, U, Eu, Hu, a).

-goal(t) :- dw(t, W, Ew, Hw), w(Tv, V, Ev, Hv), w(Tu, U, Eu, Hu), not holds(Tu, U, Eu, Hu, q),
            r(t, W, Ew, Hw, Tv, V, Ev, Hv, f), r(Tv, V, Ev, Hv, Tu, U, Eu, Hu, a).

-goal(t) :- dw(t, W, Ew, Hw), w(Tv, V, Ev, Hv), w(Tu, U, Eu, Hu), not holds(Tu, U, Eu, Hu, q),
            r(t, W, Ew, Hw, Tv, V, Ev, Hv, g), r(Tv, V, Ev, Hv, Tu, U, Eu, Hu, a).

-goal(t) :- dw(t, W, Ew, Hw), w(Tv, V, Ev, Hv), w(Tu, U, Eu, Hu), not holds(Tu, U, Eu, Hu, q),
            r(t, W, Ew, Hw, Tv, V, Ev, Hv, h), r(Tv, V, Ev, Hv, Tu, U, Eu, Hu, a).

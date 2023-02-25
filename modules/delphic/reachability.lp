% ********** REACHABILITY **********

#program step(t).

reaches(t , W, Ew,
        Tv, V, Ev, AGS) :- r(t, W, Ew, Tv, V, Ev, AG), contains_ag(AGS, AG), Tv <= t.

reaches(t , W, Ew,
        Tv, V, Ev, AGS) :- reaches(t, W, Ew, Tx, X, Ex, AGS), r(Tx, X, Ex, Tv, V, AG),
                           contains_ag(AGS, AG), Tv <= Tx, Tx <= t.

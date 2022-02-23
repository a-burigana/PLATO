% ********** REACHABILITY **********

#program step(t).

reaches(t , W,
        Tv, V, AGS) :- w(t, W), contains_ag(AGS, AG), r(t, W, Tv, V, AG), time(Tv), Tv <= t.

reaches(t , W,
        Tv, V, AGS) :- w(t, W), reaches(t, W, Tu, U, AGS), time(Tu), Tu <= t,
                       contains_ag(AGS, AG), r(Tu, U, Tv, V, AG), time(Tv), Tv <= Tu.

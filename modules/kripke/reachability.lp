% ********** REACHABILITY **********

#program step(t).

reaches(t, W, V, AGS) :- w(t, W), contains_ag(AGS, AG), r(t, W, V, AG).

reaches(t, W, V, AGS) :- w(t, W), reaches(t, W, U, AGS),
                         contains_ag(AGS, AG), r(t, U, V, AG).

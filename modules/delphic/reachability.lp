% ********** REACHABILITY **********

#program step(t).

reaches(t , W, Ew, Hw,
        Tv, V, Ev, Hv, AGS) :-
                               w(t, W, Ew, Hw),
                               contains_ag(AGS, AG),
                               r(t, W, Ew, Hw, Tv, V, Ev, Hv, AG),
                            %    w(Tv, V, Ev, Hv),
                               time(Tv), Tv <= t.
                               %* check_on_w(t, W, Ew, Hw, c(AGS, F)), *% % formula(c(AGS, F)), formula(F),

reaches(t , W, Ew, Hw,
        Tv, V, Ev, Hv, AGS) :- 
                              w(t, W, Ew, Hw),
                              reaches(t, W, Ew, Hw, Tu, U, Eu, Hu, AGS),
                              time(Tu), Tu <= t,
                            %   w(Tu, U, Eu, Hu),
                              contains_ag(AGS, AG),
                              r(Tu, U, Eu, Hu, Tv, V, Ev, Hv, AG),
                              time(Tv), Tv <= Tu.
                            %   w(Tv, V, Ev, Hv).
                              %* check_on_w(t, W, Ew, Hw, c(AGS, F)), *%
                              % formula(c(AGS, F)), formula(F),

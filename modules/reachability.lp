% ********** REACHABILITY **********

#program step(t).

reaches(t , W, Ew, Hw,
        Tv, V, Ev, Hv, AGS) :- time(t), time(Tv), Tv <= t, formula(c(AGS, F)), formula(F),
                               dw(t, W, Ew, Hw), w(t, W, Ew, Hw), w(Tv, V, Ev, Hv),
                               r(t, W, Ew, Hw, Tv, V, Ev, Hv, AG), agent(AG), agent_set(AGS), contains_ag(AGS, AG).

reaches(t , W, Ew, Hw,
        Tv, V, Ev, Hv, AGS) :- time(t), time(Tv), time(Tu), Tv <= t, Tu <= Tv, formula(c(AGS, F)), formula(F),
                               w(t, W, Ew, Hw), w(Tv, V, Ev, Hv), w(Tu, U, Eu, Hu),
                               r(t, W, Ew, Hw, Tu, U, Eu, Hu, AG), reaches(Tu, U, Eu, Hu, Tv, V, Ev, Hv, AGS),
                               agent(AG), agent_set(AGS), contains_ag(AGS, AG).

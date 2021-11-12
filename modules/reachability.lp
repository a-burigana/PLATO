% ********** REACHABILITY **********

#program step(t).

reaches(t , W, Ew, Hw,
        Tv, V, Ev, Hv, AGS) :- time(t), time(Tv), Tv <= t, formula(c(AGS, F)), formula(F),
                               w(t, W, Ew, Hw), w(Tv, V, Ev, Hv), check_on_w(t, t, W, Ew, Hw, c(AGS, F)),
                               r(t, W, Ew, Hw, Tv, V, Ev, Hv, AG), agent(AG), agent_set(AGS), contains_ag(AGS, AG).

reaches(t , W, Ew, Hw,
        Tv, V, Ev, Hv, AGS) :- time(t), time(Tu), time(Tv), Tv <= Tu, Tu <= t, formula(c(AGS, F)), formula(F),
                               w(t, W, Ew, Hw), w(Tv, V, Ev, Hv), w(Tu, U, Eu, Hu), check_on_w(t, t, W, Ew, Hw, c(AGS, F)),
                               reaches(t, W, Ew, Hw, Tu, U, Eu, Hu, AGS), r(Tu, U, Eu, Hu, Tv, V, Ev, Hv, AG),
                               agent(AG), agent_set(AGS), contains_ag(AGS, AG).

% ********** REACHABILITY **********

#program step(t).

reaches(t, W, Ew, Hw,
        t, V, Ev, Hv, AGS) :- time(t),formula(c(AGS, F)), formula(F),
                              w(t, W, Ew, Hw), w(t, V, Ev, Hv), check_on_w(t, W, Ew, Hw, c(AGS, F)),
                              r(t, W, Ew, Hw, t, V, Ev, Hv, AG), agent(AG), agent_set(AGS), contains_ag(AGS, AG).

reaches(t, W, Ew, Hw,
        t, V, Ev, Hv, AGS) :- time(t), formula(c(AGS, F)), formula(F),
                              w(t, W, Ew, Hw), w(t, V, Ev, Hv), w(t, U, Eu, Hu), check_on_w(t, W, Ew, Hw, c(AGS, F)),
                              reaches(t, W, Ew, Hw, t, U, Eu, Hu, AGS), r(t, U, Eu, Hu, t, V, Ev, Hv, AG),
                              agent(AG), agent_set(AGS), contains_ag(AGS, AG).

% ********** REACHABILITY **********

#program step(t).

reaches(w(t , W, Ew),
        w(Tv, V, Ev), AGS) :- time(t), time(Tv), Tv <= t, formula(c(AGS, F)), formula(F), dw(t, W, Ew), w(t, W, Ew), w(Tv, V, Ev),
                              r(w(t, W, Ew), w(Tv, V, Ev), AG), agent(AG), agent_set(AGS), contains_ag(AGS, AG).

reaches(w(t , W, Ew),
        w(Tv, V, Ev), AGS) :- time(t), time(Tv), time(Tu), Tv <= t, Tu <= Tv, formula(c(AGS, F)), formula(F), w(t, W, Ew), w(Tv, V, Ev), w(Tu, U, Eu),
                              r(w(t, W, Ew), w(Tu, U, Eu), AG), reaches(w(Tu, U, Eu), w(Tv, V, Ev), AGS),
                              agent(AG), agent_set(AGS), contains_ag(AGS, AG).

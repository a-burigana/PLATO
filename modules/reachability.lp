% ********** REACHABILITY **********

#program base.

reaches(w(0, W, __ini),
        w(0, V, __ini), AGS) :- formula(c(AGS, F)), formula(F), dw(0, W, __ini),
                                r(w(0, W, __ini), w(0, V, __ini), AG), agent(AG), agent_set(AGS), contains_ag(AGS, AG).

reaches(w(0, W, __ini),
        w(0, V, __ini), AGS) :- formula(c(AGS, F)), formula(F), w(0, U, __ini),
                                r(w(0, W, __ini), w(0, U, __ini), AG), reaches(w(0, U, __ini), w(0, V, __ini), AGS),
                                agent(AG), agent_set(AGS), contains_ag(AGS, AG).


#program step(t).

reaches(w(t, W, Ew),
        w(t, V, Ev), AGS) :- time(t), formula(c(AGS, F)), formula(F), dw(t, W, Ew),
                             r(w(t, W, Ew), w(t, V, Ev), AG), agent(AG), agent_set(AGS), contains_ag(AGS, AG).

reaches(w(t, W, Ew),
        w(t, V, Ev), AGS) :- time(t), formula(c(AGS, F)), formula(F), w(t, U, Eu),
                             r(w(t, W, Ew), w(t, U, Eu), AG), reaches(w(t, U, Eu), w(t, V, Ev), AGS),
                             agent(AG), agent_set(AGS), contains_ag(AGS, AG).

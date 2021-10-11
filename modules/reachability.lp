% ********** REACHABILITY **********

#program base.

reaches(pw(0, W, __ini),
        pw(0, V, __ini), AGS) :- formula(c(AGS, F)), formula(F), check_everywere(c(AGS, F)),
                                 r(pw(0, W, __ini), pw(0, V, __ini), AG), agent(AG), agent_set(AGS), contains_ag(AGS, AG).

reaches(pw(0, W, __ini),
        pw(0, V, __ini), AGS) :- formula(c(AGS, F)), formula(F), check_on_pointed(c(AGS, F)), dw(0, W, __ini),
                                 r(pw(0, W, __ini), pw(0, V, __ini), AG), agent(AG), agent_set(AGS), contains_ag(AGS, AG).

reaches(pw(0, W, __ini),
        pw(0, V, __ini), AGS) :- formula(c(AGS, F)), formula(F), pw(0, U, __ini),
                                 r(pw(0, W, __ini), pw(0, U, __ini), AG), reaches(pw(0, U, __ini), pw(0, V, __ini), AGS),
                                 agent(AG), agent_set(AGS), contains_ag(AGS, AG).


#program step(t).

% reaches/7: P1 reaches P2 with a path that contains only agents inside AGS
reaches(pw(t, W, Ew),
        pw(t, V, Ev), AGS) :- time(t), formula(c(AGS, F)), formula(F), check_everywere(c(AGS, F)),
                              r(pw(t, W, Ew), pw(t, V, Ev), AG), agent(AG), agent_set(AGS), contains_ag(AGS, AG).

reaches(pw(t, W, Ew),
        pw(t, V, Ev), AGS) :- time(t), formula(c(AGS, F)), formula(F), check_on_pointed(c(AGS, F)), dw(t, W, Ew),
                              r(pw(t, W, Ew), pw(t, V, Ev), AG), agent(AG), agent_set(AGS), contains_ag(AGS, AG).

reaches(pw(t, W, Ew),
        pw(t, V, Ev), AGS) :- time(t), formula(c(AGS, F)), formula(F), pw(t, U, Eu),
                              r(pw(t, W, Ew), pw(t, U, Eu), AG), reaches(pw(t, U, Eu), pw(t, V, Ev), AGS),
                              agent(AG), agent_set(AGS), contains_ag(AGS, AG).

% ********** REACHABILITY **********

#program base.

reaches(0, 0, P1, 0, 0, P2, AGS) :- possible_world(0, 0, P1), possible_world(0, 0, P2), formula(c(AGS, F)), formula(F), check_everywere(c(AGS, F)),
                                    believes(0, 0, P1, 0, 0, P2, AG), agent(AG), agent_set(AGS), contains_ag(AGS, AG).

reaches(0, 0, P1, 0, 0, P2, AGS) :- possible_world(0, 0, P1), possible_world(0, 0, P2), pointed(0, 0, P1), formula(c(AGS, F)), formula(F), check_on_pointed(c(AGS, F)),
                                    believes(0, 0, P1, 0, 0, P2, AG), agent(AG), agent_set(AGS), contains_ag(AGS, AG).

reaches(0, 0, P1, 0, 0, P2, AGS) :- possible_world(0, 0, P1), possible_world(0, 0, P2), possible_world(0, 0, P3), formula(c(AGS, F)), formula(F),
                                    believes(0, 0, P1, 0, 0, P3, AG), reaches(0, 0, P3, 0, 0, P2, AGS), agent(AG), agent_set(AGS), contains_ag(AGS, AG).


#program step(t).

% reaches/7: P1 reaches P2 with a path that contains only agents inside AGS
reaches(t, R1, P1, T2, R2, P2, AGS) :- time(t), time(T2), T2 <= t, possible_world(t, R1, P1), possible_world(T2, R2, P2),
                                       formula(c(AGS, F)), formula(F), check_everywere(c(AGS, F)),
                                       believes(t, R1, P1, T2, R2, P2, AG), agent(AG), agent_set(AGS), contains_ag(AGS, AG).

reaches(t, R1, P1, T2, R2, P2, AGS) :- time(t), time(T2), T2 <= t, possible_world(t, R1, P1), possible_world(T2, R2, P2), pointed(t, R1, P1),
                                       formula(c(AGS, F)), formula(F), check_on_pointed(c(AGS, F)),
                                       believes(t, R1, P1, T2, R2, P2, AG), agent(AG), agent_set(AGS), contains_ag(AGS, AG).

reaches(t, R1, P1, T2, R2, P2, AGS) :- time(t), time(T2), time(T3), T3 <= t, T2 <= T3, possible_world(t, R1, P1), possible_world(T2, R2, P2), possible_world(T3, R3, P3),
                                       formula(c(AGS, F)), formula(F), agent(AG), agent_set(AGS), contains_ag(AGS, AG), 
                                       believes(t, R1, P1, T3, R3, P3, AG), reaches(T3, R3, P3, T2, R2, P2, AGS).


reaches_no_oblivious(t, T2, R2, P2) :- t > 0, time(t), time(T2), T2 <= t, pointed(t-1, R, P), possible_world(T2, R2, P2),
                                       believes(t-1, R, P, T2, R2, P2, AG), not is_oblivious(t, AG).

reaches_no_oblivious(t, T2, R2, P2) :- t > 0, time(t), time(T1), time(T2), T1 <= t, T2 <= t, possible_world(T1, R1, P1), possible_world(T2, R2, P2),
                                       reaches_no_oblivious(t, T1, R1, P1), believes(T1, R1, P1, T2, R2, P2, AG), not is_oblivious(t, AG).

reaches_only_fully_obs(t, T2, R2, P2) :- t > 0, time(t), time(T2), T2 <= t, pointed(t-1, R, P), possible_world(T2, R2, P2),
                                         believes(t-1, R, P, T2, R2, P2, AG), is_fully_obs(t, AG).

reaches_only_fully_obs(t, T2, R2, P2) :- t > 0, time(t), time(T1), time(T2), T1 <= t, T2 <= t, possible_world(T1, R1, P1), possible_world(T2, R2, P2),
                                         reaches_only_fully_obs(t, T1, R1, P1), believes(T1, R1, P1, T2, R2, P2, AG), is_fully_obs(t, AG).

reaches_first_partially_obs(t, T2, R2, P2) :- t > 0, time(t),time(T2), T2 <= t, pointed(t-1, R, P), possible_world(T2, R2, P2),
                                              believes(t-1, R, P, T2, R2, P2, AG), is_partial_obs(t, AG).

reaches_first_partially_obs(t, T2, R2, P2) :- t > 0, time(t), time(T1), time(T2), T1 <= t, T2 <= t, possible_world(T1, R1, P1), possible_world(T2, R2, P2),
                                              reaches_first_partially_obs(t, T1, R1, P1), believes(T1, R1, P1, T2, R2, P2, AG), not is_oblivious(t, AG).

% ********** ENTAILMENT **********

#program step(t).

entails(w(t-1, W, E),  P)          :-     holds(w(t-1, W, E), P),                               w(t-1, W, E), check_on_w(w(t-1, W, E),  P),          atom(P).
entails(w(t-1, W, E), -P)          :- not holds(w(t-1, W, E), P),                               w(t-1, W, E), check_on_w(w(t-1, W, E), -P),          atom(P).

entails(w(t-1, W, E), neg(F))      :- not entails(w(t-1, W, E), F ),                            w(t-1, W, E), check_on_w(w(t-1, W, E), neg(F)),      formula(neg(F)),      formula(F).
entails(w(t-1, W, E), and(F1, F2)) :-     entails(w(t-1, W, E), F1), entails(w(t-1, W, E), F2), w(t-1, W, E), check_on_w(w(t-1, W, E), and(F1, F2)), formula(and(F1, F2)), formula(F1), formula(F2).
entails(w(t-1, W, E),  or(F1, F2)) :-     entails(w(t-1, W, E), F1),                            w(t-1, W, E), check_on_w(w(t-1, W, E),  or(F1, F2)), formula( or(F1, F2)), formula(F1), formula(F2).
entails(w(t-1, W, E),  or(F1, F2)) :-                                entails(w(t-1, W, E), F2), w(t-1, W, E), check_on_w(w(t-1, W, E),  or(F1, F2)), formula( or(F1, F2)), formula(F1), formula(F2).

entails(w(t-1, W, E),   b(AG , F)) :- not not_entails(w(t-1, W, E), b(AG , F)),                 w(t-1, W, E), check_on_w(w(t-1, W, E), b(AG , F)),   formula(  b(AG , F)), formula(F), agent(AG).
entails(w(t-1, W, E),   c(AGS, F)) :- not not_entails(w(t-1, W, E), c(AGS, F)),                 w(t-1, W, E), check_on_w(w(t-1, W, E), c(AGS, F)),   formula(  c(AGS, F)), formula(F), agent_set(AGS).

not_entails(w(t-1, W1, E1), b(AG , F)) :- not entails(w(t-1, W2, E2), F), w(t-1, W1, E1), w(t-1, W2, E2), 
                                          check_on_w(w(t-1, W1, E1), b(AG , F)), check_on_w(w(t-1, W2, E2), F),
                                          r(w(t-1, W1, E1), w(t-1, W2, E2), AG), formula(b(AG , F)), formula(F), agent(AG).

not_entails(w(t-1, W1, E1), c(AGS, F)) :- not entails(w(t-1, W2, E2), F), w(t-1, W1, E1), w(t-1, W2, E2),
                                          check_on_w(w(t-1, W1, E1), c(AGS, F)), check_on_w(w(t-1, W2, E2), F),
                                          reaches(w(t-1, W1, E1), w(t-1, W2, E2), AGS), formula(c(AGS, F)), formula(F), agent_set(AGS).

#program check(t).

entails_goal(w(t, W, E),  P)          :-     holds(w(t, W, E), P),                                       w(t, W, E), check_on_w_goal(w(t, W, E),  P),          atom(P).
entails_goal(w(t, W, E), -P)          :- not holds(w(t, W, E), P),                                       w(t, W, E), check_on_w_goal(w(t, W, E), -P),          atom(P).

entails_goal(w(t, W, E), neg(F))      :- not entails_goal(w(t, W, E), F ),                               w(t, W, E), check_on_w_goal(w(t, W, E), neg(F)),      formula(neg(F)),      formula(F).
entails_goal(w(t, W, E), and(F1, F2)) :-     entails_goal(w(t, W, E), F1), entails_goal(w(t, W, E), F2), w(t, W, E), check_on_w_goal(w(t, W, E), and(F1, F2)), formula(and(F1, F2)), formula(F1), formula(F2).
entails_goal(w(t, W, E),  or(F1, F2)) :-     entails_goal(w(t, W, E), F1),                               w(t, W, E), check_on_w_goal(w(t, W, E),  or(F1, F2)), formula( or(F1, F2)), formula(F1), formula(F2).
entails_goal(w(t, W, E),  or(F1, F2)) :-                                   entails_goal(w(t, W, E), F2), w(t, W, E), check_on_w_goal(w(t, W, E),  or(F1, F2)), formula( or(F1, F2)), formula(F1), formula(F2).

entails_goal(w(t, W, E),   b(AG , F)) :- not not_entails_goal(w(t, W, E), b(AG , F)),                    w(t, W, E), check_on_w_goal(w(t, W, E), b(AG , F)),   formula(  b(AG , F)), formula(F), agent(AG).
entails_goal(w(t, W, E),   c(AGS, F)) :- not not_entails_goal(w(t, W, E), c(AGS, F)),                    w(t, W, E), check_on_w_goal(w(t, W, E), c(AGS, F)),   formula(  c(AGS, F)), formula(F), agent_set(AGS).

not_entails_goal(w(t, W1, E1), b(AG , F)) :- not entails_goal(w(t, W2, E2), F), w(t, W1, E1), w(t, W2, E2),
                                             check_on_w_goal(w(t, W1, E1), b(AG , F)), check_on_w_goal(w(t, W2, E2), F),
                                             r(w(t, W1, E1), w(t, W2, E2), AG), formula(b(AG , F)), formula(F), agent(AG).

not_entails_goal(w(t, W1, E1), c(AGS, F)) :- not entails_goal(w(t, W2, E2), F), w(t, W1, E1), w(t, W2, E2),
                                             check_on_w_goal(w(t, W1, E1), c(AGS, F)), check_on_w_goal(w(t, W2, E2), F),
                                             reaches(w(t, W1, E1), w(t, W2, E2), AGS), formula(c(AGS, F)), formula(F), agent_set(AGS).

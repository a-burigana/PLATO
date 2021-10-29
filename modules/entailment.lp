% ********** ENTAILMENT **********

#program step(t).

entails(w(t, W, E),  P)          :- time(t),     holds(w(t, W, E), P),                             w(t, W, E), check_on_w(w(t, W, E),  P),          atom(P).
entails(w(t, W, E), -P)          :- time(t), not holds(w(t, W, E), P),                             w(t, W, E), check_on_w(w(t, W, E), -P),          atom(P).

entails(w(t, W, E), neg(F))      :- time(t), not entails(w(t, W, E), F ),                          w(t, W, E), check_on_w(w(t, W, E), neg(F)),      check_on_w(w(t, W, E), F ),                             formula(neg(F)),      formula(F).
entails(w(t, W, E), and(F1, F2)) :- time(t),     entails(w(t, W, E), F1), entails(w(t, W, E), F2), w(t, W, E), check_on_w(w(t, W, E), and(F1, F2)), check_on_w(w(t, W, E), F1), check_on_w(w(t, W, E), F2), formula(and(F1, F2)), formula(F1), formula(F2).
entails(w(t, W, E),  or(F1, F2)) :- time(t),     entails(w(t, W, E), F1),                          w(t, W, E), check_on_w(w(t, W, E),  or(F1, F2)), check_on_w(w(t, W, E), F1), check_on_w(w(t, W, E), F2), formula( or(F1, F2)), formula(F1), formula(F2).
entails(w(t, W, E),  or(F1, F2)) :- time(t),                              entails(w(t, W, E), F2), w(t, W, E), check_on_w(w(t, W, E),  or(F1, F2)), check_on_w(w(t, W, E), F1), check_on_w(w(t, W, E), F2), formula( or(F1, F2)), formula(F1), formula(F2).

entails(w(t, W, E),   b(AG , F)) :- time(t), not not_entails(w(t, W, E), b(AG , F)),               w(t, W, E), check_on_w(w(t, W, E), b(AG , F)),   formula(  b(AG , F)), formula(F), agent(AG).
entails(w(t, W, E),   c(AGS, F)) :- time(t), not not_entails(w(t, W, E), c(AGS, F)),               w(t, W, E), check_on_w(w(t, W, E), c(AGS, F)),   formula(  c(AGS, F)), formula(F), agent_set(AGS).

not_entails(w(t, W1, E1), b(AG , F)) :- time(t), time(T), T <= t, not entails(w(T, W2, E2), F), w(t, W1, E1), w(T, W2, E2), 
                                        check_on_w(w(t, W1, E1), b(AG , F)), check_on_w(w(T, W2, E2), F),
                                        r(w(t, W1, E1), w(T, W2, E2), AG), formula(b(AG , F)), formula(F), agent(AG).

not_entails(w(t, W1, E1), c(AGS, F)) :- time(t), time(T), T <= t, not entails(w(T, W2, E2), F), w(t, W1, E1), w(T, W2, E2),
                                        check_on_w(w(t, W1, E1), c(AGS, F)), check_on_w(w(T, W2, E2), F),
                                        reaches(w(t, W1, E1), w(T, W2, E2), AGS), formula(c(AGS, F)), formula(F), agent_set(AGS).

:- entails(w(t, W, E), and(F1, F2)), not entails(w(t, W, E), F1), time(t), w(t, W, E), check_on_w(w(t, W, E), and(F1, F2)), check_on_w(w(t, W, E), F1), check_on_w(w(t, W, E), F2), formula(and(F1, F2)), formula(F1), formula(F2).
:- entails(w(t, W, E), and(F1, F2)), not entails(w(t, W, E), F2), time(t), w(t, W, E), check_on_w(w(t, W, E), and(F1, F2)), check_on_w(w(t, W, E), F1), check_on_w(w(t, W, E), F2), formula(and(F1, F2)), formula(F1), formula(F2).

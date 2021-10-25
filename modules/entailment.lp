% ********** ENTAILMENT **********

#program step(t).

entails(w(t, W, E),  P)          :-     holds(w(t, W, E), P),                               w(t, W, E), check_on_w(w(t, W, E),  P),          atom(P).
entails(w(t, W, E), -P)          :- not holds(w(t, W, E), P),                               w(t, W, E), check_on_w(w(t, W, E), -P),          atom(P).

entails(w(t, W, E), neg(F))      :- not entails(w(t, W, E), F ),                            w(t, W, E), check_on_w(w(t, W, E), neg(F)),      formula(neg(F)),      formula(F).
entails(w(t, W, E), and(F1, F2)) :-     entails(w(t, W, E), F1), entails(w(t, W, E), F2), w(t, W, E), check_on_w(w(t, W, E), and(F1, F2)), formula(and(F1, F2)), formula(F1), formula(F2).
entails(w(t, W, E),  or(F1, F2)) :-     entails(w(t, W, E), F1),                            w(t, W, E), check_on_w(w(t, W, E),  or(F1, F2)), formula( or(F1, F2)), formula(F1), formula(F2).
entails(w(t, W, E),  or(F1, F2)) :-                                entails(w(t, W, E), F2), w(t, W, E), check_on_w(w(t, W, E),  or(F1, F2)), formula( or(F1, F2)), formula(F1), formula(F2).

entails(w(t, W, E),   b(AG , F)) :- not not_entails(w(t, W, E), b(AG , F)),                 w(t, W, E), check_on_w(w(t, W, E), b(AG , F)),   formula(  b(AG , F)), formula(F), agent(AG).
entails(w(t, W, E),   c(AGS, F)) :- not not_entails(w(t, W, E), c(AGS, F)),                 w(t, W, E), check_on_w(w(t, W, E), c(AGS, F)),   formula(  c(AGS, F)), formula(F), agent_set(AGS).

not_entails(w(t, W1, E1), b(AG , F)) :- not entails(w(t, W2, E2), F), w(t, W1, E1), w(t, W2, E2), 
                                        check_on_w(w(t, W1, E1), b(AG , F)), check_on_w(w(t, W2, E2), F),
                                        r(w(t, W1, E1), w(t, W2, E2), AG), formula(b(AG , F)), formula(F), agent(AG).

not_entails(w(t, W1, E1), c(AGS, F)) :- not entails(w(t, W2, E2), F), w(t, W1, E1), w(t, W2, E2),
                                        check_on_w(w(t, W1, E1), c(AGS, F)), check_on_w(w(t, W2, E2), F),
                                        reaches(w(t, W1, E1), w(t, W2, E2), AGS), formula(c(AGS, F)), formula(F), agent_set(AGS).

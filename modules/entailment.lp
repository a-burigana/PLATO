% ********** ENTAILMENT **********

#program step(t).

entails(t, Tw, W, Ew, Hw,  P)          :- time(t), time(Tw), Tw <= t,     holds(Tw, W, Ew, Hw, P),                                      w(Tw, W, Ew, Hw), check_on_w(t, Tw, W, Ew, Hw,  P),          atom(P).
entails(t, Tw, W, Ew, Hw, -P)          :- time(t), time(Tw), Tw <= t, not holds(Tw, W, Ew, Hw, P),                                      w(Tw, W, Ew, Hw), check_on_w(t, Tw, W, Ew, Hw, -P),          atom(P).

entails(t, Tw, W, Ew, Hw, neg(F))      :- time(t), time(Tw), Tw <= t, not entails(t, Tw, W, Ew, Hw, F ),                                w(Tw, W, Ew, Hw), check_on_w(t, Tw, W, Ew, Hw, neg(F)),      check_on_w(t, Tw, W, Ew, Hw, F ),                           formula(neg(F)),      formula(F).
entails(t, Tw, W, Ew, Hw, and(F1, F2)) :- time(t), time(Tw), Tw <= t,     entails(t, Tw, W, Ew, Hw, F1), entails(t, Tw, W, Ew, Hw, F2), w(Tw, W, Ew, Hw), check_on_w(t, Tw, W, Ew, Hw, and(F1, F2)), check_on_w(t, Tw, W, Ew, Hw, F1), check_on_w(t, Tw, W, Ew, Hw, F2), formula(and(F1, F2)), formula(F1), formula(F2).
entails(t, Tw, W, Ew, Hw,  or(F1, F2)) :- time(t), time(Tw), Tw <= t,     entails(t, Tw, W, Ew, Hw, F1),                                w(Tw, W, Ew, Hw), check_on_w(t, Tw, W, Ew, Hw,  or(F1, F2)), check_on_w(t, Tw, W, Ew, Hw, F1), check_on_w(t, Tw, W, Ew, Hw, F2), formula( or(F1, F2)), formula(F1), formula(F2).
entails(t, Tw, W, Ew, Hw,  or(F1, F2)) :- time(t), time(Tw), Tw <= t,                                    entails(t, Tw, W, Ew, Hw, F2), w(Tw, W, Ew, Hw), check_on_w(t, Tw, W, Ew, Hw,  or(F1, F2)), check_on_w(t, Tw, W, Ew, Hw, F1), check_on_w(t, Tw, W, Ew, Hw, F2), formula( or(F1, F2)), formula(F1), formula(F2).

entails(t, Tw, W, Ew, Hw,   b(AG , F)) :- time(t), time(Tw), Tw <= t, not not_entails(t, Tw, W, Ew, Hw, b(AG , F)),                     w(Tw, W, Ew, Hw), check_on_w(t, Tw, W, Ew, Hw, b(AG , F)),   formula(  b(AG , F)), formula(F), agent(AG).
entails(t, Tw, W, Ew, Hw,   c(AGS, F)) :- time(t), time(Tw), Tw <= t, not not_entails(t, Tw, W, Ew, Hw, c(AGS, F)),                     w(Tw, W, Ew, Hw), check_on_w(t, Tw, W, Ew, Hw, c(AGS, F)),   formula(  c(AGS, F)), formula(F), agent_set(AGS).

not_entails(t, Tw1, W1, Ew1, Hw1, b(AG , F)) :- time(t), time(Tw1), time(Tw2), Tw1 <= t, Tw2 <= Tw1,
                                                not entails(t, Tw2, W2, Ew2, Hw2, F), w(Tw1, W1, Ew1, Hw1), w(Tw2, W2, Ew2, Hw2), 
                                                check_on_w(t, Tw1, W1, Ew1, Hw1, b(AG , F)), check_on_w(t, Tw2, W2, Ew2, Hw2, F),
                                                r(Tw1, W1, Ew1, Hw1, Tw2, W2, Ew2, Hw2, AG), formula(b(AG , F)), formula(F), agent(AG).

not_entails(t, Tw1, W1, Ew1, Hw1, c(AGS, F)) :- time(t), time(Tw1), time(Tw2), Tw1 <= t, Tw2 <= Tw1,
                                                not entails(t, Tw2, W2, Ew2, Hw2, F), w(Tw1, W1, Ew1, Hw1), w(Tw2, W2, Ew2, Hw2),
                                                check_on_w(t, Tw1, W1, Ew1, Hw1, c(AGS, F)), check_on_w(t, Tw2, W2, Ew2, Hw2, F),
                                                reaches(Tw1, W1, Ew1, Hw1, Tw2, W2, Ew2, Hw2, AGS), formula(c(AGS, F)), formula(F), agent_set(AGS).

% :- entails(t, W, Hw, and(F1, F2)), not entails(t, W, Hw, F1), time(t), w(t, W, E), check_on_w(t, W, Hw, and(F1, F2)), check_on_w(t, W, Hw, F1), check_on_w(t, W, Hw, F2), formula(and(F1, F2)), formula(F1), formula(F2).
% :- entails(t, W, Hw, and(F1, F2)), not entails(t, W, Hw, F2), time(t), w(t, W, E), check_on_w(t, W, Hw, and(F1, F2)), check_on_w(t, W, Hw, F1), check_on_w(t, W, Hw, F2), formula(and(F1, F2)), formula(F1), formula(F2).

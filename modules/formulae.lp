% ********** FORMULAE **********

#program step(t).

check_on_w(w(t, W, Ew), F) :- time(t), plan(t, ACT), action(ACT), pre(ACT, E, F), formula(F),
                              w(t, W, Ew), e(ACT, E), not ne(ACT, E), same_path(t, w(t, W, Ew), e(ACT, E)).

check_on_w(w(t, W, Ew), F) :- time(t), plan(t, ACT), action(ACT), post(ACT, E, -P, F), atom(P), 
                              w(t, W, Ew), e(ACT, E), not ne(ACT, E), same_path(t, w(t, W, Ew), e(ACT, E)), formula(F), not atom(F).

check_on_w(w(t, W, Ew), F) :- time(t), goal(F), formula(F), dw(t, W, Ew).

check_on_w(w(t, W , E ), F ) :- w(t, W, E), check_on_w(w(t, W, E), neg(F)),      formula(neg(F)),      formula(F ).
check_on_w(w(t, W , E ), F1) :- w(t, W, E), check_on_w(w(t, W, E), and(F1, F2)), formula(and(F1, F2)), formula(F1), formula(F2).
check_on_w(w(t, W , E ), F2) :- w(t, W, E), check_on_w(w(t, W, E), and(F1, F2)), formula(and(F1, F2)), formula(F1), formula(F2).
check_on_w(w(t, W , E ), F1) :- w(t, W, E), check_on_w(w(t, W, E),  or(F1, F2)), formula( or(F1, F2)), formula(F1), formula(F2).
check_on_w(w(t, W , E ), F2) :- w(t, W, E), check_on_w(w(t, W, E),  or(F1, F2)), formula( or(F1, F2)), formula(F1), formula(F2).

check_on_w(w(t, W1, E1), F ) :- check_on_w(w(t, W2, E2), b(AG, F)), w(t, W1, E1), w(t, W2, E2), agent(AG),
                                r(w(t, W2, E2), w(t, W1, E1), AG), formula(b(AG, F)), formula(F).

check_on_w(w(t, W1, E1), F ) :- check_on_w(w(t, W2, E2), c(AGS, F)), w(t, W1, E1), w(t, W2, E2), agent_set(AGS),
                                reaches(w(t, W2, E2), w(t, W1, E1), AGS), formula(c(AGS, F)), formula(F).
% \todo: forse si può sostituire reaches con r, visto che poi viene richiamato ricorsivamente. Così posso togliere reaches e risparmio grounding

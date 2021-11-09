% ********** FORMULAE **********

#program step(t).

check_on_w(t, Tw , W , Ew , Hw , F ) :- time(t), time(Tw), Tw <= t, plan(t, ACT), action(ACT), pre(ACT, E, F), formula(F),
                                        w(Tw, W, Ew, Hw), e(ACT, E), not ne(ACT, E), same_path(t, Tw, W, Ew, Hw, E, _).

check_on_w(t, Tw , W , Ew , Hw , F ) :- time(t), time(Tw), Tw <= t, plan(t, ACT), action(ACT), post(ACT, E, P, F),
                                        w(Tw, W, Ew, Hw), e(ACT, E), not ne(ACT, E), same_path(t, Tw, W, Ew, Hw, E, _), formula(F).

check_on_w(t, t  , W , Ew , Hw , F ) :- time(t), goal(F), formula(F), dw(t, W, Ew, Hw).

check_on_w(t, Tw , W , Ew , Hw , F ) :- time(t), time(Tw), Tw <= t, w(Tw, W, Ew, Hw), check_on_w(t, Tw, W, Ew, Hw, neg(F)),      formula(neg(F)),      formula(F ).
check_on_w(t, Tw , W , Ew , Hw , F1) :- time(t), time(Tw), Tw <= t, w(Tw, W, Ew, Hw), check_on_w(t, Tw, W, Ew, Hw, and(F1, F2)), formula(and(F1, F2)), formula(F1), formula(F2).
check_on_w(t, Tw , W , Ew , Hw , F2) :- time(t), time(Tw), Tw <= t, w(Tw, W, Ew, Hw), check_on_w(t, Tw, W, Ew, Hw, and(F1, F2)), formula(and(F1, F2)), formula(F1), formula(F2).
check_on_w(t, Tw , W , Ew , Hw , F1) :- time(t), time(Tw), Tw <= t, w(Tw, W, Ew, Hw), check_on_w(t, Tw, W, Ew, Hw,  or(F1, F2)), formula( or(F1, F2)), formula(F1), formula(F2).
check_on_w(t, Tw , W , Ew , Hw , F2) :- time(t), time(Tw), Tw <= t, w(Tw, W, Ew, Hw), check_on_w(t, Tw, W, Ew, Hw,  or(F1, F2)), formula( or(F1, F2)), formula(F1), formula(F2).

check_on_w(t, Tw1, W1, Ew1, Hw1, F ) :- time(t), time(Tw1), time(Tw2), Tw1 <= t, Tw1 <= Tw2, check_on_w(t, Tw2, W2, Ew2, Hw2, b(AG, F)),
                                        w(Tw1, W1, Ew1, Hw1), w(Tw2, W2, Ew2, Hw2), agent(AG), r(Tw2, W2, Ew2, Hw2, Tw1, W1, Ew1, Hw1, AG), formula(b(AG, F)), formula(F).

check_on_w(t, Tw1, W1, Ew1, Hw1, F ) :- time(t), time(Tw1), time(Tw2), Tw1 <= t, Tw1 <= Tw2, check_on_w(t, Tw2, W2, Ew2, Hw2, c(AGS, F)),
                                        w(Tw1, W1, Ew1, Hw1), w(Tw2, W2, Ew2, Hw2), agent_set(AGS), reaches(Tw2, W2, Ew2, Hw2, Tw1, W1, Ew1, Hw1, AGS), formula(c(AGS, F)), formula(F).

% check_on_w(t, Tw1, W1, Ew1, Hw1, c(AGS, F)) :- time(t), time(Tw1), time(Tw2), Tw1 <= t, Tw1 <= Tw2, check_on_w(t, Tw2, W2, Ew2, Hw2, c(AGS, F)),
%                                         w(Tw1, W1, Ew1, Hw1), w(Tw2, W2, Ew2, Hw2), agent_set(AGS), agent(AG), contains_ag(AGS, AG),
%                                         r(Tw2, W2, Ew2, Hw2, Tw1, W1, Ew1, Hw1, AG), formula(c(AGS, F)), formula(F).

% check_on_w(t, Tw1, W1, Ew1, Hw1, F ) :- time(t), time(Tw1), Tw1 <= t, check_on_w(t, Tw1, W1, Ew1, Hw1, c(AGS, F)),
%                                         w(Tw1, W1, Ew1, Hw1), agent_set(AGS), formula(c(AGS, F)), formula(F).

% \todo: forse si può sostituire reaches con r, visto che poi viene richiamato ricorsivamente. Così posso togliere reaches e risparmio grounding

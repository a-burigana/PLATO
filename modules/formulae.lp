% ********** FORMULAE **********

#program base.

% %%% A literal is an atom or its negation
% literal( P) :- atom(P).
% literal(-P) :- atom(P), formula(-P).

check_on_w(w(0, W , __ini), F ) :- check_on_w(w(0, W, __ini), neg(F)),      formula(neg(F)),      formula(F ).
check_on_w(w(0, W , __ini), F1) :- check_on_w(w(0, W, __ini), and(F1, F2)), formula(and(F1, F2)), formula(F1), formula(F2).
check_on_w(w(0, W , __ini), F2) :- check_on_w(w(0, W, __ini), and(F1, F2)), formula(and(F1, F2)), formula(F1), formula(F2).
check_on_w(w(0, W , __ini), F1) :- check_on_w(w(0, W, __ini),  or(F1, F2)), formula( or(F1, F2)), formula(F1), formula(F2).
check_on_w(w(0, W , __ini), F2) :- check_on_w(w(0, W, __ini),  or(F1, F2)), formula( or(F1, F2)), formula(F1), formula(F2).

check_on_w(w(0, W1, __ini), F ) :- check_on_w(w(0, W2, __ini), b(AG, F)), w(0, W2, __ini), agent(AG),
                                   r(w(0, W2, __ini), w(0, W1, __ini), AG), formula(b(AG, F)), formula(F).

check_on_w(w(0, W1, __ini), F ) :- check_on_w(w(0, W2, __ini), c(AGS, F)), w(0, W2, __ini), agent_set(AGS),
                                   reaches(w(0, W2, __ini), w(0, W1, __ini), AGS), formula(c(AGS, F)), formula(F).


#program step(t).

check_on_w(w(t-1, W, Ew), F) :- t > 0, time(t), plan(t, ACT), action(ACT), pre(t, ACT, E, F), formula(F),
                                w(t-1, W, Ew), e(t, ACT, E), same_path(w(t-1, W, Ew), e(t, ACT, E)).

check_on_w(w(t-1, W, Ew), F) :- t > 0, time(t), plan(t, ACT), action(ACT), post(t, ACT, E, -P, F), atom(P), 
                                w(t-1, W, Ew), e(t, ACT, E), same_path(w(t-1, W, Ew), e(t, ACT, E)), formula(F), not atom(F).

% check_on_w(w(t-1, W, Ew), F) :- t > 0, time(t), plan(t, ACT), action(ACT), goal(F), formula(F), w(t-1, W, Ew), dw(t-1, W, Ew).

check_on_w(w(t-1, W , E ), F ) :- check_on_w(w(t-1, W, E), neg(F)),      formula(neg(F)),      formula(F ).
check_on_w(w(t-1, W , E ), F1) :- check_on_w(w(t-1, W, E), and(F1, F2)), formula(and(F1, F2)), formula(F1), formula(F2).
check_on_w(w(t-1, W , E ), F2) :- check_on_w(w(t-1, W, E), and(F1, F2)), formula(and(F1, F2)), formula(F1), formula(F2).
check_on_w(w(t-1, W , E ), F1) :- check_on_w(w(t-1, W, E),  or(F1, F2)), formula( or(F1, F2)), formula(F1), formula(F2).
check_on_w(w(t-1, W , E ), F2) :- check_on_w(w(t-1, W, E),  or(F1, F2)), formula( or(F1, F2)), formula(F1), formula(F2).

check_on_w(w(t-1, W1, E1), F ) :- check_on_w(w(t-1, W2, E2), b(AG, F)), w(t-1, W2, E2), agent(AG),
                                  r(w(t-1, W2, E2), w(t-1, W1, E1), AG), formula(b(AG, F)), formula(F).

check_on_w(w(t-1, W1, E1), F ) :- check_on_w(w(t-1, W2, E2), c(AGS, F)), w(t-1, W2, E2), agent_set(AGS),
                                  reaches(w(t-1, W2, E2), w(t-1, W1, E1), AGS), formula(c(AGS, F)), formula(F).


#program check(t).

check_on_w_goal(w(t, W , Ew), F ) :- t > 0, time(t), plan(t, ACT), action(ACT), goal(F), formula(F), dw(t, W, Ew), query(t).

check_on_w_goal(w(t, W , E ), F ) :- check_on_w_goal(w(t, W, E), neg(F)),      w(t, W, E), formula(neg(F)),      formula(F ),              query(t).
check_on_w_goal(w(t, W , E ), F1) :- check_on_w_goal(w(t, W, E), and(F1, F2)), w(t, W, E), formula(and(F1, F2)), formula(F1), formula(F2), query(t).
check_on_w_goal(w(t, W , E ), F2) :- check_on_w_goal(w(t, W, E), and(F1, F2)), w(t, W, E), formula(and(F1, F2)), formula(F1), formula(F2), query(t).
check_on_w_goal(w(t, W , E ), F1) :- check_on_w_goal(w(t, W, E),  or(F1, F2)), w(t, W, E), formula( or(F1, F2)), formula(F1), formula(F2), query(t).
check_on_w_goal(w(t, W , E ), F2) :- check_on_w_goal(w(t, W, E),  or(F1, F2)), w(t, W, E), formula( or(F1, F2)), formula(F1), formula(F2), query(t).

check_on_w_goal(w(t, W1, E1), F ) :- check_on_w_goal(w(t, W2, E2), b(AG, F)), w(t, W, E), w(t, W2, E2), agent(AG),
                                r(w(t, W2, E2), w(t, W1, E1), AG), formula(b(AG, F)), formula(F), query(t).

check_on_w_goal(w(t, W1, E1), F ) :- check_on_w_goal(w(t, W2, E2), c(AGS, F)), w(t, W, E), w(t, W2, E2), agent_set(AGS),
                                reaches(w(t, W2, E2), w(t, W1, E1), AGS), formula(c(AGS, F)), formula(F), query(t).

% ********** FORMULAE **********

#program base.

%%% A literal is an atom or its negation
literal( P) :- atom(P).
literal(-P) :- atom(P), formula(-P).


% check_on_designated/1: DEL formulae that need to be verified only in the pointed worlds
check_on_designated(F) :- formula(F), executable(_,    F).     % Executability conditions are to be checked only in the pointed possibility
check_on_designated(F) :- formula(F),   observes(_, _, F).     % Observability conditions are to be checked only in the pointed possibility
check_on_designated(F) :- formula(F),   aware_of(_, _, F).
check_on_designated(F) :- formula(F),       goal(F).           % Goal conditions are to be checked only in the pointed possibility

% check_everywere/1: DEL formulae that need to be verified in every world
check_everywhere(F) :- formula(F),     causes(_, _, F).     % Effects executability conditions are to be checked in each possibility
check_everywhere(F) :- formula(F), determines(_, _, F).
check_everywhere(F) :- formula(F),  announces(_, _, F).
check_everywhere(F) :- formula(F),  announces(_, F, _).     % The effects of announcement actions are to be checked in each possibility

check_everywhere(F ) :- check_everywhere(neg(F)),       formula(neg(F)),       formula(F ).
check_everywhere(F1) :- check_everywhere(and(F1, F2)),  formula(and(F1, F2)),  formula(F1), formula(F2).
check_everywhere(F2) :- check_everywhere(and(F1, F2)),  formula(and(F1, F2)),  formula(F1), formula(F2).
check_everywhere(F1) :- check_everywhere( or(F1, F2)),  formula( or(F1, F2)),  formula(F1), formula(F2).
check_everywhere(F2) :- check_everywhere( or(F1, F2)),  formula( or(F1, F2)),  formula(F1), formula(F2).

check_everywhere(F ) :- check_everywhere(  b(AG , F )), formula(  b(AG , F )), formula(F ), agent(AG).
check_everywhere(F ) :- check_everywhere(  c(AGS, F )), formula(  c(AGS, F )), formula(F ), agent_set(AGS).

% check_on_designated/3: we keep track of the worlds where each formula needs to be verified
check_on_pw(pw(0, W , __ini), F ) :- check_on_designated(F), dw(0, W, __ini), formula(F).

check_on_pw(pw(0, W , __ini), F ) :- check_on_pw(pw(0, W, __ini), neg(F)),      not check_everywhere(neg(F)),      formula(neg(F)),      formula(F ).
check_on_pw(pw(0, W , __ini), F1) :- check_on_pw(pw(0, W, __ini), and(F1, F2)), not check_everywhere(and(F1, F2)), formula(and(F1, F2)), formula(F1), formula(F2).
check_on_pw(pw(0, W , __ini), F2) :- check_on_pw(pw(0, W, __ini), and(F1, F2)), not check_everywhere(and(F1, F2)), formula(and(F1, F2)), formula(F1), formula(F2).
check_on_pw(pw(0, W , __ini), F1) :- check_on_pw(pw(0, W, __ini),  or(F1, F2)), not check_everywhere( or(F1, F2)), formula( or(F1, F2)), formula(F1), formula(F2).
check_on_pw(pw(0, W , __ini), F2) :- check_on_pw(pw(0, W, __ini),  or(F1, F2)), not check_everywhere( or(F1, F2)), formula( or(F1, F2)), formula(F1), formula(F2).

check_on_pw(pw(0, W1, __ini), F ) :- check_on_pw(pw(0, W2, __ini), b(AG , F)), pw(0, W2, __ini), agent(AG),
                                     r(pw(0, W2, __ini), pw(0, W1, __ini), AG), not check_everywhere(b(AG , F)), formula(b(AG , F)), formula(F).

check_on_pw(pw(0, W1, __ini), F ) :- check_on_pw(pw(0, W2, __ini), c(AGS, F)), pw(0, W2, __ini), agent(AG), agent_set(AGS), contains_ag(AGS, AG),
                                     reaches(pw(0, W2, __ini), pw(0, W1, __ini), AG), not check_everywhere(c(AGS, F)), formula(c(AGS, F)), formula(F).


#program step(t).

check_on_pw(pw(t, W , E), F ) :- check_on_designated(F), dw(t, W, E), formula(F).

check_on_pw(pw(t, W , E), F ) :- check_on_pw(pw(t, W, E), neg(F)),      not check_everywhere(neg(F)),      formula(neg(F)),      formula(F ).
check_on_pw(pw(t, W , E), F1) :- check_on_pw(pw(t, W, E), and(F1, F2)), not check_everywhere(and(F1, F2)), formula(and(F1, F2)), formula(F1), formula(F2).
check_on_pw(pw(t, W , E), F2) :- check_on_pw(pw(t, W, E), and(F1, F2)), not check_everywhere(and(F1, F2)), formula(and(F1, F2)), formula(F1), formula(F2).
check_on_pw(pw(t, W , E), F1) :- check_on_pw(pw(t, W, E),  or(F1, F2)), not check_everywhere( or(F1, F2)), formula( or(F1, F2)), formula(F1), formula(F2).
check_on_pw(pw(t, W , E), F2) :- check_on_pw(pw(t, W, E),  or(F1, F2)), not check_everywhere( or(F1, F2)), formula( or(F1, F2)), formula(F1), formula(F2).

check_on_pw(pw(t, W1, E), F ) :- check_on_pw(pw(t, W2, E), b(AG , F)), pw(t, W2, E), agent(AG),
                                 r(pw(t, W2, E), pw(t, W1, E), AG), not check_everywhere(b(AG , F)), formula(b(AG , F)), formula(F).

check_on_pw(pw(t, W1, E), F ) :- check_on_pw(pw(0, W2, __ini), c(AGS, F)), pw(t, W2, E), agent(AG), agent_set(AGS), contains_ag(AGS, AG),
                                 reaches(pw(t, W2, E), pw(t, W1, E), AG), not check_everywhere(c(AGS, F)), formula(c(AGS, F)), formula(F).

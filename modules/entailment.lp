% ********** ENTAILMENT **********

#program base.

entails(pw(0, W, __ini),  F)          :-     holds(pw(0, W, __ini), F),                                  check_on_pw(pw(0, W, __ini),  F),          not check_everywhere( F),          atom(F).
entails(pw(0, W, __ini), -F)          :- not holds(pw(0, W, __ini), F),                                  check_on_pw(pw(0, W, __ini), -F),          not check_everywhere(-F),          atom(F).

entails(pw(0, W, __ini), neg(F))      :- not entails(pw(0, W, __ini), F ),                               check_on_pw(pw(0, W, __ini), neg(F)),      not check_everywhere(neg(F)),      formula(neg(F)),      formula(F).
entails(pw(0, W, __ini), and(F1, F2)) :-     entails(pw(0, W, __ini), F1), entails(pw(0, W, __ini), F2), check_on_pw(pw(0, W, __ini), and(F1, F2)), not check_everywhere(and(F1, F2)), formula(and(F1, F2)), formula(F1), formula(F2).
entails(pw(0, W, __ini),  or(F1, F2)) :-     entails(pw(0, W, __ini), F1),                               check_on_pw(pw(0, W, __ini),  or(F1, F2)), not check_everywhere( or(F1, F2)), formula( or(F1, F2)), formula(F1), formula(F2).
entails(pw(0, W, __ini),  or(F1, F2)) :-                                   entails(pw(0, W, __ini), F2), check_on_pw(pw(0, W, __ini),  or(F1, F2)), not check_everywhere( or(F1, F2)), formula( or(F1, F2)), formula(F1), formula(F2).

entails(pw(0, W, __ini),   b(AG , F)) :- not not_entails(pw(0, W, __ini), b(AG , F)),                    check_on_pw(pw(0, W, __ini), b(AG , F)),   not check_everywhere(b(AG , F)),   formula(  b(AG , F)), formula(F), agent(AG).
entails(pw(0, W, __ini),   c(AGS, F)) :- not not_entails(pw(0, W, __ini), c(AGS, F)),                    check_on_pw(pw(0, W, __ini), c(AGS, F)),   not check_everywhere(c(AGS, F)),   formula(  c(AGS, F)), formula(F), agent_set(AGS).

not_entails(pw(0, W1, __ini), b(AG , F)) :- not entails(pw(0, W2, __ini), F), pw(0, W2, __ini), check_on_pw(pw(0, W1, __ini), b(AG , F)), check_on_pw(pw(0, W2, __ini), F),
                                            r(pw(0, W1, __ini), pw(0, W2, __ini), AG), not check_everywhere(b(AG , F)), formula(b(AG , F)), formula(F), agent(AG).

not_entails(pw(0, W1, __ini), c(AGS, F)) :- not entails(pw(0, W2, __ini), F), pw(0, W2, __ini), check_on_pw(pw(0, W1, __ini), c(AGS, F)), check_on_pw(pw(0, W2, __ini), F),
                                            reaches(pw(0, W1, __ini), pw(0, W2, __ini), AGS), not check_everywhere(c(AGS, F)), formula(c(AGS, F)), formula(F), agent_set(AGS).


entails(pw(0, W, __ini),  F)          :-     holds(pw(0, W, __ini), F),                                  check_everywhere( F),          atom(F).
entails(pw(0, W, __ini), -F)          :- not holds(pw(0, W, __ini), F),    pw(0, W, __ini),              check_everywhere(-F),          atom(F).

entails(pw(0, W, __ini), neg(F))      :- not entails(pw(0, W, __ini), F ), pw(0, W, __ini),              check_everywhere(neg(F)),      check_everywhere(F ),                       formula(neg(F)),      formula(F).
entails(pw(0, W, __ini), and(F1, F2)) :-     entails(pw(0, W, __ini), F1), entails(pw(0, W, __ini), F2), check_everywhere(and(F1, F2)), check_everywhere(F1), check_everywhere(F2), formula(and(F1, F2)), formula(F1), formula(F2).
entails(pw(0, W, __ini),  or(F1, F2)) :-     entails(pw(0, W, __ini), F1),                               check_everywhere( or(F1, F2)), check_everywhere(F1), check_everywhere(F2), formula( or(F1, F2)), formula(F1), formula(F2).
entails(pw(0, W, __ini),  or(F1, F2)) :-                                   entails(pw(0, W, __ini), F2), check_everywhere( or(F1, F2)), check_everywhere(F1), check_everywhere(F2), formula( or(F1, F2)), formula(F1), formula(F2).

entails(pw(0, W, __ini),   b(AG , F)) :- not not_entails(pw(0, W, __ini), b(AG , F)), pw(0, W, __ini),   check_everywhere(b(AG , F)),                                               formula(  b(AG , F)), formula(F), agent(AG).
entails(pw(0, W, __ini),   c(AGS, F)) :- not not_entails(pw(0, W, __ini), c(AGS, F)), pw(0, W, __ini),   check_everywhere(c(AGS, F)),                                               formula(  c(AGS, F)), formula(F), agent_set(AGS).

not_entails(pw(0, W1, __ini), b(AG , F)) :- not entails(pw(0, W2, __ini), F), pw(0, W2, __ini),
                                            r(pw(0, W1, __ini), pw(0, W2, __ini), AG), check_everywhere(b(AG, F)), formula(b(AG, F)), formula(F), agent(AG).

not_entails(pw(0, W1, __ini), c(AGS, F)) :- not entails(pw(0, W2, __ini), F), pw(0, W2, __ini),
                                            reaches(pw(0, W1, __ini), pw(0, W2, __ini), AGS), check_everywhere(c(AGS, F)), formula(c(AGS, F)), formula(F), agent_set(AGS).


#program step(t).

% entails/4: P entails the formula F
entails(pw(t, W, E),  F)          :-     holds(pw(t, W, E), F),                              check_on_pw(pw(t, W, E),  F),          not check_everywhere( F),          atom(F).
entails(pw(t, W, E), -F)          :- not holds(pw(t, W, E), F),                              check_on_pw(pw(t, W, E), -F),          not check_everywhere(-F),          atom(F).

entails(pw(t, W, E), neg(F))      :- not entails(pw(t, W, E), F ),                           check_on_pw(pw(t, W, E), neg(F)),      not check_everywhere(neg(F)),      formula(neg(F)),      formula(F).
entails(pw(t, W, E), and(F1, F2)) :-     entails(pw(t, W, E), F1), entails(pw(t, W, E), F2), check_on_pw(pw(t, W, E), and(F1, F2)), not check_everywhere(and(F1, F2)), formula(and(F1, F2)), formula(F1), formula(F2).
entails(pw(t, W, E),  or(F1, F2)) :-     entails(pw(t, W, E), F1),                           check_on_pw(pw(t, W, E),  or(F1, F2)), not check_everywhere( or(F1, F2)), formula( or(F1, F2)), formula(F1), formula(F2).
entails(pw(t, W, E),  or(F1, F2)) :-                               entails(pw(t, W, E), F2), check_on_pw(pw(t, W, E),  or(F1, F2)), not check_everywhere( or(F1, F2)), formula( or(F1, F2)), formula(F1), formula(F2).

entails(pw(t, W, E),   b(AG , F)) :- not not_entails(pw(t, W, E), b(AG , F)),                check_on_pw(pw(t, W, E), b(AG , F)),   not check_everywhere(b(AG , F)),   formula(  b(AG , F)), formula(F), agent(AG).
entails(pw(t, W, E),   c(AGS, F)) :- not not_entails(pw(t, W, E), c(AGS, F)),                check_on_pw(pw(t, W, E), c(AGS, F)),   not check_everywhere(c(AGS, F)),   formula(  c(AGS, F)), formula(F), agent_set(AGS).

not_entails(pw(t, W1, E), b(AG , F)) :- not entails(pw(t, W2, E), F), pw(t, W2, E), check_on_pw(pw(t, W1, E), b(AG , F)), check_on_pw(pw(t, W2, E), F),
                                        r(pw(t, W1, E), pw(t, W2, E), AG), not check_everywhere(b(AG , F)), formula(b(AG , F)), formula(F), agent(AG).

not_entails(pw(t, W1, E), c(AGS, F)) :- not entails(pw(t, W2, E), F), pw(t, W2, E), check_on_pw(pw(t, W1, E), c(AGS, F)), check_on_pw(pw(t, W2, E), F),
                                        reaches(pw(t, W1, E), pw(t, W2, E), AGS), not check_everywhere(c(AGS, F)), formula(c(AGS, F)), formula(F), agent_set(AGS).


entails(pw(t, W, E),  F)          :-     holds(pw(t, W, E), F),                              check_everywhere( F),          atom(F).
entails(pw(t, W, E), -F)          :- not holds(pw(t, W, E), F),    pw(t, W, E),              check_everywhere(-F),          atom(F).

entails(pw(t, W, E), neg(F))      :- not entails(pw(t, W, E), F ), pw(t, W, E),              check_everywhere(neg(F)),      check_everywhere(F ),                       formula(neg(F)),      formula(F).
entails(pw(t, W, E), and(F1, F2)) :-     entails(pw(t, W, E), F1), entails(pw(t, W, E), F2), check_everywhere(and(F1, F2)), check_everywhere(F1), check_everywhere(F2), formula(and(F1, F2)), formula(F1), formula(F2).
entails(pw(t, W, E),  or(F1, F2)) :-     entails(pw(t, W, E), F1),                           check_everywhere( or(F1, F2)), check_everywhere(F1), check_everywhere(F2), formula( or(F1, F2)), formula(F1), formula(F2).
entails(pw(t, W, E),  or(F1, F2)) :-                               entails(pw(t, W, E), F2), check_everywhere( or(F1, F2)), check_everywhere(F1), check_everywhere(F2), formula( or(F1, F2)), formula(F1), formula(F2).

entails(pw(t, W, E),   b(AG , F)) :- not not_entails(pw(t, W, E), b(AG , F)), pw(t, W, E),   check_everywhere(b(AG , F)),                                               formula(  b(AG , F)), formula(F), agent(AG).
entails(pw(t, W, E),   c(AGS, F)) :- not not_entails(pw(t, W, E), c(AGS, F)), pw(t, W, E),   check_everywhere(c(AGS, F)),                                               formula(  c(AGS, F)), formula(F), agent_set(AGS).

not_entails(pw(t, W1, E), b(AG , F)) :- not entails(pw(t, W2, E), F), pw(t, W2, E),
                                        r(pw(t, W1, E), pw(t, W2, E), AG), check_everywhere(b(AG, F)), formula(b(AG, F)), formula(F), agent(AG).

not_entails(pw(t, W1, E), c(AGS, F)) :- not entails(pw(t, W2, E), F), pw(t, W2, E),
                                        reaches(pw(t, W1, E), pw(t, W2, E), AGS), check_everywhere(c(AGS, F)), formula(c(AGS, F)), formula(F), agent_set(AGS).


#program base.

% check_on_designated/1: DEL formulae that need to be verified only in the pointed worlds
check_on_designated(F) :- formula(F), goal(F).           % Goal conditions are to be checked only in the designated worlds

% check_everywere/1: DEL formulae that need to be verified in every world
check_everywhere(F) :- formula(F), event(_, E), pre(E, F).
check_everywhere(F) :- formula(F), event(_, E), atom(P), post(E, P, F).

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

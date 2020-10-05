% ********** ENTAILMENT **********

#program base.

% Entailment of initially conditions. We use it to generate the initial state
entails_init(P,  F    )          :-     holds(0, 0, P, F),                          initial_possibility(P), fluent(F), init_sf(F).
entails_init(P, -F    )          :- not holds(0, 0, P, F),                          initial_possibility(P), fluent(F), init_sf(F).

entails_init(P, neg(F))          :- not entails_init(P, F ),                        initial_possibility(P), init_sf(neg(F)),      init_sf(F).
entails_init(P, and(F1, F2))     :-     entails_init(P, F1), entails_init(P, F2),   initial_possibility(P), init_sf(and(F1, F2)), init_sf(F1), init_sf(F2).
entails_init(P,  or(F1, F2))     :-     entails_init(P, F1),                        initial_possibility(P), init_sf( or(F1, F2)), init_sf(F1), init_sf(F2).
entails_init(P,  or(F1, F2))     :-                          entails_init(P, F2),   initial_possibility(P), init_sf( or(F1, F2)), init_sf(F1), init_sf(F2).

% Entailment of all the other formulas w.r.t. the calculated initial state
entails(0, 0, P,  F    )          :-     holds(0, 0, P, F),                          good_initial_possibility(P), possible_world(0, 0, P), check_on_pw(0, 0, P,  F),          not check_everywhere( F),          fluent(F).
entails(0, 0, P, -F    )          :- not holds(0, 0, P, F),                          good_initial_possibility(P), possible_world(0, 0, P), check_on_pw(0, 0, P, -F),          not check_everywhere(-F),          fluent(F).

entails(0, 0, P, neg(F))          :- not entails(0, 0, P, F ),                       good_initial_possibility(P), possible_world(0, 0, P), check_on_pw(0, 0, P, neg(F)),      not check_everywhere(neg(F)),      formula(neg(F)),      formula(F).
entails(0, 0, P, and(F1, F2))     :-     entails(0, 0, P, F1), entails(0, 0, P, F2), good_initial_possibility(P), possible_world(0, 0, P), check_on_pw(0, 0, P, and(F1, F2)), not check_everywhere(and(F1, F2)), formula(and(F1, F2)), formula(F1), formula(F2).
entails(0, 0, P,  or(F1, F2))     :-     entails(0, 0, P, F1),                       good_initial_possibility(P), possible_world(0, 0, P), check_on_pw(0, 0, P,  or(F1, F2)), not check_everywhere( or(F1, F2)), formula( or(F1, F2)), formula(F1), formula(F2).
entails(0, 0, P,  or(F1, F2))     :-                           entails(0, 0, P, F2), good_initial_possibility(P), possible_world(0, 0, P), check_on_pw(0, 0, P,  or(F1, F2)), not check_everywhere( or(F1, F2)), formula( or(F1, F2)), formula(F1), formula(F2).

entails(0, 0, P,   b(AG , F))     :- not not_entails(0, 0, P, b(AG , F)),            good_initial_possibility(P), possible_world(0, 0, P), check_on_pw(0, 0, P, b(AG , F)),   not check_everywhere(b(AG , F)),   formula(  b(AG , F)), formula(F), agent(AG).
entails(0, 0, P,   c(AGS, F))     :- not not_entails(0, 0, P, c(AGS, F)),            good_initial_possibility(P), possible_world(0, 0, P), check_on_pw(0, 0, P, c(AGS, F)),   not check_everywhere(c(AGS, F)),   formula(  c(AGS, F)), formula(F), agent_set(AGS).

not_entails(0, 0 , P1, b(AG , F)) :- not entails(0, 0, P2, F), good_initial_possibility(P1), good_initial_possibility(P2), possible_world(0, 0, P1), possible_world(0, 0, P2), check_on_pw(0, 0, P1, b(AG , F)), check_on_pw(0, 0, P2, F),
                                     believes(0, 0, P1, 0, 0, P2, AG), not check_everywhere(b(AG , F)), formula(b(AG , F)), formula(F), agent(AG).

not_entails(0, 0 , P1, c(AGS, F)) :- not entails(0, 0, P2, F), good_initial_possibility(P1), good_initial_possibility(P2), possible_world(0, 0, P1), possible_world(0, 0, P2), check_on_pw(0, 0, P1, c(AGS, F)), check_on_pw(0, 0, P2, F),
                                     reaches(0, 0, P1, 0, 0, P2, AGS), not check_everywhere(c(AGS, F)), formula(c(AGS, F)), formula(F), agent_set(AGS).


entails(0, 0, P,  F    )          :-     holds(0, 0, P, F),                          good_initial_possibility(P), possible_world(0, 0, P), check_everywhere( F),          fluent(F).
entails(0, 0, P, -F    )          :- not holds(0, 0, P, F),                          good_initial_possibility(P), possible_world(0, 0, P), check_everywhere(-F),          fluent(F).

entails(0, 0, P, neg(F))          :- not entails(0, 0, P, F ),                       good_initial_possibility(P), possible_world(0, 0, P), check_everywhere(neg(F)),      check_everywhere(F ),                       formula(neg(F)),      formula(F).
entails(0, 0, P, and(F1, F2))     :-     entails(0, 0, P, F1), entails(0, 0, P, F2), good_initial_possibility(P), possible_world(0, 0, P), check_everywhere(and(F1, F2)), check_everywhere(F1), check_everywhere(F2), formula(and(F1, F2)), formula(F1), formula(F2).
entails(0, 0, P,  or(F1, F2))     :-     entails(0, 0, P, F1),                       good_initial_possibility(P), possible_world(0, 0, P), check_everywhere( or(F1, F2)), check_everywhere(F1), check_everywhere(F2), formula( or(F1, F2)), formula(F1), formula(F2).
entails(0, 0, P,  or(F1, F2))     :-                           entails(0, 0, P, F2), good_initial_possibility(P), possible_world(0, 0, P), check_everywhere( or(F1, F2)), check_everywhere(F1), check_everywhere(F2), formula( or(F1, F2)), formula(F1), formula(F2).

entails(0, 0, P,   b(AG , F))     :- not not_entails(0, 0, P, b(AG , F)),            good_initial_possibility(P), possible_world(0, 0, P), check_everywhere(b(AG , F)),                                               formula(  b(AG , F)), formula(F), agent(AG).
entails(0, 0, P,   c(AGS, F))     :- not not_entails(0, 0, P, c(AGS, F)),            good_initial_possibility(P), possible_world(0, 0, P), check_everywhere(c(AGS, F)),                                               formula(  c(AGS, F)), formula(F), agent_set(AGS).

not_entails(0, 0 , P1, b(AG , F)) :- not entails(0, 0, P2, F), good_initial_possibility(P1), good_initial_possibility(P2), possible_world(0, 0, P1), possible_world(0, 0, P2),
                                     believes(0, 0, P1, 0, 0, P2, AG), check_everywhere(b(AG , F)), formula(b(AG , F)), formula(F), agent(AG).

not_entails(0, 0 , P1, c(AGS, F)) :- not entails(0, 0, P2, F), good_initial_possibility(P1), good_initial_possibility(P2), possible_world(0, 0, P1), possible_world(0, 0, P2),
                                     reaches(0, 0, P1, 0, 0, P2, AGS), check_everywhere(c(AGS, F)), formula(c(AGS, F)), formula(F), agent_set(AGS).


#program step(t).

% entails/4: P entails the formula F
entails(t, R, P,  F    )          :- t > 0, time(t),     holds(t, R, P, F),                          possible_world(t, R, P), check_on_pw(t, R, P,  F),          not check_everywhere( F),          fluent(F).
entails(t, R, P, -F    )          :- t > 0, time(t), not holds(t, R, P, F),                          possible_world(t, R, P), check_on_pw(t, R, P, -F),          not check_everywhere(-F),          fluent(F).

entails(t, R, P, neg(F))          :- t > 0, time(t), not entails(t, R, P, F ),                       possible_world(t, R, P), check_on_pw(t, R, P, neg(F)),      not check_everywhere(neg(F)),      formula(neg(F)),      formula(F).
entails(t, R, P, and(F1, F2))     :- t > 0, time(t),     entails(t, R, P, F1), entails(t, R, P, F2), possible_world(t, R, P), check_on_pw(t, R, P, and(F1, F2)), not check_everywhere(and(F1, F2)), formula(and(F1, F2)), formula(F1), formula(F2).
entails(t, R, P,  or(F1, F2))     :- t > 0, time(t),     entails(t, R, P, F1),                       possible_world(t, R, P), check_on_pw(t, R, P,  or(F1, F2)), not check_everywhere( or(F1, F2)), formula( or(F1, F2)), formula(F1), formula(F2).
entails(t, R, P,  or(F1, F2))     :- t > 0, time(t),                           entails(t, R, P, F2), possible_world(t, R, P), check_on_pw(t, R, P,  or(F1, F2)), not check_everywhere( or(F1, F2)), formula( or(F1, F2)), formula(F1), formula(F2).

entails(t, R, P,   b(AG , F))     :- t > 0, time(t), not not_entails(t, R, P, b(AG , F)),            possible_world(t, R, P), check_on_pw(t, R, P, b(AG , F)),   not check_everywhere(b(AG , F)),   formula(  b(AG , F)), formula(F), agent(AG).
entails(t, R, P,   c(AGS, F))     :- t > 0, time(t), not not_entails(t, R, P, c(AGS, F)),            possible_world(t, R, P), check_on_pw(t, R, P, c(AGS, F)),   not check_everywhere(c(AGS, F)),   formula(  c(AGS, F)), formula(F), agent_set(AGS).

not_entails(t, R1, P1, b(AG , F)) :- t > 0, time(t), time(T2), T2 <= t, not entails(T2, R2, P2, F), possible_world(T1, R1, P1), possible_world(T2, R2, P2), check_on_pw(t, R1, P1, b(AG , F)), check_on_pw(T2, R2, P2, F),
                                     believes(t, R1, P1, T2, R2, P2, AG), not check_everywhere(b(AG , F)), formula(b(AG , F)), formula(F), agent(AG).

not_entails(t, R1, P1, c(AGS, F)) :- t > 0, time(t), time(T2), T2 <= t, not entails(T2, R2, P2, F), possible_world(T1, R1, P1), possible_world(T2, R2, P2), check_on_pw(t, R1, P1, c(AGS, F)), check_on_pw(T2, R2, P2, F),
                                     reaches(t, R1, P1, T2, R2, P2, AGS), not check_everywhere(c(AGS, F)), formula(c(AGS, F)), formula(F), agent_set(AGS).


entails(t, R, P,  F    )          :- t > 0, time(t),     holds(t, R, P, F),                          possible_world(t, R, P), check_everywhere( F),          fluent(F).
entails(t, R, P, -F    )          :- t > 0, time(t), not holds(t, R, P, F),                          possible_world(t, R, P), check_everywhere(-F),          fluent(F).

entails(t, R, P, neg(F))          :- t > 0, time(t), not entails(t, R, P, F ),                       possible_world(t, R, P), check_everywhere(neg(F)),      check_everywhere(F ),                       formula(neg(F)),      formula(F).
entails(t, R, P, and(F1, F2))     :- t > 0, time(t),     entails(t, R, P, F1), entails(t, R, P, F2), possible_world(t, R, P), check_everywhere(and(F1, F2)), check_everywhere(F1), check_everywhere(F2), formula(and(F1, F2)), formula(F1), formula(F2).
entails(t, R, P,  or(F1, F2))     :- t > 0, time(t),     entails(t, R, P, F1),                       possible_world(t, R, P), check_everywhere( or(F1, F2)), check_everywhere(F1), check_everywhere(F2), formula( or(F1, F2)), formula(F1), formula(F2).
entails(t, R, P,  or(F1, F2))     :- t > 0, time(t),                           entails(t, R, P, F2), possible_world(t, R, P), check_everywhere( or(F1, F2)), check_everywhere(F1), check_everywhere(F2), formula( or(F1, F2)), formula(F1), formula(F2).

entails(t, R, P,   b(AG , F))     :- t > 0, time(t), not not_entails(t, R, P, b(AG , F)),            possible_world(t, R, P), check_everywhere(b(AG , F)),                                               formula(  b(AG , F)), formula(F), agent(AG).
entails(t, R, P,   c(AGS, F))     :- t > 0, time(t), not not_entails(t, R, P, c(AGS, F)),            possible_world(t, R, P), check_everywhere(c(AGS, F)),                                               formula(  c(AGS, F)), formula(F), agent_set(AGS).

not_entails(t, R1, P1, b(AG , F)) :- t > 0, time(t), time(T2), T2 <= t, not entails(T2, R2, P2, F), possible_world(T1, R1, P1), possible_world(T2, R2, P2),
                                     believes(t, R1, P1, T2, R2, P2, AG), check_everywhere(b(AG , F)), formula(b(AG , F)), formula(F), agent(AG).

not_entails(t, R1, P1, c(AGS, F)) :- t > 0, time(t), time(T2), T2 <= t, not entails(T2, R2, P2, F), possible_world(T1, R1, P1), possible_world(T2, R2, P2),
                                     reaches(t, R1, P1, T2, R2, P2, AGS), check_everywhere(c(AGS, F)), formula(c(AGS, F)), formula(F), agent_set(AGS).


#program base.

% check_on_pointed/1: belief formulae that need to be verified only in the pointed possibility
check_on_pointed(F) :- formula(F), executable(_,    F).     % Executability conditions are to be checked only in the pointed possibility
check_on_pointed(F) :- formula(F),   observes(_, _, F).     % Observability conditions are to be checked only in the pointed possibility
check_on_pointed(F) :- formula(F),   aware_of(_, _, F).
check_on_pointed(F) :- formula(F),       goal(F).           % Goal conditions are to be checked only in the pointed possibility

% check_everywere/1: belief formulae that need to be verified in each possibility
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

% check_on_pointed/3: we keep track of the possibilities where each formula needs to be verified
check_on_pw(0, 0 , P , F ) :- check_on_pointed(F),               possible_world(0, 0, P), pointed(0, 0, P), formula(F).

check_on_pw(0, 0 , P , F ) :- check_on_pw(0, 0, P, neg(F)),      possible_world(0, 0, P), not check_everywhere(neg(F)),      formula(neg(F)),      formula(F ).
check_on_pw(0, 0 , P , F1) :- check_on_pw(0, 0, P, and(F1, F2)), possible_world(0, 0, P), not check_everywhere(and(F1, F2)), formula(and(F1, F2)), formula(F1), formula(F2).
check_on_pw(0, 0 , P , F2) :- check_on_pw(0, 0, P, and(F1, F2)), possible_world(0, 0, P), not check_everywhere(and(F1, F2)), formula(and(F1, F2)), formula(F1), formula(F2).
check_on_pw(0, 0 , P , F1) :- check_on_pw(0, 0, P,  or(F1, F2)), possible_world(0, 0, P), not check_everywhere( or(F1, F2)), formula( or(F1, F2)), formula(F1), formula(F2).
check_on_pw(0, 0 , P , F2) :- check_on_pw(0, 0, P,  or(F1, F2)), possible_world(0, 0, P), not check_everywhere( or(F1, F2)), formula( or(F1, F2)), formula(F1), formula(F2).

check_on_pw(0, 0 , P1, F ) :- check_on_pw(0, 0, P2, b(AG , F)), possible_world(0, 0, P1), possible_world(0, 0, P2),
                              believes(0, 0, P2, 0, 0, P1, AG), not check_everywhere(b(AG , F)), formula(b(AG , F)), formula(F), agent(AG).

check_on_pw(0, 0 , P1, F ) :- check_on_pw(0, 0, P2, c(AGS, F)), possible_world(0, 0, P1), possible_world(0, 0, P2),
                              believes(0, 0, P2, 0, 0, P1, AG), not check_everywhere(c(AGS, F)), formula(c(AGS, F)), formula(F), agent(AG), agent_set(AGS), contains_ag(AGS, AG).

% check_on_pw(0, 0 , P1, F ) :- check_on_pw(0, 0, P2, c(AGS, F)), possible_world(0, 0, P1), possible_world(0, 0, P2),
%                               reaches(0, 0, P2, 0, 0, P1, AGS), not check_everywhere(c(AGS, F)), formula(c(AGS, F)), formula(F), agent_set(AGS).

#program step(t).

check_on_pw(t, R , P , F ) :- t > 0, time(t), check_on_pointed(F),               possible_world(t, R, P), pointed(t, R, P), formula(F).

check_on_pw(t, R , P , F ) :- t > 0, time(t), check_on_pw(t, R, P, neg(F)),      possible_world(t, R, P), not check_everywhere(neg(F)),      formula(neg(F)),      formula(F ).
check_on_pw(t, R , P , F1) :- t > 0, time(t), check_on_pw(t, R, P, and(F1, F2)), possible_world(t, R, P), not check_everywhere(and(F1, F2)), formula(and(F1, F2)), formula(F1), formula(F2).
check_on_pw(t, R , P , F2) :- t > 0, time(t), check_on_pw(t, R, P, and(F1, F2)), possible_world(t, R, P), not check_everywhere(and(F1, F2)), formula(and(F1, F2)), formula(F1), formula(F2).
check_on_pw(t, R , P , F1) :- t > 0, time(t), check_on_pw(t, R, P,  or(F1, F2)), possible_world(t, R, P), not check_everywhere( or(F1, F2)), formula( or(F1, F2)), formula(F1), formula(F2).
check_on_pw(t, R , P , F2) :- t > 0, time(t), check_on_pw(t, R, P,  or(F1, F2)), possible_world(t, R, P), not check_everywhere( or(F1, F2)), formula( or(F1, F2)), formula(F1), formula(F2).

check_on_pw(t, R1, P1, F ) :- t > 0, time(t), time(T1), time(T2), T2 <= T1, check_on_pw(t, R2, P2, b(AG , F)), possible_world(t, R1, P1), possible_world(t, R2, P2),
                              believes(t, R2, P2, t, R1, P1, AG), not check_everywhere(b(AG , F)), formula(b(AG , F)), formula(F), agent(AG).

check_on_pw(t, R1, P1, F ) :- t > 0, time(t), time(T1), time(T2), T2 <= T1, check_on_pw(t, R2, P2, c(AGS, F)), possible_world(t, R1, P1), possible_world(t, R2, P2),
                              believes(t, R2, P2, t, R1, P1, AG), not check_everywhere(c(AGS, F)), formula(c(AGS, F)), formula(F), agent(AG), agent_set(AGS), contains_ag(AGS, AG).

% check_on_pw(t, R1, P1, F ) :- t > 0, time(t), time(T1), time(T2), T2 <= T1, check_on_pw(t, R2, P2, c(AGS, F)), possible_world(t, R1, P1), possible_world(t, R2, P2),
%                               reaches(t, R2, P2, t, R1, P1, AGS), not check_everywhere(c(AGS, F)), formula(c(AGS, F)), formula(F), agent_set(AGS).

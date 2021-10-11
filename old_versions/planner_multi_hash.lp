%
% EMP encoding in ASP
%

#include <incmode>.

% ********** REACHABILITY **********

#program base.

time(0).

hash(P, 0, 0, P) :- possible_world(0, 0, P).

reaches(P1, P2, AGS) :- believes(P1, P2, AG), contains_ag(AGS, AG),
                        possible_world(0, 0, P1), possible_world(0, 0, P2), agent(AG), agent_set(AGS).

reaches(P1, P2, AGS) :- believes(P1, P3, AG), contains_ag(AGS, AG), reaches(P3, P2, AGS),
                        possible_world(0, 0, P1), possible_world(0, 0, P2), possible_world(0, 0, P3), agent(AG), agent_set(AGS).

#program step(t).

time(t).

% We associate to each triple (T, R, P) a unique integer value H
hash(H, t, R, P) :- t > 0, time(t), possible_world(t, R, P), initial_state_dimension(K), H = t*R + P+K.
:- hash(H, T1, R1, P1), hash(H, T2, R2, P2), possible_world(T1, R1, P1), possible_world(T2, R2, P2), T1 != T2, R1 != R2, P1 != P2.

% reaches/7: P1 reaches P2 with a path that contains only agents inside AGS
reaches(H1, H2, AGS) :- believes(H1, H2, AG), hash(H1, t, R1, P1), hash(H2, T2, R2, P2), agent(AG), contains_ag(AGS, AG),
                        possible_world(t, R1, P1), possible_world(T2, R2, P2), agent_set(AGS), t > 0, time(t), time(T2), T2 <= t.

reaches(H1, H2, AGS) :- believes(H1, H3, AG), reaches(H3, H2, AGS), agent(AG), agent_set(AGS), contains_ag(AGS, AG),
                        hash(H1, t, R1, P1), hash(H2, T2, R2, P2), hash(H3, T3, R3, P3), t > 0, time(t), time(T2), time(T3), T2 <= t, T3 <= t,
                        possible_world(t, R1, P1), possible_world(T2, R2, P2), possible_world(T3, R3, P3).

reaches_no_oblivious(t, H2) :- believes(H, H2, AG), hash(H, t-1, R, P), hash(H2, T2, R2, P2), not is_oblivious(t, AG),
                               pointed(t-1, R, P), possible_world(T2, R2, P2), t > 0, time(t), time(T2), T2 <= t.
                                       
reaches_no_oblivious(t, H2) :- reaches_no_oblivious(t, H1), believes(H1, H2, AG), not is_oblivious(t, AG),
                               hash(H1, T1, R1, P1), hash(H2, T2, R2, P2), possible_world(T1, R1, P1), possible_world(T2, R2, P2),
                               t > 0, time(t), time(T1), time(T2), T1 <= t, T2 <= t.

reaches_only_fully_obs(t, H2) :- believes(H, H2, AG), hash(H, t-1, R, P), hash(H2, T2, R2, P2), is_fully_obs(t, AG),
                                 pointed(t-1, R, P), possible_world(T2, R2, P2), t > 0, time(t), time(T2), T2 <= t.
                                       
reaches_only_fully_obs(t, H2) :- reaches_only_fully_obs(t, H1), believes(H1, H2, AG), is_fully_obs(t, AG),
                                 hash(H1, T1, R1, P1), hash(H2, T2, R2, P2), possible_world(T1, R1, P1), possible_world(T2, R2, P2),
                                 t > 0, time(t), time(T1), time(T2), T1 <= t, T2 <= t.

reaches_first_partially_obs(t, H2) :- believes(H, H2, AG), hash(H, t-1, R, P), hash(H2, T2, R2, P2), is_partial_obs(t, AG),
                                      pointed(t-1, R, P), possible_world(T2, R2, P2), t > 0, time(t), time(T2), T2 <= t.
                                       
reaches_first_partially_obs(t, H2) :- reaches_first_partially_obs(t, H1), believes(H1, H2, AG), not is_oblivious(t, AG),
                                      hash(H1, T1, R1, P1), hash(H2, T2, R2, P2), possible_world(T1, R1, P1), possible_world(T2, R2, P2),
                                      t > 0, time(t), time(T1), time(T2), T1 <= t, T2 <= t.


% ********** ENTAILMENT **********

#program base.

% Sensing or Announcement
soa(ACT) :- sensing(ACT).
soa(ACT) :- announcement(ACT).

literal( F) :- fluent(F).
literal(-F) :- fluent(F).

% Entailment of initially conditions. We use it to generate the initial state
entails_init(P,  F    )          :-     holds(P, F),                              good_initial_fluent_set(P), fluent(F), init_sf(F).
entails_init(P, -F    )          :- not holds(P, F),                              good_initial_fluent_set(P), fluent(F), init_sf(F).

entails_init(P, neg(F))          :- not entails_init(P, F ),                      good_initial_fluent_set(P), init_sf(neg(F)),      init_sf(F).
entails_init(P, and(F1, F2))     :-     entails_init(P, F1), entails_init(P, F2), good_initial_fluent_set(P), init_sf(and(F1, F2)), init_sf(F1), init_sf(F2).
entails_init(P,  or(F1, F2))     :-     entails_init(P, F1),                      good_initial_fluent_set(P), init_sf( or(F1, F2)), init_sf(F1), init_sf(F2).
entails_init(P,  or(F1, F2))     :-                          entails_init(P, F2), good_initial_fluent_set(P), init_sf( or(F1, F2)), init_sf(F1), init_sf(F2).

% Entailment of all the other formulas w.r.t. the calculated initial state
entails(P,  F    )         :-     holds(P, F),                    good_initial_fluent_set(P), possible_world(0, 0, P), fluent(F).
entails(P, -F    )         :- not holds(P, F),                    good_initial_fluent_set(P), possible_world(0, 0, P), fluent(F).

entails(P, neg(F))         :- not entails(P, F ),                 good_initial_fluent_set(P), possible_world(0, 0, P), formula(neg(F)),      formula(F).
entails(P, and(F1, F2))    :-     entails(P, F1), entails(P, F2), good_initial_fluent_set(P), possible_world(0, 0, P), formula(and(F1, F2)), formula(F1), formula(F2).
entails(P,  or(F1, F2))    :-     entails(P, F1),                 good_initial_fluent_set(P), possible_world(0, 0, P), formula( or(F1, F2)), formula(F1), formula(F2).
entails(P,  or(F1, F2))    :-                     entails(P, F2), good_initial_fluent_set(P), possible_world(0, 0, P), formula( or(F1, F2)), formula(F1), formula(F2).

entails(P , b(AG , F))     :- not not_entails(P , b(AG , F)),     good_initial_fluent_set(P), possible_world(0, 0, P), formula(b(AG , F)), formula(F), agent(AG).
entails(P , c(AGS, F))     :- not not_entails(P , c(AGS, F)),     good_initial_fluent_set(P), possible_world(0, 0, P), formula(c(AGS, F)), formula(F), agent_set(AGS).

not_entails(P1, b(AG , F)) :- not entails(P2, F ), believes(P1, P2, AG), good_initial_fluent_set(P1), good_initial_fluent_set(P2),
                              possible_world(0, 0, P1), possible_world(0, 0, P2), formula(b(AG , F)), formula(F), agent(AG).

not_entails(P1, c(AGS, F)) :- not entails(P2, F), reaches(P1, P2, AGS), good_initial_fluent_set(P1), good_initial_fluent_set(P2),
                              possible_world(0, 0, P1), possible_world(0, 0, P2), formula(c(AGS, F)), formula(F), agent_set(AGS).


#program step(t).

% entails/4: P entails the formula F
entails(H,  F    )      :- t > 0, time(t),     holds(H, F),                     possible_world(t, R, P), hash(H, t, R, P), fluent(F).
entails(H, -F    )      :- t > 0, time(t), not holds(H, F),                     possible_world(t, R, P), hash(H, t, R, P), fluent(F).

entails(H, neg(F))      :- t > 0, time(t), not entails(H, F ),                  possible_world(t, R, P), hash(H, t, R, P), formula(neg(F)),      formula(F).
entails(H, and(F1, F2)) :- t > 0, time(t),     entails(H, F1), entails(H, F2),  possible_world(t, R, P), hash(H, t, R, P), formula(and(F1, F2)), formula(F1), formula(F2).
entails(H,  or(F1, F2)) :- t > 0, time(t),     entails(H, F1),                  possible_world(t, R, P), hash(H, t, R, P), formula( or(F1, F2)), formula(F1), formula(F2).
entails(H,  or(F1, F2)) :- t > 0, time(t),                     entails(H, F2),  possible_world(t, R, P), hash(H, t, R, P), formula( or(F1, F2)), formula(F1), formula(F2).

entails(H,   b(AG , F)) :- t > 0, time(t), not not_entails(H, b(AG , F)), possible_world(t, R, P), hash(H, t, R, P), formula(b(AG , F)), formula(F), agent(AG).
entails(H,   c(AGS, F)) :- t > 0, time(t), not not_entails(H, c(AGS, F)), possible_world(t, R, P), hash(H, t, R, P), formula(c(AGS, F)), formula(F), agent_set(AGS).

not_entails(H1, b(AG , F)) :- t > 0, time(t), time(T2), T2 <= t, not entails(H2, F), believes(H1, H2, AG), hash(H1, t, R1, P1), hash(H2, T2, R2, P2),
                              possible_world(t, R1, P1), possible_world(T2, R2, P2), formula(b(AG , F)), formula(F), agent(AG).

not_entails(H1, c(AGS, F)) :- t > 0, time(t), time(T2), T2 <= t, not entails(H2, F), reaches(H1, H2, AGS), hash(H1, t, R1, P1), hash(H2, T2, R2, P2),
                              possible_world(t, R1, P1), possible_world(T2, R2, P2), formula(c(AGS, F)), formula(F), agent_set(AGS).


% ********** INITIAL STATE **********

#program base.

% Since we assume to deal with FINITARY S5-states, we only allow the initial conditions initially(F), where F has one of the following forms:
%  1. Phi (propositional formula)
%  2. C_all( B_i(Phi))
%  3. C_all( B_i(Phi) \/  B_i(-Phi))
%  4. C_all(-B_i(Phi) /\ -B_i(-Phi)) (this case doesn't add knowledge)

known_initially(F) :- fluent(F), initially(c(all_agents,  F)).
known_initially(F) :- fluent(F), initially(c(all_agents, -F)).

unknown_initially(F)            :- fluent(F), not known_initially(F).
initial_state_dimension(2 ** K) :- K = #count { F : fluent(F), unknown_initially(F) }.
initial_fluent_set(1..K)        :- initial_state_dimension(K).

% The initial conditions of form 1. determine the pointed possibility of the initial state
% A possibility is pointed if it entails exactly those fluents that hold initially
not_initial_pointed(P) :- good_initial_fluent_set(P), initially( F), not holds(P, F), fluent(F).
not_initial_pointed(P) :- good_initial_fluent_set(P), initially(-F),     holds(P, F), fluent(F).

pointed(0, 0, P) :- good_initial_fluent_set(P), not not_initial_pointed(P).

% The initial conditions of form 2. determine the possible worlds of the initial state
% A possibility is good if it entails all the propositional formulas which are COMMONLY KNOWN initially (2.)
    holds(P, F) :- initially(c(all_agents,  F)), initial_fluent_set(P), fluent(F).
not holds(P, F) :- initially(c(all_agents, -F)), initial_fluent_set(P), fluent(F).

% We impose that all the initial possibilities have a different fluent set
K/2 { holds(P, F) : initial_fluent_set(P) } K/2 :- unknown_initially(F), initial_state_dimension(K).

% All the initial fluent sets must be different
diffzero(P1, P2) :- good_initial_fluent_set(P1), good_initial_fluent_set(P2), holds(P1, F), not holds(P2, F),
                    fluent(F), P1 < P2, possible_world(0, 0, P1), possible_world(0, 0, P2).

diffzero(P1, P2) :- good_initial_fluent_set(P1), good_initial_fluent_set(P2), holds(P2, F), not holds(P1, F),
                    fluent(F), P1 < P2, possible_world(0, 0, P1), possible_world(0, 0, P2).

:- not diffzero(P1, P2), initial_fluent_set(P1), initial_fluent_set(P2), P1 < P2.

% *** Working on optimization #1... ***

% We impose a complete order on the fluent sets indices W_i w.r.t. their fluents
:- MF1 = #max { F : fluent(F), unknown_initially(F),     holds(P1, F), not holds(P2, F) },
   MF2 = #max { F : fluent(F), unknown_initially(F), not holds(P1, F),     holds(P2, F) },
   good_initial_fluent_set(P1), good_initial_fluent_set(P2), P1 < P2, MF1 > MF2.

% ***              End              ***

% So far we dealt with (commonly known) fluents. An initial fluent set is "good" if it entails all the fluent formulas F that are initial common knowledge
no_good_initial_fluent_set(P):- not entails_init(P, F), initially(c(all_agents, F)), init_sf(F), not literal(F), initial_fluent_set(P).
good_initial_fluent_set(P)   :- initial_fluent_set(P), not no_good_initial_fluent_set(P).

% For each good initial fluent set we create a correspoinding possible world
possible_world(0, 0, P) :- good_initial_fluent_set(P).

% The initial conditions of form 3. filter out some of the agents' beliefs inside the initial state
not_believes_initially(P1, P2, AG) :- not entails_init(P1, F),     entails_init(P2, F), good_initial_fluent_set(P1), good_initial_fluent_set(P2), P1 != P2, initially(c(all_agents, or(b(AG, F), b(AG, -F)))), formula(F).
not_believes_initially(P1, P2, AG) :-     entails_init(P1, F), not entails_init(P2, F), good_initial_fluent_set(P1), good_initial_fluent_set(P2), P1 != P2, initially(c(all_agents, or(b(AG, F), b(AG, -F)))), formula(F).

% The initial conditions of form 4. filter out some of the agents' beliefs inside the initial state
% not_believes_initially(P1, P2, AG) :-     entails(0, 0, P1, F),     entails(0, 0, P2, F), good_initial_fluent_set(P1), good_initial_fluent_set(P2), P1 != P2, initially(c(all_agents, neg(and(neg(b(AG, F)), neg(b(AG, -F)))))), formula(F).
% not_believes_initially(P1, P2, AG) :- not entails(0, 0, P1, F), not entails(0, 0, P2, F), good_initial_fluent_set(P1), good_initial_fluent_set(P2), P1 != P2, initially(c(all_agents, neg(and(neg(b(AG, F)), neg(b(AG, -F)))))), formula(F).

% TODO: TEST^^

% believes/7: the agent AG, inside P1, believes P2 to be possible
believes(P1, P2, AG) :- not not_believes_initially(P1, P2, AG), possible_world(0, 0, P1), possible_world(0, 0, P2),
                        good_initial_fluent_set(P1), good_initial_fluent_set(P2), agent(AG).


% ********** TRANSITION FUNCTION **********

#program step(t).

% is_executable/2: the action ACT is executable at time t
is_executable(t, ACT) :- t > 0, time(t), plan(t, ACT), action(ACT), pointed(t-1, R, P), executable(ACT, true).
is_executable(t, ACT) :- t > 0, time(t), plan(t, ACT), action(ACT), pointed(t-1, R, P), executable(ACT, EXEC), hash(H, t-1, R, P), entails(H, EXEC), formula(EXEC).

% is_executable_effect/6: the effect CAUSED/SENSED/ANN of the action ACT is executable at time t
is_executable_effect(t, ACT, H , CAUSED) :- t > 0, time(t), plan(t, ACT), ontic(ACT), causes(ACT, CAUSED, true ), pointed(t-1, R, P), hash(H, t-1, R, P).
is_executable_effect(t, ACT, H , CAUSED) :- t > 0, time(t), plan(t, ACT), ontic(ACT), causes(ACT, CAUSED, EEXEC), pointed(t-1, R, P), hash(H, t-1, R, P), entails(H, EEXEC), formula(EEXEC).

is_executable_effect(t, ACT, H , SENSED) :- t > 0, time(t), plan(t, ACT), sensing(ACT), determines(ACT, SENSED, true ), pointed(t-1, R, P), hash(H, t-1, R, P).
is_executable_effect(t, ACT, H , SENSED) :- t > 0, time(t), plan(t, ACT), sensing(ACT), determines(ACT, SENSED, EEXEC), pointed(t-1, R, P), hash(H, t-1, R, P), entails(H, EEXEC), formula(EEXEC).

is_executable_effect(t, ACT, H , ANN   ) :- t > 0, time(t), plan(t, ACT), announcement(ACT), announces(ACT, ANN, true ), pointed(t-1, R, P), hash(H, t-1, R, P).
is_executable_effect(t, ACT, H , ANN   ) :- t > 0, time(t), plan(t, ACT), announcement(ACT), announces(ACT, ANN, EEXEC), pointed(t-1, R, P), hash(H, t-1, R, P), entails(H, EEXEC), formula(EEXEC).

% For ontic actions: let P2 be a possibility that is reachable from the pointed one with a path labeled only with fully observant agents.
% Then the effect CAUSED is executable in P2 if P2 entails its executability condition EEXEC
is_executable_effect(t, ACT, H2, CAUSED) :- t > 0, time(t), time(T2), T2 < t, plan(t, ACT), ontic(ACT), causes(ACT, CAUSED, true ),
                                            possible_world(T2, R2, P2), hash(H2, T2, R2, P2), reaches_no_oblivious(t, H2).

is_executable_effect(t, ACT, H2, CAUSED) :- t > 0, time(t), time(T2), T2 < t, plan(t, ACT), ontic(ACT), causes(ACT, CAUSED, EEXEC), formula(EEXEC),
                                            possible_world(T2, R2, P2), hash(H2, T2, R2, P2), reaches_no_oblivious(t, H2), entails(H2, EEXEC).

% For sensing/announcement actions: let P2 be a possibility that is reachable from the pointed one with a path labeled only with fully or partially observant agents.
% Then the effect SENSED/ANN is executable in P2 if P2 entails its executability condition EEXEC
is_executable_effect(t, ACT, H2, SENSED) :- t > 0, time(t), time(T2), T2 < t, plan(t, ACT), sensing(ACT), determines(ACT, SENSED, true ), fluent(SENSED),
                                            possible_world(T2, R2, P2), hash(H2, T2, R2, P2), reaches_no_oblivious(t, H2).

is_executable_effect(t, ACT, H2, SENSED) :- t > 0, time(t), time(T2), T2 < t, plan(t, ACT), sensing(ACT), determines(ACT, SENSED, EEXEC), fluent(SENSED), formula(EEXEC),
                                            possible_world(T2, R2, P2), hash(H2, T2, R2, P2), reaches_no_oblivious(t, H2), entails(H2, EEXEC).

is_executable_effect(t, ACT, H2, ANN   ) :- t > 0, time(t), time(T2), T2 < t, plan(t, ACT), announcement(ACT), announces(ACT, ANN, true ), formula(ANN),
                                            possible_world(T2, R2, P2), hash(H2, T2, R2, P2), reaches_no_oblivious(t, H2).

is_executable_effect(t, ACT, H2, ANN   ) :- t > 0, time(t), time(T2), T2 < t, plan(t, ACT), announcement(ACT), announces(ACT, ANN, EEXEC), formula(ANN), formula(EEXEC),
                                            possible_world(T2, R2, P2), hash(H2, T2, R2, P2), reaches_no_oblivious(t, H2), entails(H2, EEXEC).


is_fully_obs  (t, AG) :- t > 0, time(t), plan(t, ACT), action(ACT), observes (ACT, AG, true), agent(AG).
is_partial_obs(t, AG) :- t > 0, time(t), plan(t, ACT),    soa(ACT), aware_of (ACT, AG, true), agent(AG).
is_oblivious  (t, AG) :- t > 0, time(t), plan(t, ACT), action(ACT), oblivious(ACT, AG),       agent(AG).

is_fully_obs  (t, AG) :- t > 0, time(t), plan(t, ACT), action(ACT), observes (ACT, AG, OBS ), agent(AG),     entails(H, OBS), formula(OBS), pointed(t-1, R, PP), hash(H, t-1, R, PP).
is_partial_obs(t, AG) :- t > 0, time(t), plan(t, ACT),    soa(ACT), aware_of (ACT, AG, OBS ), agent(AG),     entails(H, OBS), formula(OBS), pointed(t-1, R, PP), hash(H, t-1, R, PP).
is_oblivious  (t, AG) :- t > 0, time(t), plan(t, ACT), action(ACT), observes (ACT, AG, OBS ), agent(AG), not entails(H, OBS), formula(OBS), pointed(t-1, R, PP), hash(H, t-1, R, PP).
is_oblivious  (t, AG) :- t > 0, time(t), plan(t, ACT),    soa(ACT), aware_of (ACT, AG, OBS ), agent(AG), not entails(H, OBS), formula(OBS), pointed(t-1, R, PP), hash(H, t-1, R, PP).


% ONTIC ACTIONS

% pointed/3: the possibility P is pointed at time t
pointed(t, 2*MR+1, P) :- t > 0, time(t), plan(t, ACT), ontic(ACT), pointed(t-1, MR, P), possible_world(t, 2*MR+1, P).

% possible_world/3: at time t the possibility P with repetition R is associated with the fluent set W
% A triple (t, R, P) univocally identifies a possibility. When we update such a triple when an action occurres, we obtain the triple (t+1, R+MR, P),
% where MR is the maximum repetition that can be found at time t and P is a new possibility

% We explicitly generate an updated pointed possibility since it could be the case that no agent believes it at time t
possible_world(t,  2*MR+1, P) :- t > 0, time(t), plan(t, ACT), ontic(ACT), pointed(t-1, MR, P), possible_world(t-1, MR, P).

% Let P be a possibility that is reachable from the pointed one with a path labeled only with fully observant agents.
% Then we create the new possibility P.
possible_world(t, R2+MR+1, P) :- t > 0, time(t), time(T2), T2 < t, plan(t, ACT), ontic(ACT), possible_world(T2, R2, P), pointed(t-1, MR, PP),
                                 hash(H2, T2, R2, P), reaches_no_oblivious(t, H2).


% holds/2: the possibility PH2 contains the fluent F

% A fluent F holds in the possibility PH2 if it is caused by the ontic action ACT and if the effect is executable w.r.t. P
    holds(PH2, F) :- t > 0, time(t), time(T2), T2 < t, plan(t, ACT), ontic(ACT), fluent(F),
                     pointed(t-1, MR, PP), hash(H2, T2, R2, P), hash(PH2, t, R2+MR+1, P),
                     possible_world(t, R2+MR+1, P), possible_world(T2, R2, P), is_executable_effect(t, ACT, H2, F ).

% A fluent F must not hold in the fluent set phi(W) associated to the possibility P if -F is caused by the ontic action ACT and if the effect is executable w.r.t. P
not holds(PH2, F) :- t > 0, time(t), time(T2), T2 < t, plan(t, ACT), ontic(ACT), fluent(F),
                     pointed(t-1, MR, PP), hash(H2, T2, R2, P), hash(PH2, t, R2+MR+1, P),
                     possible_world(t, R2+MR+1, P), possible_world(T2, R2, P), is_executable_effect(t, ACT, H2, -F).

% Inertia: if a fluent F is not modified by the ontic action ACT, then it holds in phi(W) if it was true in W...
    holds(PH2, F) :- t > 0, time(t), time(T2), T2 < t, plan(t, ACT), ontic(ACT), holds(H2, F), fluent(F),
                     pointed(t-1, MR, PP), hash(H2, T2, R2, P), hash(PH2, t, R2+MR+1, P), possible_world(T2, R2, P), possible_world(t, R2+MR+1, P),
                     not is_executable_effect(t, ACT, H2, F), not is_executable_effect(t, ACT, H2, -F).

% ... and it must not hold in phi(W) if it was false in W.
not holds(PH2, F) :- t > 0, time(t), time(T2), T2 < t, plan(t, ACT), ontic(ACT), not holds(H2, F), fluent(F),
                     pointed(t-1, MR, PP), hash(H2, T2, R2, P), hash(PH2, t, R2+MR+1, P), possible_world(T2, R2, P), possible_world(t, R2+MR+1, P),
                     not is_executable_effect(t, ACT, H2, F), not is_executable_effect(t, ACT, H2, -F).


% Fully observant agents: if P1 -- AG --> P2 at time t' < t and AG is fully observant, then P1 -- AG --> P2 at time t
believes(PH1, PH2, AG) :- plan(t, ACT), ontic(ACT), believes(H1, H2, AG), is_fully_obs(t, AG),
                          possible_world(T1, R1, P1), possible_world(T2, R2, P2), hash(H1, T1, R1, P1), hash(H2, T2, R2, P2),
                          possible_world(t, R1+MR+1, P1), possible_world(t, R2+MR+1, P2), hash(PH1, t, R1+MR+1, P1), hash(PH2, t, R2+MR+1, P2),
                          pointed(t-1, MR, PP), t > 0, time(t), time(T1), time(T2), T1 <= t, T2 <= t, T2 <= T1.

% Oblivious agents: if P1 -- AG --> P2 at time t' < t and AG is oblivious, then P1 -- AG --> P2 at time t
believes(PH1,  H2, AG) :- plan(t, ACT), ontic(ACT), believes(H1, H2, AG), is_oblivious(t, AG),
                          possible_world(T1, R1, P1), possible_world(T2, R2, P2), hash(H1, T1, R1, P1), hash(H2, T2, R2, P2),
                          possible_world(t, R1+MR+1, P1), hash(PH1, t, R1+MR+1, P1),
                          pointed(t-1, MR, PP), t > 0, time(t), time(T1), time(T2), T1 <= t, T2 <= t, T2 <= T1.


% SENSING ACTIONS

% hold_sensed_effects/4: the possibility P2 agrees with the pointed possibility on the SENSED fluents of the sensing action ACT performed at time t
hold_sensed_effects(H , t) :- plan(t, ACT), sensing(ACT), pointed(t-1, R, PP), hash(H, t-1, R, PP), t > 0, time(t).
hold_sensed_effects(H2, t) :- plan(t, ACT), sensing(ACT), pointed(t-1, R, PP), possible_world(T2, R2, P2), hash(H, t-1, R, PP), hash(H2, T2, R2, P2),
                              0 { is_executable_effect(t, ACT, H2, SENSED) : determines(ACT, SENSED, _),     holds(H2, SENSED), not holds(H, SENSED) } 0,
                              0 { is_executable_effect(t, ACT, H2, SENSED) : determines(ACT, SENSED, _), not holds(H2, SENSED),     holds(H, SENSED) } 0,
                              reaches_no_oblivious(t, H2), t > 0, time(t), time(T2), T2 < t.


pointed(t, 2*MR+1, P) :- t > 0, plan(t, ACT), sensing(ACT), pointed(t-1, MR, P), possible_world(t, 2*MR+1, P), time(t).

% We explicitly generate an updated pointed possibility since it could be the case that no agent believes it at time t-1
possible_world(t,  2*MR+1, P) :- t > 0, plan(t, ACT), sensing(ACT), pointed(t-1, MR, P), possible_world(t-1, MR, P), time(t).

% As for ontic actions, we do the same for all the possibilities P2 that are reachable by fully-observant-labeled paths
possible_world(t, R2+MR+1, P) :- t > 0, plan(t, ACT), sensing(ACT), pointed(t-1, MR, PP), possible_world(T2, R2, P), T2 < t,
                                 hash(H2, T2, R2, P), reaches_only_fully_obs(t, H2), hold_sensed_effects(H2, t), time(t), time(T2).

% If a partially observant agent AG believes P2, then we create the new possibility P2
possible_world(t, R2+MR+1, P) :- t > 0, plan(t, ACT), sensing(ACT), pointed(t-1, MR, PP), possible_world(T2, R2, P), T2 < t,
                                 hash(H, t-1, MR, PP), hash(H2, T2, R2, P), believes(H, H2, AG), is_partial_obs(t, AG), time(t), time(T2).

% Let P be a possibility that is reachable from the pointed one with a path labeled only with fully/partially observant agents.
% Then we create the new possibility P.
possible_world(t, R2+MR+1, P) :- t > 0, plan(t, ACT), sensing(ACT), pointed(t-1, MR, PP), possible_world(T2, R2, P), T2 < t,
                                 hash(H2, T2, R2, P), reaches_first_partially_obs(t, H2), time(t), time(T2).

% Inertia: since holds depends both on a fluent set W AND a possibility P we must explicitly "copy" in P the fluents that hold in W
holds(PH2, F) :- plan(t, ACT), sensing(ACT), holds(H2, F), fluent(F), possible_world(t, R2+MR+1, P), possible_world(T2, R2, P),
                 hash(H2, T2, R2, P), hash(PH2, t, R2+MR+1, P), pointed(t-1, MR, PP), t > 0, time(t), time(T2), T2 < t.


% Fully observant agents (sigma, sigma): if P1 -- AG --> P2 at time t and AG is fully observant and BOTH P1 and P2 agree with the pointed possibility, then P1 -- AG --> P2 at time t+1
believes(PH1, PH2, AG) :- plan(t, ACT), sensing(ACT), believes(H1, H2, AG), is_fully_obs(t, AG), pointed(t-1, MR, PP),
                          possible_world(T1, R1, P1), possible_world(T2, R2, P2), hash(H1, T1, R1, P1), hash(H2, T2, R2, P2),
                          possible_world(t, R1+MR+1, P1), possible_world(t, R2+MR+1, P2), hash(PH1, t, R1+MR+1, P1), hash(PH2, t, R2+MR+1, P2),
                          hold_sensed_effects(H1, t), hold_sensed_effects(H2, t), t > 0, time(t), time(T1), time(T2), T1 <= t, T2 <= t, T2 <= T1.

% Fully observant agents (tau, tau): if P1 -- AG --> P2 at time t and AG is fully observant and NEITHER P1 nor P2 agree with the pointed possibility, then P1 -- AG --> P2 at time t+1
believes(PH1, PH2, AG) :- plan(t, ACT), sensing(ACT), believes(H1, H2, AG), is_fully_obs(t, AG), pointed(t-1, MR, PP),
                          possible_world(T1, R1, P1), possible_world(T2, R2, P2), hash(H1, T1, R1, P1), hash(H2, T2, R2, P2),
                          possible_world(t, R1+MR+1, P1), possible_world(t, R2+MR+1, P2), hash(PH1, t, R1+MR+1, P1), hash(PH2, t, R2+MR+1, P2),
                          not hold_sensed_effects(H1, t), not hold_sensed_effects(H2, t), t > 0, time(t), time(T1), time(T2), T1 <= t, T2 <= t, T2 <= T1.

% Partially observant agents: if P1 -- AG --> P2 at time t and AG is partially observant, then P1 -- AG --> P2 at time t+1
believes(PH1, PH2, AG) :- plan(t, ACT), sensing(ACT), believes(H1, H2, AG), is_partial_obs(t, AG), pointed(t-1, MR, PP),
                          possible_world(T1, R1, P1), possible_world(T2, R2, P2), hash(H1, T1, R1, P1), hash(H2, T2, R2, P2),
                          possible_world(t, R1+MR+1, P1), possible_world(t, R2+MR+1, P2), hash(PH1, t, R1+MR+1, P1), hash(PH2, t, R2+MR+1, P2),
                          t > 0, time(t), time(T1), time(T2), T1 <= t, T2 <= t, T2 <= T1.

% Oblivious agents: if P1 -- AG --> P2 at time t and AG is oblivious, then P1 -- AG --> P2 at time t+1
believes(PH1, H2 , AG) :- plan(t, ACT), sensing(ACT), believes(H1, H2, AG), is_oblivious(t, AG),
                          possible_world(T1, R1, P1), possible_world(T2, R2, P2), hash(H1, T1, R1, P1), hash(H2, T2, R2, P2),
                          possible_world(t, R1+MR+1, P1), hash(PH1, t, R1+MR+1, P1),
                          pointed(t-1, MR, PP), t > 0, time(t), time(T1), time(T2), T1 <= t, T2 <= t, T2 <= T1.

% ANNOUNCEMENT ACTIONS

% hold_announced_effects/4: the possibility P2 agrees with the pointed possibility on the ANN formulas of the announcement action ACT performed at time t
hold_announced_effects(H , t) :- plan(t, ACT), announcement(ACT), pointed(t-1, R, PP), hash(H, t-1, R, PP), t > 0, time(t).
hold_announced_effects(H2, t) :- plan(t, ACT), announcement(ACT), pointed(t-1, R, PP), possible_world(T2, R2, P2), hash(H, t-1, R, PP), hash(H2, T2, R2, P2),
                                 0 { is_executable_effect(t, ACT, H2, ANN) : announces(ACT, ANN, _),     entails(H2, ANN), not entails(H, ANN) } 0,
                                 0 { is_executable_effect(t, ACT, H2, ANN) : announces(ACT, ANN, _), not entails(H2, ANN),     entails(H, ANN) } 0,
                                 reaches_no_oblivious(t, H2), t > 0, time(t), time(T2), T2 < t.


pointed(t, 2*MR+1, P) :- t > 0, plan(t, ACT), announcement(ACT), pointed(t-1, MR, P), possible_world(t, 2*MR+1, P), time(t).

% We explicitly generate an updated pointed possibility since it could be the case that no agent believes it at time t-1
possible_world(t,  2*MR+1, P) :- t > 0, plan(t, ACT), announcement(ACT), pointed(t-1, MR, P), possible_world(t-1, MR, P), time(t).

% As for ontic actions, we do the same for all the possibilities P2 that are reachable by fully-observant-labeled paths
possible_world(t, R2+MR+1, P) :- t > 0, plan(t, ACT), announcement(ACT), pointed(t-1, MR, PP), possible_world(T2, R2, P), T2 < t,
                                 hash(H2, T2, R2, P), reaches_only_fully_obs(t, H2), hold_announced_effects(H2, t), time(t), time(T2).

% If a partially observant agent AG believes P2, then we create the new possibility P2
possible_world(t, R2+MR+1, P) :- t > 0, plan(t, ACT), announcement(ACT), pointed(t-1, MR, PP), possible_world(T2, R2, P), T2 < t,
                                 hash(H, t-1, MR, PP), hash(H2, T2, R2, P), believes(H, H2, AG), is_partial_obs(t, AG), time(t), time(T2).

% Let P be a possibility that is reachable from the pointed one with a path labeled only with fully/partially observant agents.
% Then we create the new possibility P.
possible_world(t, R2+MR+1, P) :- t > 0, plan(t, ACT), announcement(ACT), pointed(t-1, MR, PP), possible_world(T2, R2, P), T2 < t,
                                 hash(H2, T2, R2, P), reaches_first_partially_obs(t, H2), time(t), time(T2).


% Inertia: since holds depends both on a fluent set W AND a possibility P we must explicitly "copy" in P the fluents that hold in W
holds(t, R2+MR+1, P, F) :- t > 0, plan(t, ACT), announcement(ACT), possible_world(t, R2+MR+1, P), possible_world(T2, R2, P), T2 < t,
                                holds(T2, R2, P, F), fluent(F), pointed(t-1, MR, PP), time(t), time(T2).


% Fully observant agents (sigma, sigma): if P1 -- AG --> P2 at time t and AG is fully observant and BOTH P1 and P2 agree with the pointed possibility, then P1 -- AG --> P2 at time t+1
believes(PH1, PH2, AG) :- plan(t, ACT), announcement(ACT), believes(H1, H2, AG), is_fully_obs(t, AG), pointed(t-1, MR, PP),
                          possible_world(T1, R1, P1), possible_world(T2, R2, P2), hash(H1, T1, R1, P1), hash(H2, T2, R2, P2),
                          possible_world(t, R1+MR+1, P1), possible_world(t, R2+MR+1, P2), hash(PH1, t, R1+MR+1, P1), hash(PH2, t, R2+MR+1, P2),
                          hold_announced_effects(H1, t), hold_announced_effects(H2, t), t > 0, time(t), time(T1), time(T2), T1 <= t, T2 <= t, T2 <= T1.

% Fully observant agents (tau, tau): if P1 -- AG --> P2 at time t and AG is fully observant and NEITHER P1 nor P2 agree with the pointed possibility, then P1 -- AG --> P2 at time t+1
believes(PH1, PH2, AG) :- plan(t, ACT), announcement(ACT), believes(H1, H2, AG), is_fully_obs(t, AG), pointed(t-1, MR, PP),
                          possible_world(T1, R1, P1), possible_world(T2, R2, P2), hash(H1, T1, R1, P1), hash(H2, T2, R2, P2),
                          possible_world(t, R1+MR+1, P1), possible_world(t, R2+MR+1, P2), hash(PH1, t, R1+MR+1, P1), hash(PH2, t, R2+MR+1, P2),
                          not hold_announced_effects(H1, t), not hold_announced_effects(H2, t), t > 0, time(t), time(T1), time(T2), T1 <= t, T2 <= t, T2 <= T1.

% Partially observant agents: if P1 -- AG --> P2 at time t and AG is partially observant, then P1 -- AG --> P2 at time t+1
believes(PH1, PH2, AG) :- plan(t, ACT), announcement(ACT), believes(H1, H2, AG), is_partial_obs(t, AG), pointed(t-1, MR, PP),
                          possible_world(T1, R1, P1), possible_world(T2, R2, P2), hash(H1, T1, R1, P1), hash(H2, T2, R2, P2),
                          possible_world(t, R1+MR+1, P1), possible_world(t, R2+MR+1, P2), hash(PH1, t, R1+MR+1, P1), hash(PH2, t, R2+MR+1, P2),
                          t > 0, time(t), time(T1), time(T2), T1 <= t, T2 <= t, T2 <= T1.

% Oblivious agents: if P1 -- AG --> P2 at time t and AG is oblivious, then P1 -- AG --> P2 at time t+1
believes(PH1, H2 , AG) :- plan(t, ACT), announcement(ACT), believes(H1, H2, AG), is_oblivious(t, AG),
                          possible_world(T1, R1, P1), possible_world(T2, R2, P2), hash(H1, T1, R1, P1), hash(H2, T2, R2, P2),
                          possible_world(t, R1+MR+1, P1), hash(PH1, t, R1+MR+1, P1),
                          pointed(t-1, MR, PP), t > 0, time(t), time(T1), time(T2), T1 <= t, T2 <= t, T2 <= T1.

% #program base.

% good_triple(0, 0, P) :- possible_world(0, 0, P).
% rep(0).

#program step(t).

1 { plan(t, ACT) : action(ACT) } 1 :- t > 0, time(t).
:- 0 { plan(t, _) } 0.

% rep(2**(t-1)..2**t+1) :- t > 0, time(t).

% good_triple(t, R, P) :- t > 0, time(t), pointed(t-1, MR, PP), good_triple(t-1, MR, PP), rep(R), R <= 0..2*MR+1, good_initial_fluent_set(P).
% :- possible_world(t, R, P), not good_triple(t, R, P).

% Test
:- t > 0, plan(t, ACT), not is_executable(t, ACT), time(t).
% :- t > 0, plan(t, ACT), pointed(t-1, R, P), not entails(t-1, R, P, EXEC), action(ACT), executable(ACT, EXEC), formula(EXEC), time(t).
%%
% :- t > 0, plan(t, ACT), pointed(t-1, R, P), 0 { is_executable_effect(t, ACT, t-1, R, P, CAUSED) : causes(ACT, CAUSED, _) } 0, ontic(ACT), time(t).
%
%:- t > 0, reached_goal(t), plan(T2, ACT),    T2 > t.
%:- pointed(t, R, P), pointed(T1, RR, PP), T1 < t, t > 0, time(t), time(T1),
%  0 { formula(F): entails(t, R, P, F), not entails(T1, RR, PP, F)} 0,
%  0 { formula(F): not entails(t, R, P, F), entails(T1, RR, PP, F)} 0.


#program check(t).

:- not entails(H, F), pointed(t, R, P), hash(H, t, R, P), goal(F), formula(F), query(t).

% Display

#show plan/2.

% !!! Uncomment while printing the results !!!
% #show pointed/3.
% #show possible_world/3.
% #show believes/3.
% #show hash/4.
% #show holds/2.
%#show fluent/1.



% ********** BISIMULATION ********** (Dovier, ICLP 2015)

% Reflexivity and Symmetry
% bis(T1, R1, P1, T1, R1, P1) :- possible_world(T1, R1, P1).
% bis(T1, R1, P1, T2, R2, P2) :- possible_world(T1, R1, P1), possible_world(T2, R2, P2), bis(T2, R2, P2, T1, R1, P1).

% Nondeterministic choice
% { bis(T1, R1, P1, T2, R2, P2) } :- possible_world(T1, R1, P1), possible_world(T2, R2, P2).

% :- possible_world(T1, R1, P1), possible_world(T2, R2, P2), possible_world(T3, R3, P3),
%    bis(T1, R1, P1, T2, R2, P2), believes(T1, R1, P1, T3, R3, P3, AG), 0 { possible_world(T4, R4, P4) : bis(T3, R3, P3, T4, R4, P4), believes(T2, R2, P2, T4, R4, P4, AG) } 0.

% :- possible_world(T1, R1, P1), possible_world(T2, R2, P2),
%    bis(T1, R1, P1, T2, R2, P2), holds(T1, R1, P1, F), not holds(T2, R2, P2, F), fluent(F).

% Visited states
% :- pointed(T1, R1, P1), pointed(T2, R2, P2), T1 < T2, bis(T1, R1, P1, T2, R2, P2).


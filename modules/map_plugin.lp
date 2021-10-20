% ********** mA^\rho PLUGIN **********

#program step(t).

%%% Generating event spectrum %%%

% Ontic actions
e(t, ACT, sig) :- t > 0, time(t), plan(t, ACT), action(ACT), ontic(ACT).
e(t, ACT, eps) :- t > 0, time(t), plan(t, ACT), action(ACT), ontic(ACT).

de(t, ACT, sig) :- t > 0, time(t), plan(t, ACT), action(ACT), ontic(ACT).

pre(t, ACT, sig, true) :- t > 0, time(t), plan(t, ACT), action(ACT), ontic(ACT), executable(ACT, true).
pre(t, ACT, sig, F   ) :- t > 0, time(t), plan(t, ACT), action(ACT), ontic(ACT), executable(ACT, F), formula(F).
pre(t, ACT, eps, true) :- t > 0, time(t), plan(t, ACT), action(ACT), ontic(ACT).

post(t, ACT, sig, P, true) :- t > 0, time(t), plan(t, ACT), action(ACT), ontic(ACT), literal(P),     causes(ACT, P, true).
post(t, ACT, sig, P, F   ) :- t > 0, time(t), plan(t, ACT), action(ACT), ontic(ACT), literal(P),     causes(ACT, P, F), formula(F).
post(t, ACT, sig, P, P   ) :- t > 0, time(t), plan(t, ACT), action(ACT), ontic(ACT),    atom(P), not causes(ACT, P, _).
post(t, ACT, eps, P, P   ) :- t > 0, time(t), plan(t, ACT), action(ACT), ontic(ACT),    atom(P).

q(e(t, ACT, sig), e(t, ACT, sig), AG) :- t > 0, time(t), plan(t, ACT), action(ACT), ontic(ACT), agent(AG), is_fully_obs(t, AG).
q(e(t, ACT, sig), e(t, ACT, eps), AG) :- t > 0, time(t), plan(t, ACT), action(ACT), ontic(ACT), agent(AG), is_oblivious(t, AG).
q(e(t, ACT, eps), e(t, ACT, eps), AG) :- t > 0, time(t), plan(t, ACT), action(ACT), ontic(ACT), agent(AG).

% Sensing actions
e(t, ACT, sig) :- t > 0, time(t), plan(t, ACT), action(ACT), sensing(ACT).
e(t, ACT, tau) :- t > 0, time(t), plan(t, ACT), action(ACT), sensing(ACT), agent(AG), is_partial_obs(t, AG).
e(t, ACT, eps) :- t > 0, time(t), plan(t, ACT), action(ACT), sensing(ACT).

de(t, ACT, sig) :- t > 0, time(t), plan(t, ACT), action(ACT), sensing(ACT).

pre(t, ACT, sig,  P) :- t > 0, time(t), plan(t, ACT), action(ACT), sensing(ACT), executable(ACT, true), atom(P), determines(ACT, P).
pre(t, ACT, tau, -P) :- t > 0, time(t), plan(t, ACT), action(ACT), sensing(ACT), executable(ACT, true), atom(P), determines(ACT, P), agent(AG), is_partial_obs(t, AG).
pre(t, ACT, sig, and( P, F)) :- t > 0, time(t), plan(t, ACT), action(ACT), sensing(ACT), executable(ACT, F), atom(P), determines(ACT, P).
pre(t, ACT, tau, and(-P, F)) :- t > 0, time(t), plan(t, ACT), action(ACT), sensing(ACT), executable(ACT, F), atom(P), determines(ACT, P), agent(AG), is_partial_obs(t, AG).
pre(t, ACT, eps, true      ) :- t > 0, time(t), plan(t, ACT), action(ACT), sensing(ACT).

post(t, ACT, sig, P, P) :- t > 0, time(t), plan(t, ACT), action(ACT), sensing(ACT), atom(P).
post(t, ACT, tau, P, P) :- t > 0, time(t), plan(t, ACT), action(ACT), sensing(ACT), atom(P), agent(AG), is_partial_obs(t, AG).
post(t, ACT, eps, P, P) :- t > 0, time(t), plan(t, ACT), action(ACT), sensing(ACT), atom(P).

q(e(t, ACT, sig), e(t, ACT, sig), AG) :- t > 0, time(t), plan(t, ACT), action(ACT), sensing(ACT), agent(AG), is_fully_obs(t, AG).
q(e(t, ACT, tau), e(t, ACT, tau), AG) :- t > 0, time(t), plan(t, ACT), action(ACT), sensing(ACT), agent(AG), is_fully_obs(t, AG), agent(AG2), is_partial_obs(t, AG2).

q(e(t, ACT, sig), e(t, ACT, sig), AG) :- t > 0, time(t), plan(t, ACT), action(ACT), sensing(ACT), agent(AG), is_partial_obs(t, AG).
q(e(t, ACT, tau), e(t, ACT, tau), AG) :- t > 0, time(t), plan(t, ACT), action(ACT), sensing(ACT), agent(AG), is_partial_obs(t, AG).
q(e(t, ACT, sig), e(t, ACT, tau), AG) :- t > 0, time(t), plan(t, ACT), action(ACT), sensing(ACT), agent(AG), is_partial_obs(t, AG).
q(e(t, ACT, tau), e(t, ACT, sig), AG) :- t > 0, time(t), plan(t, ACT), action(ACT), sensing(ACT), agent(AG), is_partial_obs(t, AG).

q(e(t, ACT, sig), e(t, ACT, eps), AG) :- t > 0, time(t), plan(t, ACT), action(ACT), sensing(ACT), agent(AG), is_oblivious(t, AG).
q(e(t, ACT, eps), e(t, ACT, eps), AG) :- t > 0, time(t), plan(t, ACT), action(ACT), sensing(ACT), agent(AG).

% Announcement actions
e(t, ACT, sig) :- t > 0, time(t), plan(t, ACT), action(ACT), announcement(ACT).
e(t, ACT, tau) :- t > 0, time(t), plan(t, ACT), action(ACT), announcement(ACT), agent(AG), is_partial_obs(t, AG).
e(t, ACT, eps) :- t > 0, time(t), plan(t, ACT), action(ACT), announcement(ACT).

de(t, ACT, sig) :- t > 0, time(t), plan(t, ACT), action(ACT), announcement(ACT).

pre(t, ACT, sig,  P) :- t > 0, time(t), plan(t, ACT), action(ACT), announcement(ACT), executable(ACT, true), atom(P), announces(ACT, P).
pre(t, ACT, tau, -P) :- t > 0, time(t), plan(t, ACT), action(ACT), announcement(ACT), executable(ACT, true), atom(P), announces(ACT, P), agent(AG), is_partial_obs(t, AG).
pre(t, ACT, sig, and( P, F)) :- t > 0, time(t), plan(t, ACT), action(ACT), announcement(ACT), executable(ACT, F), atom(P), announces(ACT, P).
pre(t, ACT, tau, and(-P, F)) :- t > 0, time(t), plan(t, ACT), action(ACT), announcement(ACT), executable(ACT, F), atom(P), announces(ACT, P), agent(AG), is_partial_obs(t, AG).
pre(t, ACT, eps, true      ) :- t > 0, time(t), plan(t, ACT), action(ACT), announcement(ACT).

post(t, ACT, sig, P, P) :- t > 0, time(t), plan(t, ACT), action(ACT), announcement(ACT), atom(P).
post(t, ACT, tau, P, P) :- t > 0, time(t), plan(t, ACT), action(ACT), announcement(ACT), atom(P), agent(AG), is_partial_obs(t, AG).
post(t, ACT, eps, P, P) :- t > 0, time(t), plan(t, ACT), action(ACT), announcement(ACT), atom(P).

q(e(t, ACT, sig), e(t, ACT, sig), AG) :- t > 0, time(t), plan(t, ACT), action(ACT), announcement(ACT), agent(AG), is_fully_obs(t, AG).
q(e(t, ACT, tau), e(t, ACT, tau), AG) :- t > 0, time(t), plan(t, ACT), action(ACT), announcement(ACT), agent(AG), is_fully_obs(t, AG), agent(AG2), is_partial_obs(t, AG2).

q(e(t, ACT, sig), e(t, ACT, sig), AG) :- t > 0, time(t), plan(t, ACT), action(ACT), announcement(ACT), agent(AG), is_partial_obs(t, AG).
q(e(t, ACT, tau), e(t, ACT, tau), AG) :- t > 0, time(t), plan(t, ACT), action(ACT), announcement(ACT), agent(AG), is_partial_obs(t, AG).
q(e(t, ACT, sig), e(t, ACT, tau), AG) :- t > 0, time(t), plan(t, ACT), action(ACT), announcement(ACT), agent(AG), is_partial_obs(t, AG).
q(e(t, ACT, tau), e(t, ACT, sig), AG) :- t > 0, time(t), plan(t, ACT), action(ACT), announcement(ACT), agent(AG), is_partial_obs(t, AG).

q(e(t, ACT, sig), e(t, ACT, eps), AG) :- t > 0, time(t), plan(t, ACT), action(ACT), announcement(ACT), agent(AG), is_oblivious(t, AG).
q(e(t, ACT, eps), e(t, ACT, eps), AG) :- t > 0, time(t), plan(t, ACT), action(ACT), announcement(ACT), agent(AG).


%%% Checking observability relations %%%
is_fully_obs  (t, AG) :- t > 0, time(t), plan(t, ACT),       action(ACT),  observes(ACT, AG, true), agent(AG).
is_partial_obs(t, AG) :- t > 0, time(t), plan(t, ACT),      sensing(ACT),  aware_of(ACT, AG, true), agent(AG).
is_partial_obs(t, AG) :- t > 0, time(t), plan(t, ACT), announcement(ACT),  aware_of(ACT, AG, true), agent(AG).
is_oblivious  (t, AG) :- t > 0, time(t), plan(t, ACT),       action(ACT), oblivious(ACT, AG),       agent(AG).

is_fully_obs  (t, AG) :- t > 0, time(t), plan(t, ACT),       action(ACT),  observes(ACT, AG, F   ), agent(AG), formula(F),     entails(w(t-1, W, Ew), F), dw(t-1, W, Ew).
is_partial_obs(t, AG) :- t > 0, time(t), plan(t, ACT),      sensing(ACT),  aware_of(ACT, AG, F   ), agent(AG), formula(F),     entails(w(t-1, W, Ew), F), dw(t-1, W, Ew).
is_partial_obs(t, AG) :- t > 0, time(t), plan(t, ACT), announcement(ACT),  aware_of(ACT, AG, F   ), agent(AG), formula(F),     entails(w(t-1, W, Ew), F), dw(t-1, W, Ew).
is_oblivious  (t, AG) :- t > 0, time(t), plan(t, ACT),       action(ACT),  observes(ACT, AG, F   ), agent(AG), formula(F), not entails(w(t-1, W, Ew), F), dw(t-1, W, Ew).
is_oblivious  (t, AG) :- t > 0, time(t), plan(t, ACT),      sensing(ACT),  aware_of(ACT, AG, F   ), agent(AG), formula(F), not entails(w(t-1, W, Ew), F), dw(t-1, W, Ew).
is_oblivious  (t, AG) :- t > 0, time(t), plan(t, ACT), announcement(ACT),  aware_of(ACT, AG, F   ), agent(AG), formula(F), not entails(w(t-1, W, Ew), F), dw(t-1, W, Ew).

check_on_w(w(t-1, W, Ew), F) :- t > 0, time(t), plan(t, ACT),       action(ACT), observes(ACT, AG, F), agent(AG), formula(F), dw(t-1, W, Ew).
check_on_w(w(t-1, W, Ew), F) :- t > 0, time(t), plan(t, ACT),      sensing(ACT), aware_of(ACT, AG, F), agent(AG), formula(F), dw(t-1, W, Ew).
check_on_w(w(t-1, W, Ew), F) :- t > 0, time(t), plan(t, ACT), announcement(ACT), aware_of(ACT, AG, F), agent(AG), formula(F), dw(t-1, W, Ew).

#program base.
%%% Generating preconditions for epistemic actions %%%
formula(and( P, F)) :- action(ACT), sensing(ACT), executable(ACT, F), determines(ACT, P), formula(F), atom(P).
formula(and(-P, F)) :- action(ACT), sensing(ACT), executable(ACT, F), determines(ACT, P), formula(F), atom(P).
formula(-P)         :- action(ACT), sensing(ACT), executable(ACT, F), determines(ACT, P),             atom(P).

formula(and( P, F)) :- action(ACT), announcement(ACT), executable(ACT, F), announces(ACT, P), formula(F), atom(P).
formula(and(-P, F)) :- action(ACT), announcement(ACT), executable(ACT, F), announces(ACT, P), formula(F), atom(P).
formula(-P)         :- action(ACT), announcement(ACT), executable(ACT, F), announces(ACT, P),             atom(P).

% check_everywhere(and( P, F)) :- action(ACT), sensing(ACT), executable(ACT, F), determines(ACT, P), formula(and( P, F)), formula(F), atom(P).
% check_everywhere(and(-P, F)) :- action(ACT), sensing(ACT), executable(ACT, F), determines(ACT, P), formula(and(-P, F)), formula(F), atom(P).
% check_everywhere(-P)         :- action(ACT), sensing(ACT), executable(ACT, F), determines(ACT, P), formula(-P)        ,             atom(P).

% check_everywhere(and( P, F)) :- action(ACT), announcement(ACT), executable(ACT, F), announces(ACT, P), formula(and( P, F)), formula(F), atom(P).
% check_everywhere(and(-P, F)) :- action(ACT), announcement(ACT), executable(ACT, F), announces(ACT, P), formula(and(-P, F)), formula(F), atom(P).
% check_everywhere(-P)         :- action(ACT), announcement(ACT), executable(ACT, F), announces(ACT, P), formula(-P)        ,             atom(P).


% ********** INITIAL STATE **********

% Since we assume to deal with FINITARY S5-states, we only allow the initial conditions initially(F), where F has one of the following forms:
%  1. Phi (propositional formula)
%  2. C_all( B_i(Phi))
%  3. C_all( B_i(Phi) \/  B_i(-Phi))
%  4. C_all(-B_i(Phi) /\ -B_i(-Phi)) (this case doesn't add knowledge)

% Entailment of initially conditions. We use it to generate the initial state
entails_init(W,  P    )          :-     holds(w(0, W, __ini), P),                  initial_w(W), atom(P), init_sf(P).
entails_init(W, -P    )          :- not holds(w(0, W, __ini), P),                  initial_w(W), atom(P), init_sf(P).

entails_init(W, neg(F))          :- not entails_init(W, F ),                       initial_w(W), init_sf(neg(F)),      init_sf(F).
entails_init(W, and(F1, F2))     :-     entails_init(W, F1), entails_init(W, F2),  initial_w(W), init_sf(and(F1, F2)), init_sf(F1), init_sf(F2).
entails_init(W,  or(F1, F2))     :-     entails_init(W, F1),                       initial_w(W), init_sf( or(F1, F2)), init_sf(F1), init_sf(F2).
entails_init(W,  or(F1, F2))     :-                          entails_init(W, F2),  initial_w(W), init_sf( or(F1, F2)), init_sf(F1), init_sf(F2).


known_initially(P) :- atom(P), initially(c(all_agents,  P)).
known_initially(P) :- atom(P), initially(c(all_agents, -P)).

unknown_initially(P)            :- atom(P), not known_initially(P).
initial_state_dimension(2 ** K) :- K = #count { P : atom(P), unknown_initially(P) }.
initial_w(1..K)                 :- initial_state_dimension(K).

% The initial conditions of form 1. determine the designated possible world of the initial state
% A possible world is designated if it entails exactly those atoms that hold initially
not_initial_dw(W) :- good_initial_w(W), initially( P), not holds(w(0, W, __ini), P), atom(P).
not_initial_dw(W) :- good_initial_w(W), initially(-P),     holds(w(0, W, __ini), P), atom(P).

dw(0, W, __ini) :- good_initial_w(W), not not_initial_dw(W).

% The initial conditions of form 2. determine the possible worlds of the initial state
% A possible world is good if it entails all the propositional formulas which are COMMONLY KNOWN initially (2.)
    holds(w(0, W, __ini), P) :- initially(c(all_agents,  P)), initial_w(W), atom(P).
not holds(w(0, W, __ini), P) :- initially(c(all_agents, -P)), initial_w(W), atom(P).

% We impose that all the initial possibilities have a different atom set
K/2 { holds(w(0, W, __ini), P) : initial_w(W) } K/2 :- unknown_initially(P), initial_state_dimension(K).

% All the initial atom sets must be different
diffzero(W1, W2) :- initial_w(W1), initial_w(W2), holds(w(0, W1, __ini), P), not holds(w(0, W2, __ini), P),
                    atom(P), unknown_initially(F), W1 < W2.

diffzero(W1, W2) :- initial_w(W1), initial_w(W2), holds(w(0, W2, __ini), P), not holds(w(0, W1, __ini), P),
                    atom(P), unknown_initially(F), W1 < W2.

:- not diffzero(W1, W2), initial_w(W1), initial_w(W2), W1 < W2.

:- 0 { dw(0, W, __ini) : good_initial_w(W) } 0.

% We impose a complete order on the atom sets indices W_i w.r.t. their atoms
:- MP1 = #max { P : atom(P), unknown_initially(P),     holds(w(0, W1, __ini), P), not holds(w(0, W2, __ini), P) },
   MP2 = #max { P : atom(P), unknown_initially(P), not holds(w(0, W1, __ini), P),     holds(w(0, W2, __ini), P) },
   initial_w(W1), initial_w(W2), W1 < W2, MP1 > MP2.

% So far we dealt with (commonly known) atoms. An initial possible world is "good" if it entails all the atom formulas F that are initial common knowledge
literal( P) :- atom(P).
literal(-P) :- atom(P).

no_good_initial_w(W) :- not entails_init(W, F), initially(c(all_agents, F)), init_sf(F), not literal(F), initial_w(W).
good_initial_w(W)    :- initial_w(W), not no_good_initial_w(W).

% For each good initial possible world we create a correspoinding possible world
w(0, W, __ini) :- good_initial_w(W).

% The initial conditions of form 3. filter out some of the agents' beliefs inside the initial state
no_good_initial_r(W1, W2, AG) :- not entails(w(0, W1, __ini), F),     entails(w(0, W2, __ini), F), good_initial_w(W1), good_initial_w(W2), W1 != W2, initially(c(all_agents, or(b(AG, F), b(AG, neg(F))))), atom(F). % \todo: WHY ATOM???
no_good_initial_r(W1, W2, AG) :-     entails(w(0, W1, __ini), F), not entails(w(0, W2, __ini), F), good_initial_w(W1), good_initial_w(W2), W1 != W2, initially(c(all_agents, or(b(AG, F), b(AG, neg(F))))), atom(F). % \todo: WHY ATOM???

check_on_w(w(0, W, __ini), F) :- good_initial_w(W), initially(c(all_agents, or(b(AG, F), b(AG, neg(F))))), atom(F).

% The initial conditions of form 4. filter out some of the agents' beliefs inside the initial state
%no_good_initial_r(W1, W2, AG) :-     entails(0, 0, W1, F),     entails(0, 0, W2, F), good_initial_w(W1), good_initial_w(W2), W1 != W2, initially(c(all_agents, and(neg(b(AG, F)), neg(b(AG, neg(F)))))), formula(F).
%no_good_initial_r(W1, W2, AG) :- not entails(0, 0, W1, F), not entails(0, 0, W2, F), good_initial_w(W1), good_initial_w(W2), W1 != W2, initially(c(all_agents, and(neg(b(AG, F)), neg(b(AG, neg(F)))))), formula(F).

% believes/7: the agent AG, inside W1, believes W2 to be possible
r(w(0, W1, __ini), w(0, W2, __ini), AG) :- not no_good_initial_r(W1, W2, AG), w(0, W1, __ini), w(0, W2, __ini),
                                           good_initial_w(W1), good_initial_w(W2), agent(AG).


%%% Formulae stuff %%%
% % check_on_designated/1: DEL formulae that need to be verified only in the designated worlds
% check_on_designated(F) :- formula(F), executable(_,    F).     % Executability conditions are to be checked only in the designated world
% check_on_designated(F) :- formula(F),   observes(_, _, F).     % Observability conditions are to be checked only in the designated world
% check_on_designated(F) :- formula(F),   aware_of(_, _, F).
% check_on_designated(F) :- formula(F),       goal(F).           % Goal conditions are to be checked only in the designated world

% % check_everywhere/1: DEL formulae that need to be verified in every world
% check_everywhere(F) :- formula(F),     causes(_, _, F).     % Effects executability conditions are to be checked in each world
% check_everywhere(F) :- formula(F),  announces(   _, F).     % The effects of announcement actions are to be checked in each world

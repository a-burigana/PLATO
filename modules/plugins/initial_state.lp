#program base.

% ********** INITIAL STATE **********

% Since we assume to deal with FINITARY S5-states, we only allow the initial conditions initially(F), where F has one of the following forms:
%  1. Phi (propositional formula)
%  2. C_all( B_i(Phi))
%  3. C_all( B_i(Phi) \/  B_i(-Phi))
%  4. C_all(-B_i(Phi) /\ -B_i(-Phi)) (this case doesn't add knowledge)

% Entailment of initially conditions. We use it to generate the initial state
entails_init(W,  P)              :-     holds(0, W,  P),                           initial_w(W), atom(P), init_sf(P).
entails_init(W, -P)              :-     holds(0, W, -P),                           initial_w(W), atom(P), init_sf(P).

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
not_initial_dw(W) :- good_initial_w(W), initially( P), holds(0, W, -P), atom(P).
not_initial_dw(W) :- good_initial_w(W), initially(-P), holds(0, W,  P), atom(P).

dw(0, W) :- good_initial_w(W), not not_initial_dw(W).

% The initial conditions of form 2. determine the possible worlds of the initial state
% A possible world is good if it entails all the propositional formulas which are COMMONLY KNOWN initially (2.)
holds(0, W,  P) :- initially(c(all_agents,  P)), initial_w(W), atom(P).
holds(0, W, -P) :- initially(c(all_agents, -P)), initial_w(W), atom(P).

% We impose that all the initial possibilities have a different atom set
K/2 { holds(0, W,  P) : initial_w(W) } K/2 :- unknown_initially(P), initial_state_dimension(K).
K/2 { holds(0, W, -P) : initial_w(W) } K/2 :- unknown_initially(P), initial_state_dimension(K).
% TODO: use "not holds(0, W, P)" instead of "holds(0, W, -P)"

% An atom is valuated either true or false in a world
:- holds(0, W, P), holds(0, W, -P), initial_w(W).

% All the initial atom sets must be different
diffzero(W1, W2) :- initial_w(W1), initial_w(W2), holds(0, W1, P), holds(0, W2, -P),
                    atom(P), unknown_initially(F), W1 < W2.

diffzero(W1, W2) :- initial_w(W1), initial_w(W2), holds(0, W2, P), holds(0, W1, -P),
                    atom(P), unknown_initially(F), W1 < W2.

:- not diffzero(W1, W2), initial_w(W1), initial_w(W2), W1 < W2.

:- 0 { dw(0, W) : good_initial_w(W) } 0.

% We impose a complete order on the atom sets indices W_i w.r.t. their atoms
:- MP1 = #max { P : atom(P), unknown_initially(P), holds(0, W1,  P), holds(0, W2, -P) },
   MP2 = #max { P : atom(P), unknown_initially(P), holds(0, W1, -P), holds(0, W2,  P) },
   initial_w(W1), initial_w(W2), W1 < W2, MP1 > MP2.

% So far we dealt with (commonly known) atoms. An initial possible world is "good" if it entails all the atom formulas F that are initial common knowledge
literal( P) :- atom(P).
literal(-P) :- atom(P).

no_good_initial_w(W) :- not entails_init(W, F), initially(c(all_agents, F)), init_sf(F), not literal(F), initial_w(W).
good_initial_w(W)    :- initial_w(W), not no_good_initial_w(W).

% For each good initial possible world we create a correspoinding possible world
w(0, W) :- good_initial_w(W).

% The initial conditions of form 3. filter out some of the agents' beliefs inside the initial state
no_good_initial_r(W1, W2, AG) :- not entails_init(W1, F),     entails_init(W2, F), good_initial_w(W1), good_initial_w(W2), W1 != W2, initially(c(all_agents, or(b(AG, F), b(AG, neg(F))))), atom(F).
no_good_initial_r(W1, W2, AG) :-     entails_init(W1, F), not entails_init(W2, F), good_initial_w(W1), good_initial_w(W2), W1 != W2, initially(c(all_agents, or(b(AG, F), b(AG, neg(F))))), atom(F).
% \todo: WHY ATOM???

% believes/7: the agent AG, inside W1, believes W2 to be possible
r(0, W1, 0, W2, AG) :- not no_good_initial_r(W1, W2, AG), w(0, W1), w(0, W2),
                       good_initial_w(W1), good_initial_w(W2), agent(AG).

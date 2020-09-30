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
initial_possibility(1..K)        :- initial_state_dimension(K).

% The initial conditions of form 1. determine the pointed possibility of the initial state
% A possibility is pointed if it entails exactly those fluents that hold initially
not_initial_pointed(P) :- good_initial_possibility(P), initially( F), not holds(0, 0, P, F), fluent(F).
not_initial_pointed(P) :- good_initial_possibility(P), initially(-F),     holds(0, 0, P, F), fluent(F).

pointed(0, 0, P) :- good_initial_possibility(P), not not_initial_pointed(P).

% The initial conditions of form 2. determine the possible worlds of the initial state
% A possibility is good if it entails all the propositional formulas which are COMMONLY KNOWN initially (2.)
    holds(0, 0, P, F) :- initially(c(all_agents,  F)), initial_possibility(P), fluent(F).
not holds(0, 0, P, F) :- initially(c(all_agents, -F)), initial_possibility(P), fluent(F).

% We impose that all the initial possibilities have a different fluent set
K/2 { holds(0, 0, P, F) : initial_possibility(P) } K/2 :- unknown_initially(F), initial_state_dimension(K).

% All the initial fluent sets must be different
diffzero(P1, P2) :- initial_possibility(P1), initial_possibility(P2), holds(0, 0, P1, F), not holds(0, 0, P2, F),
                    fluent(F), unknown_initially(F), P1 < P2.

diffzero(P1, P2) :- initial_possibility(P1), initial_possibility(P2), holds(0, 0, P2, F), not holds(0, 0, P1, F),
                    fluent(F), unknown_initially(F), P1 < P2.

:- not diffzero(P1, P2), initial_possibility(P1), initial_possibility(P2), P1 < P2.

:- 0 { pointed(0, 0, P) : good_initial_possibility(P) } 0.

% We impose a complete order on the fluent sets indices W_i w.r.t. their fluents
:- MF1 = #max { F : fluent(F), unknown_initially(F),     holds(0, 0, P1, F), not holds(0, 0, P2, F) },
   MF2 = #max { F : fluent(F), unknown_initially(F), not holds(0, 0, P1, F),     holds(0, 0, P2, F) },
   initial_possibility(P1), initial_possibility(P2), P1 < P2, MF1 > MF2.

% So far we dealt with (commonly known) fluents. An initial possibility is "good" if it entails all the fluent formulas F that are initial common knowledge
literal( F) :- fluent(F).
literal(-F) :- fluent(F).

no_good_initial_possibility(P) :- not entails_init(P, F), initially(c(all_agents, F)), init_sf(F), not literal(F), initial_possibility(P).
good_initial_possibility(P)    :- initial_possibility(P), not no_good_initial_possibility(P).

% For each good initial possibility we create a correspoinding possible world
possible_world(0, 0, P) :- good_initial_possibility(P).

% The initial conditions of form 3. filter out some of the agents' beliefs inside the initial state
not_believes_initially(P1, P2, AG) :- not entails(0, 0, P1, F),     entails(0, 0, P2, F), good_initial_possibility(P1), good_initial_possibility(P2), P1 != P2, initially(c(all_agents, or(b(AG, F), b(AG, neg(F))))), fluent(F).
not_believes_initially(P1, P2, AG) :-     entails(0, 0, P1, F), not entails(0, 0, P2, F), good_initial_possibility(P1), good_initial_possibility(P2), P1 != P2, initially(c(all_agents, or(b(AG, F), b(AG, neg(F))))), fluent(F).

% The initial conditions of form 4. filter out some of the agents' beliefs inside the initial state
%not_believes_initially(P1, P2, AG) :-     entails(0, 0, P1, F),     entails(0, 0, P2, F), good_initial_possibility(P1), good_initial_possibility(P2), P1 != P2, initially(c(all_agents, and(neg(b(AG, F)), neg(b(AG, neg(F)))))), formula(F).
%not_believes_initially(P1, P2, AG) :- not entails(0, 0, P1, F), not entails(0, 0, P2, F), good_initial_possibility(P1), good_initial_possibility(P2), P1 != P2, initially(c(all_agents, and(neg(b(AG, F)), neg(b(AG, neg(F)))))), formula(F).

% believes/7: the agent AG, inside P1, believes P2 to be possible
believes(0, 0, P1, 0, 0, P2, AG) :- not not_believes_initially(P1, P2, AG), possible_world(0, 0, P1), possible_world(0, 0, P2),
                                    good_initial_possibility(P1), good_initial_possibility(P2), agent(AG).

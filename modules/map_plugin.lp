% ********** mA^\rho PLUGIN **********

#program base.
epistemic(ACT) :- sensing(ACT).
epistemic(ACT) :- announcement(ACT).

%%% Generating event spectrum %%%

% Null event
ne(ACT, eps) :- action(ACT).

% Ontic actions
e(ACT, osig) :- action(ACT), ontic(ACT).
e(ACT, eps ) :- action(ACT), ontic(ACT).

de(ACT, osig) :- action(ACT), ontic(ACT).

dpre(ACT, osig, true) :- action(ACT), ontic(ACT), executable(ACT, true).
dpre(ACT, osig, F   ) :- action(ACT), ontic(ACT), executable(ACT, F), formula(F).
pre(ACT, osig, true) :- action(ACT), ontic(ACT).

post(ACT, osig, P, true) :- action(ACT), ontic(ACT), literal(P), causes(ACT, P, true).
post(ACT, osig, P, F   ) :- action(ACT), ontic(ACT), literal(P), causes(ACT, P, F), formula(F).

no_post(ACT, eps)        :- action(ACT), ontic(ACT).

metaq(ACT, osig, osig, f_obs) :- action(ACT), ontic(ACT).
metaq(ACT, osig, eps , obl  ) :- action(ACT), ontic(ACT).
metaq(ACT, eps , eps , all  ) :- action(ACT), ontic(ACT).

% Sensing actions
e(ACT, ssig) :- action(ACT), sensing(ACT).
e(ACT, stau) :- action(ACT), sensing(ACT).
e(ACT, eps ) :- action(ACT), sensing(ACT).

de(ACT, ssig) :- action(ACT), sensing(ACT).

dpre(ACT, ssig, F) :- action(ACT), sensing(ACT), executable(ACT, F), formula(F).
pre(ACT, ssig,  P) :- action(ACT), sensing(ACT), determines(ACT, P), atom(P).
pre(ACT, stau, -P) :- action(ACT), sensing(ACT), determines(ACT, P), atom(P).

formula(-P) :- action(ACT), sensing(ACT), determines(ACT, P), atom(P).

metaq(ACT, ssig, ssig, f_obs) :- action(ACT), sensing(ACT).
metaq(ACT, stau, stau, f_obs) :- action(ACT), sensing(ACT).

metaq(ACT, ssig, ssig, p_obs) :- action(ACT), sensing(ACT).
metaq(ACT, stau, stau, p_obs) :- action(ACT), sensing(ACT).
metaq(ACT, ssig, stau, p_obs) :- action(ACT), sensing(ACT).
metaq(ACT, stau, ssig, p_obs) :- action(ACT), sensing(ACT).

metaq(ACT, ssig, eps , obl  ) :- action(ACT), sensing(ACT).
metaq(ACT, stau, eps , obl  ) :- action(ACT), sensing(ACT).
metaq(ACT, eps , eps , all  ) :- action(ACT), sensing(ACT).

% Announcement actions
e(ACT, asig) :- action(ACT), announcement(ACT).
e(ACT, atau) :- action(ACT), announcement(ACT).
e(ACT, eps ) :- action(ACT), announcement(ACT).

de(ACT, asig) :- action(ACT), announcement(ACT).

dpre(ACT, asig, F) :- action(ACT), announcement(ACT), executable(ACT, F), formula(F).
pre(ACT, asig,  P) :- action(ACT), announcement(ACT), announces(ACT, P), atom(P).
pre(ACT, atau, -P) :- action(ACT), announcement(ACT), announces(ACT, P), atom(P).

formula(-P) :- action(ACT), announcement(ACT), announces(ACT, P), atom(P).

metaq(ACT, asig, asig, f_obs) :- action(ACT), announcement(ACT).
metaq(ACT, atau, atau, f_obs) :- action(ACT), announcement(ACT).

metaq(ACT, asig, asig, p_obs) :- action(ACT), announcement(ACT).
metaq(ACT, atau, atau, p_obs) :- action(ACT), announcement(ACT).
metaq(ACT, asig, atau, p_obs) :- action(ACT), announcement(ACT).
metaq(ACT, atau, asig, p_obs) :- action(ACT), announcement(ACT).

metaq(ACT, asig, eps , obl  ) :- action(ACT), announcement(ACT).
metaq(ACT, atau, eps , obl  ) :- action(ACT), announcement(ACT).
metaq(ACT, eps , eps , all  ) :- action(ACT), announcement(ACT).


#program step(t).

check_on_w(t, t, W, Ew, Hw, F) :- time(t), action(ACT), dpre(ACT, E, F), formula(F),
                              w(t, W, Ew, Hw), e(ACT, E), dw(t, W, Ew, Hw), de(ACT, E).

%%% Same path with meta-q
same_path(t, t, W, Ew, Hwo, E, Hw ) :- time(t), plan(t, ACT), action(ACT), w(t, W, Ew, Hwo), e(ACT, E),
                                  dw(t, W, Ew, Hwo), de(ACT, E), Hw = (Hwo+t+1)*(Hwo+t+2)/2 + t+1.

same_path(t, T, W, Ew, Hwo, E, Hw ) :- time(t), time(T), T <= t, plan(t, ACT), action(ACT), agent(AG), is_fully_obs(t, AG),
                                  w(T, W, Ew, Hwo), e(ACT, E), w(t, W2, Ew2, Hw2), e(ACT, E2), same_path(t, t, W2, Ew2, Hw2, E2, _),
                                  r(t, W2, Ew2, Hw2, T, W, Ew, Hwo, AG), metaq(ACT, E2, E, f_obs), Hw = (Hwo+t+1)*(Hwo+t+2)/2 + t+1.

same_path(t, T, W, Ew, Hwo, E, Hw ) :- time(t), time(T), T <= t, plan(t, ACT), action(ACT), agent(AG), is_partial_obs(t, AG),
                                  w(T, W, Ew, Hwo), e(ACT, E), w(t, W2, Ew2, Hw2), e(ACT, E2), same_path(t, t, W2, Ew2, Hw2, E2, _),
                                  r(t, W2, Ew2, Hw2, T, W, Ew, Hwo, AG), metaq(ACT, E2, E, p_obs), Hw = (Hwo+t+1)*(Hwo+t+2)/2 + t+1.

same_path(t, T, W, Ew, Hwo, E, Hwo) :- time(t), time(T), T <= t, plan(t, ACT), action(ACT), agent(AG), is_oblivious(t, AG),
                                  w(T, W, Ew, Hwo), e(ACT, E), w(t, W2, Ew2, Hw2), e(ACT, E2), same_path(t, t, W2, Ew2, Hw2, E2, _),
                                  r(t, W2, Ew2, Hw2, T, W, Ew, Hwo, AG), metaq(ACT, E2, E, obl  ).

same_path(t, T, W, Ew, Hwo, E, Hwo) :- time(t), time(T), T <= t, plan(t, ACT), action(ACT), agent(AG),
                                  w(T, W, Ew, Hwo), e(ACT, E), w(t, W2, Ew2, Hw2), e(ACT, E2), same_path(t, t, W2, Ew2, Hw2, E2, _),
                                  r(t, W2, Ew2, Hw2, T, W, Ew, Hwo, AG), metaq(ACT, E2, E, all  ).


% pf(t+1, Hwo, Hw) :- time(t), time(Tw), Tw <= t, plan(t, ACT), action(ACT), e(ACT, E), w(Tw, W, Ew, Hwo),
%                     same_path(t, Tw, W, Ew, Hwo, E), Hw = (Hwo+t+1)*(Hwo+t+2)/2 + t+1.


dw(t+1, W, E, Hw) :- time(t), plan(t, ACT), action(ACT), w(t, W, Ewo, Hwo), e(ACT, E), dw(t, W, Ewo, Hwo), de(ACT, E),
                  dpre(ACT, E, true), same_path(t, t, W, Ewo, Hwo, E, Hw). %, pf(t+1, Hwo, Hw).

dw(t+1, W, E, Hw) :- time(t), plan(t, ACT), action(ACT), w(t, W, Ewo, Hwo), e(ACT, E), dw(t, W, Ewo, Hwo), de(ACT, E),
                  dpre(ACT, E, Fpre), formula(Fpre), entails(t, t, W, Ewo, Hwo, Fpre), same_path(t, t, W, Ewo, Hwo, E, Hw). %, pf(t+1, Hwo, Hw).


w(t+1, W, E, Hw) :- time(t), plan(t, ACT), action(ACT), w(t, W, Ewo, Hwo), e(ACT, E), not ne(ACT, E),
                 dw(t, W, Ewo, Hwo), de(ACT, E), dw(t+1, W, E, Hw), same_path(t, t, W, Ewo, Hwo, E, Hw). % , pf(t+1, Hwo, Hw).

w(t+1, W, E, Hw) :- time(t), time(T), T <= t, plan(t, ACT), action(ACT), w(T, W, Ewo, Hwo), e(ACT, E), not ne(ACT, E),
                 pre(ACT, E, true), same_path(t, T, W, Ewo, Hwo, E, Hw). % , pf(t+1, Hwo, Hw).

w(t+1, W, E, Hw) :- time(t), time(T), T <= t, plan(t, ACT), action(ACT), w(T, W, Ewo, Hwo), e(ACT, E), not ne(ACT, E),
                 pre(ACT, E, Fpre), formula(Fpre), entails(t, T, W, Ewo, Hwo, Fpre),
                 same_path(t, T, W, Ewo, Hwo, E, Hw). % , pf(t+1, Hwo, Hw).


%%% Accessibility relations with meta-q
r(t+1, W, E1, Hw,
  t+1, V, E2, Hv , AG) :- time(t), time(Tw), time(Tv), Tw <= t, Tv <= t, plan(t, ACT), action(ACT), agent(AG), is_fully_obs(t, AG),
                      w(Tw, W, Ew, Hwo), w(Tv, V, Ev, Hvo), e(ACT, E1), e(ACT, E2), not ne(ACT, E1), not ne(ACT, E2),
                      w(t+1, W, E1, Hw), w(t+1, V, E2, Hv), same_path(t, Tw, W, Ew, Hwo, E1, Hw), same_path(t, Tv, V, Ev, Hvo, E2, Hv), % pf(t+1, Hwo, Hw), pf(t+1, Hvo, Hv),
                      r(Tw, W, Ew, Hwo, Tv, V, Ev, Hvo, AG), metaq(ACT, E1, E2, f_obs).

r(t+1, W, E1, Hw,
  t+1, V, E2, Hv , AG) :- time(t), time(Tw), time(Tv), Tw <= t, Tv <= t, plan(t, ACT), action(ACT), agent(AG), is_partial_obs(t, AG),
                      w(Tw, W, Ew, Hwo), w(Tv, V, Ev, Hvo), e(ACT, E1), e(ACT, E2), not ne(ACT, E1), not ne(ACT, E2),
                      w(t+1, W, E1, Hw), w(t+1, V, E2, Hv), same_path(t, Tw, W, Ew, Hwo, E1, Hw), same_path(t, Tv, V, Ev, Hvo, E2, Hv), % pf(t+1, Hwo, Hw), pf(t+1, Hvo, Hv),
                      r(Tw, W, Ew, Hwo, Tv, V, Ev, Hvo, AG), metaq(ACT, E1, E2, p_obs).

r(t+1, W, E1, Hw,%                  check  Tv, V, Ev
  Tv , V, Ev, Hvo, AG) :- time(t), time(Tw), time(Tv), Tw <= t, Tv <= t, plan(t, ACT), action(ACT), agent(AG), is_oblivious(t, AG),
                      w(Tw, W, Ew, Hwo), w(Tv, V, Ev, Hvo), e(ACT, E1), e(ACT, E2), not ne(ACT, E1), ne(ACT, E2),
                      w(t+1, W, E1, Hw), same_path(t, Tw, W, Ew, Hwo, E1, Hw), % pf(t+1, Hwo, Hw), % same_path(t, Tv, V, Hvo, E2), pf(t+1, Hvo, Hv) ?????
                      r(Tw, W, Ew, Hwo, Tv, V, Ev, Hvo, AG), metaq(ACT, E1, E2, obl).


%%% Checking observability relations %%%
is_fully_obs  (t, AG) :- time(t), plan(t, ACT),       action(ACT),  observes(ACT, AG, true), agent(AG).
is_partial_obs(t, AG) :- time(t), plan(t, ACT),      sensing(ACT),  aware_of(ACT, AG, true), agent(AG).
is_partial_obs(t, AG) :- time(t), plan(t, ACT), announcement(ACT),  aware_of(ACT, AG, true), agent(AG).
is_oblivious  (t, AG) :- time(t), plan(t, ACT),       action(ACT), oblivious(ACT, AG),       agent(AG).

is_fully_obs  (t, AG) :- time(t), plan(t, ACT),       action(ACT),  observes(ACT, AG, F   ), agent(AG), formula(F),     entails(t, t, W, Ewo, Hw, F), dw(t, W, Ewo, Hw).
is_partial_obs(t, AG) :- time(t), plan(t, ACT),      sensing(ACT),  aware_of(ACT, AG, F   ), agent(AG), formula(F),     entails(t, t, W, Ewo, Hw, F), dw(t, W, Ewo, Hw).
is_partial_obs(t, AG) :- time(t), plan(t, ACT), announcement(ACT),  aware_of(ACT, AG, F   ), agent(AG), formula(F),     entails(t, t, W, Ewo, Hw, F), dw(t, W, Ewo, Hw).
is_oblivious  (t, AG) :- time(t), plan(t, ACT),       action(ACT),  observes(ACT, AG, F   ), agent(AG), formula(F), not entails(t, t, W, Ewo, Hw, F), dw(t, W, Ewo, Hw).
is_oblivious  (t, AG) :- time(t), plan(t, ACT),      sensing(ACT),  aware_of(ACT, AG, F   ), agent(AG), formula(F), not entails(t, t, W, Ewo, Hw, F), dw(t, W, Ewo, Hw).
is_oblivious  (t, AG) :- time(t), plan(t, ACT), announcement(ACT),  aware_of(ACT, AG, F   ), agent(AG), formula(F), not entails(t, t, W, Ewo, Hw, F), dw(t, W, Ewo, Hw).

check_on_w(t, t, W, Ew, Hw, F) :- time(t), plan(t, ACT),       action(ACT), observes(ACT, AG, F), agent(AG), formula(F), dw(t, W, Ew, Hw).
check_on_w(t, t, W, Ew, Hw, F) :- time(t), plan(t, ACT),      sensing(ACT), aware_of(ACT, AG, F), agent(AG), formula(F), dw(t, W, Ew, Hw).
check_on_w(t, t, W, Ew, Hw, F) :- time(t), plan(t, ACT), announcement(ACT), aware_of(ACT, AG, F), agent(AG), formula(F), dw(t, W, Ew, Hw).


#program base.

% ********** INITIAL STATE **********

% Since we assume to deal with FINITARY S5-states, we only allow the initial conditions initially(F), where F has one of the following forms:
%  1. Phi (propositional formula)
%  2. C_all( B_i(Phi))
%  3. C_all( B_i(Phi) \/  B_i(-Phi))
%  4. C_all(-B_i(Phi) /\ -B_i(-Phi)) (this case doesn't add knowledge)

% Entailment of initially conditions. We use it to generate the initial state
entails_init(W,  P    )          :-     holds(0, W, __ini, 0, P),                         initial_w(W), atom(P), init_sf(P).
entails_init(W, -P    )          :- not holds(0, W, __ini, 0, P),                         initial_w(W), atom(P), init_sf(P).

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
not_initial_dw(W) :- good_initial_w(W), initially( P), not holds(0, W, __ini, 0, P), atom(P).
not_initial_dw(W) :- good_initial_w(W), initially(-P),     holds(0, W, __ini, 0, P), atom(P).

dw(0, W, __ini, 0) :- good_initial_w(W), not not_initial_dw(W).

% The initial conditions of form 2. determine the possible worlds of the initial state
% A possible world is good if it entails all the propositional formulas which are COMMONLY KNOWN initially (2.)
    holds(0, W, __ini, 0, P) :- initially(c(all_agents,  P)), initial_w(W), atom(P).
not holds(0, W, __ini, 0, P) :- initially(c(all_agents, -P)), initial_w(W), atom(P).

% We impose that all the initial possibilities have a different atom set
K/2 { holds(0, W, __ini, 0, P) : initial_w(W) } K/2 :- unknown_initially(P), initial_state_dimension(K).

% All the initial atom sets must be different
diffzero(W1, W2) :- initial_w(W1), initial_w(W2), holds(0, W1, __ini, 0, P), not holds(0, W2, __ini, 0, P),
                    atom(P), unknown_initially(F), W1 < W2.

diffzero(W1, W2) :- initial_w(W1), initial_w(W2), holds(0, W2, __ini, 0, P), not holds(0, W1, __ini, 0, P),
                    atom(P), unknown_initially(F), W1 < W2.

:- not diffzero(W1, W2), initial_w(W1), initial_w(W2), W1 < W2.

:- 0 { dw(0, W, __ini, 0) : good_initial_w(W) } 0.

% We impose a complete order on the atom sets indices W_i w.r.t. their atoms
:- MP1 = #max { P : atom(P), unknown_initially(P),     holds(0, W1, __ini, 0, P), not holds(0, W2, __ini, 0, P) },
   MP2 = #max { P : atom(P), unknown_initially(P), not holds(0, W1, __ini, 0, P),     holds(0, W2, __ini, 0, P) },
   initial_w(W1), initial_w(W2), W1 < W2, MP1 > MP2.

% So far we dealt with (commonly known) atoms. An initial possible world is "good" if it entails all the atom formulas F that are initial common knowledge
literal( P) :- atom(P).
literal(-P) :- atom(P).

no_good_initial_w(W) :- not entails_init(W, F), initially(c(all_agents, F)), init_sf(F), not literal(F), initial_w(W).
good_initial_w(W)    :- initial_w(W), not no_good_initial_w(W).

% For each good initial possible world we create a correspoinding possible world
w(0, W, __ini, 0) :- good_initial_w(W).

% The initial conditions of form 3. filter out some of the agents' beliefs inside the initial state
no_good_initial_r(W1, W2, AG) :- not entails_init(W1, F),     entails_init(W2, F), good_initial_w(W1), good_initial_w(W2), W1 != W2, initially(c(all_agents, or(b(AG, F), b(AG, neg(F))))), atom(F). % \todo: WHY ATOM???
no_good_initial_r(W1, W2, AG) :-     entails_init(W1, F), not entails_init(W2, F), good_initial_w(W1), good_initial_w(W2), W1 != W2, initially(c(all_agents, or(b(AG, F), b(AG, neg(F))))), atom(F). % \todo: WHY ATOM???

% The initial conditions of form 4. filter out some of the agents' beliefs inside the initial state
%no_good_initial_r(W1, W2, AG) :-     entails(0, 0, W1, F),     entails(0, 0, W2, F), good_initial_w(W1), good_initial_w(W2), W1 != W2, initially(c(all_agents, and(neg(b(AG, F)), neg(b(AG, neg(F)))))), formula(F).
%no_good_initial_r(W1, W2, AG) :- not entails(0, 0, W1, F), not entails(0, 0, W2, F), good_initial_w(W1), good_initial_w(W2), W1 != W2, initially(c(all_agents, and(neg(b(AG, F)), neg(b(AG, neg(F)))))), formula(F).

% believes/7: the agent AG, inside W1, believes W2 to be possible
r(0, W1, __ini, 0, 0, W2, __ini, 0, AG) :- not no_good_initial_r(W1, W2, AG), w(0, W1, __ini, 0), w(0, W2, __ini, 0),
                              good_initial_w(W1), good_initial_w(W2), agent(AG).

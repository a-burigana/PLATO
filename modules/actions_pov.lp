#program base.
max_rep(0, 0).

#program step(t).
max_rep(t, MR  ) :- t > 0, time(t), plan(t, ACT), ontic(ACT),        max_rep(t-1, MR).
max_rep(t, MR+1) :- t > 0, time(t), plan(t, ACT), sensing(ACT),      max_rep(t-1, MR).
max_rep(t, MR+1) :- t > 0, time(t), plan(t, ACT), announcement(ACT), max_rep(t-1, MR).

% TODO: capisci bene come usare max_rep (prova a vedere in EFP). Implementa e testa la nuova versione delle repetitions spiegata sotto
% TODO: se funziona tutto, prova a implementare la pairing function in uno script Python per accorpare R e P

% ********** ONTIC ACTIONS **********

% pointed/3: the possibility P is pointed at time t
pointed(t, R, P) :- t > 0, time(t), plan(t, ACT), ontic(ACT), pointed(t-1, R, P), possible_world(t, R, P).

% possible_world/3: at time t the possibility P with repetition R is associated with the fluent set W
% A triple (t, R, P) univocally identifies a possibility. When we update such a triple when an action occurres, we obtain the triple (t+1, R+MR, P),
% where MR is the maximum repetition that can be found at time t and P is a new possibility

% We explicitly generate an updated pointed possibility since it could be the case that no agent believes it at time t
possible_world(t, R, P) :- t > 0, time(t), plan(t, ACT), ontic(ACT), pointed(t-1, R, P), possible_world(t-1, R, P).

% Let P be a possibility that is reachable from the pointed one with a path labeled only with fully observant agents.
% Then we create the new possibility P.
possible_world(t, R, P) :- t > 0, time(t), time(T2), T2 < t, plan(t, ACT), ontic(ACT),
                           possible_world(T2, R, P), reaches_no_oblivious(t, T2, R, P).


% holds/4: the fluent set W associated to P contains the fluent F

% A fluent F holds in the fluent set phi(W) associated to the possibility P if it is caused by the ontic action ACT and if the effect is executable w.r.t. P
    holds(t, R, P, F) :- t > 0, time(t), time(T2), T2 < t, plan(t, ACT), ontic(ACT), fluent(F),
                         possible_world(t, R, P), possible_world(T2, R, P), is_executable_effect(t, ACT, T2, R, P,  F).

% A fluent F must not hold in the fluent set phi(W) associated to the possibility P if -F is caused by the ontic action ACT and if the effect is executable w.r.t. P
not holds(t, R, P, F) :- t > 0, time(t), time(T2), T2 < t, plan(t, ACT), ontic(ACT), fluent(F),
                         possible_world(t, R, P), possible_world(T2, R, P), is_executable_effect(t, ACT, T2, R, P, -F).

% Inertia: if a fluent F is not modified by the ontic action ACT, then it holds in phi(W) if it was true in W...
    holds(t, R, P, F) :- t > 0, time(t), time(T2), T2 < t, plan(t, ACT), ontic(ACT), possible_world(t, R, P), possible_world(T2, R, P),
                         not is_executable_effect(t, ACT, T2, R, P, F), not is_executable_effect(t, ACT, T2, R, P, -F), holds(T2, R, P, F), fluent(F).

% ... and it must not hold in phi(W) if it was false in W.
not holds(t, R, P, F) :- t > 0, time(t), time(T2), T2 < t, plan(t, ACT), ontic(ACT), possible_world(t, R, P), possible_world(T2, R, P),
                         not is_executable_effect(t, ACT, T2, R, P, F), not is_executable_effect(t, ACT, T2, R, P, -F), not holds(T2, R, P, F), fluent(F).


% Fully observant agents: if P1 -- AG --> P2 at time t' < t and AG is fully observant, then P1 -- AG --> P2 at time t
believes(t, R1, P1, t , R2, P2, AG) :- t > 0, plan(t,ACT), ontic(ACT), believes(T1, R1, P1, T2, R2, P2, AG), T1 <= t, T2 <= t, T2 <= T1,
                                       is_fully_obs(t, AG), possible_world(T1, R1, P1), possible_world(T2, R2, P2),
                                       possible_world(t, R1, P1), possible_world(t, R2, P2), time(t), time(T1), time(T2).

% Oblivious agents: if P1 -- AG --> P2 at time t' < t and AG is oblivious, then P1 -- AG --> P2 at time t
believes(t, R1, P1, T2, R2, P2, AG) :- t > 0, plan(t, ACT), ontic(ACT), believes(T1, R1, P1, T2, R2, P2, AG), T1 <= t, T2 <= t, T2 <= T1,
                                       is_oblivious(t, AG), possible_world(T1, R1, P1), possible_world(T2, R2, P2),
                                       possible_world(t, R1, P1), time(t), time(T1), time(T2).

% SIGNIFICATO REPETITIONS: ho bisogno delle repetition per distinguere tra mondi che rappresentano il risultato di diversi punti di vista
%                          degli effetti di un'azione a partire da un mondo di partenza. Quando a partire da un mondo u = (t-1, R, P) due
%                          agenti assistono all'esecuzione di un'azione con gradi di visibilità diversi, otteniamo due mondi risultanti,
%                          u' = (t, R', P) e u'' = (t, R'', P), che i due diversi punti di vista

% REPETITIONS PER ONTIC:   qui c'è solo il nuovo p.o.v. dei fully observant (quello vecchio è rappresentato dai mondi al tempo precedente
%                          creduti dagli oblivious). È dunque sufficiente aumentare il tempo da 't-1' a 't' e la repetition da 'R' a 'R+1'
%                          lasciando invariato P per poter distinguere la nuova possibility u'

% REPETITIONS PER SENSING: qui ci sono sia il p.o.v. dei fully observant, sia quello dei partially observant, quindi il valore di R va ag-
%                          giornato: u' = (t, R+1, P) e u'' = (t, R+2, P) [DA TESTARE]


% ********** SENSING ACTIONS **********

% hold_sensed_effects/4: the possibility P2 agrees with the pointed possibility on the SENSED fluents of the sensing action ACT performed at time t
hold_sensed_effects(t-1, R , P , t) :- t > 0, plan(t, ACT), sensing(ACT), pointed(t-1, R, P), time(t).
hold_sensed_effects(T2 , R2, P2, t) :- t > 0, plan(t, ACT), sensing(ACT), possible_world(t-1, R, PP), possible_world(T2, R2, P2), T2 < t,
                                       0 { is_executable_effect(t, ACT, T2, R2, P2, SENSED) : determines(ACT, SENSED, _),     holds(T2, R2, P2, SENSED), not holds(t-1, R, PP, SENSED) } 0,
                                       0 { is_executable_effect(t, ACT, T2, R2, P2, SENSED) : determines(ACT, SENSED, _), not holds(T2, R2, P2, SENSED),     holds(t-1, R, PP, SENSED) } 0,
                                       pointed(t-1, R, PP), reaches_no_oblivious(t, T2, R2, P2), time(t), time(T2).


pointed(t, R, P) :- t > 0, plan(t, ACT), sensing(ACT), pointed(t-1, R, P), possible_world(t, R, P), time(t).

% We explicitly generate an updated pointed possibility since it could be the case that no agent believes it at time t-1
possible_world(t, R, P) :- t > 0, plan(t, ACT), sensing(ACT), pointed(t-1, R, P), possible_world(t-1, R, P), time(t).

% As for ontic actions, we do the same for all the possibilities P2 that are reachable by fully-observant paths
possible_world(t, R, P) :- t > 0, plan(t, ACT), sensing(ACT), possible_world(T, R, P), T < t,
                           reaches_only_fully_obs(t, T, R, P), hold_sensed_effects(T, R, P, t), time(t), time(T).

% If a partially observant agent AG believes P2, then we create the new possibility P2
possible_world(t, R, P) :- t > 0, plan(t, ACT), sensing(ACT), pointed(t-1, RP, PP), possible_world(T, R, P), T < t,
                           believes(t-1, RP, PP, T, R, P, AG), is_partial_obs(t, AG), time(t), time(T).

% Let P be a possibility that is reachable from the pointed one with a no-oblivious path that begins with a partially observant agent
% Then we create the new possibility P.
possible_world(t, R, P) :- t > 0, plan(t, ACT), sensing(ACT), possible_world(T, R, P), T < t,
                           reaches_first_partially_obs(t, T, R, P), time(t), time(T).


% Inertia: sensing actions do not alter the values of the fluents
holds(t, R, P, F) :- t > 0, plan(t, ACT), sensing(ACT), possible_world(t, R, P), possible_world(T, R, P), T < t,
                     holds(T, R, P, F), fluent(F), time(t), time(T).

% Prova così: per sensing e announcement, incrementa di 1 ogni rep. In questo modo la max_rep(t) = max_rep(t-1) + 1
% Per ontic: ragiona meglio

% Fully observant agents (sigma, sigma): if P1 -- AG --> P2 at time t and AG is fully observant and BOTH P1 and P2 agree with the pointed possibility, then P1 -- AG --> P2 at time t+1
believes(t, R1, P1, t , R2, P2, AG) :- t > 0, plan(t, ACT), sensing(ACT), T1 <= t, T2 <= t, T2 <= T1, is_fully_obs(t, AG),
                                       believes(T1, R1, P1, T2, R2, P2, AG), possible_world(T1, R1, P1), possible_world(T2, R2, P2),
                                       possible_world(t, R1, P1), possible_world(t, R2, P2),
                                       hold_sensed_effects(T1, R1, P1, t), hold_sensed_effects(T2, R2, P2, t), time(t), time(T1), time(T2).

% Fully observant agents (tau, tau): if P1 -- AG --> P2 at time t and AG is fully observant and NEITHER P1 nor P2 agree with the pointed possibility, then P1 -- AG --> P2 at time t+1
believes(t, R1, P1, t , R2, P2, AG) :- t > 0, plan(t, ACT), sensing(ACT), T1 <= t, T2 <= t, T2 <= T1, is_fully_obs(t, AG),
                                       believes(T1, R1, P1, T2, R2, P2, AG), possible_world(T1, R1, P1), possible_world(T2, R2, P2),
                                       possible_world(t, R1, P1), possible_world(t, R2, P2),
                                       not hold_sensed_effects(T1, R1, P1, t), not hold_sensed_effects(T2, R2, P2, t), time(t), time(T1), time(T2).

% Partially observant agents: if P1 -- AG --> P2 at time t and AG is partially observant, then P1 -- AG --> P2 at time t+1
believes(t, R1, P1, t , R2, P2, AG) :- t > 0, plan(t, ACT), sensing(ACT), T1 <= t, T2 <= t, T2 <= T1, is_partial_obs(t, AG),
                                       believes(T1, R1, P1, T2, R2, P2, AG), possible_world(T1, R1, P1), possible_world(T2, R2, P2),
                                       possible_world(t, R1, P1), possible_world(t, R2, P2), time(t), time(T1), time(T2).

% Oblivious agents: if P1 -- AG --> P2 at time t and AG is oblivious, then P1 -- AG --> P2 at time t+1
believes(t, R1, P1, T2, R2, P2, AG) :- t > 0, plan(t, ACT), sensing(ACT), T1 <= t, T2 <= t, T2 <= T1, is_oblivious(t, AG),
                                       believes(T1, R1, P1, T2, R2, P2, AG), possible_world(T1, R1, P1), possible_world(T2, R2, P2),
                                       possible_world(t, R1, P1), time(t), time(T1), time(T2).


% ********** ANNOUNCEMENT ACTIONS **********

% hold_announced_effects/4: the possibility P2 agrees with the pointed possibility on the ANN formulas of the announcement action ACT performed at time t
hold_announced_effects(t-1, R , P , t) :- t > 0, plan(t, ACT), announcement(ACT), pointed(t-1, R, P), time(t).
hold_announced_effects(T2 , R2, P2, t) :- t > 0, plan(t, ACT), announcement(ACT), possible_world(t-1, R, PP), possible_world(T2, R2, P2), T2 < t,
                                          0 { is_executable_effect(t, ACT, T2, R2, P2, ANN) : announces(ACT, ANN, _),     entails(T2, R2, P2, ANN), not entails(t-1, R, PP, ANN) } 0,
                                          0 { is_executable_effect(t, ACT, T2, R2, P2, ANN) : announces(ACT, ANN, _), not entails(T2, R2, P2, ANN),     entails(t-1, R, PP, ANN) } 0,
                                          pointed(t-1, R, PP), reaches_no_oblivious(t, T2, R2, P2), time(t), time(T2).


pointed(t, R, P) :- t > 0, plan(t, ACT), announcement(ACT), pointed(t-1, R, P), possible_world(t, R, P), time(t).

% We explicitly generate an updated pointed possibility since it could be the case that no agent believes it at time t-1
possible_world(t, R, P) :- t > 0, plan(t, ACT), announcement(ACT), pointed(t-1, R, P), possible_world(t-1, R, P), time(t).

% As for ontic actions, we do the same for all the possibilities P2 that are reachable by fully-observant paths
possible_world(t, R, P) :- t > 0, plan(t, ACT), announcement(ACT), possible_world(T, R, P), T < t,
                           reaches_only_fully_obs(t, T, R, P), hold_announced_effects(T, R, P, t), time(t), time(T).

% If a partially observant agent AG believes P2, then we create the new possibility P2
possible_world(t, R, P) :- t > 0, plan(t, ACT), announcement(ACT), pointed(t-1, RP, PP), possible_world(T, R, P), T < t,
                           believes(t-1, RP, PP, T, R, P, AG), is_partial_obs(t, AG), time(t), time(T).

% Let P be a possibility that is reachable from the pointed one with a no-oblivious path that begins with a partially observant agent
% Then we create the new possibility P.
possible_world(t, R, P) :- t > 0, plan(t, ACT), announcement(ACT), possible_world(T, R, P), T < t,
                           reaches_first_partially_obs(t, T, R, P), time(t), time(T).


% Inertia: announcement actions do not alter the values of the fluents
holds(t, R, P, F) :- t > 0, plan(t, ACT), announcement(ACT), possible_world(t, R, P), possible_world(T2, R2, P), T2 < t,
                                holds(T2, R2, P, F), fluent(F), time(t), time(T2).


% Fully observant agents (sigma, sigma): if P1 -- AG --> P2 at time t and AG is fully observant and BOTH P1 and P2 agree with the pointed possibility, then P1 -- AG --> P2 at time t+1
believes(t, R1, P1, t , R2, P2, AG) :- t > 0, plan(t, ACT), announcement(ACT), T1 <= t, T2 <= t, T2 <= T1, is_fully_obs(t, AG),
                                                             believes(T1, R1, P1, T2, R2, P2, AG), possible_world(T1, R1, P1), possible_world(T2, R2, P2),
                                                             possible_world(t, R1, P1), possible_world(t, R2, P2),
                                                             hold_announced_effects(T1, R1, P1, t), hold_announced_effects(T2, R2, P2, t), time(t), time(T1), time(T2).

% Fully observant agents (tau, tau): if P1 -- AG --> P2 at time t and AG is fully observant and NEITHER P1 nor P2 agree with the pointed possibility, then P1 -- AG --> P2 at time t+1
believes(t, R1, P1, t , R2, P2, AG) :- t > 0, plan(t, ACT), announcement(ACT), T1 <= t, T2 <= t, T2 <= T1, is_fully_obs(t, AG),
                                                             believes(T1, R1, P1, T2, R2, P2, AG), possible_world(T1, R1, P1), possible_world(T2, R2, P2),
                                                             possible_world(t, R1, P1), possible_world(t, R2, P2),
                                                             not hold_announced_effects(T1, R1, P1, t), not hold_announced_effects(T2, R2, P2, t), time(t), time(T1), time(T2).

% Partially observant agents: if P1 -- AG --> P2 at time t and AG is partially observant, then P1 -- AG --> P2 at time t+1
believes(t, R1, P1, t , R2, P2, AG) :- t > 0, plan(t, ACT), announcement(ACT), T1 <= t, T2 <= t, T2 <= T1, is_partial_obs(t, AG),
                                                             believes(T1, R1, P1, T2, R2, P2, AG), possible_world(T1, R1, P1), possible_world(T2, R2, P2),
                                                             possible_world(t, R1, P1), possible_world(t, R2, P2), time(t), time(T1), time(T2).

% Oblivious agents: if P1 -- AG --> P2 at time t and AG is oblivious, then P1 -- AG --> P2 at time t+1
believes(t, R1, P1, T2, R2           , P2, AG) :- t > 0, plan(t, ACT), announcement(ACT), T1 <= t, T2 <= t, T2 <= T1, is_oblivious(t, AG),
                                                             believes(T1, R1, P1, T2, R2, P2, AG), possible_world(T1, R1, P1), possible_world(T2, R2, P2),
                                                             possible_world(t, R1, P1), time(t), time(T1), time(T2).

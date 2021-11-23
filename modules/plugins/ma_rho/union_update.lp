% ********** mA^\rho PLUGIN **********

semantics(possibilities).

#defined ontic/1.
#defined sensing/1.
#defined announcement/1.

#defined causes/3.
#defined determines/2.
#defined announces/2.

#defined aware_of/3.
#defined oblivious/2.

#program step(t).

%%% Applicability %%%
applicable_event(t, ACT, E) :- time(t), action(ACT), e(ACT, E, 0, _), de(ACT, E), dpre(ACT, E, true).
applicable_event(t, ACT, E) :- time(t), action(ACT), e(ACT, E, 0, _), de(ACT, E), w(t, W, Ew, Hw), dw(t, W, Ew, Hw),
                               dpre(ACT, E, Fpre), formula(Fpre), entails(t, W, Ew, Hw, Fpre).

not_applicable(t, ACT) :- time(t), action(ACT), e(ACT, E, 0, _), de(ACT, E), not applicable_event(t, ACT, E).
applicable(t, ACT)     :- time(t), action(ACT), not not_applicable(t, ACT).


check_on_w(t, W, Ew, Hw, F) :- time(t), action(ACT), dpre(ACT, E, F), formula(F),
                               w(t, W, Ew, Hw), e(ACT, E, 0, _), dw(t, W, Ew, Hw), de(ACT, E).

%%% Same path with meta-q
same_path(t, W, Ewo, Hwo, Ew, Hw ) :- time(t), plan(t, ACT), action(ACT), w(t, W, Ewo, Hwo), e(ACT, Ew, 0, _),
                                      dw(t, W, Ewo, Hwo), de(ACT, Ew), Hw = Hwo + Ewo + (t+1)*Ew.

same_path(t, W, Ewo, Hwo, Ew, Hw ) :- time(t), plan(t, ACT), action(ACT), agent(AG), obs(t, AG, OBS), obs_type(OBS),% OBS != obl,
                                      w(t, W, Ewo, Hwo), e(ACT, Ew, _, _), w(t, W2, Ew2, Hw2), e(ACT, E2, _, _), same_path(t, W2, Ew2, Hw2, E2, _),
                                      r(t, W2, Ew2, Hw2, t, W, Ewo, Hwo, AG), metaq(ACT, E2, Ew, OBS), Hw = Hwo + Ewo + (t+1)*Ew.

same_path(t, W, Ewo, Hwo, Ew, Hw ) :- time(t), plan(t, ACT), action(ACT), agent(AG), Ew = 0,
                                      w(t, W, Ewo, Hwo), e(ACT, Ew, 1, 0), w(t, W2, Ew2, Hw2), e(ACT, E2, 1, 0), same_path(t, W2, Ew2, Hw2, E2, _),
                                      r(t, W2, Ew2, Hw2, t, W, Ewo, Hwo, AG), metaq(ACT, E2, Ew, all), Hw = Hwo + Ewo + (t+1)*Ew.

% same_path(t, W, Ewo, Hwo, Ew, Hwo) :- time(t), plan(t, ACT), action(ACT), agent(AG), obs(t, AG, obl),
%                                       w(t, W, Ewo, Hwo), e(ACT, Ew, 1, 0), w(t, W2, Ew2, Hw2), e(ACT, E2, 1, 0), same_path(t, W2, Ew2, Hw2, E2, _),
%                                       r(t, W2, Ew2, Hw2, t, W, Ewo, Hwo, AG), metaq(ACT, E2, Ew, obl  ).

% same_path(t, W, Ewo, Hwo, Ew, Hwo) :- time(t), plan(t, ACT), action(ACT), agent(AG),
%                                       w(t, W, Ewo, Hwo), e(ACT, Ew, 1, 0), w(t, W2, Ew2, Hw2), e(ACT, E2, 1, 0), same_path(t, W2, Ew2, Hw2, E2, _),
%                                       r(t, W2, Ew2, Hw2, t, W, Ewo, Hwo, AG), metaq(ACT, E2, Ew, all  ).


dw(t+1, W, Ew, Hw) :- time(t), plan(t, ACT), action(ACT), w(t, W, Ewo, Hwo), e(ACT, Ew, 0, _), dw(t, W, Ewo, Hwo), de(ACT, Ew),
                      dpre(ACT, Ew, true), Hw = Hwo + Ewo + (t+1)*Ew. % , same_path(t, W, Ewo, Hwo, Ew, Hw).

dw(t+1, W, Ew, Hw) :- time(t), plan(t, ACT), action(ACT), w(t, W, Ewo, Hwo), e(ACT, Ew, 0, _), dw(t, W, Ewo, Hwo), de(ACT, Ew),
                      dpre(ACT, Ew, Fpre), formula(Fpre), entails(t, W, Ewo, Hwo, Fpre), Hw = Hwo + Ewo + (t+1)*Ew. % , same_path(t, W, Ewo, Hwo, Ew, Hw).

w(t+1, W, Ew, Hw) :- time(t), plan(t, ACT), action(ACT), dw(t+1, W, Ew, Hw), de(ACT, Ew).

% Sigma (ontic)
w(t+1, W, Ew, Hw) :- time(t), plan(t, ACT), action(ACT), ontic(ACT),     w(t, W, Ewo, Hwo),
                     e(ACT, Ew, 0, 1), Ew = 1, pre(ACT, Ew, true), agent(AG), obs(t, AG, f_obs),
                     same_path(t, W, Ewo, Hwo, Ew, Hw).

% w(t+1, W, Ew, Hw) :- time(t), plan(t, ACT), action(ACT), ontic(ACT),     w(t, W, Ewo, Hwo),
%                      e(ACT, Ew, 0, 1), Ew = 1, pre(ACT, Ew, Fpre), formula(Fpre), entails(t, W, Ewo, Hwo, Fpre), agent(AG), obs(t, AG, f_obs),
%                      same_path(t, W, Ewo, Hwo, Ew, Hw).

% Sigma (epistemic)
w(t+1, W, Ew, Hw) :- time(t), plan(t, ACT), action(ACT), epistemic(ACT), w(t, W, Ewo, Hwo),
                     e(ACT, Ew, 0, 0), Ew = 2, pre(ACT, Ew, true), agent(AG), obs(t, AG, OBS), obs_type(OBS), OBS != obl, OBS != all,
                     same_path(t, W, Ewo, Hwo, Ew, Hw).

w(t+1, W, Ew, Hw) :- time(t), plan(t, ACT), action(ACT), epistemic(ACT), w(t, W, Ewo, Hwo),
                     e(ACT, Ew, 0, 0), Ew = 2, pre(ACT, Ew,  Fpre), atom(Fpre),  holds(t, W, Ewo, Hwo, Fpre), agent(AG), obs(t, AG, OBS), obs_type(OBS), OBS != obl, OBS != all,
                     same_path(t, W, Ewo, Hwo, Ew, Hw).

w(t+1, W, Ew, Hw) :- time(t), plan(t, ACT), action(ACT), epistemic(ACT), w(t, W, Ewo, Hwo),
                     e(ACT, Ew, 0, 0), Ew = 2, pre(ACT, Ew, -Fpre), atom(Fpre), not holds(t, W, Ewo, Hwo, Fpre), agent(AG), obs(t, AG, OBS), obs_type(OBS), OBS != obl, OBS != all,
                     same_path(t, W, Ewo, Hwo, Ew, Hw).

% Tau
w(t+1, W, Ew, Hw) :- time(t), plan(t, ACT), action(ACT), epistemic(ACT), w(t, W, Ewo, Hwo),
                     e(ACT, Ew, 0, 0), Ew = 1, pre(ACT, Ew, true), agent(AG), obs(t, AG, p_obs),
                     same_path(t, W, Ewo, Hwo, Ew, Hw).

w(t+1, W, Ew, Hw) :- time(t), plan(t, ACT), action(ACT), epistemic(ACT), w(t, W, Ewo, Hwo),
                     e(ACT, Ew, 0, 0), Ew = 1, pre(ACT, Ew,  Fpre), atom(Fpre), holds(t, W, Ewo, Hwo, Fpre), agent(AG), obs(t, AG, p_obs),
                     same_path(t, W, Ewo, Hwo, Ew, Hw).

w(t+1, W, Ew, Hw) :- time(t), plan(t, ACT), action(ACT), epistemic(ACT), w(t, W, Ewo, Hwo),
                     e(ACT, Ew, 0, 0), Ew = 1, pre(ACT, Ew, -Fpre), atom(Fpre), not holds(t, W, Ewo, Hwo, Fpre), agent(AG), obs(t, AG, p_obs),
                     same_path(t, W, Ewo, Hwo, Ew, Hw).

% Epsilon
w(t+1, W, Ew, Hw) :- time(t), plan(t, ACT), action(ACT),                 w(t, W, Ewo, Hwo),
                     e(ACT, Ew, 1, 0), Ew = 0, pre(ACT, Ew, true), agent(AG), obs(t, AG, obl),
                     same_path(t, W, Ewo, Hwo, Ew, Hw).

w(t+1, W, Ew, Hw) :- time(t), plan(t, ACT), action(ACT),                 w(t, W, Ewo, Hwo),
                     e(ACT, Ew, 1, 0), Ew = 0, pre(ACT, Ew, true), agent(AG),
                     same_path(t, W, Ewo, Hwo, Ew, Hw).

%%% Accessibility relations with meta-q
r(t+1, W, Ew, Hw,
  t+1, V, Ev, Hv, AG) :- time(t), plan(t, ACT), action(ACT), agent(AG), obs(t, AG, OBS),
                         w(t, W, Ewo, Hwo), w(t, V, Evo, Hvo), e(ACT, Ew, _, _), e(ACT, Ev, _, _), obs_type(OBS), OBS != all,
                         w(t+1, W, Ew, Hw), w(t+1, V, Ev, Hv), same_path(t, W, Ewo, Hwo, Ew, Hw), same_path(t, V, Evo, Hvo, Ev, Hv),
                         r(t, W, Ewo, Hwo, t, V, Evo, Hvo, AG), metaq(ACT, Ew, Ev, OBS).

r(t+1, W, Ew, Hw,
  t+1, V, Ev, Hv, AG) :- time(t), plan(t, ACT), action(ACT), agent(AG),
                         w(t, W, Ewo, Hwo), w(t, V, Evo, Hvo), e(ACT, Ew, _, _), e(ACT, Ev, _, _),
                         w(t+1, W, Ew, Hw), w(t+1, V, Ev, Hv), same_path(t, W, Ewo, Hwo, Ew, Hw), same_path(t, V, Evo, Hvo, Ev, Hv),
                         r(t, W, Ewo, Hwo, t, V, Evo, Hvo, AG), metaq(ACT, Ew, Ev, all).


% STEP 4: determine the interpretation of the worlds
holds(t+1, W, Ew, Hw, P) :- time(t), plan(t, ACT), action(ACT), ontic(ACT), e(ACT, Ew, 0, 1),
                            w(t+1, W, Ew, Hw), post(ACT, Ew,  P, true), atom(P).

-holds(t+1, W, Ew, Hw, P) :- time(t), plan(t, ACT), action(ACT), ontic(ACT), e(ACT, Ew, 0, 1),
                            w(t+1, W, Ew, Hw), post(ACT, Ew, -P, true), atom(P).

% Postcondition is satisfied
holds(t+1, W, Ew, Hw, P) :- time(t), plan(t, ACT), action(ACT), ontic(ACT), e(ACT, Ew, 0, 1), formula(Fpost),
                            w(t+1, W, Ew, Hw), w(t, W, Ewo, Hwo), post(ACT, Ew,  P, Fpost), atom(P), entails(t, W, Ewo, Hwo, Fpost),
                            same_path(t, W, Ewo, Hwo, Ew, Hw).

-holds(t+1, W, Ew, Hw, P) :- time(t), plan(t, ACT), action(ACT), ontic(ACT), e(ACT, Ew, 0, 1), formula(Fpost),
                            w(t+1, W, Ew, Hw), w(t, W, Ewo, Hwo), post(ACT, Ew, -P, Fpost), atom(P), entails(t, W, Ewo, Hwo, Fpost),
                            same_path(t, W, Ewo, Hwo, Ew, Hw).

% Inertia in ontic actions
holds(t+1, W, Ew, Hw, P) :- time(t), plan(t, ACT), action(ACT), ontic(ACT), e(ACT, Ew, 0, 1),
                            not post(ACT, Ew, P, _), not post(ACT, Ew, -P, _), atom(P), holds(t, W, Ewo, Hwo, P),
                            w(t+1, W, Ew, Hw), w(t, W, Ewo, Hwo), same_path(t, W, Ewo, Hwo, Ew, Hw).

holds(t+1, W, Ew, Hw, P) :- time(t), plan(t, ACT), action(ACT), ontic(ACT), e(ACT, Ew, 0, 1), formula(Fpost1), formula(Fpost2),
                            w(t+1, W, Ew, Hw), w(t, W, Ewo, Hwo), holds(t, W, Ewo, Hwo, P),
                            post(ACT, Ew, P, Fpost1), post(ACT, Ew, -P, Fpost2), atom(P),
                            not entails(t, W, Ewo, Hwo, Fpost1), not entails(t, W, Ewo, Hwo, Fpost2),
                            same_path(t, W, Ewo, Hwo, Ew, Hw).

holds(t+1, W, Ew, Hw, P) :- time(t), plan(t, ACT), action(ACT), ontic(ACT), e(ACT, Ew, 1, 0), Ew = 0,
                            atom(P), holds(t, W, Ewo, Hwo, P),
                            w(t+1, W, Ew, Hw), w(t, W, Ewo, Hwo), same_path(t, W, Ewo, Hwo, Ew, Hw).

% Epistemic actions
holds(t+1, W, Ew, Hw, P) :- time(t), plan(t, ACT), action(ACT), epistemic(ACT), e(ACT, Ew, _, 0),
                            atom(P), holds(t, W, Ewo, Hwo, P), w(t+1, W, Ew, Hw), w(t, W, Ewo, Hwo), 
                            same_path(t, W, Ewo, Hwo, Ew, Hw).

%%% Checking observability relations %%%
obs(t, AG, f_obs) :- time(t), plan(t, ACT),       action(ACT),  observes(ACT, AG, true), agent(AG).
obs(t, AG, p_obs) :- time(t), plan(t, ACT),      sensing(ACT),  aware_of(ACT, AG, true), agent(AG).
obs(t, AG, p_obs) :- time(t), plan(t, ACT), announcement(ACT),  aware_of(ACT, AG, true), agent(AG).
obs(t, AG, obl  ) :- time(t), plan(t, ACT),       action(ACT), oblivious(ACT, AG),       agent(AG).

obs(t, AG, f_obs) :- time(t), plan(t, ACT),       action(ACT),  observes(ACT, AG, F   ), agent(AG), formula(F),     entails(t, W, Ewo, Hw, F), dw(t, W, Ewo, Hw).
obs(t, AG, p_obs) :- time(t), plan(t, ACT),      sensing(ACT),  aware_of(ACT, AG, F   ), agent(AG), formula(F),     entails(t, W, Ewo, Hw, F), dw(t, W, Ewo, Hw).
obs(t, AG, p_obs) :- time(t), plan(t, ACT), announcement(ACT),  aware_of(ACT, AG, F   ), agent(AG), formula(F),     entails(t, W, Ewo, Hw, F), dw(t, W, Ewo, Hw).
obs(t, AG, obl  ) :- time(t), plan(t, ACT),       action(ACT),  observes(ACT, AG, F   ), agent(AG), formula(F), not entails(t, W, Ewo, Hw, F), dw(t, W, Ewo, Hw).
obs(t, AG, obl  ) :- time(t), plan(t, ACT),      sensing(ACT),  aware_of(ACT, AG, F   ), agent(AG), formula(F), not entails(t, W, Ewo, Hw, F), dw(t, W, Ewo, Hw).
obs(t, AG, obl  ) :- time(t), plan(t, ACT), announcement(ACT),  aware_of(ACT, AG, F   ), agent(AG), formula(F), not entails(t, W, Ewo, Hw, F), dw(t, W, Ewo, Hw).

check_on_w(t, W, Ew, Hw, F) :- time(t), plan(t, ACT),       action(ACT), observes(ACT, AG, F), agent(AG), formula(F), dw(t, W, Ew, Hw).
check_on_w(t, W, Ew, Hw, F) :- time(t), plan(t, ACT),      sensing(ACT), aware_of(ACT, AG, F), agent(AG), formula(F), dw(t, W, Ew, Hw).
check_on_w(t, W, Ew, Hw, F) :- time(t), plan(t, ACT), announcement(ACT), aware_of(ACT, AG, F), agent(AG), formula(F), dw(t, W, Ew, Hw).

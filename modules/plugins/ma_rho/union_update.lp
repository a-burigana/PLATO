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


% check_on_w(t, W, Ew, Hw, F) :- time(t), action(ACT), dpre(ACT, E, F), formula(F),
%                                w(t, W, Ew, Hw), e(ACT, E, 0, _), dw(t, W, Ew, Hw), de(ACT, E).

%%% Same path with meta-q
same_path(t, t , W, Ewo, Hwo, Ew, Hw ) :- time(t), plan(t, ACT), action(ACT), w(t, W, Ewo, Hwo), e(ACT, Ew, 0, _),
                                          dw(t, W, Ewo, Hwo), de(ACT, Ew), Hw = t+1 + Hwo * Ew.

same_path(t, Tw, W, Ewo, Hwo, Ew, Hw ) :- time(t), time(Tw), time(Tw2), Tw <= Tw2, Tw2 <= t, plan(t, ACT), action(ACT), agent(AG), obs(t, AG, OBS), obs_type(OBS), OBS != obl,
                                          w(Tw, W, Ewo, Hwo), e(ACT, Ew, 0, _), w(Tw2, W2, Ew2, Hw2), e(ACT, E2, 0, _), same_path(t, Tw2, W2, Ew2, Hw2, E2, _),
                                          r(Tw2, W2, Ew2, Hw2, Tw, W, Ewo, Hwo, AG), metaq(ACT, E2, Ew, OBS), Hw = t+1 + Hwo * Ew.

same_path(t, Tw, W, Ewo, Hwo, Ew, Hwo) :- time(t), time(Tw), Tw <= t, plan(t, ACT), action(ACT), agent(AG), obs(t, AG, obl),
                                          w(Tw, W, Ewo, Hwo), e(ACT, Ew, 1, 0), w(t, W2, Ew2, Hw2), e(ACT, E2, 1, 0), same_path(t, t, W2, Ew2, Hw2, E2, _),
                                          r(t, W2, Ew2, Hw2, Tw, W, Ewo, Hwo, AG), metaq(ACT, E2, Ew, obl  ).

same_path(t, Tw, W, Ewo, Hwo, Ew, Hwo) :- time(t), time(Tw), Tw <= t, plan(t, ACT), action(ACT), agent(AG),
                                          w(Tw, W, Ewo, Hwo), e(ACT, Ew, 1, 0), w(t, W2, Ew2, Hw2), e(ACT, E2, 1, 0), same_path(t, t, W2, Ew2, Hw2, E2, _),
                                          r(t, W2, Ew2, Hw2, Tw, W, Ewo, Hwo, AG), metaq(ACT, E2, Ew, all  ).


dw(t+1, W, Ew, Hw) :- time(t), plan(t, ACT), action(ACT), w(t, W, Ewo, Hwo), e(ACT, Ew, 0, _), dw(t, W, Ewo, Hwo), de(ACT, Ew),
                      dpre(ACT, Ew, true), same_path(t, t, W, Ewo, Hwo, Ew, Hw).

dw(t+1, W, Ew, Hw) :- time(t), plan(t, ACT), action(ACT), w(t, W, Ewo, Hwo), e(ACT, Ew, 0, _), dw(t, W, Ewo, Hwo), de(ACT, Ew),
                      dpre(ACT, Ew, Fpre), formula(Fpre), entails(t, W, Ewo, Hwo, Fpre), same_path(t, t, W, Ewo, Hwo, Ew, Hw).

% Sigma (ontic)
w(t+1, W, 1, Hw) :- time(t), time(Tw), Tw <= t, plan(t, ACT), action(ACT), ontic(ACT), w(Tw, W, Ewo, Hwo), e(ACT, 1, 0, 1),
                    pre(ACT, 1, true), same_path(t, Tw, W, Ewo, Hwo, 1, Hw).

% Sigma (epistemic)
w(t+1, W, 2, Hw) :- time(t), time(Tw), Tw <= t, plan(t, ACT), action(ACT), epistemic(ACT), w(Tw, W, Ewo, Hwo), e(ACT, 2, 0, 0),
                    pre(ACT, 2,  Fpre), atom(Fpre),     holds(Tw, W, Ewo, Hwo, Fpre), same_path(t, Tw, W, Ewo, Hwo, 2, Hw).

% Tau
w(t+1, W, 1, Hw) :- time(t), time(Tw), Tw <= t, plan(t, ACT), action(ACT), epistemic(ACT), w(Tw, W, Ewo, Hwo), e(ACT, 1, 0, 0),
                    pre(ACT, 1, -Fpre), atom(Fpre), not holds(Tw, W, Ewo, Hwo, Fpre), same_path(t, Tw, W, Ewo, Hwo, 1, Hw),
                    agent(AG), obs(t, AG, p_obs).


%%% Accessibility relations with meta-q
r(t+1, W, Ew, Hw,
  t+1, V, Ev, Hv, AG) :- time(t), time(Tw), time(Tv), Tw <= t, Tv <= t, plan(t, ACT), action(ACT), agent(AG), obs(t, AG, OBS),
                         w(Tw, W, Ewo, Hwo), w(Tv, V, Evo, Hvo), e(ACT, Ew, 0, _), e(ACT, Ev, 0, _), obs_type(OBS), OBS != obl,
                         w(t+1, W, Ew, Hw), w(t+1, V, Ev, Hv), same_path(t, Tw, W, Ewo, Hwo, Ew, Hw), same_path(t, Tv, V, Evo, Hvo, Ev, Hv),
                         r(Tw, W, Ewo, Hwo, Tv, V, Evo, Hvo, AG), metaq(ACT, Ew, Ev, OBS).

r(t+1, W, Ew, Hw,
  Tv , V, Ev, Hv, AG) :- time(t), time(Tw), time(Tv), Tw <= t, Tv <= t, plan(t, ACT), action(ACT), agent(AG), obs(t, AG, obl),
                         w(Tw, W, Ewo, Hwo), w(Tv, V, Ev, Hv), e(ACT, Ew, 0, _), e(ACT, E, 1, 0),
                         w(t+1, W, Ew, Hw), same_path(t, Tw, W, Ewo, Hwo, Ew, Hw),
                         r(Tw, W, Ewo, Hwo, Tv, V, Ev, Hv, AG), metaq(ACT, Ew, E, obl).

% STEP 4: determine the interpretation of the worlds
holds(t+1, W, 1, Hw, P) :-  time(t), plan(t, ACT), action(ACT), ontic(ACT), e(ACT, 1, 0, 1), w(t+1, W, 1, Hw), post(ACT, 1,  P, true), atom(P).

-holds(t+1, W, 1, Hw, P) :- time(t), plan(t, ACT), action(ACT), ontic(ACT), e(ACT, 1, 0, 1), w(t+1, W, 1, Hw), post(ACT, 1, -P, true), atom(P).

% Postcondition is satisfied
holds(t+1, W, 1, Hw, P) :-  time(t), time(Tw), Tw <= t, plan(t, ACT), action(ACT), ontic(ACT), e(ACT, 1, 0, 1), formula(Fpost),
                            w(t+1, W, 1, Hw), w(Tw, W, Ewo, Hwo), post(ACT, 1,  P, Fpost), atom(P), entails(Tw, W, Ewo, Hwo, Fpost),
                            same_path(t, Tw, W, Ewo, Hwo, 1, Hw).

-holds(t+1, W, 1, Hw, P) :- time(t), time(Tw), Tw <= t, plan(t, ACT), action(ACT), ontic(ACT), e(ACT, 1, 0, 1), formula(Fpost),
                            w(t+1, W, 1, Hw), w(Tw, W, Ewo, Hwo), post(ACT, 1, -P, Fpost), atom(P), entails(Tw, W, Ewo, Hwo, Fpost),
                            same_path(t, Tw, W, Ewo, Hwo, 1, Hw).

% Inertia in ontic actions
holds(t+1, W, 1, Hw, P) :-  time(t), time(Tw), Tw <= t, plan(t, ACT), action(ACT), ontic(ACT), e(ACT, 1, 0, 1),
                            not post(ACT, 1, P, _), not post(ACT, 1, -P, _), atom(P), holds(Tw, W, Ewo, Hwo, P),
                            w(t+1, W, 1, Hw), w(Tw, W, Ewo, Hwo), same_path(t, Tw, W, Ewo, Hwo, 1, Hw).

holds(t+1, W, 1, Hw, P) :-  time(t), time(Tw), Tw <= t, plan(t, ACT), action(ACT), ontic(ACT), e(ACT, 1, 0, 1), formula(Fpost1), formula(Fpost2),
                            post(ACT, 1, P, Fpost1), post(ACT, 1, -P, Fpost2), atom(P), holds(Tw, W, Ewo, Hwo, P), w(t+1, W, 1, Hw), w(Tw, W, Ewo, Hwo),
                            not entails(Tw, W, Ewo, Hwo, Fpost1), not entails(Tw, W, Ewo, Hwo, Fpost2), same_path(t, Tw, W, Ewo, Hwo, 1, Hw).

holds(t+1, W, 0, Hw, P) :-  time(t), time(Tw), Tw <= t, plan(t, ACT), action(ACT), ontic(ACT), e(ACT, 0, 1, 0),
                            atom(P), holds(Tw, W, Ewo, Hwo, P), w(t+1, W, 0, Hw), w(Tw, W, Ewo, Hwo), same_path(t, Tw, W, Ewo, Hwo, 0, Hw).

% Epistemic actions
holds(t+1, W, Ew, Hw, P) :- time(t), time(Tw), Tw <= t, plan(t, ACT), action(ACT), epistemic(ACT), e(ACT, Ew, _, 0),
                            atom(P), holds(Tw, W, Ewo, Hwo, P), w(t+1, W, Ew, Hw), w(Tw, W, Ewo, Hwo), same_path(t, Tw, W, Ewo, Hwo, Ew, Hw).

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

% check_on_w(t, W, Ew, Hw, F) :- time(t), plan(t, ACT),       action(ACT), observes(ACT, AG, F), agent(AG), formula(F), dw(t, W, Ew, Hw).
% check_on_w(t, W, Ew, Hw, F) :- time(t), plan(t, ACT),      sensing(ACT), aware_of(ACT, AG, F), agent(AG), formula(F), dw(t, W, Ew, Hw).
% check_on_w(t, W, Ew, Hw, F) :- time(t), plan(t, ACT), announcement(ACT), aware_of(ACT, AG, F), agent(AG), formula(F), dw(t, W, Ew, Hw).

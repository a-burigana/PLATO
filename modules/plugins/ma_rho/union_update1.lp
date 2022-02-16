% ********** mA^\rho PLUGIN **********

semantics(possibilities).

#defined ontic/1.
#defined sensing/1.
#defined announcement/1.

#defined causes/3.
#defined causes/7.
#defined determines/2.
#defined announces/2.

#defined aware_of/3.
#defined oblivious/2.

#defined init_sf/1.

#program step(t).

% applicable(t, ACT) :- action_pre(ACT, F), entails(t, W, Ew, Hw, F).

%%% Same path with meta-q
same_path(t, t , W, Ewo, Hwo, Ew, Hw ) :- dw(t, W, Ewo, Hwo), plan(t, ACT), de(ACT, Ew), e(ACT, Ew, 0, _),
                                          Hw = t+1 + Hwo * (Ewo+Ew).

same_path(t, Tw, W, Ewo, Hwo, Ew, Hw ) :- same_path(t, Tw2, W2, Ew2, Hw2, E2, _), plan(t, ACT), e(ACT, Ew, 0, _), e(ACT, E2, 0, _),
                                          obs(t, AG, OBS), obs_type(OBS), OBS != obl, metaq(ACT, E2, Ew, OBS),
                                          r(Tw2, W2, Ew2, Hw2, Tw, W, Ewo, Hwo, AG), time(Tw), time(Tw2), Tw <= Tw2, Tw2 <= t,
                                          Hw = t+1 + Hwo * (Ewo+Ew).

% Designated worlds (ontic)
dw(t+1, W, 1, Hw) :- plan(t, ACT), ontic(ACT), dw(t, W, Ewo, Hwo), applicable(t, ACT),
                     de(ACT, 1), e(ACT, 1, 0, _), same_path(t, t, W, Ewo, Hwo, 1, Hw).

% Designated worlds (epistemic)
% Sigma
dw(t+1, W, 2, Hw) :- plan(t, ACT), sensing(ACT), dw(t, W, Ewo, Hwo), applicable(t, ACT),
                     de(ACT, 2), e(ACT, 2, 0, _), determines(ACT, P), holds(t, W, Ewo, Hwo, P), same_path(t, t, W, Ewo, Hwo, 2, Hw).

% Tau
dw(t+1, W, 1, Hw) :- plan(t, ACT), sensing(ACT), dw(t, W, Ewo, Hwo), applicable(t, ACT),
                     de(ACT, 1), e(ACT, 1, 0, _), determines(ACT, P), holds(t, W, Ewo, Hwo, -P), same_path(t, t, W, Ewo, Hwo, 1, Hw).

dw(t+1, W, 2, Hw) :- plan(t, ACT), announcement(ACT), dw(t, W, Ewo, Hwo), applicable(t, ACT),
                     de(ACT, 2), e(ACT, 2, 0, _), announces(ACT, P), holds(t, W, Ewo, Hwo, P), same_path(t, t, W, Ewo, Hwo, 2, Hw).

% Tau
dw(t+1, W, 1, Hw) :- plan(t, ACT), announcement(ACT), dw(t, W, Ewo, Hwo), applicable(t, ACT),
                     de(ACT, 1), e(ACT, 1, 0, _), announces(ACT, P), holds(t, W, Ewo, Hwo, -P), same_path(t, t, W, Ewo, Hwo, 1, Hw).

% Sigma (ontic)
w(t+1, W, 1, Hw) :- same_path(t, Tw, W, Ewo, Hwo, 1, Hw), time(Tw), Tw <= t, plan(t, ACT), ontic(ACT), e(ACT, 1, 0, 1).

% Sigma (epistemic)
w(t+1, W, 2, Hw) :- same_path(t, Tw, W, Ewo, Hwo, 2, Hw), time(Tw), Tw <= t, plan(t, ACT), sensing(ACT), e(ACT, 2, 0, 0),
                    determines(ACT, P), holds(Tw, W, Ewo, Hwo, P).

% Tau
w(t+1, W, 1, Hw) :- same_path(t, Tw, W, Ewo, Hwo, 1, Hw), time(Tw), Tw <= t, plan(t, ACT), sensing(ACT), e(ACT, 1, 0, 0),
                    obs(t, _, p_obs), determines(ACT, P), holds(Tw, W, Ewo, Hwo, -P).

% Sigma (epistemic)
w(t+1, W, 2, Hw) :- same_path(t, Tw, W, Ewo, Hwo, 2, Hw), time(Tw), Tw <= t, plan(t, ACT), announcement(ACT), e(ACT, 2, 0, 0),
                    announces(ACT, P), holds(Tw, W, Ewo, Hwo, P).

% % Tau
w(t+1, W, 1, Hw) :- same_path(t, Tw, W, Ewo, Hwo, 1, Hw), time(Tw), Tw <= t, plan(t, ACT), announcement(ACT), e(ACT, 1, 0, 0),
                    obs(t, _, p_obs), announces(ACT, P), holds(Tw, W, Ewo, Hwo, -P).


%%% Accessibility relations with meta-q
r(t+1, W, Ew, Hw,
  t+1, V, Ev, Hv, AG) :- w(t+1, W, Ew, Hw), w(t+1, V, Ev, Hv), same_path(t, Tw, W, Ewo, Hwo, Ew, Hw), same_path(t, Tv, V, Evo, Hvo, Ev, Hv),
                         plan(t, ACT), e(ACT, Ew, 0, _), e(ACT, Ev, 0, _), obs(t, AG, OBS), obs_type(OBS), OBS != obl,
                         metaq(ACT, Ew, Ev, OBS), r(Tw, W, Ewo, Hwo, Tv, V, Evo, Hvo, AG).

r(t+1, W, Ew, Hw,
  Tv , V, Ev, Hv, AG) :- w(t+1, W, Ew, Hw), same_path(t, Tw, W, Ewo, Hwo, Ew, Hw),
                         plan(t, ACT), e(ACT, Ew, 0, _), e(ACT, E, 1, 0), obs(t, AG, obl),
                         metaq(ACT, Ew, E, obl), r(Tw, W, Ewo, Hwo, Tv, V, Ev, Hv, AG).

% STEP 4: determine the interpretation of the worlds
% Postcondition is satisfied
holds(t+1, W, 1, Hw,  P) :- w(t+1, W, 1, Hw), same_path(t, Tw, W, Ewo, Hwo, 1, Hw), plan(t, ACT), ontic(ACT), e(ACT, 1, 0, 1),
                            causes(t, Tw, W, Ewo, Hwo, ACT,  P).

holds(t+1, W, 1, Hw, -P) :- w(t+1, W, 1, Hw), same_path(t, Tw, W, Ewo, Hwo, 1, Hw), plan(t, ACT), ontic(ACT), e(ACT, 1, 0, 1),
                            causes(t, Tw, W, Ewo, Hwo, ACT, -P).

% Inertia in ontic actions
holds(t+1, W, 1, Hw,  P) :- w(t+1, W, 1, Hw), same_path(t, Tw, W, Ewo, Hwo, 1, Hw), plan(t, ACT), ontic(ACT), e(ACT, 1, 0, 1),
                            % not causes(t, Tw, W, Ewo, Hwo, ACT, P), not causes(t, Tw, W, Ewo, Hwo, ACT, -P),
                            idle_atom(ACT, P),
                            holds(Tw, W, Ewo, Hwo,  P).

holds(t+1, W, 1, Hw, -P) :- w(t+1, W, 1, Hw), same_path(t, Tw, W, Ewo, Hwo, 1, Hw), plan(t, ACT), ontic(ACT), e(ACT, 1, 0, 1),
                            % not causes(t, Tw, W, Ewo, Hwo, ACT, P), not causes(t, Tw, W, Ewo, Hwo, ACT, -P),
                            idle_atom(ACT, P),
                            holds(Tw, W, Ewo, Hwo, -P).

% Epistemic actions
holds(t+1, W, Ew, Hw,  P) :- w(t+1, W, Ew, Hw), same_path(t, Tw, W, Ewo, Hwo, Ew, Hw), plan(t, ACT), epistemic(ACT), e(ACT, Ew, _, 0),
                             holds(Tw, W, Ewo, Hwo,  P).

holds(t+1, W, Ew, Hw, -P) :- w(t+1, W, Ew, Hw), same_path(t, Tw, W, Ewo, Hwo, Ew, Hw), plan(t, ACT), epistemic(ACT), e(ACT, Ew, _, 0),
                             holds(Tw, W, Ewo, Hwo, -P).

%%% Checking observability relations %%%
obs(t, AG, f_obs) :- plan(t, ACT),                        observes (t, ACT, AG).
obs(t, AG, p_obs) :- plan(t, ACT),      sensing(ACT),     aware_of (t, ACT, AG).
obs(t, AG, p_obs) :- plan(t, ACT), announcement(ACT),     aware_of (t, ACT, AG).

obs(t, AG, obl  ) :- plan(t, ACT),                        oblivious(t, ACT, AG).
obs(t, AG, obl  ) :- plan(t, ACT),                    not observes (t, ACT, AG),                           agent(AG).
obs(t, AG, obl  ) :- plan(t, ACT),      sensing(ACT), not observes (t, ACT, AG), not aware_of(t, ACT, AG), agent(AG).
obs(t, AG, obl  ) :- plan(t, ACT), announcement(ACT), not observes (t, ACT, AG), not aware_of(t, ACT, AG), agent(AG).

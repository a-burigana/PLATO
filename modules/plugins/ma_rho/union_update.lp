% ********** mA^\rho PLUGIN **********

semantics(possibilities).

#defined ontic/1.
#defined sensing/1.
#defined announcement/1.

#defined causes/2.
#defined causes/3.
#defined determines/2.
#defined announces/2.

#defined aware_of/3.
#defined oblivious/2.

#defined init_sf/1.

% TODO LIST:
%  - Update domains and instances with new worlds representation
%  - Implement new representation in Kripke semantics
%  - Implement extended Delphic semantics
%

#program step(t).

applicable(t, ACT) :- action_pre(ACT, F), entails(t, t, W', F).

%%% Update condition
update(t, t, W, E, (W, t, E)) :- dw(t, W), plan(t, ACT), applicable(t, ACT), de(ACT, E).

update(t, T, W, E, (W, t, E)) :- update(t, T2, W2, E2, _), plan(t, ACT), applicable(t, ACT), e(ACT, E), e(ACT, E2), E2 > 0,
                                 obs(t, AG, OBS), obs_type(OBS), OBS != obl, metaq(ACT, E2, E, OBS),
                                 r(T2, W2, T, W, AG), time(T), time(T2), T <= T2, T2 <= t.

%%% Designated worlds
% Sigma (ontic)
dw(t+1, W') :- update(t, t, W, 1, W'), plan(t, ACT), applicable(t, ACT), ontic(ACT),
               de(ACT, 1), e(ACT, 1), dw(t, W).

% Sigma (sensing)
dw(t+1, W') :- update(t, t, W, 2, W'), plan(t, ACT), applicable(t, ACT), sensing(ACT),
               de(ACT, 2), e(ACT, 2), dw(t, W), determines(ACT, P), holds(t, W,  P).

% Tau (sensing)
dw(t+1, W') :- update(t, t, W, 1, W'), plan(t, ACT), applicable(t, ACT), sensing(ACT),
               de(ACT, 1), e(ACT, 1), dw(t, W), determines(ACT, P), holds(t, W, -P).

% Sigma (announcement)
dw(t+1, W') :- update(t, t, W, 2, W'), plan(t, ACT), applicable(t, ACT), announcement(ACT),
               de(ACT, 2), e(ACT, 2), dw(t, W), announces(ACT, P),  holds(t, W,  P).

% Tau (announcement)
dw(t+1, W') :- update(t, t, W, 1, W'), plan(t, ACT), applicable(t, ACT), announcement(ACT),
               de(ACT, 1), e(ACT, 1), dw(t, W), announces(ACT, P),  holds(t, W, -P).

%%% Worlds
% Sigma (ontic)
w(t+1, W') :- update(t, Tw, W, 1, W'), time(Tw), Tw <= t, plan(t, ACT), ontic(ACT), e(ACT, 1).

% Sigma (sensing)
w(t+1, W') :- update(t, Tw, W, 2, W'), time(Tw), Tw <= t, plan(t, ACT), sensing(ACT), e(ACT, 2),
              determines(ACT, P), holds(Tw, W, P).

% Tau (sensing)
w(t+1, W') :- update(t, Tw, W, 1, W'), time(Tw), Tw <= t, plan(t, ACT), sensing(ACT), e(ACT, 1),
              obs(t, _, p_obs), determines(ACT, P), holds(Tw, W, -P).

% Sigma (announcement)
w(t+1, W') :- update(t, Tw, W, 2, W'), time(Tw), Tw <= t, plan(t, ACT), announcement(ACT), e(ACT, 2),
              announces(ACT, P), holds(Tw, W, P).

% Tau (announcement)
w(t+1, W') :- update(t, Tw, W, 1, W'), time(Tw), Tw <= t, plan(t, ACT), announcement(ACT), e(ACT, 1),
              obs(t, _, p_obs), announces(ACT, P),  holds(Tw, W, -P).


%%% Accessibility relations with meta-q
r(t+1, W',
  t+1, V', AG) :- w(t+1, W'), w(t+1, V'), update(t, Tw, W, Ew, W'), update(t, Tv, V, Ev, V'),
                  plan(t, ACT), e(ACT, Ew), e(ACT, Ev), obs(t, AG, OBS), obs_type(OBS), OBS != obl,
                  metaq(ACT, Ew, Ev, OBS), r(Tw, W, Tv, V, AG).

r(t+1, W',
  Tv , V', AG) :- w(t+1, W'), update(t, Tw, W, Ew, W'),
                  plan(t, ACT), e(ACT, Ew), obs(t, AG, obl),
                  metaq(ACT, Ew, 0, obl), r(Tw, W, Tv, V', AG).

% STEP 4: determine the interpretation of the worlds
% Postcondition is satisfied
holds(t+1, W',  P) :- w(t+1, W'), update(t, Tw, W, 1, W'), plan(t, ACT), ontic(ACT),
                      causes(ACT,  P).

holds(t+1, W', -P) :- w(t+1, W'), update(t, Tw, W, 1, W'), plan(t, ACT), ontic(ACT),
                      causes(ACT, -P).

holds(t+1, W',  P) :- w(t+1, W'), update(t, Tw, W, 1, W'), plan(t, ACT), ontic(ACT),
                      causes(ACT,  P, F), entails(t, Tw, W, F).

holds(t+1, W', -P) :- w(t+1, W'), update(t, Tw, W, 1, W'), plan(t, ACT), ontic(ACT),
                      causes(ACT, -P, F), entails(t, Tw, W, F).

% Inertia in ontic actions
idle_atom(t, Tw, W, P) :- update(t, Tw, W, 1, _), plan(t, ACT), ontic(ACT), atom(P),
                               causes(ACT,  P, Fpost1), not entails(t, Tw, W, Fpost1),
                               causes(ACT, -P, Fpost2), not entails(t, Tw, W, Fpost2).

idle_atom(t, Tw, W, P) :- update(t, Tw, W, 1, _), plan(t, ACT), ontic(ACT), atom(P),
                               causes(ACT,  P, Fpost1), not entails(t, Tw, W, Fpost1),
                               not causes(ACT, -P, _).

idle_atom(t, Tw, W, P) :- update(t, Tw, W, 1, _), plan(t, ACT), ontic(ACT), atom(P),
                               causes(ACT, -P, Fpost1), not entails(t, Tw, W, Fpost1),
                               not causes(ACT,  P, _).


holds(t+1, W',  P) :- w(t+1, W'), update(t, Tw, W, 1, W'), plan(t, ACT), ontic(ACT),
                      idle_atom(ACT, P), holds(Tw, W,  P).

holds(t+1, W', -P) :- w(t+1, W'), update(t, Tw, W, 1, W'), plan(t, ACT), ontic(ACT),
                      idle_atom(ACT, P), holds(Tw, W, -P).

holds(t+1, W',  P) :- w(t+1, W'), update(t, Tw, W, 1, W'), plan(t, ACT), ontic(ACT),
                      idle_atom(t, Tw, W, P), holds(Tw, W,  P).

holds(t+1, W', -P) :- w(t+1, W'), update(t, Tw, W, 1, W'), plan(t, ACT), ontic(ACT),
                      idle_atom(t, Tw, W, P), holds(Tw, W, -P).

% Epistemic actions
holds(t+1, W',  P) :- w(t+1, W'), update(t, Tw, W, Ew, W'), plan(t, ACT), epistemic(ACT),
                      holds(Tw, W,  P), atom(P).

holds(t+1, W', -P) :- w(t+1, W'), update(t, Tw, W, Ew, W'), plan(t, ACT), epistemic(ACT),
                      holds(Tw, W, -P), atom(P).

%%% Checking observability relations %%%
obs(t, AG, f_obs) :- plan(t, ACT),                        observes (t, ACT, AG).
obs(t, AG, p_obs) :- plan(t, ACT),      sensing(ACT),     aware_of (t, ACT, AG).
obs(t, AG, p_obs) :- plan(t, ACT), announcement(ACT),     aware_of (t, ACT, AG).

obs(t, AG, obl  ) :- plan(t, ACT),                        oblivious(t, ACT, AG).
obs(t, AG, obl  ) :- plan(t, ACT),        ontic(ACT), not observes (t, ACT, AG),                           agent(AG).
obs(t, AG, obl  ) :- plan(t, ACT),      sensing(ACT), not observes (t, ACT, AG), not aware_of(t, ACT, AG), agent(AG).
obs(t, AG, obl  ) :- plan(t, ACT), announcement(ACT), not observes (t, ACT, AG), not aware_of(t, ACT, AG), agent(AG).

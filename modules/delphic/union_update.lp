% ********** UNION UPDATE **********

semantics(possibilities).

#program step(t).

applicable(t, ACT) :- action_pre(ACT, F), entails(t, t, W', F).

%%% Update condition
update(t, t, W, E, (W, t, E)) :- dw(t, W), plan(t, ACT), applicable(t, ACT), de(ACT, E).

update(t, T, W, E, (W, t, E)) :- update(t, T2, W2, E2, _), plan(t, ACT), e(ACT, E), not idle(ACT, E),
                                 obs(t, AG, OBS), metaq(ACT, E2, E, OBS),
                                 r(T2, W2, T, W, AG), time(T), time(T2), T <= T2, T2 <= t.

%%% Worlds
w(t+1, W') :- update(t, Tw, W, E, W'), time(Tw), Tw <= t, plan(t, ACT), e(ACT, E).

% w(t+1, W') :- update(t, Tw, W, E, W').

%%% Designated worlds
dw(t+1, W') :- update(t, t, W, E, W'), plan(t, ACT), applicable(t, ACT),
               de(ACT, E), e(ACT, E), dw(t, W).

dw(t+1, W') :- update(t, t, W, E, W'), de(ACT, E), dw(t, W).

%%% Accessibility relations with meta-q
r(t+1, W',
  t+1, V', AG) :- w(t+1, W'), w(t+1, V'), update(t, Tw, W, Ew, W'), update(t, Tv, V, Ev, V'),
                  plan(t, ACT), e(ACT, Ew), e(ACT, Ev), obs(t, AG, OBS), not idle(ACT, E),      % TODO: implement idle in input
                  metaq(ACT, Ew, Ev, OBS), r(Tw, W, Tv, V, AG).

r(t+1, W',
  Tv , V', AG) :- w(t+1, W'), update(t, Tw, W, Ew, W'),
                  plan(t, ACT), e(ACT, Ew), obs(t, AG, OBS), idle(ACT, E),
                  metaq(ACT, Ew, E, OBS), r(Tw, W, Tv, V', AG).

% STEP 4: determine the interpretation of the worlds
% Postcondition is satisfied
holds(t+1, W',  P) :- w(t+1, W'), update(t, Tw, W, E, W'), plan(t, ACT), ontic(ACT, E),
                      post(ACT, E,  P, F), entails(t+1, W', F).

:- w(t+1, W'), update(t, Tw, W, E, W'), plan(t, ACT), ontic(ACT, E),
   holds(t+1, W', P), post(ACT, E, -P, F), entails(t+1, W', F).

% Inertia in ontic actions
holds(t+1, W', P) :- w(t+1, W'), update(t, Tw, W, E, W'), plan(t, ACT), ontic(ACT, E),
                     inertia(ACT, E, P), holds(Tw, W, P).

:- w(t+1, W'), update(t, Tw, W, E, W'), plan(t, ACT), ontic(ACT, E),
   inertia(ACT, E, P), holds(t+1, W', P), not holds(Tw, W, P).

% Epistemic actions
holds(t+1, W', P) :- w(t+1, W'), update(t, Tw, W, E, W'), plan(t, ACT), epistemic(ACT, E),
                     holds(Tw, W, P).


%%% Checking observability relations %%%
obs(t, AG, OBS) :- plan(t, ACT), obs_cond(ACT, OBS, true).
obs(t, AG, OBS) :- plan(t, ACT), obs_cond(ACT, OBS, F), entails(t, W, F), dw(t, W).

:- obs(t, AG, OBS1), obs(t, AG, OBS2), OBS1 != OBS2.

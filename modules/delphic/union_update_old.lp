% ********** UNION UPDATE **********

semantics(possibilities).

#program step(t).

-applicable(t, ACT) :- pre(ACT, E, F), de(ACT, E), dw(t, W), @holds_in_world(W, E) == 0.
applicable(t, ACT) :- action(ACT), not -applicable(t, ACT).

%%% Update condition
update(t, t, W, E, (W, t, E)) :- dw(t, W), plan(t, ACT), de(ACT, E), pre(ACT, E, PRE), @holds_in_world(W, PRE) == 1.

update(t, T, W, E, (W, t, E)) :- update(t, T2, W2, E2, _), plan(t, ACT), e(ACT, E), not idle(ACT, E),
                                 r(T2, W2, T, W, AG), obs(t, AG, OBS), q(ACT, E2, E, OBS),
                                 pre(ACT, E, PRE), @holds_in_world(W, PRE) == 1, time(T), time(T2), T <= T2, T2 <= t.

%%% Worlds
w(t+1, W') :- update(t, Tw, W, E, W'), time(Tw), Tw <= t, plan(t, ACT), e(ACT, E).

% w(t+1, W') :- update(t, Tw, W, E, W').

%%% Designated worlds
dw(t+1, W') :- update(t, t, W, E, W'), plan(t, ACT), applicable(t, ACT),
               de(ACT, E), e(ACT, E), dw(t, W).

dw(t+1, W') :- update(t, t, W, E, W'), de(ACT, E), dw(t, W).

%%% Accessibility relations
r(t+1, W',
  t+1, V', AG) :- update(t, Tw, W, Ew, W'), update(t, Tv, V, Ev, V'),
                  r(Tw, W, Tv, V, AG), q(ACT, Ew, Ev, OBS), obs(t, AG, OBS), not idle(ACT, Ev).

r(t+1, W',
  Tv , V', AG) :- update(t, Tw, W, Ew, W'),
                  r(Tw, W, Tv, V', AG), q(ACT, Ew, E, OBS), obs(t, AG, OBS), idle(ACT, E).

% STEP 4: determine the interpretation of the worlds
% Postcondition is satisfied
v(t+1, W', P) :- update(t, Tw, W, E, W'), plan(t, ACT), ontic(ACT, E),
                 post(ACT, E,  P, F), @holds_in_world(W, F) == 1.

% Inertia in ontic actions
v(t+1, W', P) :- update(t, Tw, W, E, W'), plan(t, ACT), ontic(ACT, E),
                 inertia(ACT, E, P), v(Tw, W, P).

% Epistemic actions
v(t+1, W', P) :- update(t, Tw, W, E, W'), plan(t, ACT), epistemic(ACT, E),
                 v(Tw, W, P).


%%% Checking observability relations %%%
obs(t, AG, OBS) :- plan(t, ACT), obs_cond(ACT, AG, OBS, F), @holds(F) == 1.

:- obs(t, AG, OBS1), obs(t, AG, OBS2), OBS1 != OBS2.

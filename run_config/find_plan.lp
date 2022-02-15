#program step(t).

% Generate
0 { plan(t, ACT) : action(ACT), applicable(t, ACT) } 1 :- time(t).

% Test
not_reached_goal(t) :- w(t, W, Ew, Hw), dw(t, W, Ew, Hw), not entails(t, W, Ew, Hw, F), goal(F), formula(F).

:- time(t), 0 { plan(t, _) } 0, not_reached_goal(t).
:- time(t), 0 { applicable(t, _) } 0, not_reached_goal(t).
:- time(t), plan(t, _), not not_reached_goal(t).
:- time(t), plan(t, ACT), not applicable(t, ACT).
:- time(t), not dw(t, _, _, _), not_reached_goal(t).
:- time(t), holds(t, W, Ew, Hw, P), holds(t, W, Ew, Hw, -P), atom(P).

:- time(t), t > 0, plan(t-1, ACT), plan(t, ACT), epistemic(ACT).

#program check(t).
:- not_reached_goal(t), query(t).

% Display
#show plan/2.

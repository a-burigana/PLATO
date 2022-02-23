#program step(t).

% Generate
0 { plan(t, ACT) : action(ACT), applicable(t, ACT) } 1 :- time(t).

% Test
:- time(t), 0 { plan(t, _) } 0, not goal(t).
:- time(t), 0 { applicable(t, _) } 0, not goal(t).
:- time(t), plan(t, _), goal(t).
:- time(t), plan(t, ACT), not applicable(t, ACT).
:- time(t), not dw(t, _), not goal(t).
:- time(t), holds(t, Hw, P), holds(t, Hw, -P), atom(P).

:- time(t), t > 0, plan(t-1, ACT), plan(t, ACT), epistemic(ACT).

#program check(t).
:- not goal(t), query(t).

% Display
#show plan/2.

#program step(t).

% Generate
1 { plan(t, ACT) : action(ACT), applicable(t, ACT) } 1.% :- time(t), t > 0.%, not_goal_at(t-1).

% Test
:- t > 0, plan(t, ACT), not applicable(t, ACT).
:- t > 0, 0 { plan(t, _) } 0, not_goal_at(t).
:- time(t), 0 { applicable(t, _) } 0, not_goal_at(t).
% :- time(t), plan(t, _), not not_goal_at(t).

% :- time(t), not dw(t, _), not_goal_at(t).

% :- time(t), t > 0, time(T), T < t, plan(T, ACT), plan(t, ACT), once(ACT).
% :- time(t), t > 0, plan(t-1, ACT), plan(t, ACT), epistemic(ACT).


#program check(t).
% time(t).
not_goal_at(t) :- dw(t, W, E), goal(G), not holds(t, W, E, G).
:- not_goal_at(t), query(t).

% #show goal_at/1.
% #show goal/1.
% #show time/1.
% #show dw/3.
% #show holds/4.


% Display
% #show.
#show plan/2.

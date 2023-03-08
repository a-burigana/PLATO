% Print settings
#const print=true.
print_states(print).


% ***** INSERT ACTIONS TO TEST HERE *****

% plan(1,action_1).
% plan(2,action_2).
% plan(3,action_3).
% ...

stop_at(MAX_T) :- MAX_T = #max { T : plan(T, _) }.


% ***** Check *****
#program check(t).

#external query(t).
time(t).

not_goal_at(t) :- time(t), dw(t, W, E), goal(G), not holds(t, W, E, G).
goal_at(t) :- not not_goal_at(t).

% Ensuring we stop after executing all the actions in input
:- not stop_at(t), query(t).


% ***** Display *****
#show plan/2.
#show goal_at/1.

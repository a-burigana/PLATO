%%% DEBUG
plan(0,open_a).
plan(1,peek_a).
plan(2,signal_a_b).
plan(3,signal_a_c).
plan(4,shout_tail_a).
reached_goal(5).


#program check(t).
% reached_goal(0).
:- not reached_goal(t), query(t).

% Display
#show plan/2.

% #show entails/6.
% #show check_on_w/6.
% #show reaches/9.

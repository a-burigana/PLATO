%%% DEBUG
% plan(0,open_a).
% plan(1,peek_a).
% plan(2,signal_a_b).
% plan(3,signal_a_c).
% plan(4,shout_tail_a).
% reached_goal(5).

% plan(0,right).
% plan(1,sense).
% plan(2,right).
% plan(3,right).
% plan(4,shout_4).
% reached_goal(5).


plan(0,sense).
plan(1,shout_10).
plan(2,shout_10).
plan(3,left).
plan(4,shout_9).
plan(5,left).
plan(6,shout_8).
reached_goal(7).

#program check(t).
% reached_goal(0).
:- not reached_goal(t), query(t).

% Display
#show plan/2.

% #show w/4.
% #show entails/6.
% #show check_on_w/6.
% #show reaches/9.

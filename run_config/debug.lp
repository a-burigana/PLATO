%%% DEBUG
plan(0,open_a).
plan(1,peek_a).
plan(2,signal_a_c).
plan(3,signal_c_b).
plan(4,shout_tail_a).
reached_goal(5).

% plan(0,signal_a_b).
% plan(1,signal_a_c).
% plan(2,open_a).
% plan(3,peek_b).
% plan(4,shout_tail_b).
% reached_goal(5).


% plan(0,signal_a_b).
% plan(1,signal_b_c).
% reached_goal(2).


% plan(0,right_b).
% plan(1,b_check_3).
% plan(2,tell_b_b2_3).
% reached_goal(3).


% plan(0,right).
% plan(1,sense).
% plan(2,right).
% plan(3,right).
% plan(4,shout_4).
% reached_goal(5).


% plan(0,right).
% plan(1,sense).
% plan(2,right).
% plan(3,right).
% plan(4,shout_4).
% plan(5,left).
% plan(6,left).
% reached_goal(7).


% plan(0,share_a_sa_1).
% plan(1,right_a).
% plan(2,share_c_sc_1).
% plan(3,right_b).
% plan(4,share_b_sb_2).
% reached_goal(5).

#program check(t).
not_reached_goal(t) :- w(t, W, Ew, Hw), dw(t, W, Ew, Hw), not entails(t, W, Ew, Hw, F), goal(F), formula(F).
reached_goal(t) :- not not_reached_goal(t).

:- not reached_goal(t), query(t).

% Display
#show plan/2.
#show reached_goal/1.

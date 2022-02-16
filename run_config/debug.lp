%%% DEBUG
% plan(0,open_a).
% plan(1,peek_a).
% plan(2,signal_a_c).
% plan(3,signal_c_b).
% plan(4,shout_tail_a).
% goal(6).

% plan(0,open_a).
% plan(1,peek_a).
% plan(2,signal_a_c).
% plan(3,signal_c_b).
% plan(4,shout_tail_a).
% goal(5).


% plan(0,signal_a_b).
% plan(1,signal_b_c).
% goal(2).


% plan(0,left_b).
% plan(1,b_check_1).
% plan(2,tell_b_b1_1).
% goal(3).


plan(0,right).
plan(1,sense).
% plan(2,right).
% plan(3,right).
% plan(4,shout_4).
goal(5).


% plan(0,right).
% plan(1,sense).
% plan(2,right).
% plan(3,right).
% plan(4,shout_4).
% plan(5,left).
% plan(6,left).
% goal(7).


% plan(0,share_a_sa_1).
% plan(1,right_a).
% plan(2,share_c_sc_1).
% plan(3,right_b).
% plan(4,share_b_sb_2).
% goal(5).

#program check(t).
% not_reached_goal(t) :- w(t, W, Ew, Hw), dw(t, W, Ew, Hw), not entails(t, W, Ew, Hw, F), goal(F), formula(F).
% goal(t) :- not not_reached_goal(t).

:- not goal(t), query(t).

% Display
#show plan/2.
#show goal/1.
% #show reaches/9.

#show holds/5.

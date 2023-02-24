%%% DEBUG
% plan(1,open_a).
% plan(2,peek_a).
% plan(2,signal_a_c).
% plan(3,signal_c_b).
% plan(4,shout_tail_a).
% goal_at(2).

plan(1,signal_a_c).
plan(2,signal_c_b).
% plan(1,open_a).
% plan(2,peek_b).
% plan(3,signal_c_b).
% plan(4,shout_tail_a).
goal_at(2).


% plan(0,left_b).
% plan(1,b_check_1).
% plan(2,tell_b_b1_1).
% goal(3).

% plan(0,right_a).
% plan(1,a_check_3).
% plan(2,tell_b_b1_1).
% goal(3).

% plan(0,sense).
% plan(0,right).
% plan(1,sense).
% plan(2,right).
% plan(3,right).
% plan(4,shout_4).
% goal(5).


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
not_goal_at(t) :- time(t), dw(t, W, E), goal(G), not holds(t, W, E, G).
real_goal_at(t) :- not not_goal_at(t).

:- not goal_at(t), query(t).

% Display
#show plan/2.
% #show goal_at/1.
% #show not_goal_at/1.
#show real_goal_at/1.

#show w/3.
% #show dw/3.
% #show r/7.
% #show v/4.
% #show holds/4.

% #show reaches/9.

% #show holds/5.

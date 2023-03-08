#const maxT  = 8.
#const n_fl  = 10.
#const n_ag  = 2.
#const n_ags = 3.

%time(0..maxT).

% *** ATOMS ***
atom(at_a_1).
atom(at_a_2).
atom(at_a_3).
atom(at_box1_room1).
atom(at_box1_room3).
atom(at_box2_room1).
atom(at_box2_room3).
atom(at_b_1).
atom(at_b_2).
atom(at_b_3).


% *** AGENTS ***
agent(a).
agent(b).


% *** ACTIONS ***
action(a_check_1).
action_type(a_check_1, sensing).
determines(a_check_1, at_box1_room1).
action_pre(a_check_1, box(a,at_a_1)).
observes(a_check_1, a, true).
oblivious(a_check_1, b).


action(a_check_3).
action_type(a_check_3, sensing).
determines(a_check_3, at_box2_room3).
action_pre(a_check_3, box(a,at_a_3)).
observes(a_check_3, a, true).
oblivious(a_check_3, b).


action(b_check_1).
action_type(b_check_1, sensing).
determines(b_check_1, at_box1_room1).
action_pre(b_check_1, box(b,at_b_1)).
observes(b_check_1, b, true).
oblivious(b_check_1, a).


action(b_check_3).
action_type(b_check_3, sensing).
determines(b_check_3, at_box2_room3).
action_pre(b_check_3, box(b,at_b_3)).
observes(b_check_3, b, true).
oblivious(b_check_3, a).


action(left_a).
action_type(left_a, ontic).
causes(left_a, at_a_1, at_a_2).
causes(left_a, at_a_2, at_a_3).
causes(left_a, neg(at_a_2), at_a_2).
causes(left_a, neg(at_a_3), at_a_3).
action_pre(left_a, and(neg(at_a_1),box(a,neg(at_a_1)))).
observes(left_a, a, true).
observes(left_a, b, true).


action(left_b).
action_type(left_b, ontic).
causes(left_b, at_b_1, at_b_2).
causes(left_b, at_b_2, at_b_3).
causes(left_b, neg(at_b_2), at_b_2).
causes(left_b, neg(at_b_3), at_b_3).
action_pre(left_b, and(box(b,neg(at_b_1)),neg(at_b_1))).
observes(left_b, a, true).
observes(left_b, b, true).


action(right_a).
action_type(right_a, ontic).
causes(right_a, neg(at_a_1), at_a_1).
causes(right_a, at_a_2, at_a_1).
causes(right_a, neg(at_a_2), at_a_2).
causes(right_a, at_a_3, at_a_2).
action_pre(right_a, and(box(a,neg(at_a_3)),neg(at_a_3))).
observes(right_a, a, true).
observes(right_a, b, true).


action(right_b).
action_type(right_b, ontic).
causes(right_b, neg(at_b_1), at_b_1).
causes(right_b, at_b_2, at_b_1).
causes(right_b, neg(at_b_2), at_b_2).
causes(right_b, at_b_3, at_b_2).
action_pre(right_b, and(box(b,neg(at_b_3)),neg(at_b_3))).
observes(right_b, a, true).
observes(right_b, b, true).


action(tell_a_b1_1).
action_type(tell_a_b1_1, announcement).
announces(tell_a_b1_1, at_box1_room1).
action_pre(tell_a_b1_1, box(a,at_box1_room1)).
observes(tell_a_b1_1, b, true).
oblivious(tell_a_b1_1, a).


action(tell_a_b1_3).
action_type(tell_a_b1_3, announcement).
announces(tell_a_b1_3, at_box1_room3).
action_pre(tell_a_b1_3, box(a,at_box1_room3)).
observes(tell_a_b1_3, a, true).
observes(tell_a_b1_3, b, true).


action(tell_a_b2_1).
action_type(tell_a_b2_1, announcement).
announces(tell_a_b2_1, at_box2_room1).
action_pre(tell_a_b2_1, box(a,at_box2_room1)).
observes(tell_a_b2_1, a, true).
observes(tell_a_b2_1, b, true).


action(tell_a_b2_3).
action_type(tell_a_b2_3, announcement).
announces(tell_a_b2_3, at_box2_room3).
action_pre(tell_a_b2_3, box(a,at_box2_room3)).
observes(tell_a_b2_3, a, true).
observes(tell_a_b2_3, b, true).


action(tell_b_b1_1).
action_type(tell_b_b1_1, announcement).
announces(tell_b_b1_1, at_box1_room1).
action_pre(tell_b_b1_1, box(b,at_box1_room1)).
observes(tell_b_b1_1, a, true).
observes(tell_b_b1_1, b, true).


action(tell_b_b1_3).
action_type(tell_b_b1_3, announcement).
announces(tell_b_b1_3, at_box1_room3).
action_pre(tell_b_b1_3, box(b,at_box1_room3)).
observes(tell_b_b1_3, a, true).
observes(tell_b_b1_3, b, true).


action(tell_b_b2_1).
action_type(tell_b_b2_1, announcement).
announces(tell_b_b2_1, at_box2_room1).
action_pre(tell_b_b2_1, box(b,at_box2_room1)).
observes(tell_b_b2_1, a, true).
observes(tell_b_b2_1, b, true).


action(tell_b_b2_3).
action_type(tell_b_b2_3, announcement).
announces(tell_b_b2_3, at_box2_room3).
action_pre(tell_b_b2_3, box(b,at_box2_room3)).
observes(tell_b_b2_3, a, true).
observes(tell_b_b2_3, b, true).




% *** INITIALLY ***

% ** initial pointed **
initially(neg(at_a_1)).
initially(at_a_2).
initially(neg(at_a_3)).
initially(at_box1_room1).
initially(neg(at_box1_room3)).
initially(neg(at_box2_room1)).
initially(at_box2_room3).
initially(neg(at_b_1)).
initially(at_b_2).
initially(neg(at_b_3)).

% ** initial beliefs **
agent_set(all_agents).
contains_ag(all_agents,a).
contains_ag(all_agents,b).
initially(c(all_agents,at_a_2)).
initially(c(all_agents,at_b_2)).
initially(c(all_agents,neg(at_a_1))).
initially(c(all_agents,neg(at_b_1))).
initially(c(all_agents,neg(at_a_3))).
initially(c(all_agents,neg(at_b_3))).
initially(c(all_agents,or(and(at_box1_room1,neg(at_box1_room3)),and(neg(at_box1_room1),at_box1_room3)))).
initially(c(all_agents,or(and(at_box2_room1,neg(at_box2_room3)),and(neg(at_box2_room1),at_box2_room3)))).





% *** GOALS ***
goal(box(a,at_box1_room1)).
goal(box(b,at_box1_room1)).
goal(box(a,at_box2_room3)).
goal(box(b,at_box2_room3)).
goal(box(a,neg(box(b,at_box2_room3)))).
goal(box(b,neg(box(a,at_box2_room3)))).
goal(box(a,neg(box(b,at_box1_room1)))).
goal(box(b,neg(box(a,at_box1_room1)))).
goal(box(a,at_a_3)).
goal(box(b,at_a_3)).



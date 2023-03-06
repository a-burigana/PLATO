% *** ATOMS ***
atom(at_a_1).
atom(at_a_2).
atom(at_a_3).
atom(at_b1_1).
atom(at_b1_3).
atom(at_b2_1).
atom(at_b2_3).
atom(at_b_1).
atom(at_b_2).
atom(at_b_3).
atom(at_c_1).
atom(at_c_2).
atom(at_c_3).


% *** AGENTS ***
agent(a).
agent(b).
agent(c).


% *** ACTIONS ***
action(a_check_1).
action_type(a_check_1, sensing).
determines(a_check_1, at_b1_1).
action_pre(a_check_1, neg(dia(a,neg(at_a_1)))).
obs_cond(a_check_1, a, f_obs, true).
obs_cond(a_check_1, b, obl  , true).
obs_cond(a_check_1, c, obl  , true).


action(a_check_3).
action_type(a_check_3, sensing).
determines(a_check_3, at_b2_3).
action_pre(a_check_3, neg(dia(a,neg(at_a_3)))).
obs_cond(a_check_3, a, f_obs, true).
obs_cond(a_check_3, b, obl  , true).
obs_cond(a_check_3, c, obl  , true).


action(b_check_1).
action_type(b_check_1, sensing).
determines(b_check_1, at_b1_1).
action_pre(b_check_1, neg(dia(b,neg(at_b_1)))).
obs_cond(b_check_1, b, f_obs, true).
obs_cond(b_check_1, a, obl  , true).
obs_cond(b_check_1, c, obl  , true).


action(b_check_3).
action_type(b_check_3, sensing).
determines(b_check_3, at_b2_3).
action_pre(b_check_3, neg(dia(b,neg(at_b_3)))).
obs_cond(b_check_3, b, f_obs, true).
obs_cond(b_check_3, a, obl  , true).
obs_cond(b_check_3, c, obl  , true).


action(c_check_1).
action_type(c_check_1, sensing).
determines(c_check_1, at_b1_1).
action_pre(c_check_1, neg(dia(c,neg(at_c_1)))).
obs_cond(c_check_1, c, f_obs, true).
obs_cond(c_check_1, a, obl  , true).
obs_cond(c_check_1, b, obl  , true).


action(c_check_3).
action_type(c_check_3, sensing).
determines(c_check_3, at_b2_3).
action_pre(c_check_3, neg(dia(c,neg(at_c_3)))).
obs_cond(c_check_3, c, f_obs, true).
obs_cond(c_check_3, a, obl  , true).
obs_cond(c_check_3, b, obl  , true).


action(left_a).
action_type(left_a, ontic).
causes(left_a, at_a_1, at_a_2).
causes(left_a, at_a_2, at_a_3).
causes(left_a, neg(at_a_2), at_a_2).
causes(left_a, neg(at_a_3), at_a_3).
action_pre(left_a, neg(at_a_1)).
obs_cond(left_a, a, f_obs, true).
obs_cond(left_a, b, f_obs, true).
obs_cond(left_a, c, f_obs, true).


action(left_b).
action_type(left_b, ontic).
causes(left_b, at_b_1, at_b_2).
causes(left_b, at_b_2, at_b_3).
causes(left_b, neg(at_b_2), at_b_2).
causes(left_b, neg(at_b_3), at_b_3).
action_pre(left_b, neg(at_b_1)).
obs_cond(left_b, a, f_obs, true).
obs_cond(left_b, b, f_obs, true).
obs_cond(left_b, c, f_obs, true).


action(left_c).
action_type(left_c, ontic).
causes(left_c, at_c_1, at_c_2).
causes(left_c, at_c_2, at_c_3).
causes(left_c, neg(at_c_2), at_c_2).
causes(left_c, neg(at_c_3), at_c_3).
action_pre(left_c, neg(at_c_1)).
obs_cond(left_c, a, f_obs, true).
obs_cond(left_c, b, f_obs, true).
obs_cond(left_c, c, f_obs, true).


action(right_a).
action_type(right_a, ontic).
causes(right_a, neg(at_a_1), at_a_1).
causes(right_a, at_a_2, at_a_1).
causes(right_a, neg(at_a_2), at_a_2).
causes(right_a, at_a_3, at_a_2).
action_pre(right_a, neg(at_a_3)).
obs_cond(right_a, a, f_obs, true).
obs_cond(right_a, b, f_obs, true).
obs_cond(right_a, c, f_obs, true).


action(right_b).
action_type(right_b, ontic).
causes(right_b, neg(at_b_1), at_b_1).
causes(right_b, at_b_2, at_b_1).
causes(right_b, neg(at_b_2), at_b_2).
causes(right_b, at_b_3, at_b_2).
action_pre(right_b, neg(at_b_3)).
obs_cond(right_b, a, f_obs, true).
obs_cond(right_b, b, f_obs, true).
obs_cond(right_b, c, f_obs, true).


action(right_c).
action_type(right_c, ontic).
causes(right_c, neg(at_c_1), at_c_1).
causes(right_c, at_c_2, at_c_1).
causes(right_c, neg(at_c_2), at_c_2).
causes(right_c, at_c_3, at_c_2).
action_pre(right_c, neg(at_c_3)).
obs_cond(right_c, a, f_obs, true).
obs_cond(right_c, b, f_obs, true).
obs_cond(right_c, c, f_obs, true).


action(tell_a_b1_1).
action_type(tell_a_b1_1, announcement).
announces(tell_a_b1_1, at_b1_1).
action_pre(tell_a_b1_1, neg(dia(a,neg(at_b1_1)))).
obs_cond(tell_a_b1_1, a, f_obs, true).
obs_cond(tell_a_b1_1, b, f_obs, true).
obs_cond(tell_a_b1_1, c, f_obs, true).


action(tell_a_b1_3).
action_type(tell_a_b1_3, announcement).
announces(tell_a_b1_3, at_b1_3).
action_pre(tell_a_b1_3, neg(dia(a,neg(at_b1_3)))).
obs_cond(tell_a_b1_3, a, f_obs, true).
obs_cond(tell_a_b1_3, b, f_obs, true).
obs_cond(tell_a_b1_3, c, f_obs, true).


action(tell_a_b2_1).
action_type(tell_a_b2_1, announcement).
announces(tell_a_b2_1, at_b2_1).
action_pre(tell_a_b2_1, neg(dia(a,neg(at_b2_1)))).
obs_cond(tell_a_b2_1, a, f_obs, true).
obs_cond(tell_a_b2_1, b, f_obs, true).
obs_cond(tell_a_b2_1, c, f_obs, true).


action(tell_a_b2_3).
action_type(tell_a_b2_3, announcement).
announces(tell_a_b2_3, at_b2_3).
action_pre(tell_a_b2_3, neg(dia(a,neg(at_b2_3)))).
obs_cond(tell_a_b2_3, a, f_obs, true).
obs_cond(tell_a_b2_3, b, f_obs, true).
obs_cond(tell_a_b2_3, c, f_obs, true).


action(tell_b_b1_1).
action_type(tell_b_b1_1, announcement).
announces(tell_b_b1_1, at_b1_1).
action_pre(tell_b_b1_1, neg(dia(b,neg(at_b1_1)))).
obs_cond(tell_b_b1_1, a, f_obs, true).
obs_cond(tell_b_b1_1, b, f_obs, true).
obs_cond(tell_b_b1_1, c, f_obs, true).


action(tell_b_b1_3).
action_type(tell_b_b1_3, announcement).
announces(tell_b_b1_3, at_b1_3).
action_pre(tell_b_b1_3, neg(dia(b,neg(at_b1_3)))).
obs_cond(tell_b_b1_3, a, f_obs, true).
obs_cond(tell_b_b1_3, b, f_obs, true).
obs_cond(tell_b_b1_3, c, f_obs, true).


action(tell_b_b2_1).
action_type(tell_b_b2_1, announcement).
announces(tell_b_b2_1, at_b2_1).
action_pre(tell_b_b2_1, neg(dia(b,neg(at_b2_1)))).
obs_cond(tell_b_b2_1, a, f_obs, true).
obs_cond(tell_b_b2_1, b, f_obs, true).
obs_cond(tell_b_b2_1, c, f_obs, true).


action(tell_b_b2_3).
action_type(tell_b_b2_3, announcement).
announces(tell_b_b2_3, at_b2_3).
action_pre(tell_b_b2_3, neg(dia(b,neg(at_b2_3)))).
obs_cond(tell_b_b2_3, a, f_obs, true).
obs_cond(tell_b_b2_3, b, f_obs, true).
obs_cond(tell_b_b2_3, c, f_obs, true).


action(tell_c_b1_1).
action_type(tell_c_b1_1, announcement).
announces(tell_c_b1_1, at_b1_1).
action_pre(tell_c_b1_1, neg(dia(c,neg(at_b1_1)))).
obs_cond(tell_c_b1_1, a, f_obs, true).
obs_cond(tell_c_b1_1, b, f_obs, true).
obs_cond(tell_c_b1_1, c, f_obs, true).


action(tell_c_b1_3).
action_type(tell_c_b1_3, announcement).
announces(tell_c_b1_3, at_b1_3).
action_pre(tell_c_b1_3, neg(dia(c,neg(at_b1_3)))).
obs_cond(tell_c_b1_3, a, f_obs, true).
obs_cond(tell_c_b1_3, b, f_obs, true).
obs_cond(tell_c_b1_3, c, f_obs, true).


action(tell_c_b2_1).
action_type(tell_c_b2_1, announcement).
announces(tell_c_b2_1, at_b2_1).
action_pre(tell_c_b2_1, neg(dia(c,neg(at_b2_1)))).
obs_cond(tell_c_b2_1, a, f_obs, true).
obs_cond(tell_c_b2_1, b, f_obs, true).
obs_cond(tell_c_b2_1, c, f_obs, true).


action(tell_c_b2_3).
action_type(tell_c_b2_3, announcement).
announces(tell_c_b2_3, at_b2_3).
action_pre(tell_c_b2_3, neg(dia(c,neg(at_b2_3)))).
obs_cond(tell_c_b2_3, a, f_obs, true).
obs_cond(tell_c_b2_3, b, f_obs, true).
obs_cond(tell_c_b2_3, c, f_obs, true).




% *** INITIALLY ***

% ** initial pointed **
initially(neg(at_a_1)).
initially(at_a_2).
initially(neg(at_a_3)).
initially(at_b1_1).
initially(neg(at_b1_3)).
initially(neg(at_b2_1)).
initially(at_b2_3).
initially(neg(at_b_1)).
initially(at_b_2).
initially(neg(at_b_3)).
initially(neg(at_c_1)).
initially(at_c_2).
initially(neg(at_c_3)).

% ** initial beliefs **
agent_set(all_agents).
contains_ag(all_agents,a).
contains_ag(all_agents,b).
contains_ag(all_agents,c).
initially(c(all_agents,at_a_2)).
initially(c(all_agents,at_b_2)).
initially(c(all_agents,at_c_2)).
initially(c(all_agents,neg(at_a_1))).
initially(c(all_agents,neg(at_b_1))).
initially(c(all_agents,neg(at_c_1))).
initially(c(all_agents,neg(at_a_3))).
initially(c(all_agents,neg(at_b_3))).
initially(c(all_agents,neg(at_c_3))).
initially(c(all_agents,or(and(at_b1_1,neg(at_b1_3)),and(neg(at_b1_1),at_b1_3)))).
initially(c(all_agents,or(and(at_b2_1,neg(at_b2_3)),and(neg(at_b2_1),at_b2_3)))).




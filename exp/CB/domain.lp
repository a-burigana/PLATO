% *** ATOMS ***
atom(looking_a).
atom(looking_b).
atom(looking_c).
atom(opened).
atom(tail).

% *** AGENTS ***
agent(a).
agent(b).
agent(c).

agent_set(all_agents).
contains_ag(all_agents,a).
contains_ag(all_agents,b).
contains_ag(all_agents,c).


% *** OBSERVABILITY GROUPS %%%
obs_group(f_obs).
obs_group(p_obs).
obs_group(obl  ).


% *** ACTIONS ***
action(distract_a_b).
ontic(distract_a_b).

causes(distract_a_b, neg(looking_b), true).
action_pre(distract_a_b, and(and(neg(dia(a,neg(looking_a))),neg(dia(a,neg(looking_b)))),and(looking_a,looking_b))).

obs_cond(distract_a_b, a, f_obs, true).
obs_cond(distract_a_b, b, f_obs, true).
obs_cond(distract_a_b, c, obl,   true).


action(distract_a_c).
ontic(distract_a_c).

causes(distract_a_c, neg(looking_c), true).
action_pre(distract_a_c, and(and(neg(dia(a,neg(looking_a))),neg(dia(a,neg(looking_c)))),and(looking_a,looking_c))).

obs_cond(distract_a_c, a, f_obs, true).
obs_cond(distract_a_c, c, f_obs, true).
obs_cond(distract_a_c, b, obl,   true).


action(distract_b_a).
ontic(distract_b_a).

causes(distract_b_a, neg(looking_a), true).
action_pre(distract_b_a, and(and(neg(dia(b,neg(looking_b))),neg(dia(b,neg(looking_a)))),and(looking_a,looking_b))).

obs_cond(distract_b_a, a, f_obs, true).
obs_cond(distract_b_a, b, f_obs, true).
obs_cond(distract_b_a, c, obl,   true).


action(distract_b_c).
ontic(distract_b_c).

causes(distract_b_c, neg(looking_c), true).
action_pre(distract_b_c, and(and(neg(dia(b,neg(looking_b))),neg(dia(b,neg(looking_c)))),and(looking_b,looking_c))).

obs_cond(distract_b_c, b, f_obs, true).
obs_cond(distract_b_c, c, f_obs, true).
obs_cond(distract_b_c, a, obl,   true).


action(distract_c_a).
ontic(distract_c_a).

causes(distract_c_a, neg(looking_a), true).
action_pre(distract_c_a, and(and(neg(dia(c,neg(looking_c))),neg(dia(c,neg(looking_a)))),and(looking_a,looking_c))).

obs_cond(distract_c_a, a, f_obs, true).
obs_cond(distract_c_a, c, f_obs, true).
obs_cond(distract_c_a, b, obl,   true).


action(distract_c_b).
ontic(distract_c_b).

causes(distract_c_b, neg(looking_b), true).
action_pre(distract_c_b, and(and(neg(dia(c,neg(looking_c))),neg(dia(c,neg(looking_b)))),and(looking_b,looking_c))).

obs_cond(distract_c_b, b, f_obs, true).
obs_cond(distract_c_b, c, f_obs, true).
obs_cond(distract_c_b, a, obl,   true).


action(open_a).
ontic(open_a).

causes(open_a, opened, true).
action_pre(open_a, and(looking_a, neg(opened))).

obs_cond(open_a, a, f_obs, true).
obs_cond(open_a, b, f_obs, looking_b).
obs_cond(open_a, c, f_obs, looking_c).
obs_cond(open_a, b, obl,   neg(looking_b)).
obs_cond(open_a, c, obl,   neg(looking_c)).


action(open_b).
ontic(open_b).

causes(open_b, opened, true).
action_pre(open_b, and(looking_b, neg(opened))).

obs_cond(open_b, b, f_obs, true).
obs_cond(open_b, a, f_obs, looking_a).
obs_cond(open_b, c, f_obs, looking_c).
obs_cond(open_b, a, obl,   neg(looking_a)).
obs_cond(open_b, c, obl,   neg(looking_c)).


action(open_c).
ontic(open_c).

causes(open_c, opened, true).
action_pre(open_c, and(looking_c, neg(opened))).

obs_cond(open_c, c, f_obs, true).
obs_cond(open_c, a, f_obs, looking_a).
obs_cond(open_c, b, f_obs, looking_b).
obs_cond(open_c, a, obl,   neg(looking_a)).
obs_cond(open_c, b, obl,   neg(looking_b)).


action(peek_a).
sensing(peek_a).

determines(peek_a, tail).
action_pre(peek_a, and(and(neg(dia(a,neg(opened))),neg(dia(a,neg(looking_a)))),and(looking_a,opened))).

obs_cond(peek_a, a, f_obs, true).
obs_cond(peek_a, b, p_obs, looking_b).
obs_cond(peek_a, c, p_obs, looking_c).
obs_cond(peek_a, b, obl,   neg(looking_b)).
obs_cond(peek_a, c, obl,   neg(looking_c)).


action(peek_b).
sensing(peek_b).

determines(peek_b, tail).
action_pre(peek_b, and(and(neg(dia(b,neg(opened))),neg(dia(b,neg(looking_b)))),and(looking_b,opened))).

obs_cond(peek_b, b, f_obs, true).
obs_cond(peek_b, a, p_obs, looking_a).
obs_cond(peek_b, c, p_obs, looking_c).
obs_cond(peek_b, a, obl,   neg(looking_a)).
obs_cond(peek_b, c, obl,   neg(looking_c)).


action(peek_c).
sensing(peek_c).

determines(peek_c, tail).
action_pre(peek_c, and(and(neg(dia(c,neg(opened))),neg(dia(c,neg(looking_c)))),and(looking_c,opened))).

obs_cond(peek_c, c, f_obs, true).
obs_cond(peek_c, a, p_obs, looking_a).
obs_cond(peek_c, b, p_obs, looking_b).
obs_cond(peek_c, a, obl,   neg(looking_a)).
obs_cond(peek_c, b, obl,   neg(looking_b)).


action(shout_tail_a).
announcement(shout_tail_a).

announces(shout_tail_a, tail).
action_pre(shout_tail_a, and(neg(dia(a,neg(tail))),tail)).

obs_cond(shout_tail_a, a, f_obs, true).
obs_cond(shout_tail_a, b, f_obs, looking_b).
obs_cond(shout_tail_a, c, f_obs, looking_c).
obs_cond(shout_tail_a, b, obl,   neg(looking_b)).
obs_cond(shout_tail_a, c, obl,   neg(looking_c)).


action(shout_tail_b).
announcement(shout_tail_b).

announces(shout_tail_b, tail).
action_pre(shout_tail_b, and(neg(dia(b,neg(tail))),tail)).

obs_cond(shout_tail_b, b, f_obs, true).
obs_cond(shout_tail_b, a, f_obs, looking_a).
obs_cond(shout_tail_b, c, f_obs, looking_c).
obs_cond(shout_tail_b, a, obl,   neg(looking_a)).
obs_cond(shout_tail_b, c, obl,   neg(looking_c)).


action(shout_tail_c).
announcement(shout_tail_c).

announces(shout_tail_c, tail).
action_pre(shout_tail_c, and(neg(dia(c,neg(tail))),tail)).

obs_cond(shout_tail_c, c, f_obs, true).
obs_cond(shout_tail_c, a, f_obs, looking_a).
obs_cond(shout_tail_c, b, f_obs, looking_b).
obs_cond(shout_tail_c, a, obl,   neg(looking_a)).
obs_cond(shout_tail_c, b, obl,   neg(looking_b)).


action(signal_a_b).
ontic(signal_a_b).

causes(signal_a_b, looking_b, true).
action_pre(signal_a_b, and(and(neg(dia(a,neg(looking_a))),neg(dia(a,looking_b))),and(looking_a,neg(looking_b)))).

obs_cond(signal_a_b, a, f_obs, true).
obs_cond(signal_a_b, b, f_obs, true).
obs_cond(signal_a_b, c, obl,   true).


action(signal_a_c).
ontic(signal_a_c).

causes(signal_a_c, looking_c, true).
action_pre(signal_a_c, and(and(neg(dia(a,neg(looking_a))),neg(dia(a,looking_c))),and(looking_a,neg(looking_c)))).

obs_cond(signal_a_c, a, f_obs, true).
obs_cond(signal_a_c, c, f_obs, true).
obs_cond(signal_a_c, b, obl,   true).


action(signal_b_a).
ontic(signal_b_a).

causes(signal_b_a, looking_a, true).
action_pre(signal_b_a, and(and(neg(dia(b,neg(looking_b))),neg(dia(b,looking_a))),and(neg(looking_a),looking_b))).

obs_cond(signal_b_a, a, f_obs, true).
obs_cond(signal_b_a, b, f_obs, true).
obs_cond(signal_b_a, c, obl,   true).


action(signal_b_c).
ontic(signal_b_c).

causes(signal_b_c, looking_c, true).
action_pre(signal_b_c, and(and(neg(dia(b,neg(looking_b))),neg(dia(b,looking_c))),and(looking_b,neg(looking_c)))).

obs_cond(signal_b_c, b, f_obs, true).
obs_cond(signal_b_c, c, f_obs, true).
obs_cond(signal_b_c, a, obl,   true).


action(signal_c_a).
ontic(signal_c_a).

causes(signal_c_a, looking_a, true).
action_pre(signal_c_a, and(and(neg(dia(c,neg(looking_c))),neg(dia(c,looking_a))),and(neg(looking_a),looking_c))).

obs_cond(signal_c_a, a, f_obs, true).
obs_cond(signal_c_a, c, f_obs, true).
obs_cond(signal_c_a, b, obl,   true).


action(signal_c_b).
ontic(signal_c_b).

causes(signal_c_b, looking_b, true).
action_pre(signal_c_b, and(and(neg(dia(c,neg(looking_c))),neg(dia(c,looking_b))),and(neg(looking_b),looking_c))).

obs_cond(signal_c_b, b, f_obs, true).
obs_cond(signal_c_b, c, f_obs, true).
obs_cond(signal_c_b, a, obl,   true).




% *** INITIAL STATE ***

w_init(w1). w_init(w2).

r_init(W1, W2, AG) :- w_init(W1), w_init(W2), agent(AG).

v_init(w1, looking_a).
v_init(w1, tail).
v_init(w2, looking_a).

dw_init(w1).

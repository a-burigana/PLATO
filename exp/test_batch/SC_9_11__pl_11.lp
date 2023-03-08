#const maxT  = 11.
#const n_fl  = 12.
#const n_ag  = 9.
#const n_ags = 511.

%time(0..maxT).

% *** ATOMS ***
atom(at_1).
atom(at_10).
atom(at_11).
atom(at_2).
atom(at_3).
atom(at_4).
atom(at_5).
atom(at_6).
atom(at_7).
atom(at_8).
atom(at_9).
atom(q).


% *** AGENTS ***
agent(a).
agent(b).
agent(c).
agent(d).
agent(e).
agent(f).
agent(g).
agent(h).
agent(j).


% *** ACTIONS ***
action(left).
action_type(left, ontic).
causes(left, at_1, at_2).
causes(left, at_10, at_11).
causes(left, neg(at_10), at_10).
causes(left, neg(at_11), at_11).
causes(left, at_2, at_3).
causes(left, neg(at_2), at_2).
causes(left, at_3, at_4).
causes(left, neg(at_3), at_3).
causes(left, at_4, at_5).
causes(left, neg(at_4), at_4).
causes(left, at_5, at_6).
causes(left, neg(at_5), at_5).
causes(left, at_6, at_7).
causes(left, neg(at_6), at_6).
causes(left, at_7, at_8).
causes(left, neg(at_7), at_7).
causes(left, at_8, at_9).
causes(left, neg(at_8), at_8).
causes(left, at_9, at_10).
causes(left, neg(at_9), at_9).
action_pre(left, neg(at_1)).
observes(left, a, true).
observes(left, b, true).
observes(left, c, true).
observes(left, d, true).
observes(left, e, true).
observes(left, f, true).
observes(left, g, true).
observes(left, h, true).
observes(left, j, true).


action(right).
action_type(right, ontic).
causes(right, neg(at_1), at_1).
causes(right, at_10, at_9).
causes(right, neg(at_10), at_10).
causes(right, at_11, at_10).
causes(right, at_2, at_1).
causes(right, neg(at_2), at_2).
causes(right, at_3, at_2).
causes(right, neg(at_3), at_3).
causes(right, at_4, at_3).
causes(right, neg(at_4), at_4).
causes(right, at_5, at_4).
causes(right, neg(at_5), at_5).
causes(right, at_6, at_5).
causes(right, neg(at_6), at_6).
causes(right, at_7, at_6).
causes(right, neg(at_7), at_7).
causes(right, at_8, at_7).
causes(right, neg(at_8), at_8).
causes(right, at_9, at_8).
causes(right, neg(at_9), at_9).
action_pre(right, neg(at_11)).
observes(right, a, true).
observes(right, b, true).
observes(right, c, true).
observes(right, d, true).
observes(right, e, true).
observes(right, f, true).
observes(right, g, true).
observes(right, h, true).
observes(right, j, true).


action(sense).
action_type(sense, sensing).
determines(sense, q).
action_pre(sense, at_10).
observes(sense, a, true).
oblivious(sense, b).
oblivious(sense, c).
oblivious(sense, d).
oblivious(sense, e).
oblivious(sense, f).
oblivious(sense, g).
oblivious(sense, h).
oblivious(sense, j).


action(shout_1).
action_type(shout_1, announcement).
announces(shout_1, q).
action_pre(shout_1, and(box(a,q),at_1)).
observes(shout_1, a, true).
observes(shout_1, b, true).
oblivious(shout_1, c).
oblivious(shout_1, d).
oblivious(shout_1, e).
oblivious(shout_1, f).
oblivious(shout_1, g).
oblivious(shout_1, h).
oblivious(shout_1, j).


action(shout_10).
action_type(shout_10, announcement).
announces(shout_10, q).
action_pre(shout_10, and(box(a,q),at_10)).
oblivious(shout_10, a).
oblivious(shout_10, b).
oblivious(shout_10, c).
oblivious(shout_10, d).
oblivious(shout_10, e).
oblivious(shout_10, f).
oblivious(shout_10, g).
oblivious(shout_10, h).
oblivious(shout_10, j).


action(shout_11).
action_type(shout_11, announcement).
announces(shout_11, q).
action_pre(shout_11, and(box(a,q),at_11)).
oblivious(shout_11, a).
oblivious(shout_11, b).
oblivious(shout_11, c).
oblivious(shout_11, d).
oblivious(shout_11, e).
oblivious(shout_11, f).
oblivious(shout_11, g).
oblivious(shout_11, h).
oblivious(shout_11, j).


action(shout_2).
action_type(shout_2, announcement).
announces(shout_2, q).
action_pre(shout_2, and(box(a,q),at_2)).
observes(shout_2, a, true).
observes(shout_2, b, true).
observes(shout_2, c, true).
oblivious(shout_2, d).
oblivious(shout_2, e).
oblivious(shout_2, f).
oblivious(shout_2, g).
oblivious(shout_2, h).
oblivious(shout_2, j).


action(shout_3).
action_type(shout_3, announcement).
announces(shout_3, q).
action_pre(shout_3, and(box(a,q),at_3)).
observes(shout_3, b, true).
observes(shout_3, c, true).
observes(shout_3, d, true).
oblivious(shout_3, a).
oblivious(shout_3, e).
oblivious(shout_3, f).
oblivious(shout_3, g).
oblivious(shout_3, h).
oblivious(shout_3, j).


action(shout_4).
action_type(shout_4, announcement).
announces(shout_4, q).
action_pre(shout_4, and(box(a,q),at_4)).
observes(shout_4, c, true).
observes(shout_4, d, true).
observes(shout_4, e, true).
oblivious(shout_4, a).
oblivious(shout_4, b).
oblivious(shout_4, f).
oblivious(shout_4, g).
oblivious(shout_4, h).
oblivious(shout_4, j).


action(shout_5).
action_type(shout_5, announcement).
announces(shout_5, q).
action_pre(shout_5, and(box(a,q),at_5)).
observes(shout_5, d, true).
observes(shout_5, e, true).
observes(shout_5, f, true).
oblivious(shout_5, a).
oblivious(shout_5, b).
oblivious(shout_5, c).
oblivious(shout_5, g).
oblivious(shout_5, h).
oblivious(shout_5, j).


action(shout_6).
action_type(shout_6, announcement).
announces(shout_6, q).
action_pre(shout_6, and(box(a,q),at_6)).
observes(shout_6, e, true).
observes(shout_6, f, true).
observes(shout_6, g, true).
oblivious(shout_6, a).
oblivious(shout_6, b).
oblivious(shout_6, c).
oblivious(shout_6, d).
oblivious(shout_6, h).
oblivious(shout_6, j).


action(shout_7).
action_type(shout_7, announcement).
announces(shout_7, q).
action_pre(shout_7, and(box(a,q),at_7)).
observes(shout_7, f, true).
observes(shout_7, g, true).
observes(shout_7, h, true).
oblivious(shout_7, a).
oblivious(shout_7, b).
oblivious(shout_7, c).
oblivious(shout_7, d).
oblivious(shout_7, e).
oblivious(shout_7, j).


action(shout_8).
action_type(shout_8, announcement).
announces(shout_8, q).
action_pre(shout_8, and(box(a,q),at_8)).
observes(shout_8, g, true).
observes(shout_8, h, true).
observes(shout_8, j, true).
oblivious(shout_8, a).
oblivious(shout_8, b).
oblivious(shout_8, c).
oblivious(shout_8, d).
oblivious(shout_8, e).
oblivious(shout_8, f).


action(shout_9).
action_type(shout_9, announcement).
announces(shout_9, q).
action_pre(shout_9, and(box(a,q),at_9)).
observes(shout_9, h, true).
observes(shout_9, j, true).
oblivious(shout_9, a).
oblivious(shout_9, b).
oblivious(shout_9, c).
oblivious(shout_9, d).
oblivious(shout_9, e).
oblivious(shout_9, f).
oblivious(shout_9, g).




% *** INITIALLY ***

% ** initial pointed **
initially(neg(at_1)).
initially(neg(at_10)).
initially(at_11).
initially(neg(at_2)).
initially(neg(at_3)).
initially(neg(at_4)).
initially(neg(at_5)).
initially(neg(at_6)).
initially(neg(at_7)).
initially(neg(at_8)).
initially(neg(at_9)).
initially(q).

% ** initial beliefs **
agent_set(all_agents).
contains_ag(all_agents,a).
contains_ag(all_agents,b).
contains_ag(all_agents,c).
contains_ag(all_agents,d).
contains_ag(all_agents,e).
contains_ag(all_agents,f).
contains_ag(all_agents,g).
contains_ag(all_agents,h).
contains_ag(all_agents,j).
initially(c(all_agents,neg(at_1))).
initially(c(all_agents,neg(at_2))).
initially(c(all_agents,neg(at_3))).
initially(c(all_agents,neg(at_4))).
initially(c(all_agents,neg(at_5))).
initially(c(all_agents,neg(at_6))).
initially(c(all_agents,neg(at_7))).
initially(c(all_agents,neg(at_8))).
initially(c(all_agents,neg(at_9))).
initially(c(all_agents,neg(at_10))).
initially(c(all_agents,at_11)).





% *** GOALS ***
goal(box(a,q)).
goal(box(h,q)).
goal(box(j,q)).
goal(box(g,q)).
goal(box(d,q)).
goal(box(e,q)).
goal(box(f,q)).
goal(box(c,q)).



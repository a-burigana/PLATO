% *** ATOMS ***
atom(at_1).
atom(at_10).
atom(at_2).
atom(at_3).
atom(at_4).
atom(at_5).
atom(at_6).
atom(at_7).
atom(at_8).
atom(at_9).
atom(q).

% formula(at_1).
% formula(at_10).
% formula(at_2).
% formula(at_3).
% formula(at_4).
% formula(at_5).
% formula(at_6).
% formula(at_7).
% formula(at_8).
% formula(at_9).
% formula(q).


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
ontic(left).
% formula(-at_10).
% formula(-at_2).
% formula(-at_3).
% formula(-at_4).
% formula(-at_5).
% formula(-at_6).
% formula(-at_7).
% formula(-at_8).
% formula(-at_9).
% formula(-at_1).

idle_atom(left, q).

#program step(t).

applicable(t, left) :- dw(t, W, Ew, Hw), not holds(t, W, Ew, Hw, at_1).

causes(t, Tw, W, Ew, Hw, left,  at_1 ) :- w(Tw, W, Ew, Hw), same_path(t, Tw, W, Ew, Hw, _, _), holds(Tw, W, Ew, Hw, at_2).
causes(t, Tw, W, Ew, Hw, left, -at_10) :- w(Tw, W, Ew, Hw), same_path(t, Tw, W, Ew, Hw, _, _), holds(Tw, W, Ew, Hw, at_10).
causes(t, Tw, W, Ew, Hw, left,  at_2 ) :- w(Tw, W, Ew, Hw), same_path(t, Tw, W, Ew, Hw, _, _), holds(Tw, W, Ew, Hw, at_3).
causes(t, Tw, W, Ew, Hw, left, -at_2 ) :- w(Tw, W, Ew, Hw), same_path(t, Tw, W, Ew, Hw, _, _), holds(Tw, W, Ew, Hw, at_2).
causes(t, Tw, W, Ew, Hw, left,  at_3 ) :- w(Tw, W, Ew, Hw), same_path(t, Tw, W, Ew, Hw, _, _), holds(Tw, W, Ew, Hw, at_4).
causes(t, Tw, W, Ew, Hw, left, -at_3 ) :- w(Tw, W, Ew, Hw), same_path(t, Tw, W, Ew, Hw, _, _), holds(Tw, W, Ew, Hw, at_3).
causes(t, Tw, W, Ew, Hw, left,  at_4 ) :- w(Tw, W, Ew, Hw), same_path(t, Tw, W, Ew, Hw, _, _), holds(Tw, W, Ew, Hw, at_5).
causes(t, Tw, W, Ew, Hw, left, -at_4 ) :- w(Tw, W, Ew, Hw), same_path(t, Tw, W, Ew, Hw, _, _), holds(Tw, W, Ew, Hw, at_4).
causes(t, Tw, W, Ew, Hw, left,  at_5 ) :- w(Tw, W, Ew, Hw), same_path(t, Tw, W, Ew, Hw, _, _), holds(Tw, W, Ew, Hw, at_6).
causes(t, Tw, W, Ew, Hw, left, -at_5 ) :- w(Tw, W, Ew, Hw), same_path(t, Tw, W, Ew, Hw, _, _), holds(Tw, W, Ew, Hw, at_5).
causes(t, Tw, W, Ew, Hw, left,  at_6 ) :- w(Tw, W, Ew, Hw), same_path(t, Tw, W, Ew, Hw, _, _), holds(Tw, W, Ew, Hw, at_7).
causes(t, Tw, W, Ew, Hw, left, -at_6 ) :- w(Tw, W, Ew, Hw), same_path(t, Tw, W, Ew, Hw, _, _), holds(Tw, W, Ew, Hw, at_6).
causes(t, Tw, W, Ew, Hw, left,  at_7 ) :- w(Tw, W, Ew, Hw), same_path(t, Tw, W, Ew, Hw, _, _), holds(Tw, W, Ew, Hw, at_8).
causes(t, Tw, W, Ew, Hw, left, -at_7 ) :- w(Tw, W, Ew, Hw), same_path(t, Tw, W, Ew, Hw, _, _), holds(Tw, W, Ew, Hw, at_7).
causes(t, Tw, W, Ew, Hw, left,  at_8 ) :- w(Tw, W, Ew, Hw), same_path(t, Tw, W, Ew, Hw, _, _), holds(Tw, W, Ew, Hw, at_9).
causes(t, Tw, W, Ew, Hw, left, -at_8 ) :- w(Tw, W, Ew, Hw), same_path(t, Tw, W, Ew, Hw, _, _), holds(Tw, W, Ew, Hw, at_8).
causes(t, Tw, W, Ew, Hw, left,  at_9 ) :- w(Tw, W, Ew, Hw), same_path(t, Tw, W, Ew, Hw, _, _), holds(Tw, W, Ew, Hw, at_10).
causes(t, Tw, W, Ew, Hw, left, -at_9 ) :- w(Tw, W, Ew, Hw), same_path(t, Tw, W, Ew, Hw, _, _), holds(Tw, W, Ew, Hw, at_9).

observes(t, left, a).
observes(t, left, b).
observes(t, left, c).
observes(t, left, d).
observes(t, left, e).
observes(t, left, f).
observes(t, left, g).
observes(t, left, h).
observes(t, left, j).

#program base.

action(right).
ontic(right).

idle_atom(right, q).

#program step(t).

applicable(t, right) :- dw(t, W, Ew, Hw), not holds(t, W, Ew, Hw, at_10).

causes(t, Tw, W, Ew, Hw, right, -at_1 ) :- w(Tw, W, Ew, Hw), same_path(t, Tw, W, Ew, Hw, _, _), holds(Tw, W, Ew, Hw, at_1).
causes(t, Tw, W, Ew, Hw, right,  at_10) :- w(Tw, W, Ew, Hw), same_path(t, Tw, W, Ew, Hw, _, _), holds(Tw, W, Ew, Hw, at_9).
causes(t, Tw, W, Ew, Hw, right,  at_2 ) :- w(Tw, W, Ew, Hw), same_path(t, Tw, W, Ew, Hw, _, _), holds(Tw, W, Ew, Hw, at_1).
causes(t, Tw, W, Ew, Hw, right, -at_2 ) :- w(Tw, W, Ew, Hw), same_path(t, Tw, W, Ew, Hw, _, _), holds(Tw, W, Ew, Hw, at_2).
causes(t, Tw, W, Ew, Hw, right,  at_3 ) :- w(Tw, W, Ew, Hw), same_path(t, Tw, W, Ew, Hw, _, _), holds(Tw, W, Ew, Hw, at_2).
causes(t, Tw, W, Ew, Hw, right, -at_3 ) :- w(Tw, W, Ew, Hw), same_path(t, Tw, W, Ew, Hw, _, _), holds(Tw, W, Ew, Hw, at_3).
causes(t, Tw, W, Ew, Hw, right,  at_4 ) :- w(Tw, W, Ew, Hw), same_path(t, Tw, W, Ew, Hw, _, _), holds(Tw, W, Ew, Hw, at_3).
causes(t, Tw, W, Ew, Hw, right, -at_4 ) :- w(Tw, W, Ew, Hw), same_path(t, Tw, W, Ew, Hw, _, _), holds(Tw, W, Ew, Hw, at_4).
causes(t, Tw, W, Ew, Hw, right,  at_5 ) :- w(Tw, W, Ew, Hw), same_path(t, Tw, W, Ew, Hw, _, _), holds(Tw, W, Ew, Hw, at_4).
causes(t, Tw, W, Ew, Hw, right, -at_5 ) :- w(Tw, W, Ew, Hw), same_path(t, Tw, W, Ew, Hw, _, _), holds(Tw, W, Ew, Hw, at_5).
causes(t, Tw, W, Ew, Hw, right,  at_6 ) :- w(Tw, W, Ew, Hw), same_path(t, Tw, W, Ew, Hw, _, _), holds(Tw, W, Ew, Hw, at_5).
causes(t, Tw, W, Ew, Hw, right, -at_6 ) :- w(Tw, W, Ew, Hw), same_path(t, Tw, W, Ew, Hw, _, _), holds(Tw, W, Ew, Hw, at_6).
causes(t, Tw, W, Ew, Hw, right,  at_7 ) :- w(Tw, W, Ew, Hw), same_path(t, Tw, W, Ew, Hw, _, _), holds(Tw, W, Ew, Hw, at_6).
causes(t, Tw, W, Ew, Hw, right, -at_7 ) :- w(Tw, W, Ew, Hw), same_path(t, Tw, W, Ew, Hw, _, _), holds(Tw, W, Ew, Hw, at_7).
causes(t, Tw, W, Ew, Hw, right,  at_8 ) :- w(Tw, W, Ew, Hw), same_path(t, Tw, W, Ew, Hw, _, _), holds(Tw, W, Ew, Hw, at_7).
causes(t, Tw, W, Ew, Hw, right, -at_8 ) :- w(Tw, W, Ew, Hw), same_path(t, Tw, W, Ew, Hw, _, _), holds(Tw, W, Ew, Hw, at_8).
causes(t, Tw, W, Ew, Hw, right,  at_9 ) :- w(Tw, W, Ew, Hw), same_path(t, Tw, W, Ew, Hw, _, _), holds(Tw, W, Ew, Hw, at_8).
causes(t, Tw, W, Ew, Hw, right, -at_9 ) :- w(Tw, W, Ew, Hw), same_path(t, Tw, W, Ew, Hw, _, _), holds(Tw, W, Ew, Hw, at_9).

observes(t, right, a).
observes(t, right, b).
observes(t, right, c).
observes(t, right, d).
observes(t, right, e).
observes(t, right, f).
observes(t, right, g).
observes(t, right, h).
observes(t, right, j).

#program base.

action(sense).
sensing(sense).

#program step(t).

applicable(t, sense) :- dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, at_10).

determines(sense, q).

observes(t, sense, a).
oblivious(t, sense, b).
oblivious(t, sense, c).
oblivious(t, sense, d).
oblivious(t, sense, e).
oblivious(t, sense, f).
oblivious(t, sense, g).
oblivious(t, sense, h).
oblivious(t, sense, j).

#program base.

action(shout_1).
announcement(shout_1).
% formula(b(a,q)).
% formula(and(b(a,q),at_1)).

#program step(t).

applicable(t, shout_1) :- dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, at_1), not -applicable(t, shout_1).

-applicable(t, shout_1) :- dw(t, W, Ew, Hw), w(Tv, V, Ev, Hv), r(t, W, Ew, Hw, Tv, V, Ev, Hv, a), not holds(Tv, V, Ev, Hv, q).

announces(shout_1, q).

observes(t, shout_1, a).
observes(t, shout_1, b).
observes(t, shout_1, c).
observes(t, shout_1, d).
observes(t, shout_1, e).
observes(t, shout_1, f).
observes(t, shout_1, g).
observes(t, shout_1, h).
oblivious(t, shout_1, j).

#program base.

action(shout_10).
announcement(shout_10).
% formula(and(b(a,q),at_10)).

#program step(t).

applicable(t, shout_10) :- dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, at_10), not -applicable(t, shout_10).

-applicable(t, shout_10) :- dw(t, W, Ew, Hw), w(Tv, V, Ev, Hv), r(t, W, Ew, Hw, Tv, V, Ev, Hv, a), not holds(Tv, V, Ev, Hv, q).

announces(shout_10, q).

observes(t, shout_10, a).
observes(t, shout_10, e).
observes(t, shout_10, h).
oblivious(t, shout_10, b).
oblivious(t, shout_10, c).
oblivious(t, shout_10, d).
oblivious(t, shout_10, f).
oblivious(t, shout_10, g).
oblivious(t, shout_10, j).

#program base.

action(shout_2).
announcement(shout_2).
% formula(and(b(a,q),at_2)).


#program step(t).

applicable(t, shout_2) :- dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, at_2), not -applicable(t, shout_2).

-applicable(t, shout_2) :- dw(t, W, Ew, Hw), w(Tv, V, Ev, Hv), r(t, W, Ew, Hw, Tv, V, Ev, Hv, a), not holds(Tv, V, Ev, Hv, q).

announces(shout_2, q).

observes(t, shout_2, a).
observes(t, shout_2, b).
observes(t, shout_2, c).
oblivious(t, shout_2, d).
oblivious(t, shout_2, e).
oblivious(t, shout_2, f).
oblivious(t, shout_2, g).
oblivious(t, shout_2, h).
oblivious(t, shout_2, j).

#program base.

action(shout_3).
announcement(shout_3).
% formula(and(b(a,q),at_3)).

#program step(t).

applicable(t, shout_3) :- dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, at_3), not -applicable(t, shout_3).

-applicable(t, shout_3) :- dw(t, W, Ew, Hw), w(Tv, V, Ev, Hv), r(t, W, Ew, Hw, Tv, V, Ev, Hv, a), not holds(Tv, V, Ev, Hv, q).

announces(shout_3, q).

observes(t, shout_3, a).
observes(t, shout_3, c).
observes(t, shout_3, d).
oblivious(t, shout_3, b).
oblivious(t, shout_3, e).
oblivious(t, shout_3, f).
oblivious(t, shout_3, g).
oblivious(t, shout_3, h).
oblivious(t, shout_3, j).

#program base.

action(shout_4).
announcement(shout_4).
% formula(and(b(a,q),at_4)).

#program step(t).

applicable(t, shout_4) :- dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, at_4), not -applicable(t, shout_4).

-applicable(t, shout_4) :- dw(t, W, Ew, Hw), w(Tv, V, Ev, Hv), r(t, W, Ew, Hw, Tv, V, Ev, Hv, a), not holds(Tv, V, Ev, Hv, q).

announces(shout_4, q).

observes(t, shout_4, a).
observes(t, shout_4, d).
observes(t, shout_4, e).
oblivious(t, shout_4, b).
oblivious(t, shout_4, c).
oblivious(t, shout_4, f).
oblivious(t, shout_4, g).
oblivious(t, shout_4, h).
oblivious(t, shout_4, j).

#program base.

action(shout_5).
announcement(shout_5).
% formula(and(b(a,q),at_5)).

#program step(t).

applicable(t, shout_5) :- dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, at_5), not -applicable(t, shout_5).

-applicable(t, shout_5) :- dw(t, W, Ew, Hw), w(Tv, V, Ev, Hv), r(t, W, Ew, Hw, Tv, V, Ev, Hv, a), not holds(Tv, V, Ev, Hv, q).

announces(shout_5, q).

observes(t, shout_5, e).
observes(t, shout_5, a).
observes(t, shout_5, f).
oblivious(t, shout_5, b).
oblivious(t, shout_5, c).
oblivious(t, shout_5, d).
oblivious(t, shout_5, g).
oblivious(t, shout_5, h).
oblivious(t, shout_5, j).

#program base.

action(shout_6).
announcement(shout_6).
% formula(and(b(a,q),at_6)).

#program step(t).

applicable(t, shout_6) :- dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, at_6), not -applicable(t, shout_6).

-applicable(t, shout_6) :- dw(t, W, Ew, Hw), w(Tv, V, Ev, Hv), r(t, W, Ew, Hw, Tv, V, Ev, Hv, a), not holds(Tv, V, Ev, Hv, q).

announces(shout_6, q).

observes(t, shout_6, a).
observes(t, shout_6, f).
observes(t, shout_6, g).
oblivious(t, shout_6, b).
oblivious(t, shout_6, c).
oblivious(t, shout_6, d).
oblivious(t, shout_6, e).
oblivious(t, shout_6, h).
oblivious(t, shout_6, j).

#program base.

action(shout_7).
announcement(shout_7).
% formula(and(b(a,q),at_7)).

#program step(t).

applicable(t, shout_7) :- dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, at_7), not -applicable(t, shout_7).

-applicable(t, shout_7) :- dw(t, W, Ew, Hw), w(Tv, V, Ev, Hv), r(t, W, Ew, Hw, Tv, V, Ev, Hv, a), not holds(Tv, V, Ev, Hv, q).

announces(shout_7, q).

observes(t, shout_7, a).
observes(t, shout_7, g).
observes(t, shout_7, h).
oblivious(t, shout_7, b).
oblivious(t, shout_7, c).
oblivious(t, shout_7, d).
oblivious(t, shout_7, e).
oblivious(t, shout_7, f).
oblivious(t, shout_7, j).

#program base.

action(shout_8).
announcement(shout_8).
% formula(and(b(a,q),at_8)).

#program step(t).

applicable(t, shout_8) :- dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, at_8), not -applicable(t, shout_8).

-applicable(t, shout_8) :- dw(t, W, Ew, Hw), w(Tv, V, Ev, Hv), r(t, W, Ew, Hw, Tv, V, Ev, Hv, a), not holds(Tv, V, Ev, Hv, q).

announces(shout_8, q).

observes(t, shout_8, a).
observes(t, shout_8, d).
observes(t, shout_8, g).
oblivious(t, shout_8, b).
oblivious(t, shout_8, c).
oblivious(t, shout_8, e).
oblivious(t, shout_8, f).
oblivious(t, shout_8, h).
oblivious(t, shout_8, j).

#program base.

action(shout_9).
announcement(shout_9).
% formula(and(b(a,q),at_9)).

#program step(t).

applicable(t, shout_9) :- dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, at_9), not -applicable(t, shout_9).

-applicable(t, shout_9) :- dw(t, W, Ew, Hw), w(Tv, V, Ev, Hv), r(t, W, Ew, Hw, Tv, V, Ev, Hv, a), not holds(Tv, V, Ev, Hv, q).

announces(shout_9, q).

observes(t, shout_9, a).
observes(t, shout_9, c).
observes(t, shout_9, f).
oblivious(t, shout_9, b).
oblivious(t, shout_9, d).
oblivious(t, shout_9, e).
oblivious(t, shout_9, g).
oblivious(t, shout_9, h).
oblivious(t, shout_9, j).

#program base.



% *** INITIALLY ***

% ** initial pointed **
initially(-at_1).
initially(at_10).
initially(-at_2).
initially(-at_3).
initially(-at_4).
initially(-at_5).
initially(-at_6).
initially(-at_7).
initially(-at_8).
initially(-at_9).
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
formula(c(all_agents,-at_1)).
initially(c(all_agents,-at_1)).
formula(c(all_agents,-at_2)).
initially(c(all_agents,-at_2)).
formula(c(all_agents,-at_3)).
initially(c(all_agents,-at_3)).
formula(c(all_agents,-at_4)).
initially(c(all_agents,-at_4)).
formula(c(all_agents,-at_5)).
initially(c(all_agents,-at_5)).
formula(c(all_agents,-at_6)).
initially(c(all_agents,-at_6)).
formula(c(all_agents,-at_7)).
initially(c(all_agents,-at_7)).
formula(c(all_agents,-at_8)).
initially(c(all_agents,-at_8)).
formula(c(all_agents,-at_9)).
initially(c(all_agents,-at_9)).
formula(c(all_agents,at_10)).
initially(c(all_agents,at_10)).



% ** commonly known fluent formulae **
init_sf(-at_1).
init_sf(-at_2).
init_sf(-at_3).
init_sf(-at_4).
init_sf(-at_5).
init_sf(-at_6).
init_sf(-at_7).
init_sf(-at_8).
init_sf(-at_9).
init_sf(at_10).

% *** ATOMS ***
atom(at_1).
atom(at_2).
atom(at_3).
atom(at_4).
atom(q).

% formula(at_1).
% formula(at_2).
% formula(at_3).
% formula(at_4).
% formula(q).


% *** AGENTS ***
agent(a).
agent(b).
agent(c).


% *** ACTIONS ***
action(left).
ontic(left).
% formula(-at_2).
% formula(-at_3).
% formula(-at_4).
% formula(-at_1).

idle_atom(left, q).

#program step(t).

applicable(t, left) :- dw(t, W, Ew, Hw), not holds(t, W, Ew, Hw, at_1).

causes(t, Tw, W, Ew, Hw, left,  at_1) :- same_path(t, Tw, W, Ew, Hw, _, _), holds(Tw, W, Ew, Hw, at_2).
causes(t, Tw, W, Ew, Hw, left,  at_2) :- same_path(t, Tw, W, Ew, Hw, _, _), holds(Tw, W, Ew, Hw, at_3).
causes(t, Tw, W, Ew, Hw, left, -at_2) :- same_path(t, Tw, W, Ew, Hw, _, _), holds(Tw, W, Ew, Hw, at_2).
causes(t, Tw, W, Ew, Hw, left,  at_3) :- same_path(t, Tw, W, Ew, Hw, _, _), holds(Tw, W, Ew, Hw, at_4).
causes(t, Tw, W, Ew, Hw, left, -at_3) :- same_path(t, Tw, W, Ew, Hw, _, _), holds(Tw, W, Ew, Hw, at_3).
causes(t, Tw, W, Ew, Hw, left, -at_4) :- same_path(t, Tw, W, Ew, Hw, _, _), holds(Tw, W, Ew, Hw, at_4).

observes(t, left, a).
observes(t, left, b).
observes(t, left, c).

#program base.

action(right).
ontic(right).

idle_atom(right, q).

#program step(t).

applicable(t, right) :- dw(t, W, Ew, Hw), not holds(t, W, Ew, Hw, at_4).

causes(t, Tw, W, Ew, Hw, right, -at_1) :- same_path(t, Tw, W, Ew, Hw, _, _), holds(Tw, W, Ew, Hw, at_1).
causes(t, Tw, W, Ew, Hw, right,  at_2) :- same_path(t, Tw, W, Ew, Hw, _, _), holds(Tw, W, Ew, Hw, at_1).
causes(t, Tw, W, Ew, Hw, right, -at_2) :- same_path(t, Tw, W, Ew, Hw, _, _), holds(Tw, W, Ew, Hw, at_2).
causes(t, Tw, W, Ew, Hw, right,  at_3) :- same_path(t, Tw, W, Ew, Hw, _, _), holds(Tw, W, Ew, Hw, at_2).
causes(t, Tw, W, Ew, Hw, right, -at_3) :- same_path(t, Tw, W, Ew, Hw, _, _), holds(Tw, W, Ew, Hw, at_3).
causes(t, Tw, W, Ew, Hw, right,  at_4) :- same_path(t, Tw, W, Ew, Hw, _, _), holds(Tw, W, Ew, Hw, at_3).

observes(t, right, a).
observes(t, right, b).
observes(t, right, c).

#program base.

action(sense).
sensing(sense).

#program step(t).

applicable(t, sense) :- dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, at_2).

determines(sense, q).

observes(t, sense, a).
oblivious(t, sense, b).
oblivious(t, sense, c).

#program base.

action(shout_1).
announcement(shout_1).
% formula(b(a,q)).
% formula(and(b(a,q),at_1)).

#program step(t).

applicable(t, shout_1) :- dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, at_1), not -applicable(t, shout_1).

-applicable(t, shout_1) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, a), not holds(Tv, V, Ev, Hv, q).

announces(shout_1, q).

observes(t, shout_1, a).
observes(t, shout_1, b).
oblivious(t, shout_1, c).

#program base.

action(shout_2).
announcement(shout_2).
% formula(and(b(a,q),at_2)).

#program step(t).

applicable(t, shout_2) :- dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, at_2), not -applicable(t, shout_2).

-applicable(t, shout_2) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, a), not holds(Tv, V, Ev, Hv, q).

announces(shout_2, q).

observes(t, shout_2, a).
observes(t, shout_2, b).
observes(t, shout_2, c).

#program base.

action(shout_3).
announcement(shout_3).
% formula(and(b(a,q),at_3)).

#program step(t).

applicable(t, shout_3) :- dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, at_3), not -applicable(t, shout_3).

-applicable(t, shout_3) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, a), not holds(Tv, V, Ev, Hv, q).

announces(shout_3, q).

observes(t, shout_3, a).
observes(t, shout_3, b).
observes(t, shout_3, c).

#program base.

action(shout_4).
announcement(shout_4).
% formula(and(b(a,q),at_4)).

#program step(t).

applicable(t, shout_4) :- dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, at_4), not -applicable(t, shout_4).

-applicable(t, shout_4) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, a), not holds(Tv, V, Ev, Hv, q).

announces(shout_4, q).

observes(t, shout_4, a).
observes(t, shout_4, c).
oblivious(t, shout_4, b).

#program base.



% *** INITIALLY ***

% ** initial pointed **
initially(at_1).
initially(-at_2).
initially(-at_3).
initially(-at_4).
initially(q).

% ** initial beliefs **
agent_set(all_agents).
contains_ag(all_agents,a).
contains_ag(all_agents,b).
contains_ag(all_agents,c).
formula(c(all_agents,at_1)).
initially(c(all_agents,at_1)).
formula(c(all_agents,-at_2)).
initially(c(all_agents,-at_2)).
formula(c(all_agents,-at_3)).
initially(c(all_agents,-at_3)).
formula(c(all_agents,-at_4)).
initially(c(all_agents,-at_4)).



% ** commonly known fluent formulae **
init_sf(at_1).
init_sf(-at_2).
init_sf(-at_3).
init_sf(-at_4).

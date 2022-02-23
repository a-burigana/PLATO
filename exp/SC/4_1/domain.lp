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
action_pre(left, -at_1).
% formula(-at_2).
% formula(-at_3).
% formula(-at_4).
% formula(-at_1).

idle_atom(left, q).

#program step(t).

entails(t, t, W, -at_1) :- dw(t, W), holds(t, W, -at_1).

entails(t, Tw, W, at_2) :- plan(t, left), update(t, Tw, W, _, _), holds(Tw, W, at_2).
entails(t, Tw, W, at_3) :- plan(t, left), update(t, Tw, W, _, _), holds(Tw, W, at_3).
entails(t, Tw, W, at_4) :- plan(t, left), update(t, Tw, W, _, _), holds(Tw, W, at_4).

observes(t, left, a).
observes(t, left, b).
observes(t, left, c).

#program base.

action(right).
ontic(right).
action_pre(right, -at_4).

idle_atom(right, q).

#program step(t).

entails(t, t, W, -at_4) :- dw(t, W), holds(t, W, -at_4).

entails(t, Tw, W, at_1) :- plan(t, right), update(t, Tw, W, _, _), holds(Tw, W, at_1).
entails(t, Tw, W, at_2) :- plan(t, right), update(t, Tw, W, _, _), holds(Tw, W, at_2).
entails(t, Tw, W, at_3) :- plan(t, right), update(t, Tw, W, _, _), holds(Tw, W, at_3).

observes(t, right, a).
observes(t, right, b).
observes(t, right, c).

#program base.

action(sense).
sensing(sense).
action_pre(sense, at_2).
determines(sense, q).

#program step(t).

entails(t, t, W, at_2) :- dw(t, W), holds(t, W, at_2).

observes(t, sense, a).
oblivious(t, sense, b).
oblivious(t, sense, c).

#program base.

action(shout_1).
announcement(shout_1).
announces(shout_1, q).
action_pre(shout_1, and(at_1,b(a,q))).
% formula(b(a,q)).
% formula(and(b(a,q),at_1)).

#program step(t).

entails(t, t, W, and(at_1,b(a,q))) :- dw(t, W), holds(t, W, at_1), not -entails(t, t, W, b(a,q)).

-entails(t, t, W, b(a,q)) :- dw(t, W), r(t, W, Tv, V, a), holds(Tv, V, -q).

observes(t, shout_1, a).
observes(t, shout_1, b).
oblivious(t, shout_1, c).

#program base.

action(shout_2).
announcement(shout_2).
action_pre(shout_2, and(at_2,b(a,q))).
announces(shout_2, q).
% formula(and(b(a,q),at_2)).

#program step(t).

entails(t, t, W, and(at_2,b(a,q))) :- dw(t, W), holds(t, W, at_2), not -entails(t, t, W, b(a,q)).

-entails(t, t, W, b(a,q)) :- dw(t, W), r(t, W, Tv, V, a), holds(Tv, V, -q).

observes(t, shout_2, a).
observes(t, shout_2, b).
observes(t, shout_2, c).

#program base.

action(shout_3).
announcement(shout_3).
action_pre(shout_3, and(at_3,b(a,q))).
announces(shout_3, q).
% formula(and(b(a,q),at_3)).

#program step(t).

entails(t, t, W, and(at_3,b(a,q))) :- dw(t, W), holds(t, W, at_3), not -entails(t, t, W, b(a,q)).

-entails(t, t, W, b(a,q)) :- dw(t, W), r(t, W, Tv, V, a), holds(Tv, V, -q).

observes(t, shout_3, a).
observes(t, shout_3, b).
observes(t, shout_3, c).

#program base.

action(shout_4).
announcement(shout_4).
action_pre(shout_4, and(at_4,b(a,q))).
announces(shout_4, q).
% formula(and(b(a,q),at_4)).

#program step(t).

entails(t, t, W, and(at_4,b(a,q))) :- dw(t, W), holds(t, W, at_4), not -entails(t, t, W, b(a,q)).

-entails(t, t, W, b(a,q)) :- dw(t, W), r(t, W, Tv, V, a), holds(Tv, V, -q).

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

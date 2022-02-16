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


% *** ACTIONS ***
action(distract_a_b).
ontic(distract_a_b).
action_pre(distract_a_b,and(b(a,and(looking_a,looking_b)),and(looking_a,looking_b))).
% formula(-looking_b).
% formula(b(a,looking_a)).
% formula(b(a,looking_b)).
% formula(and(b(a,looking_a),b(a,looking_b))).
% formula(and(looking_a,looking_b)).
% formula(and(and(b(a,looking_a),b(a,looking_b)),and(looking_a,looking_b))).



action(distract_a_c).
ontic(distract_a_c).
action_pre(distract_a_c,and(b(a,and(looking_a,looking_c)),and(looking_a,looking_c))).
% formula(-looking_c).
% formula(b(a,looking_c)).
% formula(and(b(a,looking_a),b(a,looking_c))).
% formula(and(looking_a,looking_c)).
% formula(and(and(b(a,looking_a),b(a,looking_c)),and(looking_a,looking_c))).



action(distract_b_a).
ontic(distract_b_a).
action_pre(distract_b_a,and(b(b,and(looking_b,looking_a)),and(looking_b,looking_a))).
% formula(-looking_a).
% formula(b(b,looking_b)).
% formula(b(b,looking_a)).
% formula(and(b(b,looking_b),b(b,looking_a))).
% formula(and(and(b(b,looking_b),b(b,looking_a)),and(looking_a,looking_b))).



action(distract_b_c).
ontic(distract_b_c).
action_pre(distract_b_c,and(b(b,and(looking_b,looking_c)),and(looking_b,looking_c))).
% formula(b(b,looking_c)).
% formula(and(b(b,looking_b),b(b,looking_c))).
% formula(and(looking_b,looking_c)).
% formula(and(and(b(b,looking_b),b(b,looking_c)),and(looking_b,looking_c))).



action(distract_c_a).
ontic(distract_c_a).
action_pre(distract_c_a,and(b(c,and(looking_c,looking_a)),and(looking_c,looking_a))).
% formula(b(c,looking_c)).
% formula(b(c,looking_a)).
% formula(and(b(c,looking_c),b(c,looking_a))).
% formula(and(and(b(c,looking_c),b(c,looking_a)),and(looking_a,looking_c))).



action(distract_c_b).
ontic(distract_c_b).
action_pre(distract_c_b,and(b(c,and(looking_c,looking_b)),and(looking_c,looking_b))).
% formula(b(c,looking_b)).
% formula(and(b(c,looking_c),b(c,looking_b))).
% formula(and(and(b(c,looking_c),b(c,looking_b)),and(looking_b,looking_c))).



action(open_a).
ontic(open_a).
action_pre(open_a,-opened).
% formula(-opened).



action(peek_a).
sensing(peek_a).
action_pre(peek_a,and(b(a,and(opened,looking_a)),and(opened,looking_a))).
% formula(b(a,opened)).
% formula(and(b(a,opened),b(a,looking_a))).
% formula(and(looking_a,opened)).
% formula(and(and(b(a,opened),b(a,looking_a)),and(looking_a,opened))).



action(peek_b).
sensing(peek_b).
action_pre(peek_b,and(b(b,and(opened,looking_b)),and(opened,looking_b))).
% formula(b(b,opened)).
% formula(and(b(b,opened),b(b,looking_b))).
% formula(and(looking_b,opened)).
% formula(and(and(b(b,opened),b(b,looking_b)),and(looking_b,opened))).



action(peek_c).
sensing(peek_c).
action_pre(peek_c,and(b(c,and(opened,looking_c)),and(opened,looking_c))).
% formula(b(c,opened)).
% formula(and(b(c,opened),b(c,looking_c))).
% formula(and(looking_c,opened)).
% formula(and(and(b(c,opened),b(c,looking_c)),and(looking_c,opened))).



action(shout_tail_a).
announcement(shout_tail_a).
action_pre(shout_tail_a,and(b(a,tail),tail)).
% formula(b(a,tail)).
% formula(and(b(a,tail),tail)).



action(shout_tail_b).
announcement(shout_tail_b).
action_pre(shout_tail_b,and(b(b,tail),tail)).
% formula(b(b,tail)).
% formula(and(b(b,tail),tail)).



action(shout_tail_c).
announcement(shout_tail_c).
action_pre(shout_tail_c,and(b(c,tail),tail)).
% formula(b(c,tail)).
% formula(and(b(c,tail),tail)).



action(signal_a_b).
ontic(signal_a_b).
action_pre(signal_a_b,and(b(a,and(looking_a,-looking_b)),and(looking_a,-looking_b))).
% formula(b(a,-looking_b)).
% formula(and(b(a,looking_a),b(a,-looking_b))).
% formula(and(looking_a,-looking_b)).
% formula(and(and(b(a,looking_a),b(a,-looking_b)),and(looking_a,-looking_b))).



action(signal_a_c).
ontic(signal_a_c).
action_pre(signal_a_c,and(b(a,and(looking_a,-looking_c)),and(looking_a,-looking_c))).
% formula(b(a,-looking_c)).
% formula(and(b(a,looking_a),b(a,-looking_c))).
% formula(and(looking_a,-looking_c)).
% formula(and(and(b(a,looking_a),b(a,-looking_c)),and(looking_a,-looking_c))).



action(signal_b_a).
ontic(signal_b_a).
action_pre(signal_b_a,and(b(b,and(looking_b,-looking_a)),and(looking_b,-looking_a))).
% formula(b(b,-looking_a)).
% formula(and(b(b,looking_b),b(b,-looking_a))).
% formula(and(-looking_a,looking_b)).
% formula(and(and(b(b,looking_b),b(b,-looking_a)),and(-looking_a,looking_b))).



action(signal_b_c).
ontic(signal_b_c).
action_pre(signal_b_c,and(b(b,and(looking_b,-looking_c)),and(looking_b,-looking_c))).
% formula(b(b,-looking_c)).
% formula(and(b(b,looking_b),b(b,-looking_c))).
% formula(and(looking_b,-looking_c)).
% formula(and(and(b(b,looking_b),b(b,-looking_c)),and(looking_b,-looking_c))).



action(signal_c_a).
ontic(signal_c_a).
action_pre(signal_c_a,and(b(c,and(looking_c,-looking_a)),and(looking_c,-looking_a))).
% formula(b(c,-looking_a)).
% formula(and(b(c,looking_c),b(c,-looking_a))).
% formula(and(-looking_a,looking_c)).
% formula(and(and(b(c,looking_c),b(c,-looking_a)),and(-looking_a,looking_c))).



action(signal_c_b).
ontic(signal_c_b).
action_pre(signal_c_b,and(b(c,and(looking_c,-looking_b)),and(looking_c,-looking_b))).
% formula(b(c,-looking_b)).
% formula(and(b(c,looking_c),b(c,-looking_b))).
% formula(and(-looking_b,looking_c)).
% formula(and(and(b(c,looking_c),b(c,-looking_b)),and(-looking_b,looking_c))).


formula(F) :- action_pre(_, F).

formula(F) :- formula(neg(F)).
formula(F) :- formula(and(F,_)).
formula(F) :- formula(and(_,F)).
formula(F) :- formula( or(F,_)).
formula(F) :- formula( or(_,F)).
formula(F) :- formula(  b(_,F)).
formula(F) :- formula(  c(_,F)).

% *** INITIALLY ***

% ** initial pointed **
initially(looking_a).
initially(-looking_b).
initially(-looking_c).
initially(-opened).
initially(tail).

% ** initial beliefs **
agent_set(all_agents).
contains_ag(all_agents,a).
contains_ag(all_agents,b).
contains_ag(all_agents,c).
initially(c(all_agents,-opened)).
initially(c(all_agents,looking_a)).
initially(c(all_agents,-looking_b)).
initially(c(all_agents,-looking_c)).



% ** commonly known fluent formulae **
init_sf(has_key_a).
init_sf(-has_key_b).
init_sf(-has_key_c).
init_sf(-opened).
init_sf(looking_a).
init_sf(-looking_b).
init_sf(-looking_c).

#program step(t).

%%% distract_a_b
entails(t, W, Ew, Hw, and(b(a,and(looking_a,looking_b)),and(looking_a,looking_b))) :-
    formula(and(b(a,and(looking_a,looking_b)),and(looking_a,looking_b))), formula(b(a,and(looking_a,looking_b))),
    dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, looking_a), holds(t, W, Ew, Hw, looking_b),
    not -entails(t, W, Ew, Hw, b(a,and(looking_a,looking_b))).

-entails(t, W, Ew, Hw, b(a,and(looking_a,looking_b))) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, a), holds(Tv, V, Ev, Hv, -looking_a).
-entails(t, W, Ew, Hw, b(a,and(looking_a,looking_b))) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, a), holds(Tv, V, Ev, Hv, -looking_b).

causes(t, Tw, W, Ew, Hw, distract_a_b, -looking_b) :- same_path(t, Tw, W, Ew, Hw, _, _).
observes(t, distract_a_b, a).
observes(t, distract_a_b, b).
oblivious(t, distract_a_b, c).


%%% distract_a_c
entails(t, W, Ew, Hw, and(b(a,and(looking_a,looking_c)),and(looking_a,looking_c))) :-
    formula(and(b(a,and(looking_a,looking_c)),and(looking_a,looking_c))), formula(b(a,and(looking_a,looking_c))),
    dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, looking_a), holds(t, W, Ew, Hw, looking_c),
    not -entails(t, W, Ew, Hw, b(a,and(looking_a,looking_c))).

-entails(t, W, Ew, Hw, b(a,and(looking_a,looking_c))) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, a), holds(Tv, V, Ev, Hv, -looking_a).
-entails(t, W, Ew, Hw, b(a,and(looking_a,looking_c))) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, a), holds(Tv, V, Ev, Hv, -looking_c).

causes(t, Tw, W, Ew, Hw, distract_a_c, -looking_c) :- same_path(t, Tw, W, Ew, Hw, _, _).
observes(t, distract_a_c, a).
observes(t, distract_a_c, c).
oblivious(t, distract_a_c, b).


%%% distract_b_a
entails(t, W, Ew, Hw, and(b(b,and(looking_b,looking_a)),and(looking_b,looking_a))) :-
    formula(and(b(b,and(looking_b,looking_a)),and(looking_b,looking_a))), formula(b(b,and(looking_b,looking_a))),
    dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, looking_b), holds(t, W, Ew, Hw, looking_a),
    not -entails(t, W, Ew, Hw, b(b,and(looking_b,looking_a))).

-entails(t, W, Ew, Hw, b(b,and(looking_b,looking_a))) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, b), holds(Tv, V, Ev, Hv, -looking_b).
-entails(t, W, Ew, Hw, b(b,and(looking_b,looking_a))) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, b), holds(Tv, V, Ev, Hv, -looking_a).

causes(t, Tw, W, Ew, Hw, distract_b_a, -looking_a) :- same_path(t, Tw, W, Ew, Hw, _, _).
observes(t, distract_b_a, b).
observes(t, distract_b_a, a).
oblivious(t, distract_b_a, c).


%%% distract_b_c
entails(t, W, Ew, Hw, and(b(b,and(looking_b,looking_c)),and(looking_b,looking_c))) :-
    formula(and(b(b,and(looking_b,looking_c)),and(looking_b,looking_c))), formula(b(b,and(looking_b,looking_c))),
    dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, looking_b), holds(t, W, Ew, Hw, looking_c),
    not -entails(t, W, Ew, Hw, b(b,and(looking_b,looking_c))).

-entails(t, W, Ew, Hw, b(b,and(looking_b,looking_c))) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, b), holds(Tv, V, Ev, Hv, -looking_b).
-entails(t, W, Ew, Hw, b(b,and(looking_b,looking_c))) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, b), holds(Tv, V, Ev, Hv, -looking_c).

causes(t, Tw, W, Ew, Hw, distract_b_c, -looking_c) :- same_path(t, Tw, W, Ew, Hw, _, _).
observes(t, distract_b_c, b).
observes(t, distract_b_c, c).
oblivious(t, distract_b_c, a).


%%% distract_c_a
entails(t, W, Ew, Hw, and(b(c,and(looking_c,looking_a)),and(looking_c,looking_a))) :-
    formula(and(b(c,and(looking_c,looking_a)),and(looking_c,looking_a))), formula(b(c,and(looking_c,looking_a))),
    dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, looking_c), holds(t, W, Ew, Hw, looking_a),
    not -entails(t, W, Ew, Hw, b(c,and(looking_c,looking_a))).

-entails(t, W, Ew, Hw, b(c,and(looking_c,looking_a))) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, c), holds(Tv, V, Ev, Hv, -looking_c).
-entails(t, W, Ew, Hw, b(c,and(looking_c,looking_a))) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, c), holds(Tv, V, Ev, Hv, -looking_a).

causes(t, Tw, W, Ew, Hw, distract_c_a, -looking_a) :- same_path(t, Tw, W, Ew, Hw, _, _).
observes(t, distract_c_a, c).
observes(t, distract_c_a, a).
oblivious(t, distract_c_a, b).


%%% distract_c_b
entails(t, W, Ew, Hw, and(b(c,and(looking_c,looking_b)),and(looking_c,looking_b))) :-
    formula(and(b(c,and(looking_c,looking_b)),and(looking_c,looking_b))), formula(b(c,and(looking_c,looking_b))),
    dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, looking_c), holds(t, W, Ew, Hw, looking_b),
    not -entails(t, W, Ew, Hw, b(c,and(looking_c,looking_b))).

-entails(t, W, Ew, Hw, b(c,and(looking_c,looking_b))) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, c), holds(Tv, V, Ev, Hv, -looking_c).
-entails(t, W, Ew, Hw, b(c,and(looking_c,looking_b))) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, c), holds(Tv, V, Ev, Hv, -looking_b).

causes(t, Tw, W, Ew, Hw, distract_c_b, -looking_b) :- same_path(t, Tw, W, Ew, Hw, _, _).
observes(t, distract_c_b, c).
observes(t, distract_c_b, b).
oblivious(t, distract_c_b, a).


%%% open_a
entails(t, W, Ew, Hw, -opened) :- formula(-opened), dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, -opened).

causes(t, Tw, W, Ew, Hw, open_a, opened) :- plan(t, open_a), same_path(t, Tw, W, Ew, Hw, _, _).
observes(t, open_a, a).
observes(t, open_a, b) :- dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, looking_b).
observes(t, open_a, c) :- dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, looking_c).


%%% peek_a
entails(t, W, Ew, Hw, and(b(a,and(opened,looking_a)),and(opened,looking_a))) :-
    formula(and(b(a,and(opened,looking_a)),and(opened,looking_a))), formula(b(a,and(opened,looking_a))),
    dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, opened), holds(t, W, Ew, Hw, looking_a),
    not -entails(t, W, Ew, Hw, b(a,and(opened,looking_a))).

-entails(t, W, Ew, Hw, b(a,and(opened,looking_a))) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, a), holds(Tv, V, Ev, Hv, -opened).
-entails(t, W, Ew, Hw, b(a,and(opened,looking_a))) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, a), holds(Tv, V, Ev, Hv, -looking_a).

determines(peek_a, tail).
observes(t, peek_a, a).
aware_of(t, peek_a, b) :- dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, looking_b).
aware_of(t, peek_a, c) :- dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, looking_c).


%%% peek_b
entails(t, W, Ew, Hw, and(b(b,and(opened,looking_b)),and(opened,looking_b))) :-
    formula(and(b(b,and(opened,looking_b)),and(opened,looking_b))), formula(b(b,and(opened,looking_b))),
    dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, opened), holds(t, W, Ew, Hw, looking_b),
    not -entails(t, W, Ew, Hw, b(b,and(opened,looking_b))).

-entails(t, W, Ew, Hw, b(b,and(opened,looking_b))) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, b), holds(Tv, V, Ev, Hv, -opened).
-entails(t, W, Ew, Hw, b(b,and(opened,looking_b))) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, b), holds(Tv, V, Ev, Hv, -looking_b).

determines(peek_b, tail).
observes(t, peek_b, b).
aware_of(t, peek_b, a) :- dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, looking_a).
aware_of(t, peek_b, c) :- dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, looking_c).


%%% peek_c
entails(t, W, Ew, Hw, and(b(c,and(opened,looking_c)),and(opened,looking_c))) :-
    formula(and(b(c,and(opened,looking_c)),and(opened,looking_c))), formula(b(c,and(opened,looking_c))),
    dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, opened), holds(t, W, Ew, Hw, looking_c),
    not -entails(t, W, Ew, Hw, b(c,and(opened,looking_c))).

-entails(t, W, Ew, Hw, b(c,and(opened,looking_c))) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, c), holds(Tv, V, Ev, Hv, -opened).
-entails(t, W, Ew, Hw, b(c,and(opened,looking_c))) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, c), holds(Tv, V, Ev, Hv, -looking_c).

determines(peek_c, tail).
observes(t, peek_c, c).
aware_of(t, peek_c, a) :- dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, looking_a).
aware_of(t, peek_c, b) :- dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, looking_b).


%%% shout_tail_a
entails(t, W, Ew, Hw, and(b(a,tail),tail)) :-
    formula(and(b(a,tail),tail)), formula(b(a,tail)),
    dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, tail), not -entails(t, W, Ew, Hw, b(a,tail)).

-entails(t, W, Ew, Hw, b(a,tail)) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, a), holds(Tv, V, Ev, Hv, -tail).

announces(shout_tail_a, tail).
observes(t, shout_tail_a, a).
observes(t, shout_tail_a, b) :- dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, looking_b).
observes(t, shout_tail_a, c) :- dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, looking_c).


%%% shout_tail_b
entails(t, W, Ew, Hw, and(b(b,tail),tail)) :-
    formula(and(b(b,tail),tail)), formula(b(b,tail)),
    dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, tail), not -entails(t, W, Ew, Hw, b(b,tail)).

-entails(t, W, Ew, Hw, b(b,tail)) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, b), holds(Tv, V, Ev, Hv, -tail).

announces(shout_tail_b, tail).
observes(t, shout_tail_b, b).
observes(t, shout_tail_b, a) :- dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, looking_a).
observes(t, shout_tail_b, c) :- dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, looking_c).


%%% shout_tail_c
entails(t, W, Ew, Hw, and(b(c,tail),tail)) :-
    formula(and(b(c,tail),tail)), formula(b(c,tail)),
    dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, tail), not -entails(t, W, Ew, Hw, b(c,tail)).

-entails(t, W, Ew, Hw, b(c,tail)) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, c), holds(Tv, V, Ev, Hv, -tail).

announces(shout_tail_c, tail).
observes(t, shout_tail_c, c).
observes(t, shout_tail_c, a) :- dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, looking_a).
observes(t, shout_tail_c, b) :- dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, looking_b).


%%% signal_a_b
entails(t, W, Ew, Hw, and(b(a,and(looking_a,-looking_b)),and(looking_a,-looking_b))) :-
    formula(and(b(a,and(looking_a,-looking_b)),and(looking_a,-looking_b))), formula(b(a,and(looking_a,-looking_b))),
    dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, looking_a), holds(t, W, Ew, Hw, -looking_b),
    not -entails(t, W, Ew, Hw, b(a,and(looking_a,-looking_b))).

-entails(t, W, Ew, Hw, b(a,and(looking_a,-looking_b))) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, a), holds(Tv, V, Ev, Hv, -looking_a).
-entails(t, W, Ew, Hw, b(a,and(looking_a,-looking_b))) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, a), holds(Tv, V, Ev, Hv,  looking_b).

causes(t, Tw, W, Ew, Hw, signal_a_b, looking_b) :- same_path(t, Tw, W, Ew, Hw, _, _).
observes(t, signal_a_b, a).
observes(t, signal_a_b, b).
oblivious(t, signal_a_b, c).


%%% signal_a_c
entails(t, W, Ew, Hw, and(b(a,and(looking_a,-looking_c)),and(looking_a,-looking_c))) :-
    formula(and(b(a,and(looking_a,-looking_c)),and(looking_a,-looking_c))), formula(b(a,and(looking_a,-looking_c))),
    dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, looking_a), holds(t, W, Ew, Hw, -looking_c),
    not -entails(t, W, Ew, Hw, b(a,and(looking_a,-looking_c))).

-entails(t, W, Ew, Hw, b(a,and(looking_a,-looking_c))) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, a), holds(Tv, V, Ev, Hv, -looking_a).
-entails(t, W, Ew, Hw, b(a,and(looking_a,-looking_c))) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, a), holds(Tv, V, Ev, Hv,  looking_c).

causes(t, Tw, W, Ew, Hw, signal_a_c, looking_c) :- same_path(t, Tw, W, Ew, Hw, _, _).
observes(t, signal_a_c, a).
observes(t, signal_a_c, c).
oblivious(t, signal_a_c, b).


%%% signal_b_a
entails(t, W, Ew, Hw, and(b(b,and(looking_b,-looking_a)),and(looking_b,-looking_a))) :-
    formula(and(b(b,and(looking_b,-looking_a)),and(looking_b,-looking_a))), formula(b(b,and(looking_b,-looking_a))),
    dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, looking_b), holds(t, W, Ew, Hw, -looking_a),
    not -entails(t, W, Ew, Hw, b(b,and(looking_b,-looking_a))).

-entails(t, W, Ew, Hw, b(b,and(looking_b,-looking_a))) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, b), holds(Tv, V, Ev, Hv, -looking_b).
-entails(t, W, Ew, Hw, b(b,and(looking_b,-looking_a))) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, b), holds(Tv, V, Ev, Hv,  looking_a).

causes(t, Tw, W, Ew, Hw, signal_b_a, looking_a) :- same_path(t, Tw, W, Ew, Hw, _, _).
observes(t, signal_b_a, b).
observes(t, signal_b_a, a).
oblivious(t, signal_b_a, c).


%%% signal_b_c
entails(t, W, Ew, Hw, and(b(b,and(looking_b,-looking_c)),and(looking_b,-looking_c))) :-
    formula(and(b(b,and(looking_b,-looking_c)),and(looking_b,-looking_c))), formula(b(b,and(looking_b,-looking_c))),
    dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, looking_b), holds(t, W, Ew, Hw, -looking_c),
    not -entails(t, W, Ew, Hw, b(b,and(looking_b,-looking_c))).

-entails(t, W, Ew, Hw, b(b,and(looking_b,-looking_c))) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, b), holds(Tv, V, Ev, Hv, -looking_b).
-entails(t, W, Ew, Hw, b(b,and(looking_b,-looking_c))) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, b), holds(Tv, V, Ev, Hv,  looking_c).

causes(t, Tw, W, Ew, Hw, signal_b_c, looking_c) :- same_path(t, Tw, W, Ew, Hw, _, _).
observes(t, signal_b_c, b).
observes(t, signal_b_c, c).
oblivious(t, signal_b_c, a).


%%% signal_c_a
entails(t, W, Ew, Hw, and(b(c,and(looking_c,-looking_a)),and(looking_c,-looking_a))) :-
    formula(and(b(c,and(looking_c,-looking_a)),and(looking_c,-looking_a))), formula(b(c,and(looking_c,-looking_a))),
    dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, looking_c), holds(t, W, Ew, Hw, -looking_a),
    not -entails(t, W, Ew, Hw, b(c,and(looking_c,-looking_a))).

-entails(t, W, Ew, Hw, b(c,and(looking_c,-looking_a))) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, c), holds(Tv, V, Ev, Hv, -looking_c).
-entails(t, W, Ew, Hw, b(c,and(looking_c,-looking_a))) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, c), holds(Tv, V, Ev, Hv,  looking_a).

causes(t, Tw, W, Ew, Hw, signal_c_a, looking_a) :- same_path(t, Tw, W, Ew, Hw, _, _).
observes(t, signal_c_a, c).
observes(t, signal_c_a, a).
oblivious(t, signal_c_a, b).


%%% signal_c_b
entails(t, W, Ew, Hw, and(b(c,and(looking_c,-looking_b)),and(looking_c,-looking_b))) :-
    formula(and(b(c,and(looking_c,-looking_b)),and(looking_c,-looking_b))), formula(b(c,and(looking_c,-looking_b))),
    dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, looking_c), holds(t, W, Ew, Hw, -looking_b),
    not -entails(t, W, Ew, Hw, b(c,and(looking_c,-looking_b))).

-entails(t, W, Ew, Hw, b(c,and(looking_c,-looking_b))) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, c), holds(Tv, V, Ev, Hv, -looking_c).
-entails(t, W, Ew, Hw, b(c,and(looking_c,-looking_b))) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, c), holds(Tv, V, Ev, Hv,  looking_b).

causes(t, Tw, W, Ew, Hw, signal_c_b, looking_b) :- same_path(t, Tw, W, Ew, Hw, _, _).
observes(t, signal_c_b, c).
observes(t, signal_c_b, b).
oblivious(t, signal_c_b, a).

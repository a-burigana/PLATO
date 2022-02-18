% *** ATOMS ***
atom(at_b1_3).
atom(at_b2_1).
atom(at_b1_1).
atom(at_b2_3).
atom(at_a_3).
atom(at_b_1).
atom(at_a_2).
atom(at_b_2).
atom(at_a_1).
atom(at_b_3).
% formula(at_a_1).
% formula(at_a_2).
% formula(at_a_3).
% formula(at_b1_1).
% formula(at_b1_3).
% formula(at_b2_1).
% formula(at_b2_3).
% formula(at_b_1).
% formula(at_b_2).
% formula(at_b_3).


% *** AGENTS ***
agent(a).
agent(b).


% *** ACTIONS ***
action(a_check_1).
sensing(a_check_1).
action_pre(a_check_1, b(a,at_a_1)).
determines(a_check_1, at_b1_1).
% formula(b(a,at_a_1)).

#program step(t).

% applicable(t, a_check_1) :-  not -applicable(t, a_check_1).

% -applicable(t, a_check_1) :- dw(t, W, Ew, Hw), w(Tv, V, Ev, Hv), r(t, W, Ew, Hw, Tv, V, Ev, Hv, a),
%                              holds(Tv, V, Ev, Hv, -at_a_1).

entails(t, t, W, Ew, Hw, b(a,at_a_1))  :- dw(t, W, Ew, Hw), not -entails(t, t, W, Ew, Hw, b(a,at_a_1)).

-entails(t, t, W, Ew, Hw, b(a,at_a_1)) :-
    dw(t, W, Ew, Hw), w(Tv, V, Ev, Hv), r(t, W, Ew, Hw, Tv, V, Ev, Hv, a), holds(Tv, V, Ev, Hv, -at_a_1).

observes(t, a_check_1, a) :- plan(t, a_check_1).
oblivious(t, a_check_1, b) :- plan(t, a_check_1).

#program base.

action(a_check_3).
sensing(a_check_3).
action_pre(a_check_3, b(a,at_a_3)).
determines(a_check_3, at_b2_3).
% formula(b(a,at_a_3)).

#program step(t).

% applicable(t, a_check_3) :-  not -applicable(t, a_check_3).

% -applicable(t, a_check_3) :- dw(t, W, Ew, Hw), w(Tv, V, Ev, Hv), r(t, W, Ew, Hw, Tv, V, Ev, Hv, a),
%                              holds(Tv, V, Ev, Hv, -at_a_3).

entails(t, t, W, Ew, Hw, b(a,at_a_3))  :- dw(t, W, Ew, Hw), not -entails(t, t, W, Ew, Hw, b(a,at_a_3)).

-entails(t, t, W, Ew, Hw, b(a,at_a_3)) :-
    dw(t, W, Ew, Hw), w(Tv, V, Ev, Hv), r(t, W, Ew, Hw, Tv, V, Ev, Hv, a), holds(Tv, V, Ev, Hv, -at_a_3).


observes(t, a_check_3, a) :- plan(t, a_check_3).
oblivious(t, a_check_3, b) :- plan(t, a_check_3).

#program base.

action(b_check_1).
sensing(b_check_1).
action_pre(b_check_1, b(b,at_b_1)).
determines(b_check_1, at_b1_1).
% formula(b(b,at_b_1)).

#program step(t).

% applicable(t, b_check_1) :-  not -applicable(t, b_check_1).

% -applicable(t, b_check_1) :- dw(t, W, Ew, Hw), w(Tv, V, Ev, Hv), r(t, W, Ew, Hw, Tv, V, Ev, Hv, b),
%                              holds(Tv, V, Ev, Hv, -at_b_1).

entails(t, t, W, Ew, Hw, b(b,at_b_1))  :- dw(t, W, Ew, Hw), not -entails(t, t, W, Ew, Hw, b(b,at_b_1)).

-entails(t, t, W, Ew, Hw, b(b,at_b_1)) :- 
    dw(t, W, Ew, Hw), w(Tv, V, Ev, Hv), r(t, W, Ew, Hw, Tv, V, Ev, Hv, b), holds(Tv, V, Ev, Hv, -at_b_1).

observes(t, b_check_1, b) :- plan(t, b_check_1).
oblivious(t, b_check_1, a) :- plan(t, b_check_1).

#program base.

action(b_check_3).
sensing(b_check_3).
action_pre(b_check_3, b(b,at_b_3)).
determines(b_check_3, at_b2_3).
% formula(b(b,at_b_3)).

#program step(t).

% applicable(t, b_check_3) :-  not -applicable(t, b_check_3).

% -applicable(t, b_check_3) :- dw(t, W, Ew, Hw), w(Tv, V, Ev, Hv), r(t, W, Ew, Hw, Tv, V, Ev, Hv, b),
%                              holds(Tv, V, Ev, Hv, -at_b_3).

entails(t, t, W, Ew, Hw, b(b,at_b_3))  :- dw(t, W, Ew, Hw), not -entails(t, t, W, Ew, Hw, b(b,at_b_3)).

-entails(t, t, W, Ew, Hw, b(b,at_b_3)) :-
    dw(t, W, Ew, Hw), w(Tv, V, Ev, Hv), r(t, W, Ew, Hw, Tv, V, Ev, Hv, b), holds(Tv, V, Ev, Hv, -at_b_3).

observes(t, b_check_3, b) :- plan(t, b_check_3).
oblivious(t, b_check_3, a) :- plan(t, b_check_3).

#program base.

action(left_a).
ontic(left_a).
action_pre(left_a, and(-at_a_1,b(a,-at_a_1))).
% formula(-at_a_2).
% formula(-at_a_3).
% formula(-at_a_1).
% formula(b(a,-at_a_1)).
% formula(and(-at_a_1,b(a,-at_a_1))).

causes(left_a,  at_a_1, at_a_2).
causes(left_a,  at_a_2, at_a_3).
causes(left_a, -at_a_2, at_a_2).
causes(left_a, -at_a_3, at_a_3).

idle_atom(left_a, at_b1_3).
idle_atom(left_a, at_b2_1).
idle_atom(left_a, at_b1_1).
idle_atom(left_a, at_b2_3).
idle_atom(left_a, at_b_1).
idle_atom(left_a, at_b_2).
idle_atom(left_a, at_b_3).

#program step(t).

% applicable(t, left_a) :- dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, -at_a_1), not -applicable(t, left_a).

% -applicable(t, left_a) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, a), holds(Tv, V, Ev, Hv, at_a_1).

% causes(t, Tw, W, Ew, Hw, left_a,  at_a_1) :- same_path(t, Tw, W, Ew, Hw, _, _), holds(Tw, W, Ew, Hw, at_a_2).
% causes(t, Tw, W, Ew, Hw, left_a,  at_a_2) :- same_path(t, Tw, W, Ew, Hw, _, _), holds(Tw, W, Ew, Hw, at_a_3).
% causes(t, Tw, W, Ew, Hw, left_a, -at_a_2) :- same_path(t, Tw, W, Ew, Hw, _, _), holds(Tw, W, Ew, Hw, at_a_2).
% causes(t, Tw, W, Ew, Hw, left_a, -at_a_3) :- same_path(t, Tw, W, Ew, Hw, _, _), holds(Tw, W, Ew, Hw, at_a_3).

entails(t, t, W, Ew, Hw, and(-at_a_1,b(a,-at_a_1))) :-
    dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, -at_a_1), not -entails(t, t, W, Ew, Hw, b(a,-at_a_1)).

-entails(t, t, W, Ew, Hw, b(a,-at_a_1)) :-
    dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, a), holds(Tv, V, Ev, Hv, at_a_1).

entails(t, Tw, W, Ew, Hw, at_a_2) :- plan(t, left_a), same_path(t, Tw, W, Ew, Hw, 1, _), holds(Tw, W, Ew, Hw, at_a_2).
entails(t, Tw, W, Ew, Hw, at_a_3) :- plan(t, left_a), same_path(t, Tw, W, Ew, Hw, 1, _), holds(Tw, W, Ew, Hw, at_a_3).

observes(t, left_a, a) :- plan(t, left_a).
observes(t, left_a, b) :- plan(t, left_a).

#program base.

action(left_b).
ontic(left_b).
action_pre(left_b, and(-at_b_1,b(b,-at_b_1))).
% formula(-at_b_2).
% formula(-at_b_3).
% formula(-at_b_1).
% formula(b(b,-at_b_1)).
% formula(and(-at_b_1,b(b,-at_b_1))).

causes(left_b,  at_b_1, at_b_2).
causes(left_b,  at_b_2, at_b_3).
causes(left_b, -at_b_2, at_b_2).
causes(left_b, -at_b_3, at_b_3).

idle_atom(left_b, at_b1_3).
idle_atom(left_b, at_b2_1).
idle_atom(left_b, at_b1_1).
idle_atom(left_b, at_b2_3).
idle_atom(left_b, at_a_1).
idle_atom(left_b, at_a_2).
idle_atom(left_b, at_a_3).

#program step(t).

% applicable(t, left_b) :- dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, -at_b_1), not -applicable(t, left_b).

% -applicable(t, left_b) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, b), holds(Tv, V, Ev, Hv, at_b_1).

% causes(t, Tw, W, Ew, Hw, left_b,  at_b_1) :- same_path(t, Tw, W, Ew, Hw, _, _), holds(Tw, W, Ew, Hw, at_b_2).
% causes(t, Tw, W, Ew, Hw, left_b,  at_b_2) :- same_path(t, Tw, W, Ew, Hw, _, _), holds(Tw, W, Ew, Hw, at_b_3).
% causes(t, Tw, W, Ew, Hw, left_b, -at_b_2) :- same_path(t, Tw, W, Ew, Hw, _, _), holds(Tw, W, Ew, Hw, at_b_2).
% causes(t, Tw, W, Ew, Hw, left_b, -at_b_3) :- same_path(t, Tw, W, Ew, Hw, _, _), holds(Tw, W, Ew, Hw, at_b_3).

entails(t, t, W, Ew, Hw, and(-at_b_1,b(b,-at_b_1))) :-
    dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, -at_b_1), not -entails(t, t, W, Ew, Hw, b(b,-at_b_1)).

-entails(t, t, W, Ew, Hw, b(b,-at_b_1)) :-
    dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, b), holds(Tv, V, Ev, Hv, at_b_1).

entails(t, Tw, W, Ew, Hw, at_b_2) :- plan(t, left_b), same_path(t, Tw, W, Ew, Hw, 1, _), holds(Tw, W, Ew, Hw, at_b_2).
entails(t, Tw, W, Ew, Hw, at_b_3) :- plan(t, left_b), same_path(t, Tw, W, Ew, Hw, 1, _), holds(Tw, W, Ew, Hw, at_b_3).

observes(t, left_b, a) :- plan(t, left_b).
observes(t, left_b, b) :- plan(t, left_b).

#program base.

action(right_a).
ontic(right_a).
action_pre(right_a, and(-at_a_3,b(a,-at_a_3))).
% formula(b(a,-at_a_3)).
% formula(and(-at_a_3,b(a,-at_a_3))).

causes(right_a, -at_a_1, at_a_1).
causes(right_a,  at_a_2, at_a_1).
causes(right_a, -at_a_2, at_a_2).
causes(right_a,  at_a_3, at_a_2).

idle_atom(right_a, at_b1_3).
idle_atom(right_a, at_b2_1).
idle_atom(right_a, at_b1_1).
idle_atom(right_a, at_b2_3).
idle_atom(right_a, at_b_1).
idle_atom(right_a, at_b_2).
idle_atom(right_a, at_b_3).

#program step(t).

% applicable(t, right_a) :- dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, -at_a_3), not -applicable(t, right_a).

% -applicable(t, right_a) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, a), holds(Tv, V, Ev, Hv, at_a_3).

% causes(t, Tw, W, Ew, Hw, right_a, -at_a_1) :- same_path(t, Tw, W, Ew, Hw, _, _), holds(Tw, W, Ew, Hw, at_a_1).
% causes(t, Tw, W, Ew, Hw, right_a,  at_a_2) :- same_path(t, Tw, W, Ew, Hw, _, _), holds(Tw, W, Ew, Hw, at_a_1).
% causes(t, Tw, W, Ew, Hw, right_a, -at_a_2) :- same_path(t, Tw, W, Ew, Hw, _, _), holds(Tw, W, Ew, Hw, at_a_2).
% causes(t, Tw, W, Ew, Hw, right_a,  at_a_3) :- same_path(t, Tw, W, Ew, Hw, _, _), holds(Tw, W, Ew, Hw, at_a_2).

entails(t, t, W, Ew, Hw, and(-at_a_3,b(a,-at_a_3))) :-
    dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, -at_a_3), not -entails(t, t, W, Ew, Hw, b(a,-at_a_3)).

-entails(t, t, W, Ew, Hw, b(a,-at_a_3)) :-
    dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, a), holds(Tv, V, Ev, Hv, at_a_3).

entails(t, Tw, W, Ew, Hw, at_a_1) :- plan(t, right_a), same_path(t, Tw, W, Ew, Hw, 1, _), holds(Tw, W, Ew, Hw, at_a_1).
entails(t, Tw, W, Ew, Hw, at_a_2) :- plan(t, right_a), same_path(t, Tw, W, Ew, Hw, 1, _), holds(Tw, W, Ew, Hw, at_a_2).

observes(t, right_a, a) :- plan(t, right_a).
observes(t, right_a, b) :- plan(t, right_a).

#program base.

action(right_b).
ontic(right_b).
action_pre(right_b, and(-at_b_3,b(b,-at_b_3))).
% formula(b(b,-at_b_3)).
% formula(and(-at_b_3,b(b,-at_b_3))).

causes(right_b, -at_b_1, at_b_1).
causes(right_b,  at_b_2, at_b_1).
causes(right_b, -at_b_2, at_b_2).
causes(right_b,  at_b_3, at_b_2).

idle_atom(right_b, at_b1_3).
idle_atom(right_b, at_b2_1).
idle_atom(right_b, at_b1_1).
idle_atom(right_b, at_b2_3).
idle_atom(right_b, at_a_1).
idle_atom(right_b, at_a_2).
idle_atom(right_b, at_a_3).

#program step(t).

% applicable(t, right_b) :- dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, -at_b_3), not -applicable(t, right_b).

% -applicable(t, right_b) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, a), holds(Tv, V, Ev, Hv, at_b_3).

% causes(t, Tw, W, Ew, Hw, right_b, -at_b_1) :- same_path(t, Tw, W, Ew, Hw, _, _), holds(Tw, W, Ew, Hw, at_b_1).
% causes(t, Tw, W, Ew, Hw, right_b,  at_b_2) :- same_path(t, Tw, W, Ew, Hw, _, _), holds(Tw, W, Ew, Hw, at_b_1).
% causes(t, Tw, W, Ew, Hw, right_b, -at_b_2) :- same_path(t, Tw, W, Ew, Hw, _, _), holds(Tw, W, Ew, Hw, at_b_2).
% causes(t, Tw, W, Ew, Hw, right_b,  at_b_3) :- same_path(t, Tw, W, Ew, Hw, _, _), holds(Tw, W, Ew, Hw, at_b_2).

entails(t, t, W, Ew, Hw, and(-at_b_3,b(b,-at_b_3)))  :-
    dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, -at_b_3), not -entails(t, t, W, Ew, Hw, b(b,-at_b_3)).

-entails(t, t, W, Ew, Hw, b(b,-at_b_3)) :-
    dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, a), holds(Tv, V, Ev, Hv, at_b_3).

entails(t, Tw, W, Ew, Hw, at_b_1) :- plan(t, right_b), same_path(t, Tw, W, Ew, Hw, 1, _), holds(Tw, W, Ew, Hw, at_b_1).
entails(t, Tw, W, Ew, Hw, at_b_2) :- plan(t, right_b), same_path(t, Tw, W, Ew, Hw, 1, _), holds(Tw, W, Ew, Hw, at_b_2).

observes(t, right_b, a) :- plan(t, right_b).
observes(t, right_b, b) :- plan(t, right_b).

#program base.

action(tell_a_b1_1).
announcement(tell_a_b1_1).
action_pre(tell_a_b1_1, b(a,at_b1_1)).
announces(tell_a_b1_1, at_b1_1).
% formula(b(a,at_b1_1)).

#program step(t).

% applicable(t, tell_a_b1_1) :- dw(t, W, Ew, Hw), not -applicable(t, tell_a_b1_1).
% -applicable(t, tell_a_b1_1) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, a), holds(Tv, V, Ev, Hv, -at_b1_1).

entails(t, t, W, Ew, Hw, b(a,at_b1_1))  :- dw(t, W, Ew, Hw), not -entails(t, t, W, Ew, Hw, b(a,at_b1_1)).
-entails(t, t, W, Ew, Hw, b(a,at_b1_1)) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, a), holds(Tv, V, Ev, Hv, -at_b1_1).

observes(t, tell_a_b1_1, b) :- plan(t, tell_a_b1_1).
observes(t, tell_a_b1_1, a) :- plan(t, tell_a_b1_1).

#program base.

action(tell_a_b1_3).
announcement(tell_a_b1_3).
action_pre(tell_a_b1_3, b(a,at_b1_3)).
announces(tell_a_b1_3, at_b1_3).
% formula(b(a,at_b1_3)).

#program step(t).

% applicable(t, tell_a_b1_3) :- dw(t, W, Ew, Hw), not -applicable(t, tell_a_b1_3).
% -applicable(t, tell_a_b1_3) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, a), holds(Tv, V, Ev, Hv, -at_b1_3).

entails(t, t, W, Ew, Hw, b(a,at_b1_3))  :- dw(t, W, Ew, Hw), not -entails(t, t, W, Ew, Hw, b(a,at_b1_3)).
-entails(t, t, W, Ew, Hw, b(a,at_b1_3)) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, a), holds(Tv, V, Ev, Hv, -at_b1_3).

observes(t, tell_a_b1_3, a) :- plan(t, tell_a_b1_3).
observes(t, tell_a_b1_3, b) :- plan(t, tell_a_b1_3).

#program base.

action(tell_a_b2_1).
announcement(tell_a_b2_1).
action_pre(tell_a_b2_1, b(a,at_b2_1)).
announces(tell_a_b2_1, at_b2_1).
% formula(b(a,at_b2_1)).

#program step(t).

% applicable(t, tell_a_b2_1) :- dw(t, W, Ew, Hw), not -applicable(t, tell_a_b2_1).
% -applicable(t, tell_a_b2_1) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, a), holds(Tv, V, Ev, Hv, -at_b2_1).

entails(t, t, W, Ew, Hw, b(a,at_b2_1))  :- dw(t, W, Ew, Hw), not -entails(t, t, W, Ew, Hw, b(a,at_b2_1)).
-entails(t, t, W, Ew, Hw, b(a,at_b2_1)) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, a), holds(Tv, V, Ev, Hv, -at_b2_1).

observes(t, tell_a_b2_1, a) :- plan(t, tell_a_b2_1).
observes(t, tell_a_b2_1, b) :- plan(t, tell_a_b2_1).

#program base.

action(tell_a_b2_3).
announcement(tell_a_b2_3).
action_pre(tell_a_b2_3, b(a,at_b2_3)).
announces(tell_a_b2_3, at_b2_3).
% formula(b(a,at_b2_3)).

#program step(t).

% applicable(t, tell_a_b2_3) :- dw(t, W, Ew, Hw), not -applicable(t, tell_a_b2_3).
% -applicable(t, tell_a_b2_3) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, a), holds(Tv, V, Ev, Hv, -at_b2_3).

entails(t, t, W, Ew, Hw, b(a,at_b2_3))  :- dw(t, W, Ew, Hw), not -entails(t, t, W, Ew, Hw, b(a,at_b2_3)).
-entails(t, t, W, Ew, Hw, b(a,at_b2_3)) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, a), holds(Tv, V, Ev, Hv, -at_b2_3).

observes(t, tell_a_b2_3, a) :- plan(t, tell_a_b2_3).
observes(t, tell_a_b2_3, b) :- plan(t, tell_a_b2_3).

#program base.

action(tell_b_b1_1).
announcement(tell_b_b1_1).
action_pre(tell_b_b1_1, b(b,at_b1_1)).
announces(tell_b_b1_1, at_b1_1).
% formula(b(b,at_b1_1)).

#program step(t).

% applicable(t, tell_b_b1_1) :- dw(t, W, Ew, Hw), not -applicable(t, tell_b_b1_1).
% -applicable(t, tell_b_b1_1) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, b), holds(Tv, V, Ev, Hv, -at_b1_1).

entails(t, t, W, Ew, Hw, b(b,at_b1_1))  :- dw(t, W, Ew, Hw), not -entails(t, t, W, Ew, Hw, b(b,at_b1_1)).
-entails(t, t, W, Ew, Hw, b(b,at_b1_1)) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, b), holds(Tv, V, Ev, Hv, -at_b1_1).

observes(t, tell_b_b1_1, a) :- plan(t, tell_b_b1_1).
observes(t, tell_b_b1_1, b) :- plan(t, tell_b_b1_1).

#program base.

action(tell_b_b1_3).
announcement(tell_b_b1_3).
action_pre(tell_b_b1_3, b(b,at_b1_3)).
announces(tell_b_b1_3, at_b1_3).
% formula(b(b,at_b1_3)).

#program step(t).

% applicable(t, tell_b_b1_3) :- dw(t, W, Ew, Hw), not -applicable(t, tell_b_b1_3).
% -applicable(t, tell_b_b1_3) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, b), holds(Tv, V, Ev, Hv, -at_b1_3).

entails(t, t, W, Ew, Hw, b(b,at_b1_3))  :- dw(t, W, Ew, Hw), not -entails(t, t, W, Ew, Hw, b(b,at_b1_3)).
-entails(t, t, W, Ew, Hw, b(b,at_b1_3)) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, b), holds(Tv, V, Ev, Hv, -at_b1_3).

observes(t, tell_b_b1_3, a) :- plan(t, tell_b_b1_3).
observes(t, tell_b_b1_3, b) :- plan(t, tell_b_b1_3).

#program base.

action(tell_b_b2_1).
announcement(tell_b_b2_1).
action_pre(tell_b_b2_1, b(b,at_b2_1)).
announces(tell_b_b2_1, at_b2_1).
% formula(b(b,at_b2_1)).

#program step(t).

% applicable(t, tell_b_b2_1) :- dw(t, W, Ew, Hw), not -applicable(t, tell_b_b2_1).
% -applicable(t, tell_b_b2_1) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, b), holds(Tv, V, Ev, Hv, -at_b2_1).

epistemic(t, W, Ew, Hw, b(b,at_b2_1))  :- dw(t, W, Ew, Hw), not -epistemic(t, W, Ew, Hw, b(b,at_b2_1)).
-epistemic(t, W, Ew, Hw, b(b,at_b2_1)) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, b), holds(Tv, V, Ev, Hv, -at_b2_1).

observes(t, tell_b_b2_1, a) :- plan(t, tell_b_b2_1).
observes(t, tell_b_b2_1, b) :- plan(t, tell_b_b2_1).

#program base.

action(tell_b_b2_3).
announcement(tell_b_b2_3).
action_pre(tell_b_b2_3, b(b,at_b2_3)).
announces(tell_b_b2_3, at_b2_3).
% formula(b(b,at_b2_3)).

#program step(t).

% applicable(t, tell_b_b2_3) :- dw(t, W, Ew, Hw), not -applicable(t, tell_b_b2_3).
% -applicable(t, tell_b_b2_3) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, b), holds(Tv, V, Ev, Hv, -at_b2_3).

entails(t, t, W, Ew, Hw, b(b,at_b2_3))  :- dw(t, W, Ew, Hw), not -entails(t, t, W, Ew, Hw, b(b,at_b2_3)).
-entails(t, t, W, Ew, Hw, b(b,at_b2_3)) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, b), holds(Tv, V, Ev, Hv, -at_b2_3).

observes(t, tell_b_b2_3, a) :- plan(t, tell_b_b2_3).
observes(t, tell_b_b2_3, b) :- plan(t, tell_b_b2_3).

#program base.



% *** INITIALLY ***

% ** initial pointed **
initially(-at_a_1).
initially(at_a_2).
initially(-at_a_3).
initially(at_b1_1).
formula(-at_b1_3).
initially(-at_b1_3).
formula(-at_b2_1).
initially(-at_b2_1).
initially(at_b2_3).
initially(-at_b_1).
initially(at_b_2).
initially(-at_b_3).

% ** initial beliefs **
agent_set(all_agents).
contains_ag(all_agents,a).
contains_ag(all_agents,b).
formula(c(all_agents,at_a_2)).
initially(c(all_agents,at_a_2)).
formula(c(all_agents,at_b_2)).
initially(c(all_agents,at_b_2)).
formula(c(all_agents,-at_a_1)).
initially(c(all_agents,-at_a_1)).
formula(c(all_agents,-at_b_1)).
initially(c(all_agents,-at_b_1)).
formula(c(all_agents,-at_a_3)).
initially(c(all_agents,-at_a_3)).
formula(c(all_agents,-at_b_3)).
initially(c(all_agents,-at_b_3)).
formula(and(at_b1_1,-at_b1_3)).
formula(-at_b1_1).
formula(and(-at_b1_1,at_b1_3)).
formula(or(and(at_b1_1,-at_b1_3),and(-at_b1_1,at_b1_3))).
formula(c(all_agents,or(and(at_b1_1,-at_b1_3),and(-at_b1_1,at_b1_3)))).
initially(c(all_agents,or(and(at_b1_1,-at_b1_3),and(-at_b1_1,at_b1_3)))).
formula(-at_b2_3).
formula(and(at_b2_1,-at_b2_3)).
formula(and(-at_b2_1,at_b2_3)).
formula(or(and(at_b2_1,-at_b2_3),and(-at_b2_1,at_b2_3))).
formula(c(all_agents,or(and(at_b2_1,-at_b2_3),and(-at_b2_1,at_b2_3)))).
initially(c(all_agents,or(and(at_b2_1,-at_b2_3),and(-at_b2_1,at_b2_3)))).



% ** commonly known fluent formulae **
init_sf(at_a_2).
init_sf(at_b_2).
init_sf(-at_a_1).
init_sf(-at_b_1).
init_sf(-at_a_3).
init_sf(-at_b_3).
init_sf(at_b1_1).
init_sf(-at_b1_3).
init_sf(and(at_b1_1,-at_b1_3)).
init_sf(-at_b1_1).
init_sf(at_b1_3).
init_sf(and(-at_b1_1,at_b1_3)).
init_sf(or(and(at_b1_1,-at_b1_3),and(-at_b1_1,at_b1_3))).
init_sf(at_b2_1).
init_sf(-at_b2_3).
init_sf(and(at_b2_1,-at_b2_3)).
init_sf(-at_b2_1).
init_sf(at_b2_3).
init_sf(and(-at_b2_1,at_b2_3)).
init_sf(or(and(at_b2_1,-at_b2_3),and(-at_b2_1,at_b2_3))).

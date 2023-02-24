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
action_pre(distract_a_b, and(b(a,and(looking_a,looking_b)),and(looking_a,looking_b))).
causes(distract_a_b, -looking_b, true).


% formula(-looking_b).
% formula(b(a,looking_a)).
% formula(b(a,looking_b)).
% formula(and(b(a,looking_a),b(a,looking_b))).
% formula(and(looking_a,looking_b)).
% formula(and(and(b(a,looking_a),b(a,looking_b)),and(looking_a,looking_b))).

idle_atom(distract_a_b, looking_a).
idle_atom(distract_a_b, looking_c).
idle_atom(distract_a_b, opened).
idle_atom(distract_a_b, tail).

#program step(t).

entails(t, t, W, and(b(a,and(looking_a,looking_b)),and(looking_a,looking_b))) :-
    dw(t, W), holds(t, W, looking_a), holds(t, W, looking_b),
    not -entails(t, t, W, b(a,and(looking_a,looking_b))).

-entails(t, t, W, b(a,and(looking_a,looking_b))) :- dw(t, W), r(t, W, Tv, V, a), holds(Tv, V, -looking_a).
-entails(t, t, W, b(a,and(looking_a,looking_b))) :- dw(t, W), r(t, W, Tv, V, a), holds(Tv, V, -looking_b).

observes(t, distract_a_b, a).
observes(t, distract_a_b, b).
oblivious(t, distract_a_b, c).

#program base.

action(distract_a_c).
ontic(distract_a_c).
action_pre(distract_a_c,and(b(a,and(looking_a,looking_c)),and(looking_a,looking_c))).
causes(distract_a_c, -looking_c).
once(distract_a_c).

% formula(-looking_c).
% formula(b(a,looking_c)).
% formula(and(b(a,looking_a),b(a,looking_c))).
% formula(and(looking_a,looking_c)).
% formula(and(and(b(a,looking_a),b(a,looking_c)),and(looking_a,looking_c))).

idle_atom(distract_a_c, looking_a).
idle_atom(distract_a_c, looking_b).
idle_atom(distract_a_c, opened).
idle_atom(distract_a_c, tail).

#program step(t).

entails(t, t, W, and(b(a,and(looking_a,looking_c)),and(looking_a,looking_c))) :-
    dw(t, W), holds(t, W, looking_a), holds(t, W, looking_c),
    not -entails(t, t, W, b(a,and(looking_a,looking_c))).

-entails(t, t, W, b(a,and(looking_a,looking_c))) :- dw(t, W), r(t, W, Tv, V, a), holds(Tv, V, -looking_a).
-entails(t, t, W, b(a,and(looking_a,looking_c))) :- dw(t, W), r(t, W, Tv, V, a), holds(Tv, V, -looking_c).

observes(t, distract_a_c, a).
observes(t, distract_a_c, c).
oblivious(t, distract_a_c, b).

#program base.


action(distract_b_a).
ontic(distract_b_a).
action_pre(distract_b_a,and(b(b,and(looking_b,looking_a)),and(looking_b,looking_a))).
causes(distract_b_a, -looking_a).
once(distract_b_a).

% formula(-looking_a).
% formula(b(b,looking_b)).
% formula(b(b,looking_a)).
% formula(and(b(b,looking_b),b(b,looking_a))).
% formula(and(and(b(b,looking_b),b(b,looking_a)),and(looking_a,looking_b))).

idle_atom(distract_b_a, looking_b).
idle_atom(distract_b_a, looking_c).
idle_atom(distract_b_a, opened).
idle_atom(distract_b_a, tail).

#program step(t).

entails(t, t, W, and(b(b,and(looking_b,looking_a)),and(looking_b,looking_a))) :-
    dw(t, W), holds(t, W, looking_b), holds(t, W, looking_a),
    not -entails(t, t, W, b(b,and(looking_b,looking_a))).

-entails(t, t, W, b(b,and(looking_b,looking_a))) :- dw(t, W), r(t, W, Tv, V, b), holds(Tv, V, -looking_b).
-entails(t, t, W, b(b,and(looking_b,looking_a))) :- dw(t, W), r(t, W, Tv, V, b), holds(Tv, V, -looking_a).

observes(t, distract_b_a, b).
observes(t, distract_b_a, a).
oblivious(t, distract_b_a, c).

#program base.


action(distract_b_c).
ontic(distract_b_c).
action_pre(distract_b_c,and(b(b,and(looking_b,looking_c)),and(looking_b,looking_c))).
causes(distract_b_c, -looking_c).
once(distract_b_c).

% formula(b(b,looking_c)).
% formula(and(b(b,looking_b),b(b,looking_c))).
% formula(and(looking_b,looking_c)).
% formula(and(and(b(b,looking_b),b(b,looking_c)),and(looking_b,looking_c))).

idle_atom(distract_b_c, looking_a).
idle_atom(distract_b_c, looking_b).
idle_atom(distract_b_c, opened).
idle_atom(distract_b_c, tail).

#program step(t).

entails(t, t, W, and(b(b,and(looking_b,looking_c)),and(looking_b,looking_c))) :-
    dw(t, W), holds(t, W, looking_b), holds(t, W, looking_c),
    not -entails(t, t, W, b(b,and(looking_b,looking_c))).

-entails(t, t, W, b(b,and(looking_b,looking_c))) :- dw(t, W), r(t, W, Tv, V, b), holds(Tv, V, -looking_b).
-entails(t, t, W, b(b,and(looking_b,looking_c))) :- dw(t, W), r(t, W, Tv, V, b), holds(Tv, V, -looking_c).

observes(t, distract_b_c, b).
observes(t, distract_b_c, c).
oblivious(t, distract_b_c, a).

#program base.


action(distract_c_a).
ontic(distract_c_a).
action_pre(distract_c_a,and(b(c,and(looking_c,looking_a)),and(looking_c,looking_a))).
causes(distract_c_a, -looking_a).
once(distract_c_a).

% formula(b(c,looking_c)).
% formula(b(c,looking_a)).
% formula(and(b(c,looking_c),b(c,looking_a))).
% formula(and(and(b(c,looking_c),b(c,looking_a)),and(looking_a,looking_c))).

idle_atom(distract_c_a, looking_b).
idle_atom(distract_c_a, looking_c).
idle_atom(distract_c_a, opened).
idle_atom(distract_c_a, tail).

#program step(t).

entails(t, t, W, and(b(c,and(looking_c,looking_a)),and(looking_c,looking_a))) :-
    dw(t, W), holds(t, W, looking_c), holds(t, W, looking_a),
    not -entails(t, t, W, b(c,and(looking_c,looking_a))).

-entails(t, t, W, b(c,and(looking_c,looking_a))) :- dw(t, W), r(t, W, Tv, V, c), holds(Tv, V, -looking_c).
-entails(t, t, W, b(c,and(looking_c,looking_a))) :- dw(t, W), r(t, W, Tv, V, c), holds(Tv, V, -looking_a).

observes(t, distract_c_a, c).
observes(t, distract_c_a, a).
oblivious(t, distract_c_a, b).

#program base.


action(distract_c_b).
ontic(distract_c_b).
action_pre(distract_c_b,and(b(c,and(looking_c,looking_b)),and(looking_c,looking_b))).
causes(distract_c_b, -looking_b).
once(distract_c_b).

% formula(b(c,looking_b)).
% formula(and(b(c,looking_c),b(c,looking_b))).
% formula(and(and(b(c,looking_c),b(c,looking_b)),and(looking_b,looking_c))).

idle_atom(distract_c_b, looking_a).
idle_atom(distract_c_b, looking_c).
idle_atom(distract_c_b, opened).
idle_atom(distract_c_b, tail).

#program step(t).

entails(t, t, W, and(b(c,and(looking_c,looking_b)),and(looking_c,looking_b))) :-
    dw(t, W), holds(t, W, looking_c), holds(t, W, looking_b),
    not -entails(t, t, W, b(c,and(looking_c,looking_b))).

-entails(t, t, W, b(c,and(looking_c,looking_b))) :- dw(t, W), r(t, W, Tv, V, c), holds(Tv, V, -looking_c).
-entails(t, t, W, b(c,and(looking_c,looking_b))) :- dw(t, W), r(t, W, Tv, V, c), holds(Tv, V, -looking_b).

observes(t, distract_c_b, c).
observes(t, distract_c_b, b).
oblivious(t, distract_c_b, a).

#program base.


action(open_a).
ontic(open_a).
action_pre(open_a,-opened).
causes(open_a, opened).
once(open_a).

% formula(-opened).

idle_atom(open_a, looking_a).
idle_atom(open_a, looking_b).
idle_atom(open_a, looking_c).
idle_atom(open_a, tail).

#program step(t).

entails(t, t, W, -opened) :- dw(t, W), holds(t, W, -opened).

observes(t, open_a, a).
observes(t, open_a, b) :- dw(t, W), holds(t, W, looking_b).
observes(t, open_a, c) :- dw(t, W), holds(t, W, looking_c).

#program base.


action(peek_a).
sensing(peek_a).
action_pre(peek_a,and(b(a,and(opened,looking_a)),and(opened,looking_a))).
determines(peek_a, tail).
% formula(b(a,opened)).
% formula(and(b(a,opened),b(a,looking_a))).
% formula(and(looking_a,opened)).
% formula(and(and(b(a,opened),b(a,looking_a)),and(looking_a,opened))).

#program step(t).

entails(t, t, W, and(b(a,and(opened,looking_a)),and(opened,looking_a))) :-
    dw(t, W), holds(t, W, opened), holds(t, W, looking_a),
    not -entails(t, t, W, b(a,and(opened,looking_a))).

-entails(t, t, W, b(a,and(opened,looking_a))) :- dw(t, W), r(t, W, Tv, V, a), holds(Tv, V, -opened).
-entails(t, t, W, b(a,and(opened,looking_a))) :- dw(t, W), r(t, W, Tv, V, a), holds(Tv, V, -looking_a).

observes(t, peek_a, a).
aware_of(t, peek_a, b) :- dw(t, W), holds(t, W, looking_b).
aware_of(t, peek_a, c) :- dw(t, W), holds(t, W, looking_c).

#program base.


action(peek_b).
sensing(peek_b).
action_pre(peek_b,and(b(b,and(opened,looking_b)),and(opened,looking_b))).
determines(peek_b, tail).
% formula(b(b,opened)).
% formula(and(b(b,opened),b(b,looking_b))).
% formula(and(looking_b,opened)).
% formula(and(and(b(b,opened),b(b,looking_b)),and(looking_b,opened))).

#program step(t).

entails(t, t, W, and(b(b,and(opened,looking_b)),and(opened,looking_b))) :-
    dw(t, W), holds(t, W, opened), holds(t, W, looking_b),
    not -entails(t, t, W, b(b,and(opened,looking_b))).

-entails(t, t, W, b(b,and(opened,looking_b))) :- dw(t, W), r(t, W, Tv, V, b), holds(Tv, V, -opened).
-entails(t, t, W, b(b,and(opened,looking_b))) :- dw(t, W), r(t, W, Tv, V, b), holds(Tv, V, -looking_b).

observes(t, peek_b, b).
aware_of(t, peek_b, a) :- dw(t, W), holds(t, W, looking_a).
aware_of(t, peek_b, c) :- dw(t, W), holds(t, W, looking_c).

#program base.


action(peek_c).
sensing(peek_c).
action_pre(peek_c,and(b(c,and(opened,looking_c)),and(opened,looking_c))).
determines(peek_c, tail).
% formula(b(c,opened)).
% formula(and(b(c,opened),b(c,looking_c))).
% formula(and(looking_c,opened)).
% formula(and(and(b(c,opened),b(c,looking_c)),and(looking_c,opened))).

#program step(t).

entails(t, t, W, and(b(c,and(opened,looking_c)),and(opened,looking_c))) :-
    dw(t, W), holds(t, W, opened), holds(t, W, looking_c),
    not -entails(t, t, W, b(c,and(opened,looking_c))).

-entails(t, t, W, b(c,and(opened,looking_c))) :- dw(t, W), r(t, W, Tv, V, c), holds(Tv, V, -opened).
-entails(t, t, W, b(c,and(opened,looking_c))) :- dw(t, W), r(t, W, Tv, V, c), holds(Tv, V, -looking_c).

observes(t, peek_c, c).
aware_of(t, peek_c, a) :- dw(t, W), holds(t, W, looking_a).
aware_of(t, peek_c, b) :- dw(t, W), holds(t, W, looking_b).

#program base.


action(shout_tail_a).
announcement(shout_tail_a).
action_pre(shout_tail_a,and(b(a,tail),tail)).
announces(shout_tail_a, tail).
% formula(b(a,tail)).
% formula(and(b(a,tail),tail)).

#program step(t).

entails(t, t, W, and(b(a,tail),tail)) :-
    dw(t, W), holds(t, W, tail), not -entails(t, t, W, b(a,tail)).

-entails(t, t, W, b(a,tail)) :- dw(t, W), r(t, W, Tv, V, a), holds(Tv, V, -tail).

observes(t, shout_tail_a, a).
observes(t, shout_tail_a, b) :- dw(t, W), holds(t, W, looking_b).
observes(t, shout_tail_a, c) :- dw(t, W), holds(t, W, looking_c).

#program base.


action(shout_tail_b).
announcement(shout_tail_b).
action_pre(shout_tail_b,and(b(b,tail),tail)).
announces(shout_tail_b, tail).
% formula(b(b,tail)).
% formula(and(b(b,tail),tail)).

#program step(t).

entails(t, t, W, and(b(b,tail),tail)) :-
    dw(t, W), holds(t, W, tail), not -entails(t, t, W, b(b,tail)).

-entails(t, t, W, b(b,tail)) :- dw(t, W), r(t, W, Tv, V, b), holds(Tv, V, -tail).

observes(t, shout_tail_b, b).
observes(t, shout_tail_b, a) :- dw(t, W), holds(t, W, looking_a).
observes(t, shout_tail_b, c) :- dw(t, W), holds(t, W, looking_c).

#program base.


action(shout_tail_c).
announcement(shout_tail_c).
action_pre(shout_tail_c,and(b(c,tail),tail)).
announces(shout_tail_c, tail).
% formula(b(c,tail)).
% formula(and(b(c,tail),tail)).

#program step(t).

entails(t, t, W, and(b(c,tail),tail)) :-
    dw(t, W), holds(t, W, tail), not -entails(t, t, W, b(c,tail)).

-entails(t, t, W, b(c,tail)) :- dw(t, W), r(t, W, Tv, V, c), holds(Tv, V, -tail).

observes(t, shout_tail_c, c).
observes(t, shout_tail_c, a) :- dw(t, W), holds(t, W, looking_a).
observes(t, shout_tail_c, b) :- dw(t, W), holds(t, W, looking_b).

#program base.


action(signal_a_b).
ontic(signal_a_b).
action_pre(signal_a_b,and(b(a,and(looking_a,-looking_b)),and(looking_a,-looking_b))).
causes(signal_a_b, looking_b).
once(signal_a_b).

% formula(b(a,-looking_b)).
% formula(and(b(a,looking_a),b(a,-looking_b))).
% formula(and(looking_a,-looking_b)).
% formula(and(and(b(a,looking_a),b(a,-looking_b)),and(looking_a,-looking_b))).

idle_atom(signal_a_b, looking_a).
idle_atom(signal_a_b, looking_c).
idle_atom(signal_a_b, opened).
idle_atom(signal_a_b, tail).

#program step(t).

entails(t, t, W, and(b(a,and(looking_a,-looking_b)),and(looking_a,-looking_b))) :-
    dw(t, W), holds(t, W, looking_a), holds(t, W, -looking_b),
    not -entails(t, t, W, b(a,and(looking_a,-looking_b))).

-entails(t, t, W, b(a,and(looking_a,-looking_b))) :- dw(t, W), r(t, W, Tv, V, a), holds(Tv, V, -looking_a).
-entails(t, t, W, b(a,and(looking_a,-looking_b))) :- dw(t, W), r(t, W, Tv, V, a), holds(Tv, V,  looking_b).

observes(t, signal_a_b, a).
observes(t, signal_a_b, b).
oblivious(t, signal_a_b, c).

#program base.


action(signal_a_c).
ontic(signal_a_c).
action_pre(signal_a_c,and(b(a,and(looking_a,-looking_c)),and(looking_a,-looking_c))).
causes(signal_a_c, looking_c).
once(signal_a_c).

% formula(b(a,-looking_c)).
% formula(and(b(a,looking_a),b(a,-looking_c))).
% formula(and(looking_a,-looking_c)).
% formula(and(and(b(a,looking_a),b(a,-looking_c)),and(looking_a,-looking_c))).

idle_atom(signal_a_c, looking_a).
idle_atom(signal_a_c, looking_b).
idle_atom(signal_a_c, opened).
idle_atom(signal_a_c, tail).

#program step(t).

entails(t, t, W, and(b(a,and(looking_a,-looking_c)),and(looking_a,-looking_c))) :-
    dw(t, W), holds(t, W, looking_a), holds(t, W, -looking_c),
    not -entails(t, t, W, b(a,and(looking_a,-looking_c))).

-entails(t, t, W, b(a,and(looking_a,-looking_c))) :- dw(t, W), r(t, W, Tv, V, a), holds(Tv, V, -looking_a).
-entails(t, t, W, b(a,and(looking_a,-looking_c))) :- dw(t, W), r(t, W, Tv, V, a), holds(Tv, V,  looking_c).

observes(t, signal_a_c, a).
observes(t, signal_a_c, c).
oblivious(t, signal_a_c, b).

#program base.


action(signal_b_a).
ontic(signal_b_a).
action_pre(signal_b_a,and(b(b,and(looking_b,-looking_a)),and(looking_b,-looking_a))).
causes(signal_b_a, looking_a).
once(signal_b_a).

% formula(b(b,-looking_a)).
% formula(and(b(b,looking_b),b(b,-looking_a))).
% formula(and(-looking_a,looking_b)).
% formula(and(and(b(b,looking_b),b(b,-looking_a)),and(-looking_a,looking_b))).

idle_atom(signal_b_a, looking_b).
idle_atom(signal_b_a, looking_c).
idle_atom(signal_b_a, opened).
idle_atom(signal_b_a, tail).

#program step(t).

entails(t, t, W, and(b(b,and(looking_b,-looking_a)),and(looking_b,-looking_a))) :-
    dw(t, W), holds(t, W, looking_b), holds(t, W, -looking_a),
    not -entails(t, t, W, b(b,and(looking_b,-looking_a))).

-entails(t, t, W, b(b,and(looking_b,-looking_a))) :- dw(t, W), r(t, W, Tv, V, b), holds(Tv, V, -looking_b).
-entails(t, t, W, b(b,and(looking_b,-looking_a))) :- dw(t, W), r(t, W, Tv, V, b), holds(Tv, V,  looking_a).

observes(t, signal_b_a, b).
observes(t, signal_b_a, a).
oblivious(t, signal_b_a, c).

#program base.


action(signal_b_c).
ontic(signal_b_c).
action_pre(signal_b_c,and(b(b,and(looking_b,-looking_c)),and(looking_b,-looking_c))).
causes(signal_b_c, looking_c).
once(signal_b_c).

% formula(b(b,-looking_c)).
% formula(and(b(b,looking_b),b(b,-looking_c))).
% formula(and(looking_b,-looking_c)).
% formula(and(and(b(b,looking_b),b(b,-looking_c)),and(looking_b,-looking_c))).

idle_atom(signal_b_c, looking_a).
idle_atom(signal_b_c, looking_b).
idle_atom(signal_b_c, opened).
idle_atom(signal_b_c, tail).

#program step(t).

entails(t, t, W, and(b(b,and(looking_b,-looking_c)),and(looking_b,-looking_c))) :-
    dw(t, W), holds(t, W, looking_b), holds(t, W, -looking_c),
    not -entails(t, t, W, b(b,and(looking_b,-looking_c))).

-entails(t, t, W, b(b,and(looking_b,-looking_c))) :- dw(t, W), r(t, W, Tv, V, b), holds(Tv, V, -looking_b).
-entails(t, t, W, b(b,and(looking_b,-looking_c))) :- dw(t, W), r(t, W, Tv, V, b), holds(Tv, V,  looking_c).

observes(t, signal_b_c, b).
observes(t, signal_b_c, c).
oblivious(t, signal_b_c, a).

#program base.


action(signal_c_a).
ontic(signal_c_a).
action_pre(signal_c_a,and(b(c,and(looking_c,-looking_a)),and(looking_c,-looking_a))).
causes(signal_c_a, looking_a).
once(signal_c_a).

% formula(b(c,-looking_a)).
% formula(and(b(c,looking_c),b(c,-looking_a))).
% formula(and(-looking_a,looking_c)).
% formula(and(and(b(c,looking_c),b(c,-looking_a)),and(-looking_a,looking_c))).

idle_atom(signal_c_a, looking_b).
idle_atom(signal_c_a, looking_c).
idle_atom(signal_c_a, opened).
idle_atom(signal_c_a, tail).

#program step(t).

entails(t, t, W, and(b(c,and(looking_c,-looking_a)),and(looking_c,-looking_a))) :-
    dw(t, W), holds(t, W, looking_c), holds(t, W, -looking_a),
    not -entails(t, t, W, b(c,and(looking_c,-looking_a))).

-entails(t, t, W, b(c,and(looking_c,-looking_a))) :- dw(t, W), r(t, W, Tv, V, c), holds(Tv, V, -looking_c).
-entails(t, t, W, b(c,and(looking_c,-looking_a))) :- dw(t, W), r(t, W, Tv, V, c), holds(Tv, V,  looking_a).

observes(t, signal_c_a, c).
observes(t, signal_c_a, a).
oblivious(t, signal_c_a, b).

#program base.


action(signal_c_b).
ontic(signal_c_b).
action_pre(signal_c_b,and(b(c,and(looking_c,-looking_b)),and(looking_c,-looking_b))).
causes(signal_c_b, looking_b).
once(signal_c_b).

% formula(b(c,-looking_b)).
% formula(and(b(c,looking_c),b(c,-looking_b))).
% formula(and(-looking_b,looking_c)).
% formula(and(and(b(c,looking_c),b(c,-looking_b)),and(-looking_b,looking_c))).

idle_atom(signal_c_b, looking_a).
idle_atom(signal_c_b, looking_c).
idle_atom(signal_c_b, opened).
idle_atom(signal_c_b, tail).

#program step(t).

entails(t, t, W, and(b(c,and(looking_c,-looking_b)),and(looking_c,-looking_b))) :-
    dw(t, W), holds(t, W, looking_c), holds(t, W, -looking_b),
    not -entails(t, t, W, b(c,and(looking_c,-looking_b))).

-entails(t, t, W, b(c,and(looking_c,-looking_b))) :- dw(t, W), r(t, W, Tv, V, c), holds(Tv, V, -looking_c).
-entails(t, t, W, b(c,and(looking_c,-looking_b))) :- dw(t, W), r(t, W, Tv, V, c), holds(Tv, V,  looking_b).

observes(t, signal_c_b, c).
observes(t, signal_c_b, b).
oblivious(t, signal_c_b, a).

#program base.


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

% *** ATOMS ***
atom(looking_a).
atom(looking_b).
atom(looking_c).
atom(opened).
atom(tail).

literal(looking_a).
literal(looking_b).
literal(looking_c).
literal(opened).
literal(tail).
literal(-looking_a).
literal(-looking_b).
literal(-looking_c).
literal(-opened).
literal(-tail).

% *** AGENTS ***
agent(a).
agent(b).
agent(c).


% *** ACTIONS ***
action(distract_a_b).
ontic(distract_a_b).
% formula(-looking_b).
% formula(b(a,looking_a)).
% formula(b(a,looking_b)).
% formula(and(b(a,looking_a),b(a,looking_b))).
% formula(and(looking_a,looking_b)).
% formula(and(and(b(a,looking_a),b(a,looking_b)),and(looking_a,looking_b))).

#program step(t).

applicable(t, distract_a_b)  :- dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, looking_a), holds(t, W, Ew, Hw, looking_b),
                                           not -applicable(t, distract_a_b).
                                           % 0 { w(Tv, V, Ev, Hv) : r(t, W, Ew, Hw, Tv, V, Ev, Hv, a), holds(Tv, V, Ev, Hv, -looking_a) } 0,
                                           % 0 { w(Tv, V, Ev, Hv) : r(t, W, Ew, Hw, Tv, V, Ev, Hv, a), holds(Tv, V, Ev, Hv, -looking_b) } 0.

-applicable(t, distract_a_b) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, a),
                                           holds(Tv, V, Ev, Hv, -looking_a).

-applicable(t, distract_a_b) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, a),
                                           holds(Tv, V, Ev, Hv, -looking_b).

causes(t, Tw, W, Ew, Hw, distract_a_b, -looking_b) :- plan(t, distract_a_b), same_path(t, Tw, W, Ew, Hw, _, _).
observes(t, distract_a_b, a) :- plan(t, distract_a_b).
observes(t, distract_a_b, b) :- plan(t, distract_a_b).
oblivious(t, distract_a_b, c) :- plan(t, distract_a_b).

#program base.

action(distract_a_c).
ontic(distract_a_c).
% formula(-looking_c).
% formula(b(a,looking_c)).
% formula(and(b(a,looking_a),b(a,looking_c))).
% formula(and(looking_a,looking_c)).
% formula(and(and(b(a,looking_a),b(a,looking_c)),and(looking_a,looking_c))).

#program step(t).

applicable(t, distract_a_c)  :- dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, looking_a), holds(t, W, Ew, Hw, looking_c),
                                not -applicable(t, distract_a_c).
                                % 0 { w(Tv, V, Ev, Hv) : r(t, W, Ew, Hw, Tv, V, Ev, Hv, a), holds(Tv, V, Ev, Hv, -looking_a) } 0,
                                % 0 { w(Tv, V, Ev, Hv) : r(t, W, Ew, Hw, Tv, V, Ev, Hv, a), holds(Tv, V, Ev, Hv, -looking_c) } 0.

-applicable(t, distract_a_c) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, a),
                                holds(Tv, V, Ev, Hv, -looking_a).

-applicable(t, distract_a_c) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, a),
                                holds(Tv, V, Ev, Hv, -looking_c).

causes(t, Tw, W, Ew, Hw, distract_a_c, -looking_c) :- plan(t, distract_a_c), same_path(t, Tw, W, Ew, Hw, _, _).
observes(t, distract_a_c, a) :- plan(t, distract_a_c).
observes(t, distract_a_c, c) :- plan(t, distract_a_c).
oblivious(t, distract_a_c, b) :- plan(t, distract_a_c).

#program base.

action(distract_b_a).
ontic(distract_b_a).
% formula(-looking_a).
% formula(b(b,looking_b)).
% formula(b(b,looking_a)).
% formula(and(b(b,looking_b),b(b,looking_a))).
% formula(and(and(b(b,looking_b),b(b,looking_a)),and(looking_a,looking_b))).

#program step(t).

applicable(t, distract_b_a)  :- dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, looking_b), holds(t, W, Ew, Hw, looking_a),
                                not -applicable(t, distract_b_a).
                                % 0 { w(Tv, V, Ev, Hv) : r(t, W, Ew, Hw, Tv, V, Ev, Hv, b), holds(Tv, V, Ev, Hv, -looking_b) } 0,
                                % 0 { w(Tv, V, Ev, Hv) : r(t, W, Ew, Hw, Tv, V, Ev, Hv, b), holds(Tv, V, Ev, Hv, -looking_a) } 0.

-applicable(t, distract_b_a) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, b),
                                holds(Tv, V, Ev, Hv, -looking_b).

-applicable(t, distract_b_a) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, b),
                                holds(Tv, V, Ev, Hv, -looking_a).

causes(t, Tw, W, Ew, Hw, distract_b_a, -looking_a) :- plan(t, distract_b_a), same_path(t, Tw, W, Ew, Hw, _, _).
observes(t, distract_b_a, b) :- plan(t, distract_b_a).
observes(t, distract_b_a, a) :- plan(t, distract_b_a).
oblivious(t, distract_b_a, c) :- plan(t, distract_b_a).

#program base.

action(distract_b_c).
ontic(distract_b_c).
% formula(b(b,looking_c)).
% formula(and(b(b,looking_b),b(b,looking_c))).
% formula(and(looking_b,looking_c)).
% formula(and(and(b(b,looking_b),b(b,looking_c)),and(looking_b,looking_c))).

#program step(t).

applicable(t, distract_b_c)  :- dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, looking_b), holds(t, W, Ew, Hw, looking_c),
                                not -applicable(t, distract_b_c).
                                % 0 { w(Tv, V, Ev, Hv) : r(t, W, Ew, Hw, Tv, V, Ev, Hv, b), holds(Tv, V, Ev, Hv, -looking_b) } 0,
                                % 0 { w(Tv, V, Ev, Hv) : r(t, W, Ew, Hw, Tv, V, Ev, Hv, b), holds(Tv, V, Ev, Hv, -looking_c) } 0.

-applicable(t, distract_b_c) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, b),
                                holds(Tv, V, Ev, Hv, -looking_b).

-applicable(t, distract_b_c) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, b),
                                holds(Tv, V, Ev, Hv, -looking_c).

causes(t, Tw, W, Ew, Hw, distract_b_c, -looking_c) :- plan(t, distract_b_c), same_path(t, Tw, W, Ew, Hw, _, _).
observes(t, distract_b_c, b) :- plan(t, distract_b_c).
observes(t, distract_b_c, c) :- plan(t, distract_b_c).
oblivious(t, distract_b_c, a) :- plan(t, distract_b_c).

#program base.

action(distract_c_a).
ontic(distract_c_a).
% formula(b(c,looking_c)).
% formula(b(c,looking_a)).
% formula(and(b(c,looking_c),b(c,looking_a))).
% formula(and(and(b(c,looking_c),b(c,looking_a)),and(looking_a,looking_c))).

#program step(t).

applicable(t, distract_c_a)  :- dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, looking_c), holds(t, W, Ew, Hw, looking_a),
                                not -applicable(t, distract_c_a).
                                % 0 { w(Tv, V, Ev, Hv) : r(t, W, Ew, Hw, Tv, V, Ev, Hv, c), holds(Tv, V, Ev, Hv, -looking_c) } 0,
                                % 0 { w(Tv, V, Ev, Hv) : r(t, W, Ew, Hw, Tv, V, Ev, Hv, c), holds(Tv, V, Ev, Hv, -looking_a) } 0.

-applicable(t, distract_c_a) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, c),
                                holds(Tv, V, Ev, Hv, -looking_c).

-applicable(t, distract_c_a) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, c),
                                holds(Tv, V, Ev, Hv, -looking_a).

causes(t, Tw, W, Ew, Hw, distract_c_a, -looking_a) :- plan(t, distract_c_a), same_path(t, Tw, W, Ew, Hw, _, _).
observes(t, distract_c_a, c) :- plan(t, distract_c_a).
observes(t, distract_c_a, a) :- plan(t, distract_c_a).
oblivious(t, distract_c_a, b) :- plan(t, distract_c_a).

#program base.

action(distract_c_b).
ontic(distract_c_b).
% formula(b(c,looking_b)).
% formula(and(b(c,looking_c),b(c,looking_b))).
% formula(and(and(b(c,looking_c),b(c,looking_b)),and(looking_b,looking_c))).

#program step(t).

applicable(t, distract_c_b)  :- dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, looking_c), holds(t, W, Ew, Hw, looking_b),
                                not -applicable(t, distract_c_b).
                                % 0 { w(Tv, V, Ev, Hv) : r(t, W, Ew, Hw, Tv, V, Ev, Hv, c), holds(Tv, V, Ev, Hv, -looking_c) } 0,
                                % 0 { w(Tv, V, Ev, Hv) : r(t, W, Ew, Hw, Tv, V, Ev, Hv, c), holds(Tv, V, Ev, Hv, -looking_b) } 0.

-applicable(t, distract_c_b) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, c),
                                holds(Tv, V, Ev, Hv, -looking_c).

-applicable(t, distract_c_b) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, c),
                                holds(Tv, V, Ev, Hv, -looking_b).

causes(t, Tw, W, Ew, Hw, distract_c_b, -looking_b) :- plan(t, distract_c_b), same_path(t, Tw, W, Ew, Hw, _, _).
observes(t, distract_c_b, c) :- plan(t, distract_c_b).
observes(t, distract_c_b, b) :- plan(t, distract_c_b).
oblivious(t, distract_c_b, a) :- plan(t, distract_c_b).

#program base.

action(open_a).
ontic(open_a).
% formula(-opened).

#program step(t).

applicable(t, open_a) :- dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, -opened).

causes(t, Tw, W, Ew, Hw, open_a, opened) :- plan(t, open_a), same_path(t, Tw, W, Ew, Hw, _, _).
observes(t, open_a, a) :- plan(t, open_a).
observes(t, open_a, b) :- plan(t, open_a), dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, looking_b).
observes(t, open_a, c) :- plan(t, open_a), dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, looking_c).

#program base.

action(peek_a).
sensing(peek_a).
determines(peek_a, tail).
% formula(b(a,opened)).
% formula(and(b(a,opened),b(a,looking_a))).
% formula(and(looking_a,opened)).
% formula(and(and(b(a,opened),b(a,looking_a)),and(looking_a,opened))).

#program step(t).

applicable(t, peek_a) :-  dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, opened), holds(t, W, Ew, Hw, looking_a),
                          not -applicable(t, peek_a).
                        % 0 { w(Tv, V, Ev, Hv) : r(t, W, Ew, Hw, Tv, V, Ev, Hv, a), holds(Tv, V, Ev, Hv, -opened) } 0,
                        % 0 { w(Tv, V, Ev, Hv) : r(t, W, Ew, Hw, Tv, V, Ev, Hv, a), holds(Tv, V, Ev, Hv, -looking_a) } 0.

-applicable(t, peek_a) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, a),
                          holds(Tv, V, Ev, Hv, -opened).

-applicable(t, peek_a) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, a),
                          holds(Tv, V, Ev, Hv, -looking_a).

observes(t, peek_a, a) :- plan(t, peek_a).
aware_of(t, peek_a, b) :- plan(t, peek_a), dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, looking_b).
aware_of(t, peek_a, c) :- plan(t, peek_a), dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, looking_c).

#program base.

action(peek_b).
sensing(peek_b).
determines(peek_b, tail).
% formula(b(b,opened)).
% formula(and(b(b,opened),b(b,looking_b))).
% formula(and(looking_b,opened)).
% formula(and(and(b(b,opened),b(b,looking_b)),and(looking_b,opened))).

#program step(t).

applicable(t, peek_b) :-  dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, opened), holds(t, W, Ew, Hw, looking_b),
                          not -applicable(t, peek_b).
                        % 0 { w(Tv, V, Ev, Hv) : r(t, W, Ew, Hw, Tv, V, Ev, Hv, b), holds(Tv, V, Ev, Hv, -opened) } 0,
                        % 0 { w(Tv, V, Ev, Hv) : r(t, W, Ew, Hw, Tv, V, Ev, Hv, b), holds(Tv, V, Ev, Hv, -looking_b) } 0.

-applicable(t, peek_b) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, b),
                          holds(Tv, V, Ev, Hv, -opened).

-applicable(t, peek_b) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, b),
                          holds(Tv, V, Ev, Hv, -looking_b).

observes(t, peek_b, b) :- plan(t, peek_b).
aware_of(t, peek_b, a) :- plan(t, peek_b), dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, looking_a).
aware_of(t, peek_b, c) :- plan(t, peek_b), dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, looking_c).

#program base.

action(peek_c).
sensing(peek_c).
determines(peek_c, tail).
% formula(b(c,opened)).
% formula(and(b(c,opened),b(c,looking_c))).
% formula(and(looking_c,opened)).
% formula(and(and(b(c,opened),b(c,looking_c)),and(looking_c,opened))).

#program step(t).

applicable(t, peek_c) :-  dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, opened), holds(t, W, Ew, Hw, looking_c),
                          not -applicable(t, peek_c).
                        % 0 { w(Tv, V, Ev, Hv) : r(t, W, Ew, Hw, Tv, V, Ev, Hv, c), holds(Tv, V, Ev, Hv, -opened) } 0,
                        % 0 { w(Tv, V, Ev, Hv) : r(t, W, Ew, Hw, Tv, V, Ev, Hv, c), holds(Tv, V, Ev, Hv, -looking_c) } 0.

-applicable(t, peek_c) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, c),
                          holds(Tv, V, Ev, Hv, -opened).

-applicable(t, peek_c) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, c),
                          holds(Tv, V, Ev, Hv, -looking_c).

observes(t, peek_c, c) :- plan(t, peek_c).
aware_of(t, peek_c, a) :- plan(t, peek_c), dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, looking_a).
aware_of(t, peek_c, b) :- plan(t, peek_c), dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, looking_b).

#program base.

action(shout_tail_a).
announcement(shout_tail_a).
announces(shout_tail_a, tail).
% formula(b(a,tail)).
% formula(and(b(a,tail),tail)).

#program step(t).

applicable(t, shout_tail_a) :-  dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, tail),
                                not -applicable(t, shout_tail_a).
                                % 0 { w(Tv, V, Ev, Hv) : r(t, W, Ew, Hw, Tv, V, Ev, Hv, a), holds(Tv, V, Ev, Hv, -tail) } 0.

-applicable(t, shout_tail_a) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, a),
                                holds(Tv, V, Ev, Hv, -tail).

observes(t, shout_tail_a, a) :- plan(t, shout_tail_a).
observes(t, shout_tail_a, b) :- plan(t, shout_tail_a), dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, looking_b).
observes(t, shout_tail_a, c) :- plan(t, shout_tail_a), dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, looking_c).

#program base.

action(shout_tail_b).
announcement(shout_tail_b).
announces(shout_tail_b, tail).
% formula(b(b,tail)).
% formula(and(b(b,tail),tail)).

#program step(t).

applicable(t, shout_tail_b) :-  dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, tail),
                                not -applicable(t, shout_tail_b).
                                % 0 { w(Tv, V, Ev, Hv) : r(t, W, Ew, Hw, Tv, V, Ev, Hv, b), holds(Tv, V, Ev, Hv, -tail) } 0.

-applicable(t, shout_tail_b) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, b),
                                holds(Tv, V, Ev, Hv, -tail).

observes(t, shout_tail_b, b) :- plan(t, shout_tail_b).
observes(t, shout_tail_b, a) :- plan(t, shout_tail_b), dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, looking_a).
observes(t, shout_tail_b, c) :- plan(t, shout_tail_b), dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, looking_c).

#program base.

action(shout_tail_c).
announcement(shout_tail_c).
announces(shout_tail_c, tail).
% formula(b(c,tail)).
% formula(and(b(c,tail),tail)).

#program step(t).

applicable(t, shout_tail_c) :-  dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, tail),
                                not -applicable(t, shout_tail_c).
                                % 0 { w(Tv, V, Ev, Hv) : r(t, W, Ew, Hw, Tv, V, Ev, Hv, c), holds(Tv, V, Ev, Hv, -tail) } 0.

-applicable(t, shout_tail_c) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, c),
                                holds(Tv, V, Ev, Hv, -tail).

observes(t, shout_tail_c, c) :- plan(t, shout_tail_c).
observes(t, shout_tail_c, a) :- plan(t, shout_tail_c), dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, looking_a).
observes(t, shout_tail_c, b) :- plan(t, shout_tail_c), dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, looking_b).

#program base.

action(signal_a_b).
ontic(signal_a_b).
% formula(b(a,-looking_b)).
% formula(and(b(a,looking_a),b(a,-looking_b))).
% formula(and(looking_a,-looking_b)).
% formula(and(and(b(a,looking_a),b(a,-looking_b)),and(looking_a,-looking_b))).

#program step(t).

applicable(t, signal_a_b)  :- dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, looking_a), holds(t, W, Ew, Hw, -looking_b),
                              not -applicable(t, signal_a_b).
                            % 0 { w(Tv, V, Ev, Hv) : r(t, W, Ew, Hw, Tv, V, Ev, Hv, a), holds(Tv, V, Ev, Hv, -looking_a) } 0,
                            % 0 { w(Tv, V, Ev, Hv) : r(t, W, Ew, Hw, Tv, V, Ev, Hv, a),     holds(Tv, V, Ev, Hv, looking_b) } 0.

-applicable(t, signal_a_b) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, a),
                              holds(Tv, V, Ev, Hv, -looking_a).

-applicable(t, signal_a_b) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, a),
                              holds(Tv, V, Ev, Hv, looking_b).

causes(t, Tw, W, Ew, Hw, signal_a_b, looking_b) :- plan(t, signal_a_b), same_path(t, Tw, W, Ew, Hw, _, _).
observes(t, signal_a_b, a) :- plan(t, signal_a_b).
observes(t, signal_a_b, b) :- plan(t, signal_a_b).
oblivious(t, signal_a_b, c) :- plan(t, signal_a_b).

#program base.

action(signal_a_c).
ontic(signal_a_c).
% formula(b(a,-looking_c)).
% formula(and(b(a,looking_a),b(a,-looking_c))).
% formula(and(looking_a,-looking_c)).
% formula(and(and(b(a,looking_a),b(a,-looking_c)),and(looking_a,-looking_c))).

#program step(t).

applicable(t, signal_a_c)  :- dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, looking_a), holds(t, W, Ew, Hw, -looking_c),
                              not -applicable(t, signal_a_c).
                            % 0 { w(Tv, V, Ev, Hv) : r(t, W, Ew, Hw, Tv, V, Ev, Hv, a), holds(Tv, V, Ev, Hv, -looking_a) } 0,
                            % 0 { w(Tv, V, Ev, Hv) : r(t, W, Ew, Hw, Tv, V, Ev, Hv, a),     holds(Tv, V, Ev, Hv, looking_c) } 0.

-applicable(t, signal_a_c) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, a),
                              holds(Tv, V, Ev, Hv, -looking_a).

-applicable(t, signal_a_c) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, a),
                              holds(Tv, V, Ev, Hv, looking_c).

causes(t, Tw, W, Ew, Hw, signal_a_c, looking_c) :- plan(t, signal_a_c), same_path(t, Tw, W, Ew, Hw, _, _).
observes(t, signal_a_c, a) :- plan(t, signal_a_c).
observes(t, signal_a_c, c) :- plan(t, signal_a_c).
oblivious(t, signal_a_c, b) :- plan(t, signal_a_c).

#program base.

action(signal_b_a).
ontic(signal_b_a).
% formula(b(b,-looking_a)).
% formula(and(b(b,looking_b),b(b,-looking_a))).
% formula(and(-looking_a,looking_b)).
% formula(and(and(b(b,looking_b),b(b,-looking_a)),and(-looking_a,looking_b))).

#program step(t).

applicable(t, signal_b_a)  :- dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, looking_b), holds(t, W, Ew, Hw, -looking_a),
                              not -applicable(t, signal_b_a).
                            % 0 { w(Tv, V, Ev, Hv) : r(t, W, Ew, Hw, Tv, V, Ev, Hv, b), holds(Tv, V, Ev, Hv, -looking_b) } 0,
                            % 0 { w(Tv, V, Ev, Hv) : r(t, W, Ew, Hw, Tv, V, Ev, Hv, b),     holds(Tv, V, Ev, Hv, looking_a) } 0.

-applicable(t, signal_b_a) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, b),
                              holds(Tv, V, Ev, Hv, -looking_b).

-applicable(t, signal_b_a) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, b),
                              holds(Tv, V, Ev, Hv, looking_a).

causes(t, Tw, W, Ew, Hw, signal_b_a, looking_a) :- plan(t, signal_b_a), same_path(t, Tw, W, Ew, Hw, _, _).
observes(t, signal_b_a, b) :- plan(t, signal_b_a).
observes(t, signal_b_a, a) :- plan(t, signal_b_a).
oblivious(t, signal_b_a, c) :- plan(t, signal_b_a).

#program base.

action(signal_b_c).
ontic(signal_b_c).
% formula(b(b,-looking_c)).
% formula(and(b(b,looking_b),b(b,-looking_c))).
% formula(and(looking_b,-looking_c)).
% formula(and(and(b(b,looking_b),b(b,-looking_c)),and(looking_b,-looking_c))).

#program step(t).

applicable(t, signal_b_c)  :- dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, looking_b), holds(t, W, Ew, Hw, -looking_c),
                              not -applicable(t, signal_b_c).
                            % 0 { w(Tv, V, Ev, Hv) : r(t, W, Ew, Hw, Tv, V, Ev, Hv, b), holds(Tv, V, Ev, Hv, -looking_b) } 0,
                            % 0 { w(Tv, V, Ev, Hv) : r(t, W, Ew, Hw, Tv, V, Ev, Hv, b),     holds(Tv, V, Ev, Hv, looking_c) } 0.

-applicable(t, signal_b_c) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, b),
                              holds(Tv, V, Ev, Hv, -looking_b).

-applicable(t, signal_b_c) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, b),
                              holds(Tv, V, Ev, Hv, looking_c).

causes(t, Tw, W, Ew, Hw, signal_b_c, looking_c) :- plan(t, signal_b_c), same_path(t, Tw, W, Ew, Hw, _, _).
observes(t, signal_b_c, b) :- plan(t, signal_b_c).
observes(t, signal_b_c, c) :- plan(t, signal_b_c).
oblivious(t, signal_b_c, a) :- plan(t, signal_b_c).

#program base.

action(signal_c_a).
ontic(signal_c_a).
% formula(b(c,-looking_a)).
% formula(and(b(c,looking_c),b(c,-looking_a))).
% formula(and(-looking_a,looking_c)).
% formula(and(and(b(c,looking_c),b(c,-looking_a)),and(-looking_a,looking_c))).

#program step(t).

applicable(t, signal_c_a)  :- dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, looking_c), holds(t, W, Ew, Hw, -looking_a),
                              not -applicable(t, signal_c_a).
                            % 0 { w(Tv, V, Ev, Hv) : r(t, W, Ew, Hw, Tv, V, Ev, Hv, c), holds(Tv, V, Ev, Hv, -looking_c) } 0,
                            % 0 { w(Tv, V, Ev, Hv) : r(t, W, Ew, Hw, Tv, V, Ev, Hv, c),     holds(Tv, V, Ev, Hv, looking_a) } 0.

-applicable(t, signal_c_a) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, c),
                              holds(Tv, V, Ev, Hv, -looking_c).

-applicable(t, signal_c_a) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, c),
                              holds(Tv, V, Ev, Hv, looking_a).

causes(t, Tw, W, Ew, Hw, signal_c_a, looking_a) :- plan(t, signal_c_a), same_path(t, Tw, W, Ew, Hw, _, _).
observes(t, signal_c_a, c) :- plan(t, signal_c_a).
observes(t, signal_c_a, a) :- plan(t, signal_c_a).
oblivious(t, signal_c_a, b) :- plan(t, signal_c_a).

#program base.

action(signal_c_b).
ontic(signal_c_b).
% formula(b(c,-looking_b)).
% formula(and(b(c,looking_c),b(c,-looking_b))).
% formula(and(-looking_b,looking_c)).
% formula(and(and(b(c,looking_c),b(c,-looking_b)),and(-looking_b,looking_c))).

#program step(t).

applicable(t, signal_c_b)  :- dw(t, W, Ew, Hw), holds(t, W, Ew, Hw, looking_c), holds(t, W, Ew, Hw, -looking_b),
                              not -applicable(t, signal_c_b).
                            % 0 { w(Tv, V, Ev, Hv) : r(t, W, Ew, Hw, Tv, V, Ev, Hv, c), holds(Tv, V, Ev, Hv, -looking_c) } 0,
                            % 0 { w(Tv, V, Ev, Hv) : r(t, W, Ew, Hw, Tv, V, Ev, Hv, c),     holds(Tv, V, Ev, Hv, looking_b) } 0.

-applicable(t, signal_c_b) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, c),
                              holds(Tv, V, Ev, Hv, -looking_c).

-applicable(t, signal_c_b) :- dw(t, W, Ew, Hw), r(t, W, Ew, Hw, Tv, V, Ev, Hv, c),
                              holds(Tv, V, Ev, Hv, looking_b).

causes(t, Tw, W, Ew, Hw, signal_c_b, looking_b) :- plan(t, signal_c_b), same_path(t, Tw, W, Ew, Hw, _, _).
observes(t, signal_c_b, c) :- plan(t, signal_c_b).
observes(t, signal_c_b, b) :- plan(t, signal_c_b).
oblivious(t, signal_c_b, a) :- plan(t, signal_c_b).

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

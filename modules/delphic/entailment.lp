% ********** ENTAILMENT **********

#program step(t).

entails(t, W, Ew, Hw,  P)          :- atom(P),                                            holds(t, W, Ew, Hw,  P).%,                               w(t, W, Ew, Hw).
entails(t, W, Ew, Hw, -P)          :- atom(P),                                            holds(t, W, Ew, Hw, -P),                               w(t, W, Ew, Hw).

entails(t, W, Ew, Hw, neg(F))      :- formula(neg(F)),      formula(F),               not entails(t, W, Ew, Hw, F ),                            w(t, W, Ew, Hw).
entails(t, W, Ew, Hw, and(F1, F2)) :- formula(and(F1, F2)), formula(F1), formula(F2),     entails(t, W, Ew, Hw, F1), entails(t, W, Ew, Hw, F2).%, w(t, W, Ew, Hw).
entails(t, W, Ew, Hw,  or(F1, F2)) :- formula( or(F1, F2)), formula(F1), formula(F2),     entails(t, W, Ew, Hw, F1).%,                            w(t, W, Ew, Hw).
entails(t, W, Ew, Hw,  or(F1, F2)) :- formula( or(F1, F2)), formula(F1), formula(F2),                                entails(t, W, Ew, Hw, F2).%, w(t, W, Ew, Hw).

entails(t, W, Ew, Hw,   b(AG , F)) :- formula(  b(AG , F)), formula(F),               not -entails(t, W, Ew, Hw, b(AG , F)),                    w(t, W, Ew, Hw).
entails(t, W, Ew, Hw,   c(AGS, F)) :- formula(  c(AGS, F)), formula(F),               not -entails(t, W, Ew, Hw, c(AGS, F)),                    w(t, W, Ew, Hw).

-entails(t, W1, Ew1, Hw1, b(AG , F)) :-
                                        % w(t, W1, Ew1, Hw1), 
                                        formula(b(AG , F)), formula(F),
                                        r(t, W1, Ew1, Hw1, Tw2, W2, Ew2, Hw2, AG),
                                        time(Tw2), Tw2 <= t,
                                        % w(Tw2, W2, Ew2, Hw2), 
                                        not entails(Tw2, W2, Ew2, Hw2, F).

-entails(t, W1, Ew1, Hw1, c(AGS, F)) :-
                                        % w(t, W1, Ew1, Hw1),
                                        formula(c(AGS, F)), formula(F),
                                        reaches(t, W1, Ew1, Hw1, Tw2, W2, Ew2, Hw2, AGS),
                                        time(Tw2), Tw2 <= t,
                                        % w(Tw2, W2, Ew2, Hw2),
                                        not entails(Tw2, W2, Ew2, Hw2, F).


% not_entails(t, Tw1, W1, Ew1, Hw1, c(AGS, F)) :- time(Tw1), Tw1 <= t,
%                                                 not entails(t, Tw1, W1, Ew1, Hw1, F), w(Tw1, W1, Ew1, Hw1),
%                                                 check_on_w(t, Tw1, W1, Ew1, Hw1, c(AGS, F)), check_on_w(t, Tw1, W1, Ew1, Hw1, F),
%                                                 formula(c(AGS, F)), formula(F), agent_set(AGS), agent(AG), contains_ag(AGS, AG).

% not_entails(t, Tw1, W1, Ew1, Hw1, c(AGS, F)) :- time(Tw1), time(Tw2), Tw1 <= t, Tw2 <= Tw1,
%                                                 not entails(t, Tw2, W2, Ew2, Hw2, c(AGS, F)), w(Tw1, W1, Ew1, Hw1), w(Tw2, W2, Ew2, Hw2),
%                                                 check_on_w(t, Tw1, W1, Ew1, Hw1, c(AGS, F)), check_on_w(t, Tw1, W1, Ew1, Hw1, F),
%                                                 check_on_w(t, Tw2, W2, Ew2, Hw2, c(AGS, F)), check_on_w(t, Tw2, W2, Ew2, Hw2, F),
%                                                 r(Tw1, W1, Ew1, Hw1, Tw2, W2, Ew2, Hw2, AG), formula(c(AGS, F)), formula(F), agent_set(AGS), agent(AG), contains_ag(AGS, AG).

% :- entails(t, Tw, W, Ew, Hw, neg(F)),      not not entails(t, Tw, W, Ew, Hw, F ),                                    w(Tw, W, Ew, Hw), check_on_w(t, Tw, W, Ew, Hw, neg(F)),      check_on_w(t, Tw, W, Ew, Hw, F ),                               formula(neg(F)),      formula(F ).
% :- entails(t, Tw, W, Ew, Hw, and(F1, F2)), not     entails(t, Tw, W, Ew, Hw, F1),                                    w(Tw, W, Ew, Hw), check_on_w(t, Tw, W, Ew, Hw, and(F1, F2)), check_on_w(t, Tw, W, Ew, Hw, F1), check_on_w(t, Tw, W, Ew, Hw, F2), formula(and(F1, F2)), formula(F1), formula(F2).
% :- entails(t, Tw, W, Ew, Hw, and(F1, F2)), not     entails(t, Tw, W, Ew, Hw, F2),                                    w(Tw, W, Ew, Hw), check_on_w(t, Tw, W, Ew, Hw, and(F1, F2)), check_on_w(t, Tw, W, Ew, Hw, F1), check_on_w(t, Tw, W, Ew, Hw, F2), formula(and(F1, F2)), formula(F1), formula(F2).
% :- entails(t, Tw, W, Ew, Hw, and(F1, F2)), not     entails(t, Tw, W, Ew, Hw, F1), not entails(t, Tw, W, Ew, Hw, F2), w(Tw, W, Ew, Hw), check_on_w(t, Tw, W, Ew, Hw,  or(F1, F2)), check_on_w(t, Tw, W, Ew, Hw, F1), check_on_w(t, Tw, W, Ew, Hw, F2), formula( or(F1, F2)), formula(F1), formula(F2).

% :- entails(t, Tw, W, Ew, Hw,   b(AG , F)), -entails(t, Tw, W, Ew, Hw, b(AG , F)),                                 w(Tw, W, Ew, Hw), check_on_w(t, Tw, W, Ew, Hw,   b(AG , F)), formula(b(AG , F)), formula(F), agent(AG).
% :- entails(t, Tw, W, Ew, Hw,   c(AGS, F)), -entails(t, Tw, W, Ew, Hw, c(AGS, F)),                                 w(Tw, W, Ew, Hw), check_on_w(t, Tw, W, Ew, Hw,   c(AGS, F)), formula(b(AG , F)), formula(F), agent_set(AGS).

% :- entails(t, Tw, W, Ew, Hw, b(AG , F)), -entails(t, Tw2, W2, Ew2, Hw2, F), w(Tw, W, Ew, Hw), w(Tw2, W2, Ew2, Hw2), r(Tw, W, Ew, Hw, Tw2, W2, Ew2, Hw2, AG),
%    check_on_w(t, Tw, W, Ew, Hw, b(AG, F)), check_on_w(t, Tw2, W2, Ew2, Hw2, F), formula(b(AG, F)), formula(F), agent(AG).

% :- entails(t, Tw, W, Ew, Hw, c(AGS, F)), -entails(t, Tw2, W2, Ew2, Hw2, F), w(Tw, W, Ew, Hw), w(Tw2, W2, Ew2, Hw2), reaches(Tw, W, Ew, Hw, Tw2, W2, Ew2, Hw2, AGS),
%    check_on_w(t, Tw, W, Ew, Hw, c(AGS, F)), check_on_w(t, Tw2, W2, Ew2, Hw2, F), formula(c(AGS, F)), formula(F), agent_set(AGS).

% :- entails(t, Tw, W, Ew, Hw, F), not check_on_w(t, Tw, W, Ew, Hw, F), w(Tw, W, Ew, Hw), formula(F).




% entails(t, W, Ew, Hw,  P)          :-     holds(t, W, Ew, Hw, P),                               w(t, W, Ew, Hw), check_everywhere( P), atom(P).
% entails(t, W, Ew, Hw, -P)          :- not holds(t, W, Ew, Hw, P),                               w(t, W, Ew, Hw), check_everywhere(-P), atom(P).

% entails(t, W, Ew, Hw, neg(F))      :- not entails(t, W, Ew, Hw, F ),                            w(t, W, Ew, Hw), check_everywhere(neg(F)),      check_everywhere(F ),                       formula(neg(F)),      formula(F).
% entails(t, W, Ew, Hw, and(F1, F2)) :-     entails(t, W, Ew, Hw, F1), entails(t, W, Ew, Hw, F2), w(t, W, Ew, Hw), check_everywhere(and(F1, F2)), check_everywhere(F1), check_everywhere(F2), formula(and(F1, F2)), formula(F1), formula(F2).
% entails(t, W, Ew, Hw,  or(F1, F2)) :-     entails(t, W, Ew, Hw, F1),                            w(t, W, Ew, Hw), check_everywhere( or(F1, F2)), check_everywhere(F1), check_everywhere(F2), formula( or(F1, F2)), formula(F1), formula(F2).
% entails(t, W, Ew, Hw,  or(F1, F2)) :-                                entails(t, W, Ew, Hw, F2), w(t, W, Ew, Hw), check_everywhere( or(F1, F2)), check_everywhere(F1), check_everywhere(F2), formula( or(F1, F2)), formula(F1), formula(F2).

% entails(t, W, Ew, Hw,   b(AG , F)) :- not -entails(t, W, Ew, Hw, b(AG , F)),                    w(t, W, Ew, Hw), check_everywhere(b(AG , F)), formula(b(AG , F)), formula(F), agent(AG).
% entails(t, W, Ew, Hw,   c(AGS, F)) :- not -entails(t, W, Ew, Hw, c(AGS, F)),                    w(t, W, Ew, Hw), check_everywhere(c(AGS, F)), formula(c(AGS, F)), formula(F), agent_set(AGS).

% -entails(t, W1, Ew1, Hw1, b(AG , F)) :- time(Tw2), Tw2 <= t, check_everywhere(b(AG , F)), check_everywhere(F),
%                                         not entails(Tw2, W2, Ew2, Hw2, F), w(t, W1, Ew1, Hw1), w(Tw2, W2, Ew2, Hw2), 
%                                         r(t, W1, Ew1, Hw1, Tw2, W2, Ew2, Hw2, AG), formula(b(AG , F)), formula(F), agent(AG).

% -entails(t, W1, Ew1, Hw1, c(AGS, F)) :- time(Tw2), Tw2 <= t, check_everywhere(c(AGS, F)), check_everywhere(F),
%                                         not entails(Tw2, W2, Ew2, Hw2, F), w(t, W1, Ew1, Hw1), w(Tw2, W2, Ew2, Hw2),
%                                         reaches(t, W1, Ew1, Hw1, Tw2, W2, Ew2, Hw2, AGS), formula(c(AGS, F)), formula(F), agent_set(AGS).



% entails(t, W, Ew, Hw,  P)          :-     holds(t, W, Ew, Hw, P),                               w(t, W, Ew, Hw), not check_everywhere( P),          check_on_w(t, W, Ew, Hw,  P), atom(P).
% entails(t, W, Ew, Hw, -P)          :- not holds(t, W, Ew, Hw, P),                               w(t, W, Ew, Hw), not check_everywhere(-P),          check_on_w(t, W, Ew, Hw, -P), atom(P).

% entails(t, W, Ew, Hw, neg(F))      :- not entails(t, W, Ew, Hw, F ),                            w(t, W, Ew, Hw), not check_everywhere(neg(F)),      check_on_w(t, W, Ew, Hw, neg(F)),      check_on_w(t, W, Ew, Hw, F ),                               formula(neg(F)),      formula(F).
% entails(t, W, Ew, Hw, and(F1, F2)) :-     entails(t, W, Ew, Hw, F1), entails(t, W, Ew, Hw, F2), w(t, W, Ew, Hw), not check_everywhere(and(F1, F2)), check_on_w(t, W, Ew, Hw, and(F1, F2)), check_on_w(t, W, Ew, Hw, F1), check_on_w(t, W, Ew, Hw, F2), formula(and(F1, F2)), formula(F1), formula(F2).
% entails(t, W, Ew, Hw,  or(F1, F2)) :-     entails(t, W, Ew, Hw, F1),                            w(t, W, Ew, Hw), not check_everywhere( or(F1, F2)), check_on_w(t, W, Ew, Hw,  or(F1, F2)), check_on_w(t, W, Ew, Hw, F1), check_on_w(t, W, Ew, Hw, F2), formula( or(F1, F2)), formula(F1), formula(F2).
% entails(t, W, Ew, Hw,  or(F1, F2)) :-                                entails(t, W, Ew, Hw, F2), w(t, W, Ew, Hw), not check_everywhere( or(F1, F2)), check_on_w(t, W, Ew, Hw,  or(F1, F2)), check_on_w(t, W, Ew, Hw, F1), check_on_w(t, W, Ew, Hw, F2), formula( or(F1, F2)), formula(F1), formula(F2).

% entails(t, W, Ew, Hw,   b(AG , F)) :- not -entails(t, W, Ew, Hw, b(AG , F)),                    w(t, W, Ew, Hw), not check_everywhere(b(AG , F)),   check_on_w(t, W, Ew, Hw, b(AG , F)),  formula(b(AG , F)), formula(F), agent(AG).
% entails(t, W, Ew, Hw,   c(AGS, F)) :- not -entails(t, W, Ew, Hw, c(AGS, F)),                    w(t, W, Ew, Hw), not check_everywhere(c(AGS, F)),   check_on_w(t, W, Ew, Hw, c(AGS, F)),  formula(c(AGS, F)), formula(F), agent_set(AGS).

% -entails(t, W1, Ew1, Hw1, b(AG , F)) :- time(Tw2), Tw2 <= t, %time(Tw1), time(Tw2), Tw1 <= t <= Tw1, time(T), T <= t,
%                                         not entails(Tw2, W2, Ew2, Hw2, F), w(t, W1, Ew1, Hw1), w(Tw2, W2, Ew2, Hw2), 
%                                         check_on_w(t, W1, Ew1, Hw1, b(AG , F)), check_on_w(t, W2, Ew2, Hw2, F), not check_everywhere(b(AG , F)),
%                                         r(t, W1, Ew1, Hw1, Tw2, W2, Ew2, Hw2, AG), formula(b(AG , F)), formula(F), agent(AG).

% -entails(t, W1, Ew1, Hw1, c(AGS, F)) :- time(Tw2), Tw2 <= t, %time(Tw1), time(Tw2), Tw1 <= t <= Tw1, time(T), T <= t,
%                                         not entails(Tw2, W2, Ew2, Hw2, F), w(t, W1, Ew1, Hw1), w(Tw2, W2, Ew2, Hw2),
%                                         check_on_w(t, W1, Ew1, Hw1, c(AGS, F)), check_on_w(t, W2, Ew2, Hw2, F), not check_everywhere(c(AGS, F)),
%                                         reaches(t, W1, Ew1, Hw1, Tw2, W2, Ew2, Hw2, AGS), formula(c(AGS, F)), formula(F), agent_set(AGS).

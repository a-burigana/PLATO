#program step(t).

% Generate
0 { plan(t, ACT) : action(ACT), applicable(t, ACT) } 1 :- time(t).

% Test
not_reached_goal(t) :- w(t, W, Ew, Hw), dw(t, W, Ew, Hw), not entails(t, W, Ew, Hw, F), goal(F), formula(F).

:- time(t), 0 { plan(t, _) } 0, not_reached_goal(t).
:- time(t), plan(t, _), not not_reached_goal(t).
:- time(t), plan(t, ACT), not applicable(t, ACT).
% :- time(t), not dw(t, _, _, _), not_reached_goal(t).

:- time(t), t > 0, plan(t-1, ACT), plan(t, ACT), epistemic(ACT).

% % Axiom 4
% :- time(t), time(Tw2), time(Tw3), Tw2 <= t, Tw3 <= Tw2, w(t, W1, Ew1, Hw1), w(Tw2, W2, Ew2, Hw2), w(Tw3, W3, Ew3, Hw3), agent(AG),
%    r(t, W1, Ew1, Hw1, Tw2, W2, Ew2, Hw2, AG), r(Tw2, W2, Ew2, Hw2, Tw3, W3, Ew3, Hw3, AG), not r(t, W1, Ew1, Hw1, Tw3, W3, Ew3, Hw3, AG).
% % Axiom 5
% :- time(t), time(Tw2), time(Tw3), Tw2 <= t, Tw3 <= Tw2, w(t, W1, Ew1, Hw1), w(Tw2, W2, Ew2, Hw2), w(Tw3, W3, Ew3, Hw3), agent(AG),
%    r(t, W1, Ew1, Hw1, Tw2, W2, Ew2, Hw2, AG), r(t, W1, Ew1, Hw1, Tw3, W3, Ew3, Hw3, AG), not r(Tw2, W2, Ew2, Hw2, Tw3, W3, Ew3, Hw3, AG).
% Axiom D
% :- time(t), w(t, W1, Ew1, Hw1), 0 { r(t, W1, Ew1, Hw1, Tw2, W2, Ew2, Hw2, AG) : time(Tw2), Tw2 <= t, w(Tw2, W2, Ew2, Hw2), agent(AG) } 0.

#program check(t).
:- not_reached_goal(t), query(t).

% Display
#show plan/2.

% #show check_on_w/5.

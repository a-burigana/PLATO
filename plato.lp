#include "modules/inc_solve.lp".    % Multi-shot solving Python script

% To avoid showing the warning "info: atom does not occur in any rule head"
#defined plan/2.
#defined agent_set/1.
#defined contains_ag/2.

#program step(t).
time(t).

#include "modules/reachability.lp".
#include "modules/formulae.lp".
#include "modules/entailment.lp".
#include "modules/transition_function.lp".
#include "modules/map_plugin.lp".
% #include "modules/bisimulation.lp".

#program step(t).

% Generate
0 { plan(t, ACT) : action(ACT), applicable(t, ACT) } 1 :- time(t).

% Test
not_reached_goal(t) :- w(t, W, Ew, Hw), dw(t, W, Ew, Hw), not entails(t, t, W, Ew, Hw, F), goal(F), formula(F).

:- time(t), 0 { plan(t, _) } 0, not_reached_goal(t).
:- time(t), plan(t, _), not not_reached_goal(t).
:- time(t), plan(t, ACT), not applicable(t, ACT).
% :- time(t), not dw(t, _, _, _), not_reached_goal(t).


% Axiom 4
:- time(t), time(Tw2), time(Tw3), Tw2 <= t, Tw3 <= Tw2, w(t, W1, Ew1, Hw1), w(Tw2, W2, Ew2, Hw2), w(Tw3, W3, Ew3, Hw3), agent(AG),
   r(t, W1, Ew1, Hw1, Tw2, W2, Ew2, Hw2, AG), r(Tw2, W2, Ew2, Hw2, Tw3, W3, Ew3, Hw3, AG), not r(t, W1, Ew1, Hw1, Tw3, W3, Ew3, Hw3, AG).
% Axiom 5
:- time(t), time(Tw2), time(Tw3), Tw2 <= t, Tw3 <= Tw2, w(t, W1, Ew1, Hw1), w(Tw2, W2, Ew2, Hw2), w(Tw3, W3, Ew3, Hw3), agent(AG),
   r(t, W1, Ew1, Hw1, Tw2, W2, Ew2, Hw2, AG), r(t, W1, Ew1, Hw1, Tw3, W3, Ew3, Hw3, AG), not r(Tw2, W2, Ew2, Hw2, Tw3, W3, Ew3, Hw3, AG).
% Axiom D
:- time(t), w(t, W1, Ew1, Hw1), 0 { r(t, W1, Ew1, Hw1, Tw2, W2, Ew2, Hw2, AG) : time(Tw2), Tw2 <= t, w(Tw2, W2, Ew2, Hw2), agent(AG) } 0.

#program check(t).
:- not_reached_goal(t), query(t).

%%% DEBUG
% plan(0, left_b).
% plan(1, b_check_1).
% plan(2, tell_b_b1_1).
% reached_goal(3).


% plan(0,open_a).
% plan(1,signal_a_c).
% plan(2,signal_c_b).
% plan(3,distract_c_a).
% plan(4,peek_c).
% plan(5,shout_tail_c).
% plan(0,open_a) plan(1,signal_a_b) plan(2,signal_b_c) plan(3,distract_b_a) plan(4,peek_b) plan(5,shout_tail_b)
% reached_goal(5).


% plan(0, signal_a_b).
% plan(1, open_a).
% plan(2, peek_b).
% % plan(2, signal_c_b).
% % plan(3, distract_c_a).
% reached_goal(3).

% #program check(t).
% % reached_goal(0).
% :- not reached_goal(t), query(t).

% Display
#show plan/2.

% !!! Uncomment while printing the results !!!
% #show w/4.
% #show dw/4.
% #show r/9.
% #show holds/5.
% #show atom/1.

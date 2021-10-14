#include <incmode>.     % Multi-shot Python script (see Gebser et al., 2019)

% To avoid showing the warning "info: atom does not occur in any rule head"
#defined plan/2.
#defined agent_set/1.
#defined contains_ag/2.


#program base.
time(0).

#program step(t).
time(t).

#include "modules/reachability.lp".
#include "modules/entailment.lp".
#include "modules/transition_function.lp".
% #include "modules/bisimulation.lp".


#program step(t).

% Generate
1 { plan(t, ACT) : action(ACT) } 1 :- t > 0, time(t).

% reached_goal(2).

% Test
:- 0 { plan(t, _) } 0.
:- t > 0, time(t), plan(t, ACT), not applicable(t, ACT).

#program check(t).
:- not entails(pw(t, W, E), F), dw(t, W, E), goal(F), formula(F), query(t).
% :- not reached_goal(t), query(t).

% Display
#show plan/2.

% !!! Uncomment while printing the results !!!
% #show pointed/3.
% #show possible_world/3.
% #show believes/7.
% #show holds/4.
% #show atom/1.

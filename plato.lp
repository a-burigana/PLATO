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
#include "modules/formulae.lp".
#include "modules/entailment.lp".
#include "modules/transition_function.lp".
#include "modules/map_plugin.lp".
% #include "modules/bisimulation.lp".

#program step(t).

% plan(t, open_a) :- t = 1.
% plan(t, peek_a) :- t = 2.


% % Generate
1 { plan(t, ACT) : action(ACT) } 1 :- t > 0, time(t).

% % Test
:- 0 { plan(t, _) } 0.
:- t > 0, time(t), plan(t, ACT), not applicable(t, ACT).

#program check(t).
:- not entails_goal(w(t, W, E), F), dw(t, W, E), goal(F), formula(F), query(t).
% \todo: to improve goal checking, try to set the initial state to time 1 (a lot of work)


% reached_goal(2).
% :- not reached_goal(t), query(t).


% Display
#show plan/2.

% !!! Uncomment while printing the results !!!
% #show dw/3.
% #show w/3.
% #show r/3.
% #show holds/2.
% #show atom/1.

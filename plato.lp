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
% plan(1,signal_a_c).
% plan(2,signal_c_b).

% % Generate
1 { plan(t, ACT) : action(ACT) } 1 :- t > 0, time(t).

% % Test
:- 0 { plan(t, _) } 0.
:- t > 0, time(t), plan(t, ACT), not applicable(t, ACT).

#program check(t).
:- not entails_goal(w(t, W, E), F), dw(t, W, E), goal(F), formula(F), query(t).
% \todo: to improve goal checking, try to set the initial state to time 1 (a lot of work)


%%% DEBUG
% reached_goal(1).
% :- not reached_goal(t), query(t).


% Display
#show plan/2.
% #show e/3.
% #show de/3.
% #show q/3.
% #show pre/4.
% #show post/5.
% #show applicable/1.
% #show applicable/2.
% #show entails/2.
% #show entails_goal/2.
% #show check_on_w/2.
% #show check_on_w_goal/2.
% #show same_path/2.

% !!! Uncomment while printing the results !!!
% #show dw/3.
% #show w/3.
% #show r/3.
% #show holds/2.
% #show atom/1.

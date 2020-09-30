%
% MEP encoding in ASP
%

#include <incmode>.

%To avoid showing the error "info: atom does not occur in any rule head"
#defined plan/2.
#defined init_sf/1.
#defined agent_set/1.
#defined contains_ag/2.

#defined ontic/1.
#defined causes/3.
#defined sensing/1.
#defined determines/3.
#defined announcement/1.
#defined announces/3.

#defined observes/3.
#defined aware_of/3.
#defined oblivious/2.

#program base.
time(0).

#program step(t).
time(t).

#include "modules/reachability.lp".
#include "modules/entailment.lp".
#include "modules/initial_state.lp".
#include "modules/transition_function.lp".
% #include "modules/bisimulation.lp".


#program step(t).

% Generate
1 { plan(t, ACT) : action(ACT) } 1 :- t > 0, time(t).

% Test
:- 0 { plan(t, _) } 0.
:- t > 0, time(t), plan(t, ACT), not is_executable(t, ACT).

#program check(t).
:- not entails(t, R, P, F), pointed(t, R, P), goal(F), formula(F), query(t).

% Display
#show plan/2.


% !!! Uncomment while printing the results !!!
%#show pointed/3.
%#show possible_world/3.
%#show believes/7.
%#show holds/4.
%#show fluent/1.

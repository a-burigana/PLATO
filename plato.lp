#include <incmode>.     % Multi-shot Python script (see Gebser et al., 2019)

% To avoid showing the warning "info: atom does not occur in any rule head"
#defined plan/2.
#defined init_sf/1.
#defined check_everywere/1.
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

% Post ICLP 2020
% #include "old_versions/modules/reachability_old.lp".
% #include "old_versions/modules/entailment_old.lp".

% Optimizations in progress
#include "modules/reachability.lp".
#include "modules/entailment.lp".
#include "modules/initial_state.lp".
#include "modules/transition_function.lp".
% #include "modules/bisimulation.lp".


#program step(t).

% Generate
1 { plan(t, ACT) : action(ACT) } 1 :- t > 0, time(t).

% plan(1, goto_q1).
% plan(2, read_0).
% plan(1, write_ab_0).
% plan(2, write_bc_0).
% plan(3, write_ac_1).
% plan(4, write_ab_1).
% plan(5, write_bc_1).
% plan(6, share_b_1).
% plan(7, share_c_1).

% reached_goal(2).

% Test
:- 0 { plan(t, _) } 0.
:- t > 0, time(t), plan(t, ACT), not is_executable(t, ACT).

#program check(t).
:- not entails(t, R, P, F), pointed(t, R, P), goal(F), formula(F), query(t).
% :- not reached_goal(t), query(t).

% Display
#show plan/2.

% !!! Uncomment while printing the results !!!
% #show pointed/3.
% #show possible_world/3.
% #show believes/7.
% #show holds/4.
% #show fluent/1.

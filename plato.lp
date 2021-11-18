#include "multi_shot/inc_solve.lp".    % Multi-shot solving Python script

% To avoid showing the warning "info: atom does not occur in any rule head"
#defined plan/2.
#defined agent_set/1.
#defined contains_ag/2.

#program step(t).
time(t).

%%% MODULES %%%
#include "modules/reachability.lp".
#include "modules/formulae.lp".
#include "modules/entailment.lp".
#include "modules/transition_function.lp".

#include "modules/map_plugin/initial_state.lp".
#include "modules/map_plugin/update.lp".
#include "modules/map_plugin/actions.lp".

% #include "modules/bisimulation.lp".

%%% RUN CONFIGURATION %%%
#include "run_config/find_plan.lp".
% #include "run_config/debug.lp".


% !!! Uncomment while printing the results !!!
% #include "run_config/print.lp".

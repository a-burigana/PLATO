#include "multi_shot/inc_solve.lp".    % Multi-shot solving Python script

% To avoid showing the warning "info: atom does not occur in any rule head"
#defined plan/2.
#defined agent_set/1.
#defined contains_ag/2.

#program check(t).
time(t).

%%% SEMANTICS %%%
% #include "semantics/delphic.lp".
% #include "semantics/ma_rho.lp".
% #include "semantics/ma_star.lp".


%%% RUN CONFIGURATION %%%
% #include "run_config/find_plan.lp".
% #include "run_config/debug.lp".


% !!! Uncomment while printing the results !!!
% #include "run_config/print.lp".

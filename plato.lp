% #include <incmode>.	 % Multi-shot Python script (see Gebser et al., 2019)

#script (python)
from typing import Optional, cast

from clingo.solving import SolveResult
from clingo.symbol import Function, Number

def get(val, default):
	return val if val != None else default

def main(prg):
	imin = get(prg.get_const("imin"), 1)
	imax = prg.get_const("imax")
	istop = get(prg.get_const("istop"), "SAT")
	step = 0
	ret: Optional[SolveResult] = None

	while ((imax is None or step < imax) and
			(ret is None or step < imin or (
				(istop == "SAT" and not ret.satisfiable) or
				(istop == "UNSAT" and not ret.unsatisfiable) or
				(istop == "UNKNOWN" and not ret.unknown)))):
		parts = []
		parts.append(("check", [Number(step)]))
		if step > 0:
			prg.release_external(Function("query", [Number(step - 1)]))
			parts.append(("step", [Number(step)]))
			prg.cleanup()
		else:
			parts.append(("base", []))
			parts.append(("step", [Number(step)]))
		prg.ground(parts)

		prg.assign_external(Function("query", [Number(step)]), True)
		ret, step = cast(SolveResult, prg.solve()), step + 1
#end.

#program check(t).
#external query(t).

% To avoid showing the warning "info: atom does not occur in any rule head"
#defined plan/2.
#defined agent_set/1.
#defined contains_ag/2.


% #program base.
% time(0).

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
:- time(t), 1 { plan(t, _) } 1, not not_reached_goal(t).
:- time(t), plan(t, ACT), not applicable(t, ACT).
:- time(t), 0 { dw(t, _, _, _) } 0, not_reached_goal(t).

#program check(t).
:- not_reached_goal(t), query(t).

% \todo: implementa history dei mondi con pairing function

%%% DEBUG
% plan(0, left_b).
% plan(1, b_check_1).
% plan(2, tell_b_b1_1).
% reached_goal(3).


% plan(0, open_a).
% plan(1, peek_a).
% plan(2, signal_a_b).
% plan(3, signal_a_c).
% plan(4, shout_tail_a).
% reached_goal(4).


% plan(0, signal_a_b).
% plan(1, open_a).
% plan(2, peek_b).
% % plan(2, signal_c_b).
% % plan(3, distract_c_a).
% reached_goal(3).

% #program check(t).
% % reached_goal(0).
% :- not reached_goal(t), query(t).

% #show not_reached_goal/1.

% Display
% #show time/1.
#show plan/2.
% #show pf/3.
% #show de/2.
% #show e/2.
% #show q/3.
% #show pre/3.
% #show post/4.
% #show applicable_event/3.
% #show applicable/2.
% #show is_fully_obs/2.
% #show is_partial_obs/2.
% #show is_oblivious/2.
% #show entails/4.
% #show check_on_w/5.
% #show same_path/6.

% !!! Uncomment while printing the results !!!
% #show w/4.
% #show dw/4.
% #show r/9.
% #show holds/5.
% #show atom/1.


% Regex
%
% w\(0,(\d+),__ini\)
% w(0:W$1)
%
% w\((\d),w\(\d:(W\w+?)\),e\(\w+?,(\w+?)\)\)
% w($1:$2_$3)

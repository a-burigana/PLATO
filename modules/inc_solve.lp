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

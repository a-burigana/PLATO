# PLATO
An ASP based comprehensive Multi-Agent Epistemic Planner

## Usage
The main program is `plato.lp`. To run PLATO you will only need to have *clingo* (https://potassco.org/clingo/) installed in your system.

Given a MEP domain instance `instance.lp`, to calculate a plan simply run the following line in your terminal:

```
clingo plato.lp path/to/instance.lp <options>
```

You can easily calculate all the plans for the given instance:

```
clingo plato.lp path/to/instance.lp 0
```

The best working *clingo*'s configurations (as to the conducted evaluations) are `many` and `frumpy`. In the *exp* folder you can find the domains instances that we used to test the efficiency of PLATO. A description of the domains is available at http://clp.dimi.uniud.it/sw/.

## Overview
PLATO (e**P**istemic mu**L**ti-agent **A**nswer se**T** programming s**O**lver) is a multi-agent epistmic planner written in ASP. It exploits *clingo*'s multi-shot capabilities [4], allowing for an incremental approach. Namely, we deal with a single planning step at a time, exploring the search space in a *breadth first* manner.

When we look at a MEP domain, we have different kinds of elements, such as actions' descriptions, initial state description and goal conditions. All of these elements are described by means of Dynamic Epistemic Logic [6] (DEL) formulae (or belief formulae). Moreover, an action description include executability conditions, execution effects and observability relations. For a complete description see [1,2].

## Program structure
PLATO comprises of three main components:
1. Entailment of belief formulae
2. Initial state generation
3. Transition function: ontic, sensing and announcement actions

PLATO is based on the semantics of the language *mAp*, described in [3]. For a complete analysis of the encoding see [2].

## Our goals
At the moment, PLATO *correctly* encodes the semantics of *mAp* as proved in [3]. At the moment, we impose some assumptions on the behavior of the agents. Namely, agents must be truthful and trustworthy.

Here we list our current and future works:
- [x] Enhancement of the entailment rules
- [ ] Rework of the repetition parameters in the atoms `possible_world(T, R, P)`
- [ ] Heuristics implementation
- [ ] Implementing the extended semantics of *mAp* that formalizes novel concepts **inconsistent beliefs**, **trust**, **misconceptions** and **lies**

## Bibliography
[1] Aczel, P. 1988. "Non-well-founded sets". CSLI Lecture Notes, 14, Stanford University, Center for the Study of Language and Information.

[2] Burigana, A., Fabiano, F., Dovier, A., and Pontelli, E. 2020. "Modelling Multi-Agent Epistemic Planning in ASP". Proc of ICLP, 101–109.

[3] Fabiano, F., Burigana, A., Dovier, A., and Pontelli, E. 2020. "EFP 2.0: A multi-Agent Epistemic Solver with Multiple e-State Representations". Proc of ICAPS, 101–109.

[4] Gebser, M., Kaminski, R., Kaufmann, B., and Schaub, T. 2019. "Multi-shot ASP solving with clingo". Theory and Practice of Logic Programming 19, 27–82.

[5] Gerbrandy, J. and Groeneveld, W. 1997. "Reasoning about information change". Journal of Logic, Language and Information 6, 2, 147–169.

[6] Van Ditmarsch, H., van Der Hoek, W. and Kooi, B. 2007. "Dynamic epistemic logic". Volume 337, Springer Science & Business Media.
